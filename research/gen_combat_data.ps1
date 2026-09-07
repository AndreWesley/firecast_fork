# ATENCAO ENCODING: este arquivo TEM BOM UTF-8 de proposito e nao pode perde-lo, como o
# gen_merit_data.ps1 ao lado (SPEC B84). O CODIGO e 100% ASCII: todo acento sai ou dos DADOS
# lidos das TSVs, ou de um [char]0x.. montado abaixo. O PowerShell 5.1 le .ps1 sem BOM como
# ANSI, e um literal acentuado chegaria mojibake DENTRO DO TEXTO QUE O JOGADOR LE, sem erro.
#
# gen_combat_data.ps1 - monta o dado dos 2 pickers de COMBAT a partir de research/weapon.tsv
# (17 colunas, 189 armas) e research/armor.tsv (9 colunas, 33 protecoes: 29 armor + 4 shield,
# partidas pela coluna kind). SPEC T1004, T1012, T1019, I157c, I157d, I157h, I157i, I157p,
# I158a, I158e, I159b, R151, R152, R154, R157, R159.
#
#   -OutDir\combatData.lua      WEAPON_DATA / ARMOR_DATA (SPEC I157d), CRLF como meritData.lua
#   -OutDir\descWeapon_en.lua   as 3 caixas de SPEC I21, 1 entrada por arma  (LF, SPEC V345)
#   -OutDir\descWeapon_pt.lua   idem                                          + a chave Conceal
#   -OutDir\descArmor_en.lua    1 entrada por armadura                        (LF)
#   -OutDir\descArmor_pt.lua    idem
#   -OutDir\picker_combat.txt   os 3 blocos de PICKER_LIST p/ WoD20th.lfm (weapon/armor/shield)
#   -OutDir\lang_pt.txt         as linhas wod.<nome>=<pt> da secao [pt]
#   -OutDir\lang_en.txt         as linhas wod.<nome>=<nome> da secao [en]
#   -OutDir\ptmap.txt           as linhas ["<en>"] = "<pt>", do mapa PT de WoD20.6.lfm
#
# Nada disso e emendado no lugar por este script: ele SO gera, e quem cola e a tarefa (T1006,
# T1007) - a mesma divisao de gen_merit_data.ps1.

param(
    [string]$Research = (Split-Path -Parent $MyInvocation.MyCommand.Path),
    [string]$OutDir   = (Join-Path $env:TEMP 'combatgen'),
    [string]$Map      = (Join-Path (Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)) 'Plugins\Sheets\World of Darkness 20th Anniversary Edition\WoD20th\WoD20.6.lfm')
)
$ErrorActionPreference = 'Stop'
New-Item -ItemType Directory -Force $OutDir | Out-Null
$U8 = New-Object Text.UTF8Encoding($false)

$PAG = 'p' + [char]0xE1 + 'g.'                                     # pag.
$MID = ' ' + [char]0xB7 + ' '                                      # o ponto medio da legenda

# Titulo por extenso, a mesma grafia de research/README.md e dos 10 modulos que ja existem.
# O titulo NAO traduz; so o rotulo p./pag. muda de idioma (SPEC I100e, I21).
$TITLE = @{
    core = 'Vampire: The Masquerade 20th Anniversary Edition'
    da   = 'Vampire: The Dark Ages 20th Anniversary Edition'
    m20  = 'Mage: The Ascension 20th Anniversary Edition'
    w20  = 'Werewolf: The Apocalypse 20th Anniversary Edition'
    ca   = 'Vampire: The Classical Age 20th Anniversary Edition'
}

# As 7 celulas da arma e as 3 da armadura, na ordem em que SPEC I157h manda imprimi-las.
$W_LAB_EN = @('Roll', 'Difficulty', 'Damage', 'Range', 'Rate', 'Clip', 'Conceal', 'Notes')
$W_LAB_PT = @('Parada', 'Dificuldade', 'Dano', 'Alcance',
              ('Cad' + [char]0xEA + 'ncia'), 'Pente',
              ('Oculta' + [char]0xE7 + [char]0xE3 + 'o'), 'Notas')
