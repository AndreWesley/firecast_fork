# ATENCAO ENCODING: este arquivo TEM BOM UTF-8 de proposito e nao pode perde-lo.
# Ele carrega literais acentuados que o PowerShell 5.1 precisa ler certo - `pag.` do bloco 1
# de SPEC I21 e os nomes de origem em PT. Sem BOM, o PS 5.1 le .ps1 como ANSI e esses
# literais chegam mojibake NO TEXTO QUE O JOGADOR LE, sem erro nenhum (SPEC B84).
# O extrator (extract_merit_flaw.ps1) resolve o mesmo problema pelo outro lado: la os regex
# casam texto de livro, entao ele e 100% ASCII e monta os curvos com [char]0x2019.
# gen_merit_data.ps1 - monta a lista FINAL de qualidade/defeito a partir de merit_flaw.tsv
# (T750, 135a rodada). Aplica o dedupe ja decidido em merit_flaw_dedupe.md e escreve:
#
#   -OutDir\meritData.lua        MERIT_DATA / FLAW_DATA (SPEC I100d)
#   -OutDir\picker_merit.txt     o bloco de PICKER_LIST["merit"] / ["flaw"] p/ WoD20th.lfm
#   -OutDir\lang_pt.txt          as linhas wod.<nome>=<pt> da secao [pt]
#   -OutDir\lang_en.txt          as linhas wod.<nome>=<nome> da secao [en]
#   -OutDir\ptmap.txt            as linhas ["<en>"] = "<pt>", do mapa PT de WoD20.6.lfm
#
# Nada disso e emendado no lugar por este script: ele SO gera, e quem cola e a tarefa.

param(
    [string]$Research  = (Split-Path -Parent $MyInvocation.MyCommand.Path),
    [string]$OutDir    = (Join-Path $env:TEMP 'meritgen'),
    [string]$BodiesCsv = (Join-Path $env:TEMP 'mf_bodies.csv')
)
$ErrorActionPreference = 'Stop'
New-Item -ItemType Directory -Force $OutDir | Out-Null

# precedencia entre livros. hh ANTES de gr: e o que merit_flaw_dedupe.md decidiu ao ler
# Clear-Sighted lado a lado (gr 4pt x hh 3pt -> fica o do hh).
$PREC = @('core','lotc','hh','gr','bh','anarch','rob','lob','da','tos','dac','bos','sorc','sorcc','m20va')
$TITLE = @{
    core   = 'Vampire: The Masquerade 20th Anniversary Edition'
    da     = 'Vampire: The Dark Ages 20th Anniversary Edition'
    rob    = 'Rites of Blood'
    lotc   = 'Lore of the Clans'
    lob    = 'Lore of the Bloodlines'
    tos    = 'Dark Ages Tome of Secrets'
    dac    = 'Dark Ages Companion'
    bh     = ("The Black Hand: A Guide to the Tal" + [char]0x2019 + "Mahe" + [char]0x2019 + "Ra")
    gr     = 'Ghouls & Revenants'
    anarch = 'Anarchs Unbound'
    hh     = 'The Hunters Hunted II'
    sorc   = 'M20 Sorcerer'
    sorcc  = "Sorcerer's Companion"
    m20va  = 'M20 Victorian Age'
    bos    = 'Book of Secrets'
}
# Regra 3 de merit_flaw_dedupe.md: mecanica DIFERENTE sob o mesmo nome -> `Nome (Origem)`.
# chave = "<nome>|<livro>", valor = o nome final que a ficha oferece.
$SPLIT = @{
    'Bound|core'       = 'Bound (Vampire)'
    'Bound|bos'        = 'Bound (Mage)'
    'Apostate|da'      = 'Apostate (Dark Ages)'
    'Apostate|bh'      = 'Apostate (Modern)'
    'Loyalty|bos'      = 'Loyalty (Mage)'
    'Loyalty|gr'       = 'Loyalty (Vampire)'
    'Oathbreaker|lotc' = 'Oathbreaker (Ravnos)'
    'Berserker|bh'     = 'Berserker (Vampire)'
    'Berserker|bos'    = 'Berserker (Mage)'
    # 6o caso, achado em 2026-08-28 ao aplicar a Q24 e decidido pelo user: `Clear Sighted` e
    # 1 nome para 2 rolagens diferentes - hh p.141 enxerga Obfuscate/Chimerstry com
    # Percepcao + Prontidao contra nivel+3; bos p.75 enxerga ilusao de Esfera com
    # Percepcao + Consciencia, dificuldade 5 + Rank. Jogos diferentes, mecanicas diferentes.
    'Clear Sighted|hh'  = 'Clear Sighted (Hunter)'
    'Clear Sighted|bos' = 'Clear Sighted (Mage)'
}
# A ORIGEM tambem traduz - a ficha ja faz isso nas familias (`Bratovich (Trevas)`,
# `Grimaldi (Moderna)`). Substantivo INVARIAVEL de proposito: o genero do nome muda de
# entrada para entrada (`Apostata` masc., `Lealdade` fem.) e um adjetivo concordaria com um
# so. Nome proprio (Ravnos) nao traduz.
$ORIGIN_PT = @{
    'Vampire'   = 'Vampiro'
    'Mage'      = 'Mago'
    'Hunter'    = 'Caçador'
    'Dark Ages' = 'Idade das Trevas'
    'Modern'    = 'Era Moderna'
    'Ravnos'    = 'Ravnos'
}

