$ErrorActionPreference='Stop'
$cache="$env:TEMP\wod_books_table"

function DeHyph([string]$s){ return ([regex]::Replace($s,'([a-zA-Z])- ([a-z])','$1$2') -replace '\s{2,}',' ').Trim() }
function Expand([string]$s){
  $sb=New-Object Text.StringBuilder
  foreach($ch in $s.ToCharArray()){
    if($ch -eq [char]9){ $n=8-($sb.Length%8); [void]$sb.Append(' '*$n) } else { [void]$sb.Append($ch) }
  }
  return $sb.ToString()
}
function ColX([string]$hdr){
  $x=@()
  # col1 is the SCORE cell. Its header reads Score | Rating | Dots | Path Rating, and -table often
  # glues prose from the neighbouring column onto the same line, so anchoring at 0 reads the prose
  # and every row parses as a continuation. Walk LEFT from the score word while the gap is ONE
  # space: that keeps the `Path` of `Path Rating` (digits sit under it) and drops prose, which is
  # always further off. Measured: da p.447 needs the walk, da p.123/124/130/432 need the drop.
  $ms=[regex]::Match($hdr,'(?i)\b(Score|Rating|Dots)\b')
  if($ms.Success){
    $s=$ms.Index
    while($s -ge 2 -and $hdr[$s-1] -eq ' ' -and $hdr[$s-2] -ne ' '){
      $q=$s-1; while($q -gt 0 -and $hdr[$q-1] -ne ' '){ $q-- }
      $s=$q
    }
    $x+=$s
  } else { $x+=0 }
  # `Wrongdoing` alone is real: da p.432 prints `Minimum` on the line ABOVE the header
  foreach($pat in '(?i)Moral Guideline|Minimum Wrongdoing|Wrongdoing','(?i)Rationale'){
    $m=[regex]::Match($hdr,$pat)
    if($m.Success){ $x+=$m.Index } else { $x+=-1 }
  }
  return ,$x
}
function Slice([string]$s,[int]$a,[int]$b){
  if($a -lt 0 -or $a -ge $s.Length){ return '' }
  if($b -lt 0 -or $b -gt $s.Length){ $b=$s.Length }
  if($b -le $a){ return '' }
  return $s.Substring($a,$b-$a).Trim()
}