$A_LAB_EN = @('Rating', 'Penalty', 'Notes')
$A_LAB_PT = @('Valor', 'Penalidade', 'Notas')

# As 2 LEGENDAS dos ? de chave FIXA do cabecalho (SPEC I158a, I158e, I159, V462). UMA OPCAO
# POR LINHA, com 1 linha em branco entre duas - foi o pedido do user de 2026-09-07 e e o que
# V462a mede. Cada linha e "<codigo> = <texto>" e NENHUMA junta 2 opcoes: o - e o varies/varia
# contam como valor e tem linha propria (V462b), senao o ? fica sem resposta para as celulas
# que os carregam. Este mapa e o UNICO dono do texto (V462d): o dropdown de Conceal do painel
# custom monta a lista PARTINDO estas mesmas linhas em runtime (I158b), nao ha 2a copia.
$SEP = "`n`n"
$LEGEND_EN = (@(
    'P = Pocket'
    'J = Jacket'
    'T = Trenchcoat'
    'N = Cannot be concealed'
    'C = Loose Clothing (Dark Ages)'
    'L = Long Cloak (Dark Ages)'
    'varies = Varies with the item'
    '- = The book gives no value'
) -join $SEP)
$LEGEND_PT = (@(
    'B = Bolsa'
    'R = Roupa Solta'
    'M = Manto Longo'
    ('N = N' + [char]0xE3 + 'o Pode Ser Escondido')
    'varia = Depende do item'
    ('- = O livro n' + [char]0xE3 + 'o d' + [char]0xE1 + ' valor')
) -join $SEP)
# A legenda do ? de Damage (SPEC I158e, R157). O codigo e o que vem entre parenteses na coluna
# damage/damage_pt. Em PT o B de bashing virou C de contusao (I157p) e o C do agarrao virou P
# de Persiste, senao o C valeria 2 coisas na mesma legenda (Q78.1, V462c).
$DMG_EN = (@(
    'B = Bashing damage'
    'L = Lethal damage'
    'A = Aggravated damage'
    'K = Knockdown: the target falls'
    "R = Reduces the opponent's attack successes"
    'C = Clinch: carries over on successive turns'
    'fire = Fire damage: see the Explosives chart'
    '- = The book gives no value'
) -join $SEP)
$DMG_PT = (@(
    ('C = Dano de Contus' + [char]0xE3 + 'o')
    'L = Dano Letal'
    'A = Dano Agravado'
    'K = Derrubada: o alvo cai'
    'R = Reduz os sucessos de ataque do oponente'
    ('P = Agarr' + [char]0xE3 + 'o: continua nos turnos seguintes')
    'fogo = Dano de Fogo: ver a tabela de Explosivos'
    ('- = O livro n' + [char]0xE3 + 'o d' + [char]0xE1 + ' valor')
) -join $SEP)

# ReadAllLines com UTF8 explicito: Get-Content do PS 5.1 cai em ANSI e devolveria os acentos
# das colunas _pt como mojibake, sem erro. A 1a linha nomeia as colunas - nenhuma
# posicao de coluna e escrita aqui, entao acrescentar coluna na TSV nao quebra o gerador.
function ReadTsv([string]$path) {
    $lines = [IO.File]::ReadAllLines($path, [Text.Encoding]::UTF8)
    $head = $lines[0] -split "`t"
    $out = New-Object System.Collections.Generic.List[psobject]
    for ($n = 1; $n -lt $lines.Count; $n++) {
        $l = $lines[$n]
        if ($l.Trim() -eq '' -or $l.StartsWith('#')) { continue }
        $c = $l -split "`t"
        if ($c.Count -ne $head.Count) { throw "$([IO.Path]::GetFileName($path)) linha $($n + 1): $($c.Count) colunas, esperadas $($head.Count)" }
        $h = @{}
        for ($i = 0; $i -lt $head.Count; $i++) { $h[$head[$i]] = $c[$i].Trim() }
        $out.Add([pscustomobject]$h)
    }
    return $out
}