# ReadAllLines e UTF-8; Get-Content do PS 5.1 cai em ANSI e devolveria "DÃ©ficit"
$rows = [IO.File]::ReadAllLines("$Research\merit_flaw.tsv") | Where-Object { $_ -notmatch '^#' -and $_.Trim() -ne '' } | ForEach-Object {
    $p = $_ -split "`t"
    [pscustomobject]@{ Raw=$p[0].Trim(); Kind=$p[1].Trim(); Cost=$p[2].Trim(); Book=$p[4].Trim(); Page=$p[5].Trim() }
}
$pt = @{}
[IO.File]::ReadAllLines("$Research\merit_flaw_pt.tsv") | Where-Object { $_ -notmatch '^#' -and $_.Trim() -ne '' } | ForEach-Object {
    $p = $_ -split "`t"
    if ($p.Count -ge 2 -and -not $pt.ContainsKey($p[0])) { $pt[$p[0].Trim()] = $p[1].Trim() }
}

# nome final de cada linha, e a linha VENCEDORA de cada nome (a do livro de maior precedencia)
$best = @{}
foreach ($r in $rows) {
    $name = $r.Raw
    $sk = "$($r.Raw)|$($r.Book)"
    if ($SPLIT.ContainsKey($sk)) { $name = $SPLIT[$sk] }
    elseif ($SPLIT.Keys -match "^$([regex]::Escape($r.Raw))\|") {
        # nome que a Regra 3 desdobra, mas num livro que ela NAO nomeia: fica com o nome cru
        # (e o caso de `Oathbreaker` em bh/bos/da, que a tabela junta num item so)
    }
    # a chave do dedupe ignora CAIXA de proposito, decisao do user 2026-08-28 ("so o core"):
    # `Sleeping With the Enemy` (core p.492) e `Sleeping with the Enemy` (bos p.66) sao o mesmo
    # traco com 2 tipografias e viram 1 item, com a grafia de quem vence a precedencia. O .tsv
    # guarda as 2 linhas - ele e nome x livro, e apagar a evidencia do bos seria perda calada.
    $key = ($r.Kind + '|' + $name).ToLowerInvariant()
    $rank = [array]::IndexOf($PREC, $r.Book); if ($rank -lt 0) { $rank = 99 }
    if (-not $best.ContainsKey($key) -or $rank -lt $best[$key].Rank) {
        $best[$key] = [pscustomobject]@{ Name=$name; Kind=$r.Kind; Cost=$r.Cost; Book=$r.Book; Page=$r.Page; Rank=$rank; Raw=$r.Raw }
    }
}
# ---- Q24: o custo e SEMPRE um numero fixo (SPEC C Q24, I109, T796) ----------------
# Faixa e alternativa nao sao 1 custo, sao N custos impressos curto, e a ficha tem de oferecer
# o que o jogador esta comprando (pedido user 2026-08-29). `1 or 3` vira 2 entradas e `1-5`
# vira 5, cada uma com o SEU numero e o MESMO livro, pagina e corpo - o livro tem 1 verbete so,
# entao texto por nivel seria conteudo inventado (SPEC I109d).
#
# TRES gramaticas e nenhuma quarta: `N` fica, `N to M` / `N-M` e a corrida inteira, `N or M` /
# `N, M or K` sao so os nomeados. String que nao casa nenhuma das 3 PARA o gerador: chutar um
# custo e a ficha votando contra o livro (SPEC I109a, R8, e o precedente de T774).
function CostValues([string]$c) {
    $c = $c.Trim()
    if ($c -eq '') { return @() }                      # os 2 que o livro imprime sem custo
    if ($c -match '^\d+$') { return @([int]$c) }
    if ($c -match '^(\d+)\s*(?:to|-)\s*(\d+)$') {
        $a = [int]$Matches[1]; $b = [int]$Matches[2]
        if ($b -le $a) { throw "custo com faixa invertida ou vazia: '$c'" }
        return @($a..$b)
    }
    if ($c -match '^\d+(\s*,\s*\d+)*\s+or\s+\d+$') {
        return @((($c -replace '\s+or\s+', ',') -split ',') | ForEach-Object { [int]$_.Trim() } | Sort-Object -Unique)
    }
    throw "custo fora das 3 gramaticas de SPEC I109a: '$c'"
}
# Base guarda o nome ANTES do sufixo de custo, e e por ele que os corpos sao procurados: o
# corpo EN ja se acha por Raw (que a particao nao toca) e o PT se achava por Name, que agora
# muda. Sem Base, as 87 que partem perderiam o corpo PT e o arquivo nao seria gravado.
$split = New-Object System.Collections.Generic.List[object]
foreach ($it in $best.Values) {
    $vals = CostValues $it.Cost
    if ($vals.Count -le 1) {
        $split.Add([pscustomobject]@{ Name=$it.Name; Base=$it.Name; Suffix=''; Kind=$it.Kind; Cost=$it.Cost; Book=$it.Book; Page=$it.Page; Raw=$it.Raw })
        continue
    }
    foreach ($v in $vals) {
        $split.Add([pscustomobject]@{ Name="$($it.Name) ($v)"; Base=$it.Name; Suffix=" ($v)"; Kind=$it.Kind; Cost="$v"; Book=$it.Book; Page=$it.Page; Raw=$it.Raw })
    }
}
$items = @($split | Sort-Object Kind, Name)
$merits = @($items | Where-Object Kind -eq 'Merit')
$flaws  = @($items | Where-Object Kind -eq 'Flaw')
$grew = @($items | Where-Object { $_.Suffix -ne '' })
$fromN = @($grew | Group-Object Base, Kind).Count
"itens: {0}  (Merit {1} + Flaw {2})" -f $items.Count, $merits.Count, $flaws.Count
"particao Q24 .....: {0} entrada(s) viraram {1}" -f $fromN, $grew.Count
# Agrupar por BASE e nao por Name: depois da particao um nome de 1 lista so tem N irmas, e
# `Count -gt 1` chamaria de "nas duas listas" toda entrada que partiu. O que define as duas
# listas e o KIND aparecer 2x sob a mesma base (SPEC I102g, B89).
$dup = @($items | Group-Object Base | Where-Object { @($_.Group | Group-Object Kind).Count -gt 1 })
$bothList = @{}
$bothBase = @{}
foreach ($d in $dup) {
    $bothBase[$d.Name] = $true
    foreach ($g in $d.Group) { $bothList[$g.Name] = $true }
}
"nome nas DUAS listas: {0}" -f $dup.Count
foreach ($d in $dup) { '   ' + $d.Name }
$noCost = @($items | Where-Object { $_.Cost -eq '' })
"sem custo no livro : {0}" -f $noCost.Count
foreach ($x in $noCost) { '   {0,-7} p.{1,-5} {2} [{3}]' -f $x.Book, $x.Page, $x.Name, $x.Kind }
$noPt = @($items | Where-Object { -not $pt.ContainsKey($_.Raw) })
"sem traducao PT ...: {0}" -f $noPt.Count
foreach ($x in $noPt) { '   ' + $x.Raw }

