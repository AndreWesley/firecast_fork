# Corpo (bloco 3 de SPEC I21) dos 47 antecedentes de PICKER_LIST["background"].
# Le os despejos -layout -enc UTF-8 de $env:TEMP\wod_books_layout, corta na calha, acha o
# cabecalho de cada item e para no cabecalho SEGUINTE (o unico fim confiavel - README 8).
#
# ASCII puro (SPEC B84): PowerShell 5.1 le .ps1 sem BOM como ANSI, entao caractere curvo
# LITERAL num regex chega mojibake e nao casa CALADO. Os curvos sao montados com [char].
#
# Saida: -Out = arquivo de revisao (1 bloco por item, paragrafos separados por linha em branco)
#        -Tsv = <item><TAB><corpo com \n marcando quebra de paragrafo>, a forma que
#               research/gen_bg_desc.ps1 le (mesma convencao de merit_flaw_body_pt.tsv).
param([string]$TxtDir = "$env:TEMP\wod_books_layout",
      [string]$Out    = 'research\bg_body_raw.txt',
      [string]$Ovr    = 'research\bg_body_overrides.tsv',
      [string]$Tsv    = '')
$ErrorActionPreference = 'Stop'

# As 10 palavras que o livro escreve COM hifen e que a de-hifenizacao da quebra de linha
# colou errado. Lista NOMEADA e FINITA - nao ha dicionario aqui, e um 'if parece composto'
# seria adivinhacao. Cada colagem sai no relatorio no fim; o que estiver errado entra aqui.
$HYPHEN_KEEP = @{
  'fireready'        = 'fire-ready'
  'here-andnow'      = 'here-and-now'
  'Lowlevel'         = 'Low-level'
  'namerecognition'  = 'name-recognition'
  'nonTechnocratic'  = 'non-Technocratic'
  'semipermanent'    = 'semi-permanent'
  'singlepurpose'    = 'single-purpose'
  'spiritanimal'     = 'spirit-animal'
  'twodot'           = 'two-dot'
  'wellinformed'     = 'well-informed'
}

$BULL = [char]0x2022      # bolinha de nivel
$FFFD = [char]0xFFFD      # o V20 core mapeia a bolinha dele para U+FFFD (SPEC T764)
$EMDA = [char]0x2014      # travessao: core e hh escrevem ' -- ' na camada de texto
$RSQU = [char]0x2019      # apostrofo curvo: w20 e m20 ja usam, core e hh usam o reto

$off = @{ core = 8; hh = 1; m20 = 1; w20 = 2 }

# indentacao que marca INICIO DE PARAGRAFO, por livro. Linha em branco nao serve: a virada
# de coluna deixa branco no meio de um paragrafo so (README 8, SPEC B85 pelo outro caminho).
$parInd = @{ core = 2; hh = 2; m20 = 4; w20 = 3 }

# mobilia de pagina: cabecalho corrente e numero. Sai por LIVRO, nao por heuristica, porque
# heuristica generica ja comeu corpo bom uma vez (README 12).
$furn = @{
  core = @('^\d{1,3}\s+CHAPTER\b', '^VAMPIRE THE MASQUERADE', '^EDITION\s+\d+$')
  hh   = @('^THE HUNTERS HUNTED II$', '^\d{1,3}\s+[Cc]hapter\b', '^\d{1,3}\s+CHAPTER\b')
  m20  = @('^\d{1,3}\s+Mage: The Ascension', '^Chapter \w+:')
  w20  = @('^\d{1,3}\s+WEREWOLF THE APOCALYPSE', '^WEREWOLF THE APOCALYPSE', '^CHAPTER \w+:')
}

# item do picker | livro | pagina impressa | cabecalho NO LIVRO | cabecalho que ENCERRA
$ROWS = @'
Allies|core|111|Allies|Alternate Identity
Alternate Identity|core|111|Alternate Identity|Black Hand Membership
Contacts|core|112|Contacts|Domain
Domain|core|112|Domain|Fame
Fame|core|114|Fame|Generation
Generation|core|114|Generation|Herd
Herd|core|114|Herd|Influence
Influence|core|114|Influence|Mentor
Mentor|core|115|Mentor|Resources
Resources|core|115|Resources|Retainers
Retainers|core|116|Retainers|Rituals
Rituals|core|117|Rituals|Status
Status (Vampire)|core|118|Status|Pooling Backgrounds
Armory|hh|37|New Background: Armory|New Background: Base of Operations
Base of Operations|hh|38|New Background: Base of Operations|New Background: Guide
Guide|hh|39|New Background: Guide|Virtues
Rank|hh|134|Rank|Requisition
Requisitions|hh|134|Requisition|Psychic Numina
Artifacts|hh|140|Artifact|Library
Library|hh|140|Library|Mentor
Ancestors|w20|136|Ancestors|Contacts
Fetish|w20|137|Fetish|Kinfolk
Kinfolk|w20|138|Kinfolk|Mentor
Pure Breed|w20|138|Pure Breed|Resources
Rites|w20|139|Rites|Spirit Heritage
Totem (Werewolf)|w20|140|Totem|Pooling Backgrounds
Arcane|m20|305|Arcane/ Cloaking|Avatar/ Genius
Avatar|m20|305|Avatar/ Genius|Backup
Backup|m20|306|Backup|Blessing
Certification|m20|308|Certification|Chantry/ Construct
Chantry|m20|308|Chantry/ Construct|Contacts
Cult|m20|310|Cult|Demesne
Demesne|m20|310|Demesne|Destiny
Destiny|m20|311|Destiny|Dream/ Hypercram
Dream|m20|312|Dream/ Hypercram|Enhancement
Enhancement|m20|312|Enhancement|Fame
Familiar|m20|314|Familiar/ Companion|Influence
Legend|m20|317|Legend|Library
Node|m20|319|Node|Past Lives
Past Lives|m20|320|Past Lives|Patron
Patron|m20|320|Patron|Rank
Sanctum|m20|323|Sanctum/ Laboratory|Secret Weapons
Secret Weapons|m20|325|Secret Weapons|Spies
Spies|m20|325|Spies|Status
Status (Mage)|m20|325|Status|Totem
Totem (Mage)|m20|326|Totem|Wonder (Device/ Fetish/ Talisman, etc.)
Wonder|m20|328|Wonder (Device/ Fetish/ Talisman, etc.)|Arete/ Enlightenment
'@ -split "`r?`n" | Where-Object { $_.Trim() -ne '' }

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

