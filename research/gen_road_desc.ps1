#Requires -Version 5.1
<#
    gen_road_desc.ps1 - escreve descRoad_en.lua e descRoad_pt.lua (T931, I141, V210, V409).

    DETERMINISTICO. Roda quantas vezes quiser: le so os .tsv de research/ e os 2 .lfm, e
    reescreve os 2 modulos inteiros. Nao ha edicao a mao nos .lua - se o texto esta errado, o
    errado esta num .tsv, e e la que se conserta.

    ENTRADA (research/):
      road_bearing.tsv           nome -> livro + pagina da SECAO (o bloco 1) + epoca
      road_aura_map.tsv          nome -> bid          | road_aura_raw.tsv + _overrides.tsv -> prosa
      road_sins_map.tsv          nome -> tid + tid_mae| road_sins_raw.tsv + _overrides.tsv -> tabela
      road_sins_titles.tsv       tid  -> cabecalho da tabela, nos 2 idiomas
      road_aura_pt.tsv           bid  -> prosa em pt
      road_sins_pt.tsv           (tid, score) -> wrongdoing + rationale em pt
    E os 2 .lfm, que sao a AUTORIDADE e nao copia:
      WoD20th.lfm   PICKER_LIST["road"] (a ordem e as chaves, V24) e BEARING (o nome da aura)
      WoD20.6.lfm   o mapa PT (o nome da aura em portugues - o MESMO que a linha de ROAD mostra)

    4 BLOCOS separados por 2 LINHAS EM BRANCO (I141a, I21, Q56):
      1  <Titulo do livro>, p. <n>      (em pt so o "p." vira "pag.", o titulo NAO traduz, I100e)
      2  <nome>                          (NAO traduz - e a chave, e o que descPath_pt ja faz)
      3  Aura: <Nome>. <prosa do livro>  (I141b)
      4  <cabecalho da tabela> + os niveis (I141c)

    A FUSAO E ASSADA NA STRING (I141f): o filho carrega a tabela da mae com os niveis que ele
    nomeia SUBSTITUIDOS, ja pronta. Nada em runtime precisa saber quem e mae de quem.
#>
param(
    [string]$Research = $PSScriptRoot,
    [string]$Plugin = (Join-Path (Split-Path $PSScriptRoot -Parent) 'Plugins\Sheets\World of Darkness 20th Anniversary Edition')
)
$ErrorActionPreference = 'Stop'

$BOOK_TITLE = @{
    core = 'Vampire: The Masquerade 20th Anniversary Edition'
    da   = 'Vampire: The Dark Ages 20th Anniversary Edition'
    # I142h: U+2019 e DELIMITADOR DE STRING no PS 5.1 - 'Tal’Mahe’Ra' fecha a string no
    # apostrofo curvo e o resto da linha vira codigo. O titulo entra por [char].
    bh   = ('The Black Hand: A Guide to the Tal' + [char]0x2019 + 'Mahe' + [char]0x2019 + 'Ra')
    lotc = 'Lore of the Clans'
    dac  = 'Dark Ages Companion'
}

function ReadRows([string]$path) {
    $out = New-Object System.Collections.ArrayList
    if (-not (Test-Path -LiteralPath $path)) { return $out }
    $txt = [Text.Encoding]::UTF8.GetString([IO.File]::ReadAllBytes($path))
    if ($txt.Length -gt 0 -and $txt[0] -eq [char]0xFEFF) { $txt = $txt.Substring(1) }
    foreach ($l in ($txt -split "`r?`n")) {
        if ($l.Trim() -eq '' -or $l.StartsWith('#')) { continue }
        [void]$out.Add($l -split "`t")
    }
    return $out
}
function Cell($row, [int]$i) { if ($row.Count -gt $i) { return $row[$i] } else { return '' } }

