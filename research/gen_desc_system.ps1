# gen_desc_system.ps1 - SPEC T768 / I104: reescreve o BLOCO 3 dos 8 modulos de descricao
# para carregar SO a mecanica.
#
# ASCII puro DE PROPOSITO (SPEC B84): .ps1 sem BOM e lido como ANSI pelo PS 5.1, e literal
# nao-ASCII dentro de regex falha CALADO. A bolinha vem de [char]0x2022.
#
# NAO le PDF. A fonte e o proprio .lua instalado: os 3 blocos de I21 ja estao la e o texto ja
# foi conferido rodada a rodada. O que muda e o RECORTE do bloco 3 (I104a: blocos 1 e 2 saem
# VERBATIM).
#
# A regra, por entrada:
#   - entrada COM blocos de nivel (linha que abre com bolinha): a prosa introdutoria sai, e
#     cada nivel vira <cabecalho de bolinha> + o que vem a partir de `System:` / `Sistema:`
#     (I104b). O que vier DEPOIS do System no mesmo nivel fica - tabela de sucessos e
#     modificadores sao mecanica.
#   - entrada SEM bloco de nivel (a maioria dos rituais): o bloco 3 inteiro e um write-up so,
#     entao vale a mesma regra sem cabecalho - fica do marcador para baixo.
#   - marcador AUSENTE: a entrada (ou o nivel) mantem o paragrafo mecanico INTEIRO e entra na
#     lista de excecao de I104c, que este script IMPRIME. V335c quer essa lista MEDIDA, nao
#     suposta, e por isso ela sai daqui e nao da cabeca de ninguem.
#
# Sem -Apply o script so MEDE e escreve em -OutDir. Com -Apply, grava por cima dos 8 no
# plugin - sempre com [IO.File]::WriteAllText e em LF, que e a forma da casa nos 12 modulos
# de descricao (SPEC V345, B87). NAO usar sed/awk do Git Bash para isso: eles comem o CR do
# arquivo inteiro, calados (SPEC B74), e aqui a regra e o oposto - nao pode ENTRAR CR.
param(
    [string]$Plugin = '',
    [string]$OutDir = "$env:TEMP\descgen",
    [switch]$Apply
)
$ErrorActionPreference = 'Stop'
if ($Plugin -eq '') {
    $Plugin = Join-Path (Split-Path -Parent $PSScriptRoot) 'Plugins\Sheets\World of Darkness 20th Anniversary Edition'
}
$DOT = [char]0x2022
$enc = New-Object Text.UTF8Encoding($false)
New-Item -ItemType Directory -Force $OutDir | Out-Null

$AREAS = @(
    @('descDisc',   'DISC_DESC'),
    @('descNumina', 'DESC'),
    @('descPath',   'PATH_DESC'),
    @('descRitual', 'RITUAL_DESC')
)

# Tira as linhas em branco do fim. Lista, nao fatia de array: `$a[0..($a.Count-2)]` com 1 item
# vira `$a[0..-1]`, que em PowerShell devolve o array INTEIRO ao contrario, nao um vazio.
function Trim-Tail([string[]]$lines) {
    $l = New-Object System.Collections.Generic.List[string]
    foreach ($x in $lines) { $l.Add($x) }
    while ($l.Count -gt 0 -and $l[$l.Count - 1].Trim() -eq '') { $l.RemoveAt($l.Count - 1) }
    , $l.ToArray()
}

# Recorta um bloco de linhas a partir do marcador. Devolve $null quando o marcador nao esta la.
function Cut-System([string[]]$lines, [string]$marker) {
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i].TrimStart() -clike "$($marker):*") {
            return , (Trim-Tail @($lines[$i..($lines.Count - 1)]))
        }
    }
    return $null
}

# A forma INVERSA, a do descNumina (SPEC I104e, R133): la `System` e CABECALHO DE SECAO - linha
# sozinha, SEM dois-pontos - e os niveis de bolinha moram DENTRO dela, junto de `Modifiers:`
# `Time:` `Duration:` `Effects:` `Price of Failure:`. O recorte e do cabecalho ate o fim da
# entrada, nao por nivel. Devolve $null quando a entrada nao tem esse cabecalho: as 23 psiquicas
# do M20 Sorcerer nao tem, e la vale a regra normal de nivel (I104b + a excecao de I104c).
function Cut-SystemHeader([string[]]$lines, [string]$marker) {
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i].Trim() -ceq $marker) {
            return , (Trim-Tail @($lines[$i..($lines.Count - 1)]))
        }
    }
    return $null
}

