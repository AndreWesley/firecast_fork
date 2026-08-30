# extract_merit_flaw.ps1 - extrai qualidade/defeito dos 15 livros (T749/T751, 2026-08-28)
#
# Gera as linhas que viraram research/merit_flaw.tsv. Rode assim:
#     powershell -File research\extract_merit_flaw.ps1 -TxtDir <pasta com os .txt -layout>
#
# ============================ MODO DO pdftotext ============================
# Os .txt tem de sair com `pdftotext -layout -enc UTF-8` (README.md deste diretorio,
# armadilhas 8 e 9):
#
#   -layout  poe as 2 colunas da pagina LADO A LADO na mesma linha, separadas por uma calha
#            de espacos. Este script acha a calha por pagina e corta cada linha nela, entao
#            le as colunas na ordem certa. Sem isso o fim de um corpo e um chute: o cabecalho
#            seguinte esta na OUTRA coluna, a centenas de linhas na ordem de leitura, e o
#            corpo corre ate o teto (Simply Waiting saia com 4425 chars contra 488 reais).
#            O -layout NAO cola palavras: 1397 coladas contra 1399 do modo padrao, medido.
#
#   -enc UTF-8 e OBRIGATORIO. Sem ele o pdftotext cai em Latin-1 e o travessao, a reticencia
#            e as aspas duplas curvas viram U+FFFD no corpo - texto que o jogador LERIA com
#            um losango preto no meio da frase. Este script normaliza SO a aspa simples curva
#            (U+2018/U+2019 -> aspa reta) porque a chave canonica de merit_flaw.tsv usa a reta.
#            ATENCAO: a versao ANTIGA deste script PERDIA 15 entradas com -enc UTF-8 (783
#            linhas viravam 768, calado) porque tinha os caracteres curvos LITERAIS dentro dos
#            regex e o PowerShell 5.1 le .ps1 sem BOM como ANSI. Aqui os regex sao montados a
#            partir de [char]0x2019 e o arquivo e 100% ASCII, entao o defeito nao volta.
#
# NAO aplicar o corte por "linha com cara de titulo" ao corpus INTEIRO: foi tentado em
# 2026-08-28, consertava o Simply Waiting e comia 24% do texto bom. Aqui ele so toca os
# corpos que ja se sabem nao confiaveis (coluna Stop != head) - ver LooksLikeHeading.
#
# A coluna Stop do CSV diz POR QUE o corpo parou, e e ela, nao o comprimento, que separa o
# confiavel do duvidoso:
#   head  achou o cabecalho da entrada seguinte. UNICO fim confiavel por construcao.
#   cut   parou por teto e o corte por titulo achou onde a secao acaba. Confiavel na pratica.
#   cap   bateu no teto de 130 linhas sem achar nem cabecalho nem titulo. DUVIDOSO.
#   page  atravessou 2 viradas de pagina. DUVIDOSO.
#   sect  bateu num cabecalho de categoria ("Physical Merits"). DUVIDOSO.
# ===========================================================================

param(
    [string]$TxtDir = (Join-Path $env:TEMP 'wod_books_layout'),
    [string]$OutCsv = (Join-Path $env:TEMP 'mf_bodies.csv'),
    [int]$FatLimit  = 3000
)
$ErrorActionPreference = 'Stop'
$txt = $TxtDir
$FF  = [string][char]12
$AP  = [string][char]0x2019   # apostrofo curvo, caso o .txt venha em UTF-8 mesmo assim
if (-not (Test-Path $txt)) { throw "pasta de texto nao existe: $txt" }

$OFF = @{ core=8; da=1; rob=1; lotc=1; lob=1; tos=1; dac=1; bh=1; gr=1; anarch=1; hh=1; sorc=1; sorcc=0; m20va=1; bos=1 }
$ORDER = @('core','lotc','gr','hh','bh','anarch','rob','lob','da','tos','dac','bos','sorc','sorcc','m20va')