function LuaStr($s) { return ($s -replace '\\', '\\' -replace '"', '\"') }

$weapons = @(ReadTsv "$Research\weapon.tsv")
$armors  = @(ReadTsv "$Research\armor.tsv")

# CELULA VAZIA E ERRO, nao `-` implicito (SPEC I157d, V456a): `-` e um VALOR que a TSV escreve
# a mao, e deixar o gerador inventa-lo esconderia a linha que ninguem mediu. O Lua nunca decide
# isso - por isso a checagem e aqui e nao la (SPEC V457b).
$need = @('name', 'book', 'page', 'roll', 'roll_pt', 'diff', 'damage', 'damage_pt', 'range',
          'rate', 'clip', 'conceal', 'conceal_pt', 'name_pt')
foreach ($w in $weapons) {
    foreach ($k in $need) { if ($w.$k -eq $null -or $w.$k -eq '') { throw "weapon.tsv: '$($w.name)' tem a coluna '$k' vazia" } }
    if (-not $TITLE.ContainsKey($w.book)) { throw "weapon.tsv: '$($w.name)' cita o livro '$($w.book)', fora da tabela de research/README.md" }
}
foreach ($a in $armors) {
    foreach ($k in @('name', 'kind', 'book', 'page', 'rating', 'penalty', 'name_pt')) { if ($a.$k -eq $null -or $a.$k -eq '') { throw "armor.tsv: '$($a.name)' tem a coluna '$k' vazia" } }
    if (-not $TITLE.ContainsKey($a.book)) { throw "armor.tsv: '$($a.name)' cita o livro '$($a.book)', fora da tabela de research/README.md" }
    if ($a.kind -ne 'armor' -and $a.kind -ne 'shield') { throw "armor.tsv: '$($a.name)' tem kind '$($a.kind)', fora de armor|shield" }
}
foreach ($pair in @(@('weapon.tsv', $weapons), @('armor.tsv', $armors))) {
    $d = @($pair[1] | Group-Object name | Where-Object Count -gt 1)
    if ($d.Count) { throw "$($pair[0]): nome repetido - $($d.Name -join ', ')" }
}

# O mapa conceal -> conceal_pt tem de ser FUNCAO (SPEC V461d): a mesma letra EN nunca vira 2
# letras PT. Medido aqui e nao so no gate porque e o gerador que espalha a coluna nos 3 lugares.
$cmap = @{}
foreach ($w in $weapons) {
    if ($cmap.ContainsKey($w.conceal) -and $cmap[$w.conceal] -ne $w.conceal_pt) {
        throw "weapon.tsv: conceal '$($w.conceal)' vira '$($cmap[$w.conceal])' e tambem '$($w.conceal_pt)'"
    }
    $cmap[$w.conceal] = $w.conceal_pt
}

$wSorted = @($weapons | Sort-Object name)
$aSorted = @($armors  | Sort-Object name)
"armas .....: $($wSorted.Count)"
"armaduras .: $($aSorted.Count)"
"conceal ...: $((@($cmap.Keys | Sort-Object | ForEach-Object { "$_ -> $($cmap[$_])" })) -join '  ')"

