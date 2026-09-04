#Requires -Version 5.1
<#
    road_aura_parse.ps1 - o bloco 3 de I141b (`Aura: <Nome>. <prosa do livro>`), T849.

    MAQUINA - nao editar a saida a mao. O que ele cospe e research/road_aura_raw.tsv; quem liga
    nome do picker -> bloco e road_aura_map.tsv, e o que ele NAO alcanca por construcao mora em
    road_aura_overrides.tsv. E a mesma forma de 4 pecas do pipeline dos pecados (I142j).

    bid = <livro>:<pag_impressa>:<ordinal na pagina>, o MESMO formato do tid de road_sins_map.tsv.

    FONTE: o cache de texto de I142a, %TEMP%\wod_books_txt\<livro>.txt (UTF-8, 1 paragrafo por
    linha, `f entre paginas). NAO e o cache -table de road_sins_parse.ps1: a aura e PROSA e mora
    na secao. Pagina IMPRESSA = indice do PDF menos o offset da tabela do README, mais 1.

    5 armadilhas MEDIDAS aqui, e nenhuma acende sozinha:
      (a) o rotulo tem 2 grafias e elas se dividem por LIVRO, nao por trilha - `da` e `dac`
          escrevem `Aura:`, core/bh/lotc escrevem `Bearing:`. Procurar so um perde 21 blocos.
      (b) o terminador NAO pode ser `Road of ` nem `Path of `: as duas frases aparecem DENTRO da
          prosa ("A follower of the Road of Blood takes his task seriously") e cortar nelas
          decepou 4 blocos na 1a tentativa, deixando "A follower of the" como texto final. O
          terminador de verdade e o rotulo irmao que vem depois - `Virtues:` no da, `Basic
          Beliefs:` no core/bh/lotc.
      (c) `-match` do PowerShell e case-INSENSITIVE e `[regex]::Match` e case-SENSITIVE. Usar os
          dois no mesmo STOP faz o teste "fechou nesta pagina?" discordar do corte: o rodape
          `the road of lilith` casava minusculo no teste e nao casava no corte, e o bloco saia
          com o rodape colado dentro. As duas pontas usam [regex] agora.
      (d) 4 blocos sao a FICHA em branco e o apendice, nao trilha nenhuma (`da` p.145 e p.484,
          `core` p.78 e p.519). Sao roster explicito aqui, nao heuristica: o de `da` p.145 e
          prosa legivel ("Tied to Road and its rating") e nenhuma regua de forma o separa.
      (e) o cache diz des-hifenizado e nao esta: sobra `bear- ing` no core p.326. A juncao
          `([a-z])- ([a-z])` roda DEPOIS da colagem de pagina, senao ela nao ve o par partido.
#>
param(
    [string]$TxtDir = "$env:TEMP\wod_books_txt",
    [string]$Out = (Join-Path $PSScriptRoot 'road_aura_raw.tsv')
)
$ErrorActionPreference = 'Stop'

$OFFSET = @{ core = 8; da = 1; bh = 1; lotc = 1; dac = 1 }

# (d) a ficha em branco e o apendice - <livro>:<pagina impressa>
$NOISE = @('da:145', 'da:484', 'core:78', 'core:519')

# (b) onde o bloco da aura ACABA: o rotulo irmao que o livro imprime logo depois.
$STOP = '\bVirtues\s*:|\bBasic Beliefs\s*:|\bThe Ethics of the Path\b|\bPaths\s*:|\bNickname\s*:|\bWillpower\s*:|\bBlood Pool\s*:|\bPlaying the Road\s*:|\bAdditional Ethics\b|\bHierarchy of Sins\b|\bSins Against\b|\bOrganization\s*:|\bRituals and Observances\s*:|\bSetites\s*:'

function CleanText([string]$s) {
    $s = $s -replace "`r?`n", ' '
    $s = $s -replace '\s+', ' '
    return $s.Trim()
}

$rows = New-Object System.Collections.Generic.List[string]
$rows.Add("# road_aura_raw.tsv - GERADO por road_aura_parse.ps1 em $(Get-Date -Format 'yyyy-MM-dd'). NAO editar a mao.")
$rows.Add('# bid = <livro>:<pag_impressa>:<ordinal>, e e a chave que road_aura_map.tsv e road_aura_overrides.tsv usam.')
$rows.Add('# bid<TAB>rotulo<TAB>nome<TAB>prosa')

$kept = 0
foreach ($book in @('da', 'core', 'bh', 'lotc', 'dac')) {
    $path = Join-Path $TxtDir "$book.txt"
    if (-not (Test-Path -LiteralPath $path)) { Write-Output "MISSING $path"; continue }
    $pages = ([Text.Encoding]::UTF8.GetString([IO.File]::ReadAllBytes($path))) -split [char]12
    for ($i = 0; $i -lt $pages.Count; $i++) {
        $printed = $i + 1 - $OFFSET[$book]
        $ord = 0
        if ($NOISE -contains "${book}:${printed}") { continue }
        foreach ($m in [regex]::Matches($pages[$i], '\b(Aura|Bearing)\s*:')) {
            $body = CleanText $pages[$i].Substring($m.Index + $m.Length)
            # (c) o mesmo motor nas duas pontas
            if (-not [regex]::IsMatch($body, $STOP) -and $i + 1 -lt $pages.Count) {
                $body = $body + ' ' + (CleanText $pages[$i + 1])
            }
            $cut = [regex]::Match($body, $STOP)
            if ($cut.Success) { $body = $body.Substring(0, $cut.Index).Trim() }
            $body = $body -replace '([a-z])- ([a-z])', '$1$2'   # (e)
            if ($body.Length -lt 20) { continue }
            # `Aura: Menace. <prosa>` - o nome e a 1a frase curta quando ela existe. Bloco SEM
            # nome e o das 5 que o user batizou (rodape do road_bearing.tsv) e sai com nome vazio.
            $name = ''
            $nm = [regex]::Match($body, '^([A-Z][A-Za-z]*(?: and [a-z]+)?)\.\s')
            if ($nm.Success -and $nm.Groups[1].Value.Length -le 20) {
                $name = $nm.Groups[1].Value
                $body = $body.Substring($nm.Length).Trim()
            }
            $ord++
            $rows.Add(("{0}:{1}:{2}`t{3}`t{4}`t{5}" -f $book, $printed, $ord, $m.Groups[1].Value, $name, $body))
            $kept++
        }
    }
}
[IO.File]::WriteAllText($Out, (($rows -join "`r`n") + "`r`n"), (New-Object Text.UTF8Encoding($false)))
Write-Output "$kept blocos -> $Out"