# ---------------------------------------------------------------- os 2 .lfm sao a autoridade
$rootLua = [Text.Encoding]::UTF8.GetString([IO.File]::ReadAllBytes((Join-Path $Plugin 'WoD20th\WoD20th.lfm')))
$m = [regex]::Match($rootLua, '(?s)\["road"\] = \{(.*?)\n\t{4}\},')
if (-not $m.Success) { throw 'PICKER_LIST["road"] nao encontrado' }
$PICKER = @()
foreach ($q in [regex]::Matches($m.Groups[1].Value, '"([^"]*)"')) { $PICKER += $q.Groups[1].Value }

$bm = [regex]::Match($rootLua, '(?s)\n\t{4}BEARING = \{(.*?)\n\t{4}\};')
if (-not $bm.Success) { throw 'BEARING nao encontrado' }
$BEARING = @{}
foreach ($q in [regex]::Matches($bm.Groups[1].Value, '\["([^"]+)"\]\s*=\s*"([^"]*)"')) { $BEARING[$q.Groups[1].Value] = $q.Groups[2].Value }

$ptLua = [Text.Encoding]::UTF8.GetString([IO.File]::ReadAllBytes((Join-Path $Plugin 'WoD20th\WoD20.6.lfm')))
$pm = [regex]::Match($ptLua, '(?s)local PT = \{(.*?)\n\s*\};')
$PTMAP = @{}
foreach ($q in [regex]::Matches($pm.Groups[1].Value, '\["([^"]+)"\]\s*=\s*"([^"]*)"')) { $PTMAP[$q.Groups[1].Value] = $q.Groups[2].Value }

# ---------------------------------------------------------------- research/
# NAO chamar isto de $bearing: PowerShell e case-insensitive em nome de variavel, e ele
# seria a MESMA caixa que o $BEARING lido do .lfm acima. Custou um "Aura:
# System.Collections.Hashtable." nas 55 entradas, com o gerador saindo 0 e o log limpo.
$sectionOf = @{}
foreach ($r in (ReadRows (Join-Path $Research 'road_bearing.tsv'))) {
    $sectionOf[$r[0]] = @{ Book = (Cell $r 2); Page = (Cell $r 3) }
}

$auraBid = @{}
foreach ($r in (ReadRows (Join-Path $Research 'road_aura_map.tsv'))) { $auraBid[$r[0]] = $r[1] }

$auraBlock = @{}
foreach ($r in (ReadRows (Join-Path $Research 'road_aura_raw.tsv'))) { $auraBlock[$r[0]] = (Cell $r 3) }
foreach ($r in (ReadRows (Join-Path $Research 'road_aura_overrides.tsv'))) { $auraBlock[$r[0]] = (Cell $r 2) }

$auraPt = @{}
foreach ($r in (ReadRows (Join-Path $Research 'road_aura_pt.tsv'))) { $auraPt[$r[0]] = (Cell $r 1) }

$sinsTid = @{}
$sinsMae = @{}
foreach ($r in (ReadRows (Join-Path $Research 'road_sins_map.tsv'))) {
    $sinsTid[$r[0]] = (Cell $r 1)
    $mae = Cell $r 2
    if ($mae -ne '' -and $mae -ne '!SEM-MAE') { $sinsMae[$r[0]] = $mae }
}

$titleEn = @{}; $titlePt = @{}
foreach ($r in (ReadRows (Join-Path $Research 'road_sins_titles.tsv'))) {
    $titleEn[$r[0]] = (Cell $r 1); $titlePt[$r[0]] = (Cell $r 2)
}

# tabela: tid -> score -> @{ W; R }
$table = @{}
function PutRow([string]$tid, [string]$score, [string]$w, [string]$r) {
    if (-not $table.ContainsKey($tid)) { $table[$tid] = @{} }
    $table[$tid][$score] = @{ W = $w; R = $r }
}
foreach ($r in (ReadRows (Join-Path $Research 'road_sins_raw.tsv'))) { PutRow $r[0] (Cell $r 4) (Cell $r 5) (Cell $r 6) }
foreach ($r in (ReadRows (Join-Path $Research 'road_sins_overrides.tsv'))) { PutRow $r[0] (Cell $r 1) (Cell $r 2) (Cell $r 3) }