$CAT = 'Physical|Social|Mental|Supernatural|Psychological|Aptitude|Background|Merit|Flaw'
$NM1 = "[A-Za-z'$AP-]"
$NM2 = "[A-Za-z '$AP/,.()-]"
$NM3 = "[A-Za-z '$AP/,.-]"
$RX_PAREN = [regex]("(?i)^(?<name>[A-Z]$NM1$NM2{0,44}?)\s*:?\s*\(\s*(?<cost>\d+(?:\s*(?:or|to|and|-|,)\s*\d+)*)?\s*[- ]?(?:pts?|points?)?\s*\.?\s*(?<cat>(?:$CAT)\s+)?(?<kind>Merit|Flaw)\s*\)")
$RX_BARE  = [regex]("(?i)^\(\s*(?<cost>\d+(?:\s*(?:or|to|and|-|,)\s*\d+)*)?\s*[- ]?(?:pts?|points?)?\s*\.?\s*(?<cat>(?:$CAT)\s+)?(?<kind>Merit|Flaw)\s*\)\s*$")
$RX_COLON = [regex]("(?i)^(?<name>[A-Z]$NM1$NM3{0,44}?)\s*\(\s*(?<cost>\d+(?:\s*(?:or|to|and|-|,)\s*\d+)*)\s*points?\s*\)\s*:")
$RX_NAME  = [regex]("^[A-Z]$NM1$NM3{1,44}$")
# mobilia de pagina: numero da pagina + titulo corrente. So e tirada na PRIMEIRA e na ULTIMA
# linha nao-vazia da pagina, senao ela come linha de corpo que por acaso termina em numero.
$RX_FURN  = [regex]'^(?:\d{1,4}(?:\s+\S.{0,40})?|\S.{0,40}?\s+\d{1,4})$'
# titulo corrente sem numero, em CAIXA ALTA ("FAITH", "LORE OF THE BLOODLINES"). Nome de
# qualidade nunca vem em caixa alta, e a regra so vale nas 2 pontas da pagina.
$RX_RUN   = [regex]"^[A-Z][A-Z0-9 '&:.,-]{2,40}$"

function Clean($s) {
    $t = $s.TrimEnd()
    $t = $t -replace '^[\s\u2022\u25CF\u00B7\u2219\uFFFD\*\-]+', ''
    # aspa simples CURVA -> reta, e so ela. O nome canonico de merit_flaw.tsv usa a reta
    # (`Lawman's Friend`) e trocar a chave orfanaria as 640 traducoes de merit_flaw_pt.tsv.
    # Travessao, reticencia e aspa dupla curva FICAM: sao texto que o jogador le.
    $t = $t -replace '[\u2018\u2019]', "'"
    return $t.Trim()
}
# "linha com cara de titulo". CUIDADO: em 2026-08-28 esta regra foi aplicada ao corpus INTEIRO
# e comeu 24% do texto bom. Aqui ela so toca os corpos que ja se sabem NAO CONFIAVEIS (os que
# terminaram por teto/pagina/secao, nunca os que acharam o cabecalho seguinte).
function LooksLikeHeading($l) {
    if ($l.Length -lt 3 -or $l.Length -gt 45) { return $false }
    if ($l -notmatch '^[A-Z]') { return $false }
    if ($l -match '[.,;:]$') { return $false }
    $w = @($l -split '\s+' | Where-Object { $_.Length -gt 0 })
    if ($w.Count -lt 1 -or $w.Count -gt 7) { return $false }
    $cap = @($w | Where-Object { $_ -match '^[A-Z0-9]' }).Count
    return ($cap / $w.Count) -ge 0.6
}
function IsHead($l) {
    return ($RX_PAREN.IsMatch($l) -and -not ($l -match '\)\s+\d{1,3}\s*$')) -or $RX_BARE.IsMatch($l) -or $RX_COLON.IsMatch($l)
}