function LuaStr($s) { return ($s -replace '\\', '\\' -replace '"', '\"') }
# O sufixo de ORIGEM (Regra 3) traduz; o de CUSTO (Q24) e um numero e nao traduz. Os dois sao
# lidos de campos DIFERENTES de proposito: a origem sai de Base, o custo de Suffix. Ler os dois
# do Name obrigaria a adivinhar, pelo conteudo do parenteses, qual dos dois esta ali.
function PtName($it) {
    $base = if ($pt.ContainsKey($it.Raw)) { $pt[$it.Raw] } else { $it.Raw }
    if ($it.Base -ne $it.Raw -and $it.Base -match '\(([^)]+)\)\s*$') {
        $o = $matches[1]
        if ($ORIGIN_PT.ContainsKey($o)) { $o = $ORIGIN_PT[$o] }
        $base = "$base ($o)"
    }
    return $base + $it.Suffix
}

# ---- meritData.lua ---------------------------------------------------------------
$L = New-Object System.Collections.Generic.List[string]
$L.Add('-- Merit and Flaw book data (SPEC I100d, I100e, I100g / T750).')
$L.Add('--')
$L.Add('-- Data only: no function, no state, no require of gui/ndb/locale (SPEC I24). It lives in a')
$L.Add('-- module and NOT in the <script> of a .lfm because the CDATA is copied raw into')
$L.Add('-- constructNew_*(), so every open sheet would parse its own copy - the disease T479 already')
$L.Add('-- cured for the description tables. The require lives inside mfOpen() (SPEC I107e).')
$L.Add('--')
$L.Add('-- TWO tables, not one. SPEC I100d assumed no name is shared between merits and flaws and')
$L.Add('-- said so was to be CONFIRMED before it held; the sweep found `Cannibal` - a 1pt Merit in')
$L.Add('-- Lore of the Clans p.106 (you can eat food) and a 3pt Flaw in Ghouls & Revenants p.136')
$L.Add('-- (compulsion for human flesh). Opposite mechanics, and the sheet already keeps the two')
$L.Add('-- tables apart (dedupe rule 0), so one table keyed by name cannot carry both.')
$L.Add('--')
$L.Add('-- `cost` is a STRING holding ONE fixed number, and that is the whole of SPEC C Q24: the')
$L.Add('-- books print `2 or 4` and `1-3`, and an entry written that way is N entries printed')
$L.Add('-- short. They are SPLIT here - `Acute Senses` at `1 or 3` ships as `Acute Senses (1)`')
$L.Add('-- and `Acute Senses (3)`, same book, same page, same description (SPEC I109b, I109d).')
$L.Add('-- TWO entries of M20 Victorian Age carry no cost at all (notation 7 prints the category')
$L.Add('-- only) and keep an empty string: there is no number to suffix and inventing one would')
$L.Add('-- be the sheet voting against the book (SPEC V340a, V348b).')
$L.Add('-- `book` is the TITLE spelled out, matching block 1 of SPEC I21; the title does not')
$L.Add('-- translate, only `p.`/`pag.` does.')
$L.Add('--')
$L.Add('-- Generated by research/gen_merit_data.ps1 from research/merit_flaw.tsv. Do not hand-edit.')
$L.Add('')
foreach ($pair in @(@('MERIT_DATA', $merits), @('FLAW_DATA', $flaws))) {
    $L.Add("local $($pair[0]) = {")
    foreach ($it in $pair[1]) {
        $L.Add(('	["{0}"] = {{ book = "{1}", page = "{2}", cost = "{3}" }},' -f (LuaStr $it.Name), (LuaStr $TITLE[$it.Book]), $it.Page, (LuaStr $it.Cost)))
    }
    $L.Add('};')
    $L.Add('')
}
$L.Add('return { merit = MERIT_DATA, flaw = FLAW_DATA };')
[IO.File]::WriteAllText("$OutDir\meritData.lua", (($L -join "`r`n") + "`r`n"), (New-Object Text.UTF8Encoding $false))