$tables=New-Object System.Collections.ArrayList
foreach($f in (Get-ChildItem $cache -Filter *.txt | Sort-Object Name)){
  if($f.Name -notmatch '^([a-z]+)_(\d+)-(\d+)\.txt$'){ continue }
  $bk=$Matches[1]; $first=[int]$Matches[2]
  $pages=([Text.Encoding]::UTF8.GetString([IO.File]::ReadAllBytes($f.FullName))) -split [char]12
  for($pi=0;$pi -lt $pages.Count;$pi++){
    $pnum=$first+$pi
    $raw=$pages[$pi] -split "`r?`n"
    $lines=@($raw | ForEach-Object { Expand $_ })
    for($i=0;$i -lt $lines.Count;$i++){
      if($lines[$i] -notmatch '(?i)(Moral Guideline|Minimum Wrongdoing|Wrongdoing)'){ continue }
      $hi=$i
      # title: nearest non-blank line above that is not part of the table body
      $ti=-1
      for($j=$i-1;$j -ge [Math]::Max(0,$i-8);$j--){
        if($lines[$j].Trim() -eq ''){ continue }
        if($lines[$j] -match '(?i)(Moral Guideline|Minimum Wrongdoing|Wrongdoing)'){ break }
        $ti=$j; break
      }
      $cx=ColX $lines[$hi]
      $title = if($ti -ge 0){ ($lines[$ti].Trim() -replace '\s+',' ') } else { '(untitled)' }
      if($ti -ge 1 -and $title -match '(?i)^AGAINST\b'){
        for($j=$ti-1;$j -ge [Math]::Max(0,$ti-4);$j--){ if($lines[$j].Trim() -ne ''){ $title=(($lines[$j].Trim()+' '+$title) -replace '\s+',' '); break } }
      }
      $rows=New-Object System.Collections.ArrayList
      $blank=0
      for($j=$hi+1;$j -lt $lines.Count;$j++){
        $ln=$lines[$j]
        if($ln.Trim() -eq ''){ $blank++; if($blank -ge 3 -and $rows.Count -ge 1){ break }; continue }
        if($ln -match '(?i)hierarchy\s*of\s*sins?'){ break }
        if($ln -match '(?i)\b(Score|Rating|Dots)\b' -and $ln -match '(?i)wrongdoing'){ break }
        $blank=0
        # Slicing by the header x FAILS on the core tables: they are laid out with TABs, so the
        # boundary between cells drifts line by line and cuts words in half (`non-Assami`, `pay`,
        # `emotio` - measured). Take the maximal RUNS of text that hold no 2-space gap instead and
        # give each to the nearest column at or left of where it starts. Works for both layouts.
        if($raw[$j].Contains([char]9)){
            # TAB-laid-out table (every core one): the cell boundary drifts line by line after tab
            # expansion and an x-slice cuts words in half (`non-Assami`, `pay`, `emotio`). Give each
            # maximal run of text to the nearest column at or left of where it starts instead.
            # TAB-laid-out table (every core one): after tab expansion the cell boundary drifts
            # line by line and an x-slice cuts words in half (`non-Assami`, `pay`, `emotio`).
            # Give each maximal run of text to the nearest column at or left of where it starts.
            $c1=''; $c2=''; $c3=''
            foreach($run in [regex]::Matches($ln,'\S(?:(?!\s\s).)*')){
                $rx0=$run.Index; $txt=$run.Value.Trim()
                if($txt -eq ''){ continue }
                if($cx[2] -ge 0 -and $rx0 -ge $cx[2]-2){ $c3=($c3+' '+$txt).Trim() }
                elseif($rx0 -ge $cx[1]-2){
                    # a 2-column table has no Rationale, so anything past the wrongdoing cell is
                    # the NEIGHBOURING column: one line holds at most score + wrongdoing
                    if($cx[2] -lt 0 -and $c2 -ne ''){ continue }
                    $c2=($c2+' '+$txt).Trim()
                }
                else { $c1=($c1+' '+$txt).Trim() }
            }
        } else {
            # space-aligned table (da, bh, lotc, dac): the x-slice is exact and the run rule would
            # mis-bin the narrow wrapped cells of da p.432 and the 2-column tables
            $c1=Slice $ln $cx[0] $cx[1]
            $c2=Slice $ln $cx[1] $cx[2]
            $c3=Slice $ln $cx[2] -1
            if($cx[2] -lt 0){ $g=[regex]::Match($c2,'\s{5,}'); if($g.Success){ $c2=$c2.Substring(0,$g.Index).Trim() } }
        }
        if($c1 -match '^(10|[1-9])$'){
          [void]$rows.Add([pscustomobject]@{Score=[int]$c1;W=$c2;R=$c3})
        } elseif($rows.Count -gt 0 -and $c1 -eq '' -and ($c2 -ne '' -or $c3 -ne '')) {
            # a CONTINUATION line has an EMPTY score cell. Prose that follows the table reflows to
            # the left margin, so its col1 slice carries words - and without this test the last row
            # (score 1) swallows the rest of the page, footer included. Measured: 31 of 57 tables.
          $last=$rows[$rows.Count-1]
          if($c2 -ne ''){ $last.W=($last.W+' '+$c2).Trim() }
          if($c3 -ne ''){ $last.R=($last.R+' '+$c3).Trim() }
        } elseif($rows.Count -gt 0 -and $c1 -eq '' -and $c2 -eq '' -and $c3 -eq '') {
          continue
        } elseif($rows.Count -gt 0) { break }
      }
      if($rows.Count -gt 0){ [void]$tables.Add([pscustomobject]@{Book=$bk;Page=$pnum;Title=$title;Rows=$rows}) }
      $i=$hi
    }
  }
}
Write-Host "TABLES FOUND: $($tables.Count)"
$full=0
foreach($t in ($tables | Sort-Object Book,Page,Title)){
  $sc=($t.Rows|ForEach-Object{$_.Score})
  if($sc.Count -eq 10){$full++}
  Write-Host ("{0,-4} p.{1,-4} {2,-52} [{3}]" -f $t.Book,$t.Page,$t.Title.Substring(0,[Math]::Min(52,$t.Title.Length)),($sc -join ','))
}
Write-Host "10-row tables: $full of $($tables.Count)"
$tables | Export-Clixml "$env:TEMP\road_tables.xml"
# ---- emit the raw extraction as TSV (CRLF, UTF-8 no BOM) --------------------------------
$outTsv = 'c:\Users\awlol\OneDrive\Documents\firecast_fork\research\road_sins_raw.tsv'
$sb = New-Object Text.StringBuilder
[void]$sb.Append("# road_sins_raw.tsv - MACHINE OUTPUT of research\road_sins_parse.ps1 (T849, I141, R139)`r`n")
[void]$sb.Append("# Regenerate: road_table_cache.ps1 then road_sins_parse.ps1. Do NOT hand-edit.`r`n")
[void]$sb.Append("# tid<TAB>book<TAB>pag_impressa<TAB>titulo_da_tabela<TAB>score<TAB>minimum_wrongdoing<TAB>rationale`r`n")
[void]$sb.Append("# UNMAPPED to a picker name on purpose: the name<->table map is road_sins_map.tsv, by hand (I142b).`r`n")
$ord=@{}
foreach($tb in ($tables | Sort-Object Book,Page,Title)){
  $ord[$tb.Book+":"+$tb.Page] = [int]$ord[$tb.Book+":"+$tb.Page] + 1
  $tid = "{0}:{1}:{2}" -f $tb.Book,$tb.Page,$ord[$tb.Book+":"+$tb.Page]
  foreach($r in $tb.Rows){
    $line = @($tid,$tb.Book,$tb.Page,($tb.Title -replace "`t",' '),$r.Score,(DeHyph ($r.W -replace "`t",' ')),(DeHyph ($r.R -replace "`t",' '))) -join "`t"
    [void]$sb.Append($line + "`r`n")
  }
}
[IO.File]::WriteAllBytes($outTsv,(New-Object Text.UTF8Encoding($false)).GetBytes($sb.ToString()))
Write-Host "wrote $outTsv : $((Get-Item $outTsv).Length) bytes"