# ---- combatData.lua ---------------------------------------------------------------
$L = New-Object System.Collections.Generic.List[string]
$L.Add('-- Weapon and armour book data (SPEC I157d / T1004).')
$L.Add('--')
$L.Add('-- Data only: no function, no state, no require of gui/ndb/locale (SPEC I24, V456e). It')
$L.Add('-- lives in a module and NOT in the <script> of a .lfm because the CDATA is copied raw')
$L.Add('-- into constructNew_*(), so every open sheet would parse its own copy - the disease T479')
$L.Add('-- cured for the description tables. The require lives inside mfOpen() (SPEC I157e).')
$L.Add('--')
$L.Add('-- The seven weapon cells and the three armour cells are DATA PER LANGUAGE, which is why')
$L.Add('-- each entry carries an `en` and a `pt` table instead of a name the PT map translates:')
$L.Add('-- `Dex + Melee` is two abilities the sheet already spells in Portuguese, and running it')
$L.Add('-- through the name map would ask that map to hold every dice pool in the four books.')
$L.Add('--')
$L.Add('-- A cell the book leaves blank reads `-`, and the `-` is written HERE and not in the Lua')
$L.Add('-- (SPEC V457b): the reader writes what the table hands it, so a missing cell is a missing')
$L.Add('-- row in research/weapon.tsv and not a silent empty box on the sheet. `notes` is the one')
$L.Add('-- that may be "" - it is prose the description pane appends, not a column of the sheet.')
$L.Add('--')
$L.Add('-- Generated by research/gen_combat_data.ps1 from research/weapon.tsv and')
$L.Add('-- research/armor.tsv. Do not hand-edit.')
$L.Add('')
$L.Add('local WEAPON_DATA = {')
foreach ($w in $wSorted) {
    $L.Add(('	["{0}"] = {{' -f (LuaStr $w.name)))
    $L.Add(('		en = {{ roll = "{0}", diff = "{1}", damage = "{2}", range = "{3}", rate = "{4}", clip = "{5}", conceal = "{6}" }},' -f (LuaStr $w.roll), (LuaStr $w.diff), (LuaStr $w.damage), (LuaStr $w.range), (LuaStr $w.rate), (LuaStr $w.clip), (LuaStr $w.conceal)))
    $L.Add(('		pt = {{ roll = "{0}", diff = "{1}", damage = "{2}", range = "{3}", rate = "{4}", clip = "{5}", conceal = "{6}" }},' -f (LuaStr $w.roll_pt), (LuaStr $w.diff), (LuaStr $w.damage_pt), (LuaStr $w.range), (LuaStr $w.rate), (LuaStr $w.clip), (LuaStr $w.conceal_pt)))
    $L.Add('	},')
}
$L.Add('};')
$L.Add('')
$L.Add('local ARMOR_DATA = {')
foreach ($a in $aSorted) {
    $L.Add(('	["{0}"] = {{' -f (LuaStr $a.name)))
    $L.Add(('		en = {{ rating = "{0}", penalty = "{1}", notes = "{2}" }},' -f (LuaStr $a.rating), (LuaStr $a.penalty), (LuaStr $a.notes_en)))
    $L.Add(('		pt = {{ rating = "{0}", penalty = "{1}", notes = "{2}" }},' -f (LuaStr $a.rating), (LuaStr $a.penalty), (LuaStr $a.notes_pt)))
    $L.Add('	},')
}
$L.Add('};')
$L.Add('')
$L.Add('return { weapon = WEAPON_DATA, armor = ARMOR_DATA };')
# CRLF, a forma de meritData.lua, o irmao deste modulo na raiz do plugin. Os desc* abaixo sao
# LF porque V345 mede os desc*.lua e so eles (SPEC V345, B87).
[IO.File]::WriteAllText("$OutDir\combatData.lua", (($L -join "`r`n") + "`r`n"), $U8)
"combatData.lua ....: $($wSorted.Count) armas + $($aSorted.Count) armaduras"