# ---- bloco de PICKER_LIST --------------------------------------------------------
function PickerBlock($key, $list) {
    $o = New-Object System.Collections.Generic.List[string]
    $o.Add("				[""$key""] = {")
    $line = '					""'
    foreach ($it in $list) {
        $s = ', "' + (LuaStr $it.Name) + '"'
        if (($line.Length + $s.Length) -gt 108) { $o.Add($line + ','); $line = '					"' + (LuaStr $it.Name) + '"' }
        else { $line += $s }
    }
    $o.Add($line + ',')
    $o.Add('				},')
    return $o
}
$pk = New-Object System.Collections.Generic.List[string]
foreach ($x in (PickerBlock 'merit' $merits)) { $pk.Add($x) }
foreach ($x in (PickerBlock 'flaw'  $flaws))  { $pk.Add($x) }
[IO.File]::WriteAllText("$OutDir\picker_merit.txt", (($pk -join "`r`n") + "`r`n"), (New-Object Text.UTF8Encoding $false))

# ---- .lang e mapa PT -------------------------------------------------------------
$names = @($items.Name | Sort-Object -Unique)
$ptOf = @{}
foreach ($it in $items) { if (-not $ptOf.ContainsKey($it.Name)) { $ptOf[$it.Name] = (PtName $it) } }
[IO.File]::WriteAllText("$OutDir\lang_pt.txt", ((@($names | ForEach-Object { "wod.$_=$($ptOf[$_])" })) -join "`r`n") + "`r`n", (New-Object Text.UTF8Encoding $false))
[IO.File]::WriteAllText("$OutDir\lang_en.txt", ((@($names | ForEach-Object { "wod.$_=$_" })) -join "`r`n") + "`r`n", (New-Object Text.UTF8Encoding $false))
[IO.File]::WriteAllText("$OutDir\ptmap.txt", ((@($names | ForEach-Object { '				["' + (LuaStr $_) + '"] = "' + (LuaStr $ptOf[$_]) + '",' })) -join "`r`n") + "`r`n", (New-Object Text.UTF8Encoding $false))