$exc = New-Object System.Collections.Generic.List[string]
$stat = New-Object System.Collections.Generic.List[string]
$pend = New-Object System.Collections.Generic.List[object]

foreach ($a in $AREAS) {
    foreach ($lang in @('en', 'pt')) {
        $path = Join-Path $Plugin "$($a[0])_$lang.lua"
        if (-not (Test-Path $path)) { "FALTA $path"; exit 1 }
        $marker = $(if ($lang -eq 'en') { 'System' } else { 'Sistema' })
        $txt = [IO.File]::ReadAllText($path)
        # Fecha em `]==]` e nada mais: descNumina escreve `]==] },` com espaco, os outros 3
        # escrevem `]==],`. Exigir a virgula colada zerava descNumina inteiro, calado.
        $rx = [regex]('(?s)\["((?:[^"\\]|\\.)*)"\]\s*=\s*\{\s*' + $lang + '\s*=\s*\[==\[(.*?)\]==\]')
        $ms = @($rx.Matches($txt))
        if ($ms.Count -eq 0) { "FALHA $($a[0])_$lang.lua : 0 entradas casadas"; exit 1 }

        $sb = New-Object Text.StringBuilder
        $prev = 0
        $nCut = 0; $nWhole = 0
        foreach ($m in $ms) {
            $name = $m.Groups[1].Value -replace '\\"', '"' -replace "\\\\", "\"
            $g = $m.Groups[2]
            $body = $g.Value -replace "`r", ''
            $blocks = $body -split "`n`n`n"
            if ($blocks.Count -lt 3) { "FALHA $($a[0])_$lang.lua '$name' : $($blocks.Count) bloco(s), esperado 3 (SPEC I21)"; exit 1 }
            $head = ($blocks[0..1] -join "`n`n`n")
            $b3 = ($blocks[2..($blocks.Count - 1)] -join "`n`n`n")
            $lines = $b3 -split "`n"

            # ESCADA: cabecalho de nivel e a bolinha SEGUINTE da escada - 1, depois 2, depois 3.
            # Bolinha que nao continua a escada e LISTA dentro do nivel corrente: `Auspex` poe
            # `• Obfuscate:` `• Chimerstry:` `• Other Powers:` dentro do System de um nivel, e
            # `Sanguinus` e `Grave's Decay` fazem o mesmo (SPEC R133, I104c(i)). Sem a escada
            # essas viravam nivel proprio e CORTAVAM o System do dono no meio.
            $heads = @()
            $wantDots = 1
            for ($i = 0; $i -lt $lines.Count; $i++) {
                $mh = [regex]::Match($lines[$i], '^(' + $DOT + '+) \S')
                if (-not $mh.Success) { continue }
                if ($mh.Groups[1].Value.Length -ne $wantDots) { continue }
                $heads += $i
                $wantDots++
            }

            $new = ''
            # descNumina primeiro: a entrada que tem o cabecalho `System` sozinho segue a forma
            # INVERSA (I104e) e nem chega na logica de nivel. A que nao tem cai na regra normal.
            $hdrCut = $null
            if ($a[0] -eq 'descNumina') { $hdrCut = Cut-SystemHeader $lines $marker }
            if ($null -ne $hdrCut) {
                $new = ($hdrCut -join "`n")
                $nCut++
            }
            elseif ($heads.Count -eq 0) {
                $cut = Cut-System $lines $marker
                if ($null -eq $cut) { $new = $b3; $nWhole++; $exc.Add("$($a[0])_$lang`t$name`t<entrada inteira>") }
                else { $new = ($cut -join "`n"); $nCut++ }
            }
            else {
                $chunks = @()
                for ($h = 0; $h -lt $heads.Count; $h++) {
                    $s = $heads[$h]
                    $e = $(if ($h -lt ($heads.Count - 1)) { $heads[$h + 1] - 1 } else { $lines.Count - 1 })
                    $blk = @($lines[$s..$e])
                    $tail = $(if ($blk.Count -gt 1) { @($blk[1..($blk.Count - 1)]) } else { @() })
                    $cut = Cut-System $tail $marker
                    if ($null -eq $cut) {
                        $tail = Trim-Tail $tail
                        $chunks += (@($blk[0]) + $tail -join "`n")
                        $nWhole++
                        $exc.Add("$($a[0])_$lang`t$name`t$($blk[0])")
                    }
                    else {
                        $chunks += (@($blk[0]) + $cut -join "`n")
                        $nCut++
                    }
                }
                $new = ($chunks -join "`n`n")
            }

            if ($new.Trim() -eq '') { "FALHA $($a[0])_$lang.lua '$name' : bloco 3 ficaria VAZIO (SPEC V335d)"; exit 1 }
            # LF, a forma da CASA, inclusive DENTRO do literal [==[ ]==] (SPEC V345, B87). Os
            # \r foram tirados de $body la em cima e NAO voltam aqui: a 1a escrita deste script
            # devolvia CRLF so no bloco reescrito, o que faz o arquivo quebrar linha de dois
            # jeitos e o diff mentir sobre o que a rodada fez - foi exatamente a doenca de B87.
            $rebuilt = ($head + "`n`n`n" + $new)
            [void]$sb.Append($txt.Substring($prev, $g.Index - $prev))
            [void]$sb.Append($rebuilt)
            $prev = $g.Index + $g.Length
        }
        [void]$sb.Append($txt.Substring($prev))
        # NADA e gravado aqui. Os 8 ficam em memoria e so vao para o disco depois que a trava
        # la embaixo passar - a 1a escrita deste script gravou os 8 e SO ENTAO recusou o -Apply,
        # e o que salvou o dia foi o backup de B78. Medir antes de gravar, sempre.
        $pend.Add([pscustomobject]@{ Plugin = $path; Out = (Join-Path $OutDir "$($a[0])_$lang.lua"); Text = $sb.ToString() })
        $stat.Add(("{0,-12} {1}  entradas={2,-4} recortadas={3,-4} inteiras={4}" -f $a[0], $lang, $ms.Count, $nCut, $nWhole))
    }
}