# ---- desc{Weapon,Armor}_{en,pt}.lua ----------------------------------------------
function WeaponBody($w, $lang) {
    $lab = if ($lang -eq 'en') { $W_LAB_EN } else { $W_LAB_PT }
    $val = if ($lang -eq 'en') { @($w.roll, $w.diff, $w.damage, $w.range, $w.rate, $w.clip, $w.conceal) }
           else                { @($w.roll_pt, $w.diff, $w.damage_pt, $w.range, $w.rate, $w.clip, $w.conceal_pt) }
    $o = New-Object System.Collections.Generic.List[string]
    for ($i = 0; $i -lt 7; $i++) { $o.Add("$($lab[$i]): $($val[$i])") }
    $txt = ($o -join "`n")
    $n = if ($lang -eq 'en') { $w.notes_en } else { $w.notes_pt }
    if ($n -ne '') { $txt = $txt + "`n`n" + $lab[7] + ': ' + $n }
    return $txt
}
function ArmorBody($a, $lang) {
    $lab = if ($lang -eq 'en') { $A_LAB_EN } else { $A_LAB_PT }
    $txt = "$($lab[0]): $($a.rating)`n$($lab[1]): $($a.penalty)"
    $n = if ($lang -eq 'en') { $a.notes_en } else { $a.notes_pt }
    if ($n -ne '') { $txt = $txt + "`n`n" + $lab[2] + ': ' + $n }
    return $txt
}
# Bloco 1 = fonte, bloco 2 = o nome do PICKER (a chave, em ingles - SPEC V24), bloco 3 = o
# corpo. 2 linhas em branco entre eles, o que em Lua e "\n\n\n" (SPEC I21).
function Blocks([string]$book, [string]$page, [string]$name, [string]$lang, [string]$body) {
    $pg = if ($lang -eq 'pt') { $PAG } else { 'p.' }
    return "$($TITLE[$book]), $pg $page`n`n`n$name`n`n`n$body"
}

$HDR = @(
 '-- {1} descriptions, the [{0}] half (SPEC I157h, I21, V210 / T1004).',
 '--',
 '-- One entry per item of PICKER_LIST["{2}"], keyed in ENGLISH because that is what the sheet',
 '-- saves (SPEC V24). Three blocks, exactly as the twelve description modules already do:',
 '-- "<Book>, p. <n>" - blank - blank - <Name> - blank - blank - <text>. The book title does',
 '-- not translate; only p./pag. does (SPEC I100e).',
 '--',
 '-- One module PER LANGUAGE and never both halves in one file (SPEC V210): half of every',
 '-- module was the language the session never opens, and require pulled both in to read one.',
 '-- The renderer builds the name by concatenation - require("desc<Kind>_" .. half .. ".lua")',
 '-- and never a constant name (SPEC V210b).',
 '--',
 '-- Data only: no function, no state, no require of gui/ndb/locale (SPEC I24).',
 '-- Generated by research/gen_combat_data.ps1 from research/weapon.tsv and',
 '-- research/armor.tsv. Do not hand-edit.',
 ''
)
foreach ($kind in @('Weapon', 'Armor')) {
    $list = if ($kind -eq 'Weapon') { $wSorted } else { $aSorted }
    $low  = $kind.ToLowerInvariant()
    foreach ($lang in @('en', 'pt')) {
        $o = New-Object System.Collections.Generic.List[string]
        foreach ($x in $HDR) { $o.Add(($x -f $lang, $kind, $low)) }
        $o.Add('return {')
        $o.Add("`t`t`t`t-- >>> $($kind.ToUpperInvariant())_DESC_BEGIN (generated - SPEC T1004)")
        foreach ($it in $list) {
            $body = if ($kind -eq 'Weapon') { WeaponBody $it $lang } else { ArmorBody $it $lang }
            $o.Add(("`t`t`t`t[""{0}""] = {{" -f (LuaStr $it.name)))
            $o.Add(("`t`t`t`t`t{0} = [==[{1}]==]," -f $lang, (Blocks $it.book $it.page $it.name $lang $body)))
            $o.Add("`t`t`t`t},")
        }
        # As 2 chaves EXTRA de descWeapon_*: as LEGENDAS dos ? de cabecalho Conceal e Damage
        # (SPEC I157p, I158e, V461b, V464c). Sao as UNICAS 2 chaves dos 2 modulos fora de
        # PICKER_LIST["weapon"] - um ? de cabecalho nao tem linha atras dele, entao a chave e
        # FIXA e nao um nome de arma. descArmor_* segue com ZERO delas.
        if ($kind -eq 'Weapon') {
            $fixed = @(
                @{ Key = 'Conceal'; En = $LEGEND_EN; Pt = $LEGEND_PT; BkEn = 'core'; PgEn = '281'; BkPt = 'ca';   PgPt = '330' },
                @{ Key = 'Damage';  En = $DMG_EN;    Pt = $DMG_PT;    BkEn = 'core'; PgEn = '279'; BkPt = 'core'; PgPt = '279' }
            )
            foreach ($f in $fixed) {
                $lg = if ($lang -eq 'en') { $f.En }   else { $f.Pt }
                $bk = if ($lang -eq 'en') { $f.BkEn } else { $f.BkPt }
                $pp = if ($lang -eq 'en') { $f.PgEn } else { $f.PgPt }
                $o.Add(("`t`t`t`t[""{0}""] = {{" -f $f.Key))
                $o.Add(("`t`t`t`t`t{0} = [==[{1}]==]," -f $lang, (Blocks $bk $pp $f.Key $lang $lg)))
                $o.Add("`t`t`t`t},")
            }
        }
        $o.Add("`t`t`t`t-- <<< $($kind.ToUpperInvariant())_DESC_END")
        $o.Add('};')
        # LF, a forma da CASA dos modulos de descricao, inclusive DENTRO do literal [==[ ]==]
        # (SPEC V345, B87). Misturar CRLF aqui nao muda 1 char de texto e faz o diff mentir.
        [IO.File]::WriteAllText("$OutDir\desc$($kind)_$lang.lua", (($o -join "`n") + "`n"), $U8)
        "desc$($kind)_$lang.lua : $($list.Count) entradas$(if ($kind -eq 'Weapon') { ' + Conceal + Damage' } else { '' })"
    }
}

