# Extrai o corpo EN de cada cla de PICKER_LIST["clan"] -> research/clan_body_en.tsv
#   <nome do picker> TAB <codigo do livro> TAB <pagina impressa> TAB <corpo com \n escapado>
# Duas fontes, porque o livro as escreve diferente:
#   13 do core: o titulo e ARTE e nao esta na camada de texto -> corpo = a pagina ATE "Nickname:"
#   os outros:  o titulo E uma linha de texto -> corpo = do titulo ate o 1o rotulo mecanico
$ErrorActionPreference = 'Stop'
$rootDir = 'C:\Users\awlol\OneDrive\Documents\firecast_fork'
$cache   = "$env:TEMP\wod_books_txt"
# indice 0-based da pagina no cache MENOS a pagina IMPRESSA. MEDIDO no rodape da propria pagina
# 2026-09-03, e a medicao corrigiu 4 valores: o numero do README e relativo a pagina do PDF
# (1-based) e este e relativo ao INDICE, um a menos. A 175a rodada gravou os 61 verbetes uma
# pagina cedo por causa disso, e a QA que leu os 61 nao pegou porque leu o CORPO e nao o numero.
# Provas: core idx 55 -> impressa 48 (o corpo do Assamite) . core idx 401 -> impressa 394 (o
# titulo Baali) . core idx 427 -> impressa 420 (Children of Osiris) . anarch idx 39 -> impressa
# 39 (Caitiff) . lob idx 36 -> impressa 36 . bh idx 167 -> impressa 167.
$OFF = @{ core=7; da=1; lotc=1; rob=1; bh=0; lob=0; dac=1; tos=1; gr=1; anarch=0; hh=1; sorc=1; sorcc=0; bos=1; m20va=1 }
$STOP = '^\s*(Nickname|Disciplines|Weakness|Weaknesses|Quote|Sect|Appearance|Haven|Background|Organization|Character Creation|Clan Disciplines|Bloodline Disciplines|Sobriquet|Lineage):'
# mobilia de pagina: numero solto, cabecalho corrido, titulo do livro
$FURN = '^\s*(\d{1,3}|CHAPTER [A-Z]+.*|VAMPIRE THE MASQUERADE.*|APPENDIX.*|VARIATIONS OF THE BLOOD.*|ANARCHS UNBOUND.*)\s*$'

# as 13 do core, pagina IMPRESSA onde o write-up abre (MEDIDO: sequencia PAR 48..72). A pagina
# anterior a cada uma NAO e arte: core idx 54 = impressa 47 carrega 3557 chars do fim da secao
# Independents. O write-up abre mesmo na par, e a sequencia impar era o mesmo off-by-one de $OFF.
$CORE13 = [ordered]@{
    'Assamite' = 48; 'Brujah' = 50; 'Followers of Set' = 52; 'Gangrel' = 54; 'Giovanni' = 56
    'Lasombra' = 58; 'Malkavian' = 60; 'Nosferatu' = 62; 'Ravnos' = 64; 'Toreador' = 66
    'Tremere' = 68; 'Tzimisce' = 70; 'Ventrue' = 72
}
# o titulo como o LIVRO o escreve, quando difere do picker
$HEAD = @{
    'Gargoyles (Modern)' = 'Gargoyles'; 'Gargoyles (Scout)' = 'Scout Gargoyles'
    'Gargoyles (Sentinel)' = 'Sentinel Gargoyles'; 'Gargoyles (Warrior)' = 'Warrior Gargoyles'
}
# onde procurar o titulo, quando o core NAO e a fonte
$SRC = @{
    'Gargoyles (Scout)' = 'lob'; 'Gargoyles (Sentinel)' = 'lob'; 'Gargoyles (Warrior)' = 'lob'
    'Maeghar' = 'bh'; 'Caitiff' = 'anarch'
}
# pagina PINADA: onde 2 lugares carregam o mesmo titulo e o mais longo e o INDICE, nao o verbete
$PIN = @{
    'Gargoyles (Scout)' = 36; 'Gargoyles (Sentinel)' = 36; 'Gargoyles (Warrior)' = 36
}
# ULTIMA frase do verbete, quando o PDF entrega as COLUNAS fora de ordem e a parada por titulo do
# proximo verbete dispara tarde demais. Uma entrada so, e ela foi MEDIDA: em anarch p.40 o
# paragrafo logo apos o fim do Caitiff e do BRUJAH, cujo titulo aparece MAIS ABAIXO na mesma
# pagina; sem esta parada o Caitiff engole 1150 chars alheios (3904 -> 2754).
$TAIL = @{
    'Caitiff' = 'I fear for us should we forget the lesson that the Prince of L.A. learned long ago.'
}