# Acha a CALHA da pagina: a faixa de colunas em branco na quase totalidade das linhas e que
# tem texto de verdade do lado direito. Devolve $null quando a pagina e de 1 coluna.
function Find-Gutter([string[]]$rowsIn) {
    $rows = @($rowsIn | Where-Object { $_.Length -gt 0 })
    if ($rows.Count -lt 8) { return $null }
    $W = ($rows | Measure-Object -Property Length -Maximum).Maximum
    if ($W -lt 50) { return $null }
    $lo = [int]($W * 0.25); $hi = [int]($W * 0.75)
    # perfil de brancura da faixa do meio. Coluna JUSTIFICADA entra na calha de vez em quando,
    # entao um corte fixo em 90% perde pagina boa (dac p.100 e bos p.35 chegam so a 78%/81%).
    # O corte e RELATIVO ao pico da propria pagina.
    $f = @{}
    $peak = 0.0; $argmax = -1
    for ($c = $lo; $c -le $hi; $c++) {
        $blank = 0
        foreach ($r in $rows) { if ($c -ge $r.Length -or $r[$c] -eq ' ') { $blank++ } }
        $v = $blank / $rows.Count
        $f[$c] = $v
        if ($v -gt $peak) { $peak = $v; $argmax = $c }
    }
    # pagina de 1 coluna: no meio dela so ha espaco ENTRE PALAVRAS, nunca uma faixa branca
    if ($peak -lt 0.65) { return $null }
    $thr = [Math]::Max(0.60, $peak - 0.10)
    $s = $argmax; while ($s - 1 -ge $lo -and $f[$s - 1] -ge $thr) { $s-- }
    $e = $argmax; while ($e + 1 -le $hi -and $f[$e + 1] -ge $thr) { $e++ }
    # a coluna da direita tem de carregar texto de verdade
    $right = 0
    foreach ($r in $rows) { if ($r.Length -gt ($e + 1) -and $r.Substring($e + 1).Trim().Length -gt 0) { $right++ } }
    if (($right / $rows.Count) -lt 0.25) { return $null }
    return [pscustomobject]@{ S = $s; E = $e; Width = ($e - $s + 1) }
}

# Uma pagina -> as linhas na ORDEM DE LEITURA: coluna esquerda inteira, depois a direita.
function Split-Page([string[]]$rowsIn) {
    $g = Find-Gutter $rowsIn
    if ($null -eq $g) { return , @($rowsIn) }
    $cut = $g.E + 1
    $colA = New-Object System.Collections.Generic.List[string]
    $colB = New-Object System.Collections.Generic.List[string]
    foreach ($ln in $rowsIn) {
        # a linha entra nas DUAS colunas sempre - a direita leva '' quando nao ha texto la.
        # Sem isso a coluna B perde as linhas em branco e com elas a divisao de paragrafo.
        if ($ln.Length -le $cut) { $colA.Add($ln); $colB.Add(''); continue }
        $b = $cut
        if ($ln[$cut] -ne ' ') {
            # ha palavra EM CIMA da calha. Ou e titulo de largura inteira (fica inteiro a
            # esquerda), ou e um cabecalho da coluna B que comeca um pouco mais para a
            # esquerda que o corpo dela - foi assim que `Social Flaws` (da p.423) sumiu e
            # 18 defeitos do da sairam com tipo Merit.
            $w = $cut
            while ($w -gt 0 -and $ln[$w - 1] -ne ' ') { $w-- }
            if ($w -ge 2 -and ($cut - $w) -le 12 -and $ln[$w - 1] -eq ' ' -and $ln[$w - 2] -eq ' ') { $b = $w }
            else { $colA.Add($ln); $colB.Add(''); continue }
        }
        $colA.Add($ln.Substring(0, $b))
        $colB.Add($ln.Substring($b))
    }
    $r = New-Object System.Collections.Generic.List[string]
    foreach ($x in $colA) { $r.Add($x) }
    foreach ($x in $colB) { $r.Add($x) }
    return , $r.ToArray()
}

