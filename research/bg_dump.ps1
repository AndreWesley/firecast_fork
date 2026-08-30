# Despeja um intervalo de paginas de um livro em ORDEM DE LEITURA (calha cortada).
# ASCII puro (SPEC B84).
param([Parameter(Mandatory=$true)][string]$Book,
      [Parameter(Mandatory=$true)][int]$From,
      [Parameter(Mandatory=$true)][int]$To,
      [string]$TxtDir = "$env:TEMP\wod_books_layout",
      [string]$Out = '')
$ErrorActionPreference = 'Stop'

function Find-Gutter([string[]]$rowsIn) {
    $rows = @($rowsIn | Where-Object { $_.Length -gt 0 })
    if ($rows.Count -lt 8) { return $null }
    $W = ($rows | Measure-Object -Property Length -Maximum).Maximum
    if ($W -lt 50) { return $null }
    $lo = [int]($W * 0.25); $hi = [int]($W * 0.75)
    $f = @{}; $peak = 0.0; $argmax = -1
    for ($c = $lo; $c -le $hi; $c++) {
        $blank = 0
        foreach ($r in $rows) { if ($c -ge $r.Length -or $r[$c] -eq ' ') { $blank++ } }
        $v = $blank / $rows.Count; $f[$c] = $v
        if ($v -gt $peak) { $peak = $v; $argmax = $c }
    }
    if ($peak -lt 0.65) { return $null }
    $thr = [Math]::Max(0.60, $peak - 0.10)
    $s = $argmax; while ($s - 1 -ge $lo -and $f[$s - 1] -ge $thr) { $s-- }
    $e = $argmax; while ($e + 1 -le $hi -and $f[$e + 1] -ge $thr) { $e++ }
    $right = 0
    foreach ($r in $rows) { if ($r.Length -gt ($e + 1) -and $r.Substring($e + 1).Trim().Length -gt 0) { $right++ } }
    if (($right / $rows.Count) -lt 0.25) { return $null }
    return [pscustomobject]@{ S = $s; E = $e }
}
function Split-Page([string[]]$rowsIn) {
    $g = Find-Gutter $rowsIn
    if ($null -eq $g) { return , @($rowsIn) }
    $cut = $g.E + 1
    $colA = New-Object System.Collections.Generic.List[string]
    $colB = New-Object System.Collections.Generic.List[string]
    foreach ($ln in $rowsIn) {
        if ($ln.Length -le $cut) { $colA.Add($ln); $colB.Add(''); continue }
        $b = $cut
        if ($ln[$cut] -ne ' ') {
            while ($b -gt $g.S -and $ln[$b - 1] -ne ' ') { $b-- }
            if ($b -le $g.S) { $colA.Add($ln); $colB.Add(''); continue }
        }
        $colA.Add($ln.Substring(0, $b)); $colB.Add($ln.Substring($b))
    }
    , (@($colA) + @($colB))
}

$off = @{core=8;bos=1;m20va=1;da=1;hh=1;gr=1;anarch=1;sorc=1;sorcc=0;lotc=1;lob=1;bh=1;tos=1;dac=1;rob=1;m20=1;bcm=2;trel=1;w20=2;w20kin=1;w20da=1}
$o = $off[$Book]; if ($null -eq $o) { $o = 1 }
$pages = ([IO.File]::ReadAllText((Join-Path $TxtDir "$Book.txt"))) -split "`f"
$L = New-Object System.Collections.Generic.List[string]
for ($pr = $From; $pr -le $To; $pr++) {
    $i = $pr + $o - 1
    if ($i -lt 0 -or $i -ge $pages.Count) { continue }
    $L.Add("===== $Book p.$pr (pdf $($i+1)) =====")
    foreach ($r in (Split-Page ($pages[$i] -split "`r?`n"))) { $t = $r.TrimEnd(); if ($t.Trim() -ne '') { $L.Add($t) } }
}
if ($Out -eq '') { $Out = "$env:TEMP\bg_dump_$Book`_$From-$To.txt" }
[IO.File]::WriteAllText($Out, (($L -join "`r`n") + "`r`n"), (New-Object Text.UTF8Encoding($false)))
"$($L.Count) linhas -> $Out"
