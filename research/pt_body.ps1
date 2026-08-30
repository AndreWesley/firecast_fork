# pt_body.ps1 - a bancada da metade PT de SPEC T751.
#
# ASCII-only DE PROPOSITO (SPEC B84): .ps1 sem BOM e lido como ANSI pelo PS 5.1, e literal
# acentuado dentro de regex falha CALADO. Todo texto acentuado aqui e LIDO de arquivo.
#
# O corpo EN sai do descMerit_en.lua ja instalado (nao do PDF): ele ja tem os 3 blocos de
# SPEC I21 e as 647 chaves finais. O corpo PT vai para research/merit_flaw_body_pt.tsv, que
# e o que gen_merit_data.ps1 le para escrever descMerit_pt.lua.
#
#   .\pt_body.ps1 -Plan              quanto falta, e onde comeca o proximo lote
#   .\pt_body.ps1 -Next [-Budget N]  imprime o proximo lote de corpos EN (N chars, padrao 13000)
#   .\pt_body.ps1 -Append <arquivo>  valida e anexa um lote traduzido (<nome EN>TAB<corpo PT>)
#
# O \n de 2 chars no corpo e QUEBRA DE PARAGRAFO - gen_merit_data.ps1 o troca por linha em
# branco. Nao use quebra de linha de verdade: uma linha do TSV = uma entrada.
param(
    [switch]$Plan,
    [switch]$Next,
    [string]$Append = '',
    [int]$Budget = 13000
)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$lua  = Join-Path $root 'Plugins\Sheets\World of Darkness 20th Anniversary Edition\descMerit_en.lua'
$tgt  = Join-Path $PSScriptRoot 'merit_flaw_body_pt.tsv'
$enc  = New-Object Text.UTF8Encoding($false)

# ---- corpo EN, de volta a forma <nome>TAB<corpo com o \n de 2 chars> --------------------
$txt = [IO.File]::ReadAllText($lua)
$rx  = [regex]'(?s)\["((?:[^"\\]|\\.)*)"\] = \{\r?\n\s*en = \[==\[(.*?)\]==\],'
$en    = New-Object System.Collections.Generic.List[object]
$seen  = @{}
foreach ($m in $rx.Matches($txt)) {
    $name = $m.Groups[1].Value -replace '\\"', '"' -replace "\\\\", "\"
    # RESOLVIDO em T791: `Cannibal` e Qualidade E Defeito e a tabela de descricao e PLANA por
    # nome, entao a 2a chave sobrescrevia a 1a em Lua (SPEC B89). Agora os nomes que estao nas
    # DUAS listas saem com chave COMPOSTA (`merit|Cannibal` / `flaw|Cannibal`, SPEC I102g) e o
    # total virou 647, nao 646. Este guarda FICA: ele e o que denuncia a volta da colisao, e
    # V344 e quem reprova de verdade.
    if ($seen.ContainsKey($name)) { continue }
    $seen[$name] = $true
    $blocks = ($m.Groups[2].Value -replace "`r", '') -split "`n`n`n"
    if ($blocks.Count -lt 3) { "FAIL $name : $($blocks.Count) bloco(s), esperado 3 (SPEC I21)"; exit 1 }
    $flat = ($blocks[2..($blocks.Count - 1)] -join "`n`n`n") -replace "`n`n", '\n'
    if ($flat.Contains("`n")) { "FAIL $name : sobrou quebra de linha de verdade no corpo"; exit 1 }
    $en.Add([pscustomobject]@{ Name = $name; Body = $flat })
}

# ---- o que ja esta traduzido -----------------------------------------------------------
$have = @{}; $rows = New-Object System.Collections.Generic.List[string]
if (Test-Path $tgt) {
    foreach ($l in [IO.File]::ReadAllLines($tgt)) {
        $rows.Add($l)
        if ($l -match '^#' -or $l.Trim() -eq '') { continue }
        $have[($l -split "`t")[0]] = $true
    }
} else {
    $rows.Add('# merit_flaw_body_pt.tsv - corpo PT de cada qualidade/defeito (SPEC T751, I21, V210)')
    $rows.Add('#')
    $rows.Add('# colunas: nome_EN canonico <TAB> corpo_PT. O \n de 2 chars e QUEBRA DE PARAGRAFO.')
    $rows.Add('# Nome da entrada e titulo do livro NAO traduzem (I100e); so p. -> pag., e o gerador faz isso.')
    $rows.Add('#')
}

if ($Plan) {
    $falta = @($en | Where-Object { -not $have.ContainsKey($_.Name) })
    "total=$($en.Count)  traduzidos=$($have.Count)  faltam=$($falta.Count)"
    if ($falta.Count) { "proximo: $($falta[0].Name)" }
    return
}

if ($Next) {
    $sum = 0; $out = New-Object System.Collections.Generic.List[string]
    foreach ($e in $en) {
        if ($have.ContainsKey($e.Name)) { continue }
        $len = $e.Name.Length + 1 + $e.Body.Length
        if ($sum -gt 0 -and ($sum + $len) -gt $Budget) { break }
        $sum += $len
        $out.Add(("{0}`t{1}" -f $e.Name, $e.Body))
    }
    "=== LOTE: $($out.Count) entradas, $sum chars ==="
    $out | ForEach-Object { $_ }
    return
}

if ($Append -ne '') {
    if (-not (Test-Path $Append)) { "FAIL arquivo nao encontrado: $Append"; exit 1 }
    $known = @{}; foreach ($e in $en) { $known[$e.Name] = $true }
    $bad = @(); $n = 0
    foreach ($l in [IO.File]::ReadAllLines($Append)) {
        if ($l.Trim() -eq '') { continue }
        $c = $l -split "`t"
        if ($c.Count -ne 2)          { $bad += "nao tem exatamente 2 colunas: $($l.Substring(0, [math]::Min(60, $l.Length)))"; continue }
        if (-not $known.ContainsKey($c[0])) { $bad += "chave desconhecida: '$($c[0])'"; continue }
        if ($have.ContainsKey($c[0]))       { $bad += "chave repetida: '$($c[0])'"; continue }
        if ($c[1].Trim() -eq '')     { $bad += "corpo vazio: '$($c[0])'"; continue }
        $have[$c[0]] = $true; $rows.Add($l); $n++
    }
    if ($bad) { $bad | ForEach-Object { "FAIL $_" }; exit 1 }
    [IO.File]::WriteAllText($tgt, (($rows -join "`r`n") + "`r`n"), $enc)
    "OK +$n  traduzidos=$($have.Count)/$($en.Count)"
    return
}

'uso: -Plan | -Next [-Budget N] | -Append <arquivo>'