# ---- descMerit_en.lua / descMerit_pt.lua (T751, forma de 3 blocos de SPEC I21) -----
# corpo EN: merit_flaw_overrides.tsv manda, senao o CSV do extrator, casado por <livro>|<nome cru>
$ovr = @{}
if (Test-Path "$Research\merit_flaw_overrides.tsv") {
    foreach ($ln in [IO.File]::ReadAllLines("$Research\merit_flaw_overrides.tsv")) {
        if ($ln -match '^#' -or $ln.Trim() -eq '') { continue }
        $c = $ln -split "`t"
        if ($c.Count -ge 4) { $ovr["$($c[1].Trim())|$($c[0].Trim())"] = $c[3] }
    }
}
$body = @{}
if (Test-Path $BodiesCsv) {
    foreach ($r in (Import-Csv $BodiesCsv)) {
        $k = "$($r.Book)|$($r.Name)"
        if (-not $body.ContainsKey($k) -or [int]$body[$k].Len -lt [int]$r.Len) { $body[$k] = $r }
    }
}
$ptBody = @{}
if (Test-Path "$Research\merit_flaw_body_pt.tsv") {
    foreach ($ln in [IO.File]::ReadAllLines("$Research\merit_flaw_body_pt.tsv")) {
        if ($ln -match '^#' -or $ln.Trim() -eq '') { continue }
        $c = $ln -split "`t"
        if ($c.Count -ge 2 -and $c[1].Trim() -ne '') { $ptBody[$c[0].Trim()] = $c[1] }
    }
}
function Blocks($it, $lang, $txt) {
    $pg = if ($lang -eq 'pt') { 'pág.' } else { 'p.' }
    # LF, a forma da CASA (SPEC V345, B87). MEDIDO byte a byte: descDisc, descNumina, descPath e
    # descRitual somam 0 CR entre os 4. O descMerit_en.lua da 136a rodada saiu CRLF e por um
    # tempo pareceu ser ele o padrao - nao e, e quem disse o contrario foi um `grep -c` que nao
    # interpretou o \r. Misturar as duas formas nao muda 1 char de texto e faz o diff do arquivo
    # mentir sobre o que a rodada fez.
    $b3 = ($txt -replace '\\n', "`n`n")
    return "$($TITLE[$it.Book]), $pg $($it.Page)`n`n`n$($it.Name)`n`n`n$b3"
}
$missEn = @(); $missPt = @()
$D = New-Object System.Collections.Generic.List[string]
$D.Add('-- Merit and Flaw descriptions, the [{0}] half (SPEC I102e, I21, V210 / T751).')
$D.Add('--')
$D.Add('-- One entry per item of PICKER_LIST["merit"] and ["flaw"], keyed in ENGLISH because that is')
$D.Add('-- what the sheet saves (SPEC V24). Three blocks, exactly as the eight description modules')
$D.Add('-- already do: "<Book>, p. <n>" - blank - blank - <Name> - blank - blank - <text>. The book')
$D.Add('-- title does not translate; only p./pag. does (SPEC I100e).')
$D.Add('--')
$D.Add('-- One module PER LANGUAGE and never both halves in one file (SPEC V210): half of every')
$D.Add('-- module was the language the session never opens, and require pulled both in to read one.')
$D.Add('-- The renderer builds the name by concatenation - require("descMerit_" .. half .. ".lua")')
$D.Add('-- and never a constant name (SPEC V210b).')
$D.Add('--')
$D.Add('-- Data only: no function, no state, no require of gui/ndb/locale (SPEC I24).')
$D.Add('-- Generated by research/gen_merit_data.ps1 from research/merit_flaw.tsv and the bodies')
$D.Add('-- research/extract_merit_flaw.ps1 pulls out of the books. Do not hand-edit.')
$D.Add('')
foreach ($lang in @('en', 'pt')) {
    $o = New-Object System.Collections.Generic.List[string]
    foreach ($x in $D) { $o.Add(($x -f $lang)) }
    $o.Add('return {')
    $o.Add("`t`t`t`t-- >>> MERIT_DESC_BEGIN (generated - SPEC T751)")
    $n = 0
    foreach ($it in $items) {
        $k = "$($it.Book)|$($it.Raw)"
        $txt = if ($lang -eq 'en') {
            if ($ovr.ContainsKey($k)) { $ovr[$k] } elseif ($body.ContainsKey($k)) { $body[$k].Body } else { '' }
        } else {
            # Composta primeiro, nua depois: os 2 `Cannibal` tem corpos EN DIFERENTES (lotc e a
            # Qualidade, gr e o Defeito) e por isso precisam de 2 corpos PT tambem. Cair na nua
            # aqui e o que fazia os dois mostrarem o mesmo texto (SPEC I102g, B89).
            # Por BASE e nao por Name: as N irmas de uma entrada partida dividem 1 corpo, que e
            # o que I109d manda. Buscar por Name daria 0 corpo para as 87 que partiram.
            $kPt = $it.Kind.ToLowerInvariant() + '|' + $it.Base
            if ($ptBody.ContainsKey($kPt)) { $ptBody[$kPt] }
            elseif (-not $bothBase.ContainsKey($it.Base) -and $ptBody.ContainsKey($it.Base)) { $ptBody[$it.Base] }
            else { '' }
        }
        if ($txt -eq '') {
            if ($lang -eq 'en') { $missEn += "$($it.Kind)|$($it.Name) ($($it.Book) p.$($it.Page))" } else { $missPt += $it.Name }
            continue
        }
        # Chave COMPOSTA so onde o nome esta nas DUAS listas (SPEC I102g, B89). A tabela de
        # descricao e PLANA por nome: `Cannibal` e Qualidade (lotc p.106) E Defeito (gr p.136),
        # e em Lua a 2a chave sobrescreve a 1a - um dos dois abria a descricao do outro, calado.
        # Nome de 1 lista so segue com a chave NUA: prefixo sem colisao e ruido.
        $descKey = $(if ($bothList.ContainsKey($it.Name)) { $it.Kind.ToLowerInvariant() + '|' + $it.Name } else { $it.Name })
        # (bothList e keyed pelo nome FINAL: uma base nas 2 listas marca todas as irmas dela)
        $o.Add(("`t`t`t`t[""{0}""] = {{" -f (LuaStr $descKey)))
        $o.Add(("`t`t`t`t`t{0} = [==[{1}]==]," -f $lang, (Blocks $it $lang $txt)))
        $o.Add("`t`t`t`t},")
        $n++
    }
    $o.Add("`t`t`t`t-- <<< MERIT_DESC_END")
    $o.Add('};')
    if ($lang -eq 'en' -or $missPt.Count -eq 0) {
        # LF tambem AQUI, nao so dentro do literal: o arquivo inteiro quebra linha de um jeito
        # so, e esse jeito e o dos outros 8 modulos de descricao (SPEC V345).
        [IO.File]::WriteAllText("$OutDir\descMerit_$lang.lua", (($o -join "`n") + "`n"), (New-Object Text.UTF8Encoding $false))
        "descMerit_$lang.lua : $n entradas"
    } else {
        "descMerit_pt.lua .. NAO GRAVADO: faltam $($missPt.Count) de $($items.Count) corpos traduzidos (SPEC V210a: os 2 lados carregam as MESMAS chaves)"
    }
}
if ($missEn.Count) { "sem corpo EN ......: $($missEn.Count)"; $missEn | ForEach-Object { '   ' + $_ } }
# a lista do que falta traduzir, na ordem em que o .lua a quer
[IO.File]::WriteAllText("$OutDir\pt_pendente.txt", (($missPt -join "`r`n") + "`r`n"), (New-Object Text.UTF8Encoding $false))

"gravado em $OutDir"