# cabecalho do livro vem decorado: 'Enhancement $', 'Secret Weapons*', 'Totem $'.
# O padrao mora numa VARIAVEL de proposito: em PowerShell a virgula liga mais forte que o
# '+', entao `$t -replace 'a' + $x, ''` vira `-replace @('a'+$x+'')` - 1 argumento so, a
# troca nao acontece e NAO ha erro. Foi assim que os 4 cabecalhos decorados sumiram calados.
$RX_DECOR = '[\*\$' + $FFFD + $BULL + ']+$'
$RX_DOT   = '^(?:[' + $BULL + ']+|X)(?:\s|$)'
function Bare([string]$s) {
    $t = $s.Trim()
    $t = $t -replace $RX_DECOR, ''
    return $t.Trim()
}

$cache = @{}
function Get-Flat([string]$book, [int]$from, [int]$to) {
    $key = "$book|$from|$to"
    if ($cache.ContainsKey($key)) { return $cache[$key] }
    $pages = ([IO.File]::ReadAllText((Join-Path $TxtDir "$book.txt"))) -split "`f"
    $o = $off[$book]
    $L = New-Object System.Collections.Generic.List[psobject]
    for ($pr = $from; $pr -le $to; $pr++) {
        $i = $pr + $o - 1
        if ($i -lt 0 -or $i -ge $pages.Count) { continue }
        foreach ($r in (Split-Page ($pages[$i] -split "`r?`n"))) {
            $t = $r.TrimEnd()
            if ($t.Trim() -eq '') { $L.Add([pscustomobject]@{ T = ''; I = 0; P = $pr }); continue }
            $ind = $t.Length - $t.TrimStart().Length
            $L.Add([pscustomobject]@{ T = $t.Trim(); I = $ind; P = $pr })
        }
    }
    $cache[$key] = $L
    return $L
}

# Corpos consertados a mao: a pagina saiu com coluna embaralhada, tabela no meio ou uma
# barra lateral cravada dentro do texto, e nenhuma regra generica arruma isso sem comer texto
# bom (README 12). Mesmo papel de research/merit_flaw_overrides.tsv.
$over = @{}
if ($Ovr -ne '' -and (Test-Path $Ovr)) {
    foreach ($l in [IO.File]::ReadAllLines($Ovr)) {
        if ($l.StartsWith('#') -or $l.Trim() -eq '') { continue }
        $ix = $l.IndexOf("`t"); if ($ix -lt 1) { continue }
        $over[$l.Substring(0, $ix)] = $l.Substring($ix + 1)
    }
}

$review = New-Object System.Collections.Generic.List[string]
$tsvRows = New-Object System.Collections.Generic.List[string]
$report = New-Object System.Collections.Generic.List[string]
$joins  = New-Object System.Collections.Generic.List[string]