# ---- picker_combat.txt -----------------------------------------------------------
# A mesma quebra de linha de gen_merit_data.ps1: 108 colunas, tabulacao de 4 tabs.
function PickerBlock([string]$key, $list) {
    $o = New-Object System.Collections.Generic.List[string]
    $o.Add("				[""$key""] = {")
    $line = '					""'
    foreach ($it in $list) {
        $s = ', "' + (LuaStr $it.name) + '"'
        if (($line.Length + $s.Length) -gt 108) { $o.Add($line + ','); $line = '					"' + (LuaStr $it.name) + '"' }
        else { $line = $line + $s }
    }
    $o.Add($line + ',')
    $o.Add('				},')
    return $o
}
# TRES blocos desde o 15o lote (SPEC I159b, V466c): a coluna kind parte a lista de protecao em
# armor e shield, e quem separa e a LISTA - combatData.armor e descArmor_* seguem com as 33
# entradas inteiras, porque escudo e armadura leem o mesmo dado e a mesma descricao. Item em 2
# listas seria escolha dupla para 1 objeto, e a interseccao vazia e o que V466c mede.
$shSorted = @($aSorted | Where-Object { $_.kind -eq 'shield' })
$arSorted = @($aSorted | Where-Object { $_.kind -eq 'armor'  })
if (($shSorted.Count + $arSorted.Count) -ne $aSorted.Count) { throw 'armor.tsv: kind fora de armor|shield' }
"protecao ..: $($arSorted.Count) armor + $($shSorted.Count) shield = $($aSorted.Count)"
$pk = New-Object System.Collections.Generic.List[string]
foreach ($x in (PickerBlock 'weapon' $wSorted))  { $pk.Add($x) }
foreach ($x in (PickerBlock 'armor'  $arSorted)) { $pk.Add($x) }
foreach ($x in (PickerBlock 'shield' $shSorted)) { $pk.Add($x) }
[IO.File]::WriteAllText("$OutDir\picker_combat.txt", (($pk -join "`r`n") + "`r`n"), $U8)
"picker_combat.txt .: $($pk.Count) linhas"