$txt  = [Text.Encoding]::UTF8.GetString([IO.File]::ReadAllBytes("$rootDir\Plugins\Sheets\World of Darkness 20th Anniversary Edition\WoD20th\WoD20th.lfm"))
$m    = [regex]::Match($txt, '(?s)\["clan"\]\s*=\s*\{(.*?)\n\s*\},')
$clan = @([regex]::Matches($m.Groups[1].Value, '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value } | Where-Object { $_ -ne '' })

$books = @{}
foreach ($f in Get-ChildItem $cache -Filter *.txt) {
    $books[$f.BaseName] = ($([Text.Encoding]::UTF8.GetString([IO.File]::ReadAllBytes($f.FullName))) -split [char]12)
}

function Clean([string[]]$arr) {
    $keep = @()
    foreach ($l in $arr) {
        if ($l -match $FURN) { continue }
        $t = $l.Trim()
        if ($t -eq '') { continue }
        $keep += $t
    }
    $j = ($keep -join "`n")
    # hifen de quebra de COLUNA que sobreviveu ao cache (MEDIDO: 'ob- sessed' em Assamite Sorcerers)
    return ([regex]::Replace($j, '([a-z])- ([a-z])', '$1$2'))
}

$out = @()
$miss = @()
foreach ($c in $clan) {
    $body = $null; $bk = $null; $pg = $null

    if ($CORE13.Contains($c)) {
        $bk = 'core'; $pg = $CORE13[$c]
        $lines = $books[$bk][$pg + $OFF[$bk]] -split "`n"
        $take = @()
        foreach ($l in $lines) { if ($l -match $STOP) { break }; $take += $l }
        $body = Clean $take
    } else {
        $want = if ($HEAD.ContainsKey($c)) { $HEAD[$c] } else { $c }
        $only = if ($SRC.ContainsKey($c)) { $SRC[$c] } else { 'core' }
        $OTHER = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
        foreach ($o in $clan) {
            $on = if ($HEAD.ContainsKey($o)) { $HEAD[$o] } else { $o }
            if ($on -ne $want) { [void]$OTHER.Add($on) }
        }
        $pp = $books[$only]
        $best = $null
        for ($i = 0; $i -lt $pp.Count; $i++) {
            $lines = $pp[$i] -split "`n"
            for ($j = 0; $j -lt $lines.Count; $j++) {
                if ($lines[$j].Trim() -ne $want) { continue }
                # corre ate o rotulo mecanico, atravessando ate 2 quebras de pagina
                $take = @(); $done = $false; $pi = $i; $lj = $j + 1
                for ($span = 0; $span -lt 3 -and -not $done; $span++) {
                    $ls = $pp[$pi] -split "`n"
                    for ($k = $lj; $k -lt $ls.Count; $k++) {
                        if ($ls[$k] -match $STOP) { $done = $true; break }
                        # o verbete acaba onde o PROXIMO comeca: uma linha que e o titulo de
                        # outra entrada da lista. Sem isto o corpo atravessa o capitulo inteiro.
                        if ($OTHER.Contains($ls[$k].Trim())) { $done = $true; break }
                        $take += $ls[$k]
                    }
                    if (-not $done) { $pi++; $lj = 0; if ($pi -ge $pp.Count) { break } }
                }
                $cand = Clean $take
                if ($cand.Length -lt 150) { continue }
                if ($PIN.ContainsKey($c) -and ($i - $OFF[$only]) -ne $PIN[$c]) { continue }
                if ($null -eq $best -or $cand.Length -gt $best.Body.Length) {
                    $best = [pscustomobject]@{ Body = $cand; Page = $i - $OFF[$only] }
                }
            }
        }
        if ($null -ne $best) { $bk = $only; $pg = $best.Page; $body = $best.Body }
    }

    if ($null -ne $body -and $TAIL.ContainsKey($c)) {
        $cut = $body.IndexOf($TAIL[$c])
        if ($cut -lt 0) { throw "TAIL de '$c' nao foi achado no corpo - a frase mudou ou o corpo encolheu" }
        $body = $body.Substring(0, $cut + $TAIL[$c].Length)
    }
    if ($null -eq $body -or $body.Length -lt 150) { $miss += $c; continue }
    $out += ("{0}`t{1}`t{2}`t{3}" -f $c, $bk, $pg, ($body -replace "`n", '\n'))
}

# O cabecalho e escrito AQUI e nao a mao: a 175a rodada comentou o .tsv a mao e a re-extracao da
# 176a apagou os 22 comentarios sem avisar. Cabecalho que o gerador nao escreve nao sobrevive ao
# proprio gerador. ASCII por convencao (V411b) - o DADO abaixo dele e que carrega acento.
$HEADER = @(
    '# clan_body_en.tsv - o CORPO em ingles de cada um dos 61 nomes de PICKER_LIST["clan"].'
    '# GERADO por research/clan_extract.ps1 a partir do cache de texto dos livros em'
    '# %TEMP%\wod_books_txt. Nao edite a mao: conserte o gerador e rode de novo.'
    '#'
    '# nome_picker<TAB>livro<TAB>pagina_impressa<TAB>corpo (com \n escapado)'
    '#'
    '# DUAS FONTES, porque o livro escreve as duas metades diferente:'
    '#   13 do core (pp. 48..72, PARES): o TITULO e arte e nao esta na camada de texto, entao o'
    '#     corpo e a pagina inteira ATE a linha Nickname:.'
    '#   os outros 48: o titulo E uma linha de texto, entao o corpo vai do titulo ate o 1o rotulo'
    '#     mecanico OU ate o titulo do proximo verbete, o que vier antes.'
    '#'
    '# 4 nomes nao saem do core: Gargoyles (Scout|Sentinel|Warrior) = lob p.36 (pinados) e'
    '# Caitiff = anarch p.39.'
    '#'
    '# As paginas foram TODAS corrigidas em 1 na 176a rodada: $OFF e relativo ao INDICE 0-based e'
    '# carregava o numero do PDF (1-based). O Caitiff perdeu 1075 chars alheios pela mesma revisao.'
)
$enc = New-Object Text.UTF8Encoding($false)
[IO.File]::WriteAllBytes("$rootDir\research\clan_body_en.tsv", $enc.GetBytes(((@($HEADER) + $out) -join "`r`n") + "`r`n"))
"extraidos: $($out.Count) de $($clan.Count)"
if ($miss.Count) { "SEM CORPO: " + ($miss -join ', ') }
$lens = $out | ForEach-Object { (($_ -split "`t")[3]).Length }
"corpo: min=$(($lens | Measure-Object -Minimum).Minimum) mediana=$(($lens | Sort-Object)[[int]($lens.Count/2)]) max=$(($lens | Measure-Object -Maximum).Maximum) soma=$(($lens | Measure-Object -Sum).Sum)"