foreach ($line in $ROWS) {
    $c = $line -split '\|'
    $item = $c[0]; $book = $c[1]; $page = [int]$c[2]; $head = $c[3]; $stop = $c[4]
    $flat = Get-Flat $book $page ($page + 4)
    $pi = $parInd[$book]
    $fr = $furn[$book]

    $hi = -1
    for ($i = 0; $i -lt $flat.Count; $i++) {
        if ($flat[$i].P -ne $page) { continue }
        if ((Bare $flat[$i].T) -eq $head) { $hi = $i; break }
    }
    if ($hi -lt 0) { $report.Add("SEM CABECALHO: $item ($book p.$page) -> '$head'"); continue }

    $paras = New-Object System.Collections.Generic.List[string]
    $cur = ''
    $dotInd = -1
    $why = 'fim do intervalo'
    for ($k = $hi + 1; $k -lt $flat.Count; $k++) {
        $t = $flat[$k].T
        if ($t -eq '') { continue }
        if ((Bare $t) -eq $stop) { $why = 'cabecalho seguinte'; break }
        $skip = $false
        foreach ($rx in $fr) { if ($t -match $rx) { $skip = $true; break } }
        if ($skip) { continue }
        if ($t -match '^\d{1,3}$') { continue }

        # U+FFFD no COMECO da linha e a bolinha de nivel do V20 core (SPEC T764). No MEIO da
        # palavra e outra coisa: o mesmo mapa devolve U+FFFD para as acentuadas, e trocar
        # tudo por bolinha escreveu 'prot**g*' no lugar de 'protege' acentuado. So a corrida
        # inicial vira bolinha; o que sobrar no meio sai no relatorio para conserto a mao.
        $mb = [regex]::Match($t, '^' + $FFFD + '+')
        if ($mb.Success) { $t = ($BULL.ToString() * $mb.Length) + $t.Substring($mb.Length) }
        $isDot = $t -match $RX_DOT
        # a escada de bolinhas quebra em varias linhas e a continuacao vem MAIS indentada que
        # o marcador. Sem esta regra cada continuacao virava paragrafo proprio e o nivel saia
        # picado ('One ally of moderate influence and' / 'power'). Dentro da escada so abre
        # paragrafo outra bolinha, ou uma linha que volte para a indentacao do marcador - que
        # e o texto que o livro poe DEPOIS da escada.
        if ($isDot -and $dotInd -lt 0) { $dotInd = $flat[$k].I }
        if ($dotInd -ge 0) { $newPar = $isDot -or ($flat[$k].I -le $dotInd) }
        else { $newPar = $flat[$k].I -ge $pi }

        if ($newPar -and $cur -ne '') { $paras.Add($cur); $cur = '' }
        if ($cur -eq '') { $cur = $t }
        else {
            # de-hifenizacao da quebra de linha: 'fami-' + 'ly' -> 'family'. So quando a
            # letra antes do hifen e minuscula E a linha seguinte comeca minuscula.
            if ($cur -match '[a-z]-$' -and $t -match '^[a-z]') {
                # a colagem tambem acerta palavra que o livro escreve COM hifen ('name-' +
                # 'recognition'). Nao da p/ distinguir sem dicionario, entao cada colagem
                # sai no relatorio: quem le decide, e o que estiver errado vai p/ o override.
                $lw = ''; if ($cur -match '(\S+)-$') { $lw = $Matches[1] }
                $rw = ''; if ($t -match '^(\S+)')    { $rw = $Matches[1] }
                $joins.Add($lw + $rw)
                $cur = $cur.Substring(0, $cur.Length - 1) + $t
            }
            else { $cur = $cur + ' ' + $t }
        }
    }
    if ($cur -ne '') { $paras.Add($cur) }

    $body = @()
    foreach ($p in $paras) {
        $x = $p -replace '\s{2,}', ' '
        $rxEm = ' -- '; $x = $x -replace $rxEm, (' ' + $EMDA + ' ')
        $x = $x -replace "'", $RSQU
        foreach ($k in $HYPHEN_KEEP.Keys) { $x = $x.Replace($k, $HYPHEN_KEEP[$k]) }
        # o mapa do V20 core devolve U+FFFD tambem para as acentuadas, e a unica palavra
        # acentuada dos 47 corpos e 'protege' com os dois agudos (core p.115, Mentor). O
        # relatorio no fim conta U+FFFD que sobrou no meio do texto - se aparecer outra, ela
        # entra aqui, uma por uma, e nunca por regra generica.
        $x = $x.Replace('prot' + $FFFD + 'g' + $FFFD, 'prot' + [char]0xE9 + 'g' + [char]0xE9)
        $body += $x.Trim()
    }
    if ($over.ContainsKey($item)) { $body = @($over[$item] -split '\\n'); $why = 'OVERRIDE' }

    $bad = ([regex]::Matches(($body -join ' '), $FFFD)).Count
    if ($bad -gt 0) { $report.Add("  ^ ${item}: $bad U+FFFD no meio do texto - conferir a mao") }
    $review.Add("### $item | $book p.$page | $why | $(($body -join '').Length) chars")
    foreach ($b in $body) { $review.Add($b); $review.Add('') }
    $review.Add('')
    $tsvRows.Add(($item + "`t" + ($body -join '\n')))
    $report.Add(('{0,-22} {1,-5} p.{2,-4} {3,6} chars  {4}' -f $item, $book, $page, (($body -join '').Length), $why))
}

[IO.File]::WriteAllText($Out, (($review -join "`r`n") + "`r`n"), (New-Object Text.UTF8Encoding($false)))
if ($Tsv -ne '') { [IO.File]::WriteAllText($Tsv, (($tsvRows -join "`n") + "`n"), (New-Object Text.UTF8Encoding($false))) }
$report | ForEach-Object { $_ }
"colagens de hifen ($($joins.Count)) - conferir uma a uma:"
($joins | Sort-Object -Unique) -join '  '
"itens: $($tsvRows.Count) / 47  ->  $Out"