# ---- .lang e mapa PT -------------------------------------------------------------
# Nome que JA existe no mapa PT FICA com a traducao que tem, e o gerador PULA a chave (SPEC
# I157i): `Dodge` = `Esquiva` e `Tough Hide` = `Couro Grosso` ja estavam la. Se a TSV
# DISCORDAR do mapa, isso acende aqui - o mapa e o dono, a TSV e quem tem de ceder.
$have = @{}
foreach ($l in [IO.File]::ReadAllLines($Map, [Text.Encoding]::UTF8)) {
    $m = [regex]::Match($l, '^\s*\["([^"]+)"\]\s*=\s*"(.*)",\s*$')
    if ($m.Success -and -not $have.ContainsKey($m.Groups[1].Value)) { $have[$m.Groups[1].Value] = $m.Groups[2].Value }
}
$pairs = New-Object System.Collections.Generic.List[psobject]
foreach ($it in @($wSorted + $aSorted)) { $pairs.Add([pscustomobject]@{ En = $it.name; Pt = $it.name_pt }) }
# SPEC I157i/V459: os 3 rotulos de "vazio" sao chave como qualquer nome, e a string e a MESMA
# que mfOpen deriva de `weapon`/`armor`/`shield` (SPEC I113a). SHIELD entra junto: o TITULO da
# caixa e rotulo como qualquer outro e passa pelo mesmo mapa (SPEC V10, V28, I159a) - ARMOR,
# COMBAT e VIRTUES ja estao la desde sempre, e o gerador PULA quem ja esta.
$pairs.Add([pscustomobject]@{ En = 'Select Weapon'; Pt = 'Selecionar Arma' })
$pairs.Add([pscustomobject]@{ En = 'Select Armor';  Pt = 'Selecionar Armadura' })
$pairs.Add([pscustomobject]@{ En = 'Select Shield'; Pt = 'Selecionar Escudo' })
$pairs.Add([pscustomobject]@{ En = 'SHIELD';        Pt = 'ESCUDO' })

$skip = @()
$clash = @()
$new = New-Object System.Collections.Generic.List[psobject]
foreach ($p in $pairs) {
    if ($have.ContainsKey($p.En)) {
        $skip += $p.En
        if ($have[$p.En] -ne $p.Pt) { $clash += "$($p.En): mapa diz '$($have[$p.En])', a TSV diz '$($p.Pt)'" }
        continue
    }
    $new.Add($p)
}
if ($clash.Count) { "DISCORDANCIA COM O MAPA PT ($($clash.Count)):"; $clash | ForEach-Object { '   ' + $_ } }
"ja no mapa PT .....: $($skip.Count) ($($skip -join ', '))"

[IO.File]::WriteAllText("$OutDir\lang_pt.txt", ((@($new | ForEach-Object { "wod.$($_.En)=$($_.Pt)" })) -join "`r`n") + "`r`n", $U8)
[IO.File]::WriteAllText("$OutDir\lang_en.txt", ((@($new | ForEach-Object { "wod.$($_.En)=$($_.En)" })) -join "`r`n") + "`r`n", $U8)
[IO.File]::WriteAllText("$OutDir\ptmap.txt", ((@($new | ForEach-Object { '				["' + (LuaStr $_.En) + '"] = "' + (LuaStr $_.Pt) + '",' })) -join "`r`n") + "`r`n", $U8)
"chaves novas ......: $($new.Count) (.lang nas 2 metades e mapa PT)"
"gravado em $OutDir"