$sinsPt = @{}
foreach ($r in (ReadRows (Join-Path $Research 'road_sins_pt.tsv'))) {
    $k = "$($r[0])|$(Cell $r 1)"
    $sinsPt[$k] = @{ W = (Cell $r 2); R = (Cell $r 3) }
}

# ---------------------------------------------------------------- montagem
$MISSING = New-Object System.Collections.ArrayList
function Want([string]$got, [string]$what) {
    if ($got -eq $null -or $got -eq '') { [void]$MISSING.Add($what); return "((FALTA $what))" }
    return $got
}

# I141e: a base e SEMPRE a tabela da mae; o nivel que o filho nomeia TROCA a linha daquele nivel.
function FusedRows([string]$tid, [string]$mae) {
    $rows = @{}
    if ($mae -ne '' -and $table.ContainsKey($mae)) {
        foreach ($s in $table[$mae].Keys) { $rows[$s] = @{ Tid = $mae; Score = $s } }
    }
    if ($table.ContainsKey($tid)) {
        foreach ($s in $table[$tid].Keys) { $rows[$s] = @{ Tid = $tid; Score = $s } }
    }
    return ($rows.Keys | Sort-Object { [int]$_ } -Descending | ForEach-Object { $rows[$_] })
}

function BuildTable([string]$name, [string]$lang) {
    $tid = $sinsTid[$name]
    $mae = ''
    if ($sinsMae.ContainsKey($name)) { $mae = $sinsMae[$name] }
    $t = if ($lang -eq 'pt') { $titlePt[$tid] } else { $titleEn[$tid] }
    if (($null -eq $t -or $t -eq '') -and $mae -ne '') { $t = if ($lang -eq 'pt') { $titlePt[$mae] } else { $titleEn[$mae] } }
    $lines = New-Object System.Collections.ArrayList
    [void]$lines.Add((Want $t "titulo $tid $lang"))
    [void]$lines.Add('')
    foreach ($e in (FusedRows $tid $mae)) {
        $cell = $table[$e.Tid][$e.Score]
        $w = $cell.W; $r = $cell.R
        if ($lang -eq 'pt') {
            $k = "$($e.Tid)|$($e.Score)"
            if ($sinsPt.ContainsKey($k)) { $w = $sinsPt[$k].W; $r = $sinsPt[$k].R }
            else { $w = "((FALTA pt $k))"; [void]$MISSING.Add("pt $k"); $r = '' }
        }
        [void]$lines.Add("$($e.Score) — $w")
        if ($r -ne '') { [void]$lines.Add("      $r") }
        [void]$lines.Add('')
    }
    while ($lines.Count -gt 0 -and $lines[$lines.Count - 1] -eq '') { $lines.RemoveAt($lines.Count - 1) }
    return ($lines -join "`n")
}

function BuildEntry([string]$name, [string]$lang) {
    $b = $sectionOf[$name]
    if ($null -eq $b) { throw "road_bearing.tsv nao tem '$name'" }
    $title = $BOOK_TITLE[$b.Book]
    if ($null -eq $title) { throw "livro '$($b.Book)' sem titulo (nome '$name')" }
    $pfx = if ($lang -eq 'pt') { 'pág.' } else { 'p.' }

    $bid = $auraBid[$name]
    $prose = if ($lang -eq 'pt') { Want $auraPt[$bid] "aura pt $bid" } else { Want $auraBlock[$bid] "aura en $bid" }
    $auraName = $BEARING[$name]
    if ($lang -eq 'pt' -and $PTMAP.ContainsKey($auraName)) { $auraName = $PTMAP[$auraName] }

    $blocks = @(
        "$title, $pfx $($b.Page)",
        $name,
        "Aura: $auraName. $prose",
        (BuildTable $name $lang)
    )
    return ($blocks -join "`n`n`n")
}