$stat | ForEach-Object { $_ }
""
# TRAVA MEDIDA em 2026-08-28, na 1a rodada seca deste script: descNumina rende 0 recortes e 289
# inteiras porque ele NAO escreve `System:` com dois-pontos - escreve `System` como CABECALHO de
# secao e os niveis de bolinha moram DENTRO dela (o que C ja dizia: "prosa introdutoria + bloco
# System INTEIRO"). Ou seja, I104b descreve a forma de descDisc/descPath/descRitual e a forma de
# descNumina e a INVERSA. Enquanto a regra do numina nao estiver escrita, -Apply e recusado: o
# recorte errado apagaria a mecanica inteira de 50 numinas caladamente.
$travas = @()
foreach ($s in $stat) {
    if ($s -match '^(\S+)\s+(\S+)\s+entradas=(\d+)\s+recortadas=(\d+)\s+inteiras=(\d+)') {
        if ([int]$Matches[4] -eq 0) { $travas += "$($Matches[1])_$($Matches[2]) : 0 recortes em $($Matches[3]) entradas - o marcador nao existe nessa forma" }
    }
}
if ($travas -and $Apply) {
    $travas | ForEach-Object { "TRAVA $_" }
    "-Apply RECUSADO: SPEC I104 nao cobre essa forma. Emendar a spec (/ck:spec) antes de gravar."
    "Nenhum dos 8 modulos foi tocado."
    exit 1
}
foreach ($w in $pend) { [IO.File]::WriteAllText($(if ($Apply) { $w.Plugin } else { $w.Out }), $w.Text, $enc) }
"EXCECOES DE I104c (sem marcador de sistema): $($exc.Count)"
$exc | ForEach-Object { '   ' + $_ }
[IO.File]::WriteAllText((Join-Path $OutDir 'excecoes.tsv'), (($exc -join "`r`n") + "`r`n"), $enc)
""
$(if ($Apply) { "GRAVADO POR CIMA dos 8 em $Plugin" } else { "gravado em $OutDir (use -Apply para escrever no plugin)" })