$out = @()
foreach ($code in $ORDER) {
    $f = Join-Path $txt "$code.txt"
    if (-not (Test-Path $f)) { continue }
    $pages = [IO.File]::ReadAllText($f) -split $FF
    $flat = New-Object System.Collections.Generic.List[object]
    for ($p = 0; $p -lt $pages.Count; $p++) {
        $raw = @(($pages[$p] -split "`n") | ForEach-Object { ($_ -replace "`r", '').TrimEnd() })
        # tira a mobilia ANTES de medir a calha: o rodape mora no pe da coluna esquerda e
        # entraria NO MEIO do corpo que atravessa a virada de coluna
        # as DUAS de cada ponta, porque o rodape costuma vir em 2 linhas ("FAITH" / "108")
        $ix = @(0..($raw.Count - 1) | Where-Object { $raw[$_].Trim().Length -gt 0 })
        if ($ix.Count -ge 6) {
            foreach ($i in @($ix[0], $ix[1], $ix[-2], $ix[-1])) {
                $t = $raw[$i].Trim()
                if ($t.Length -le 50 -and ($RX_FURN.IsMatch($t) -or $RX_RUN.IsMatch($t))) { $raw[$i] = '' }
            }
        }
        foreach ($ln in (Split-Page $raw)) {
            $t = Clean $ln
            # notacao 8 (tos, secao dos Gorgons): a camada de texto do PDF devolve
            # "2( pt. Social Merit)" com o digito ANTES do parentese. Sem desembaralhar,
            # Heretical Sympathizer / Hunted by the Hierophants / Postulant of Echidna somem
            # do livro e so sobram os pontos de SUMARIO deles, que apontam para a pagina 4.
            if ($t -match '(?i)^\d+\(\s*(?:pts?|points?)') { $t = $t -replace '^(\d+)\(\s*', '($1 ' }
            # recuo da linha ANTES do Clean: o -layout recua o inicio de paragrafo em 2+ espacos
            # e e por ele (mais a linha em branco) que o corpo recupera a divisao de paragrafo
            $ind = 0; while ($ind -lt $ln.Length -and $ln[$ind] -eq ' ') { $ind++ }
            $flat.Add([pscustomobject]@{ T = $t; P = ($p + 1) - $OFF[$code]; I = $ind })
        }
    }
    # cabecalho que QUEBRA em 2 linhas: a coluna do -layout e estreita e o tos escreve
    # "Demonic Patron (5 pt." / "Supernatural Merit)". Sem juntar, o item some E o item de
    # cima engole o corpo dele (Blasphemous Pact ia de 963 para 1487 chars).
    for ($i = 0; $i -lt $flat.Count - 1; $i++) {
        $a = $flat[$i].T
        if ($a.Length -lt 6 -or $a.Length -gt 60) { continue }
        if (IsHead $a) { continue }
        # 3 formas de quebra medidas: parentese aberto que fecha na linha de baixo (tos),
        # nome cortado na barra (bos "Esoteric Discourse /"), e dois-pontos do sorc
        # ("Isolated Upbringing:" + "(5 pt Merit)")
        $open = ([regex]::Matches($a, '\(')).Count -gt ([regex]::Matches($a, '\)')).Count
        if (-not $open -and $a -notmatch '[/:-]$') { continue }
        $b = $flat[$i + 1].T
        if ($b.Length -lt 3 -or $b.Length -gt 60) { continue }
        # 3+ espacos seguidos = ponto de sumario, nao cabecalho quebrado (tos p.4)
        if ($a -match '\s{3,}' -or $b -match '\s{3,}') { continue }
        $j = "$a $b"
        if ($RX_PAREN.IsMatch($j) -or $RX_COLON.IsMatch($j)) { $flat[$i].T = $j; $flat[$i + 1].T = '' }
    }
    $section = ''   # ultimo cabecalho "<Categoria> Merits|Flaws" visto
    for ($i = 0; $i -lt $flat.Count; $i++) {
        $l = $flat[$i].T
        if ($l.Length -lt 4) { continue }
        # o da (notacao 4) escreve "Ambidextrous (1 point):" e NAO diz Merit nem Flaw: o tipo
        # vem do cabecalho de SECAO. Sem guardar a secao, 81 entradas saem sem tipo e nao da
        # para saber em qual das 2 tabelas da ficha elas entram.
        if ($l -match '^(?:Physical|Social|Mental|Supernatural|Psychological|Aptitude|Background|Supernatural)\s+(Merits|Flaws)\s*$') {
            $section = if ($matches[1] -eq 'Merits') { 'Merit' } else { 'Flaw' }
            continue
        }
        # linha de sumario: varias entradas coladas numa linha so. NAO vale para a forma do
        # da (Nome (N points): prosa), cuja prosa costuma ter um segundo parentese com pontos -
        # foi assim que o guarda cru comeu o Unclean, que e entrada legitima (da p.421).
        if (-not $RX_COLON.IsMatch($l) -and ([regex]::Matches($l, '(?i)\((?:[^)]*?)(?:pts?|points?)(?:[^)]*?)\)')).Count -gt 1) { continue }
        $name = ''; $kind = ''; $cost = ''
        $isToc = $l -match '\)\s+\d{1,3}\s*$'

        $mb = $RX_BARE.Match($l)
        $m  = $RX_PAREN.Match($l)
        $mc = $RX_COLON.Match($l)
        if ($mb.Success) {
            for ($j = $i - 1; $j -ge 0 -and $j -ge $i - 3; $j--) {
                $prev = $flat[$j].T
                if ($prev.Length -ge 3 -and $RX_NAME.IsMatch($prev)) { $name = $prev; break }
                if ($prev.Length -ge 3) { break }
            }
            if ($name -eq '') { continue }
            $kind = $mb.Groups['kind'].Value; $cost = $mb.Groups['cost'].Value
        } elseif ($m.Success -and -not $isToc -and ($m.Groups['cost'].Value -ne '' -or $m.Groups['cat'].Value -ne '')) {
            $name = $m.Groups['name'].Value.Trim(); $kind = $m.Groups['kind'].Value; $cost = $m.Groups['cost'].Value
        } elseif ($mc.Success) {
            $name = $mc.Groups['name'].Value.Trim(); $cost = $mc.Groups['cost'].Value
            $kind = $section   # a notacao 4 nao diz o tipo; ele vem da secao
        } else { continue }
        # 2+ espacos DENTRO do nome sao fronteira de coluna que sobrou, nunca parte do nome:
        # `the  Tracker's Mark` (dac p.100) e o rabo da coluna esquerda colado no cabecalho da
        # direita. Fica so o que vem depois do ultimo vao.
        if ($name -match '\s{2,}') { $name = (($name -split '\s{2,}')[-1]).Trim() }
        if ($name.Length -lt 3) { continue }

        # o corpo corre ate o cabecalho seguinte. Com as colunas na ordem certa esse cabecalho
        # fica LOGO ABAIXO, entao os tetos abaixo sao cinto de seguranca, nao o mecanismo.
        $buf = New-Object System.Collections.Generic.List[string]
        $blk = New-Object System.Collections.Generic.List[bool]   # a linha vinha DEPOIS de um branco?
        $par = New-Object System.Collections.Generic.List[bool]   # a linha estava RECUADA?
        $prevBlank = $true
        # a forma do da carrega prosa na propria linha do cabecalho, depois dos dois-pontos
        if ($mc.Success) { $tail = $l.Substring($mc.Length).Trim(); if ($tail) { $buf.Add($tail); $blk.Add($false); $par.Add($false) } }
        # notacao 7 (m20va): "Construct (Social Flaw): <prosa>" casa por RX_PAREN, nao por
        # RX_COLON, e a prosa fica na MESMA linha depois do parentese. Sem isto a entrada sai
        # com corpo VAZIO e a caixa do ? abre em branco.
        if ($m.Success) { $tail2 = $l.Substring($m.Index + $m.Length).TrimStart(':', ' ').Trim(); if ($tail2.Length -gt 3) { $buf.Add($tail2); $blk.Add($false); $par.Add($false) } }
        $p0 = $flat[$i].P
        $kept = 0
        # POR QUE o corpo parou. 'head' = achou o cabecalho seguinte, unico fim CONFIAVEL.
        # 'sect' 'page' 'cap' sao os freios de emergencia: o corpo ja pode estar comendo o que
        # vem depois da secao, e sao esses que vao para a conferencia / merit_flaw_overrides.tsv.
        $stop = 'cap'
        for ($k = $i + 1; $k -lt $flat.Count -and $k -le $i + 260 -and $kept -lt 130; $k++) {
            $b = $flat[$k].T
            if ($b.Length -ge 4 -and (IsHead $b)) { $stop = 'head'; break }
            # uma descricao nao atravessa DUAS viradas de pagina
            if ($flat[$k].P -gt $p0 + 1) { $stop = 'page'; break }
            # 22+ letras seguidas nao e prosa: e fonte decorativa que a camada de texto devolve
            # embaralhada. Ilegivel por construcao, fora.
            if ($b -match '[A-Za-z]{22,}') { continue }
            if ($b -match '^(Physical|Social|Mental|Supernatural)\s+(Merits|Flaws)\s*$') { $stop = 'sect'; break }
            # linha em branco NAO conta no teto: a coluna B carrega as quebras de paragrafo
            # (ver Split-Page) e sem esta distincao o teto morderia corpo legitimo
            if ($b.Length -gt 0) {
                $blk.Add($prevBlank)          # veio depois de branco -> candidata a TITULO de secao
                # comeco de PARAGRAFO = RECUO, so. Linha em branco nao serve aqui: a virada de
                # coluna e a mobilia arrancada deixam branco no meio de um paragrafo so, e foi
                # assim que `Simply Waiting` ganhou um \n em "but in / truth".
                $par.Add($flat[$k].I -ge 2)
                $buf.Add($b)
                $kept++; $prevBlank = $false
            }
            else { $prevBlank = $true }
        }
        # corpo NAO confiavel: corta no 1o titulo de secao depois de uma linha em branco.
        # Para os que fecharam em 'head' nada disso roda - o fim deles ja e o certo.
        if ($stop -ne 'head') {
            for ($z = 1; $z -lt $buf.Count; $z++) {
                if ($blk[$z] -and (LooksLikeHeading $buf[$z])) {
                    while ($buf.Count -gt $z) { $buf.RemoveAt($buf.Count - 1) }
                    $stop = 'cut'
                    break
                }
            }
        }
        # `\n` de 2 chars marca quebra de PARAGRAFO, do mesmo jeito que merit_flaw_overrides.tsv.
        # Quem gera o .lua troca por quebra de verdade; assim o corpo cabe numa celula de CSV.
        $sb = New-Object Text.StringBuilder
        for ($z = 0; $z -lt $buf.Count; $z++) {
            if ($z -gt 0) { [void]$sb.Append($(if ($par[$z]) { '\n' } else { ' ' })) }
            [void]$sb.Append($buf[$z])
        }
        $body = ($sb.ToString()) -replace '[ \t]{2,}', ' '
        $out += [pscustomobject]@{ Name = $name; Kind = $kind; Cost = ($cost -replace '\s+', ' ').Trim(); Book = $code; Page = $flat[$i].P; Len = $body.Length; Stop = $stop; Body = $body }
    }
}
$susp = @($out | Where-Object { $_.Stop -notin @('head', 'cut') -or $_.Len -gt $FatLimit })
'entradas com corpo: {0}' -f $out.Count
'nomes distintos ..: {0}' -f (($out | Select-Object -ExpandProperty Name | Sort-Object -Unique).Count)
'corpo vazio ......: {0}' -f (@($out | Where-Object { $_.Len -lt 20 }).Count)
'corpo mediano ....: {0} chars' -f ([int](($out | Sort-Object Len)[[int]($out.Count / 2)].Len))
'corpo total ......: {0} KB' -f ([int]((($out | Measure-Object Len -Sum).Sum) / 1KB))
foreach ($g in ($out | Group-Object Stop | Sort-Object Count -Descending)) { '  fim por {0,-5}: {1}' -f $g.Name, $g.Count }
'PARA CONFERIR ....: {0}  (fim cap/page/sect, ou acima de {1} chars)' -f $susp.Count, $FatLimit
foreach ($x in ($susp | Sort-Object { [int]$_.Len } -Descending)) { '   {0,-5} {1,6}  {2} ({3} p.{4})' -f $x.Stop, $x.Len, $x.Name, $x.Book, $x.Page }
$out | Export-Csv $OutCsv -NoTypeInformation -Encoding UTF8
'gravado ' + $OutCsv