function WriteModule([string]$lang) {
    $out = New-Object System.Collections.Generic.List[string]
    $out.Add("-- Road/Path descriptions, the [$lang] half (SPEC I141, I21, V210, V409 / T931).")
    $out.Add('--')
    $out.Add('-- One entry per item of PICKER_LIST["road"], keyed by the value the sheet SAVES, byte for')
    $out.Add('-- byte (SPEC V24, I142e): "Path of Humanity", not "Humanity". Both halves carry the SAME')
    $out.Add('-- 55 keys - a name in one and not the other reddens V210 in both directions.')
    $out.Add('--')
    $out.Add('-- FOUR blocks, not three (SPEC I141a): the third block of I21 splits in two, into the AURA')
    $out.Add('-- and the hierarchy of sins. Separator is the same two blank lines the other ten modules')
    $out.Add('-- use (SPEC Q56). The book title does not translate; only p./pag. does (SPEC I100e), and')
    $out.Add('-- neither does the name in block 2 - it is the key.')
    $out.Add('--')
    $out.Add('-- The aura name is the string BEARING already shows on the ROAD line of the Main tab, read')
    $out.Add('-- from WoD20th.lfm at generation time (SPEC I141b): there is no second identity for it, and')
    $out.Add('-- V409(c) measures exactly that. The pt spelling is the sheet PT map, same single owner.')
    $out.Add('--')
    $out.Add('-- A Path that inherits its table carries the mother table with its own levels SUBSTITUTED,')
    $out.Add('-- BAKED into the string (SPEC I141e, I141f): the levels it does not name keep the mother')
    $out.Add('-- text verbatim, so nothing at runtime needs to know who is mother to whom.')
    $out.Add('--')
    $out.Add('-- Data only: no function, no state, no require of gui/ndb/locale (SPEC I24).')
    $out.Add('-- GENERATED by research/gen_road_desc.ps1 from the .tsv in research/. Do not hand-edit:')
    $out.Add('-- fix the .tsv and run it again.')
    $out.Add('')
    $out.Add('return {')
    $out.Add("`t`t`t`t-- >>> ROAD_DESC_BEGIN (generated - SPEC T931)")
    foreach ($name in $PICKER) {
        $body = BuildEntry $name $lang
        $out.Add("`t`t`t`t[`"$name`"] = {")
        $out.Add("`t`t`t`t`t$lang = [==[$body]==],")
        $out.Add("`t`t`t`t},")
    }
    $out.Add("`t`t`t`t-- <<< ROAD_DESC_END")
    $out.Add('};')
    $path = Join-Path $Plugin "descRoad_$lang.lua"
    # V345/B87: os modulos de descricao sao LF de ponta a ponta, ao contrario do resto do repo,
    # que e CRLF. Juntar com CRLF aqui deixa o arquivo MISTO (o corpo das entradas ja e LF) e o
    # gate conta os dois - foram 192 CRLF entre 2308 quebras na 1a escrita.
    [IO.File]::WriteAllText($path, (($out -join "`n") + "`n"), (New-Object Text.UTF8Encoding($false)))
    return $path
}

foreach ($lang in @('en', 'pt')) {
    $p = WriteModule $lang
    Write-Output ("{0}  {1} entradas  {2} bytes" -f (Split-Path $p -Leaf), $PICKER.Count, (Get-Item -LiteralPath $p).Length)
}
if ($MISSING.Count -gt 0) {
    $u = $MISSING | Sort-Object -Unique
    Write-Output "FALTAM $($u.Count) pecas de dado:"
    foreach ($x in ($u | Select-Object -First 25)) { Write-Output "  - $x" }
    if ($u.Count -gt 25) { Write-Output "  ... e mais $($u.Count - 25)" }
}
else { Write-Output 'COMPLETO - nenhum buraco de dado' }
