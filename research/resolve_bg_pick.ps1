# ASCII puro (SPEC B84). Resolve QUAL linha de bg_essence.tsv vale para cada item do picker e
# grava a tabela resolvida no fim do proprio arquivo, sob marcador.
param([switch]$Print)
$ErrorActionPreference = 'Stop'
$root = 'c:\Users\awlol\OneDrive\Documents\firecast_fork'
$p = "$root\research\bg_essence.tsv"
$lfm = "$root\Plugins\Sheets\World of Darkness 20th Anniversary Edition\WoD20th\WoD20th.lfm"
$enc = New-Object Text.UTF8Encoding($false)

# Precedencia de livro. A ficha e da linha VAMPIRO e mortal (SPEC G) entao o V20 core manda,
# depois o resto do eixo Vampire na ordem em que o README ja usa, e so entao Mage e Werewolf.
$prec = @('core','da','hh','anarch','bh','m20','w20')

$rows = @()
$keep = New-Object System.Collections.Generic.List[string]
foreach ($l in [IO.File]::ReadAllLines($p, [Text.Encoding]::UTF8)) {
    # StartsWith, nao igualdade: o marcador carrega sufixo. Com `-eq` a 2a rodada lia as
    # proprias linhas de pick como linhas de essencia e a coluna `pag` chegava no lugar de
    # `livro` - o guard de precedencia pegou, mas o certo e nao chegar la.
    if ($l.StartsWith('# >>> BG_PICK_BEGIN')) { break }
    $keep.Add($l)
    if ($l.StartsWith('#') -or $l.StartsWith('nome_EN') -or $l.Trim() -eq '') { continue }
    $c = $l -split "`t"
    $rows += [pscustomobject]@{ Nome = $c[0]; Jogo = $c[1]; Livro = $c[2]; Pag = $c[3] }
}
while ($keep.Count -gt 0 -and $keep[$keep.Count - 1].Trim() -eq '') { $keep.RemoveAt($keep.Count - 1) }

$t = [IO.File]::ReadAllText($lfm)
$m = [regex]::Match($t, '(?s)\["background"\] = \{(.*?)\n\s*\},')
if (-not $m.Success) { 'NAO ACHOU PICKER_LIST["background"]'; exit 1 }
$itens = @([regex]::Matches($m.Groups[1].Value, '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value } | Where-Object { $_ -ne '' })

$out = New-Object System.Collections.Generic.List[string]
$bad = @()
foreach ($i in $itens) {
    $base = $i -replace ' \((Mage|Vampire|Werewolf)\)$', ''
    $jogo = $null
    if ($i -match ' \((Mage|Vampire|Werewolf)\)$') { $jogo = $Matches[1] }
    $cand = @($rows | Where-Object { $_.Nome -eq $base -and ($null -eq $jogo -or $_.Jogo -eq $jogo) })
    if ($cand.Count -eq 0) { $bad += $i; continue }
    $win = $cand | Sort-Object { [array]::IndexOf($prec, $_.Livro) } | Select-Object -First 1
    if ([array]::IndexOf($prec, $win.Livro) -lt 0) { $bad += "$i : livro '$($win.Livro)' fora da precedencia"; continue }
    $out.Add(("{0}`t{1}`t{2}" -f $i, $win.Livro, $win.Pag))
}
if ($bad) { $bad | ForEach-Object { "SEM LINHA: $_" }; exit 1 }
if ($out.Count -ne $itens.Count) { "resolveu $($out.Count) de $($itens.Count)"; exit 1 }

if ($Print) { $out | ForEach-Object { $_ }; "($($out.Count) itens)"; return }

$hdr = @(
'',
'# >>> BG_PICK_BEGIN  (gerado por research/resolve_bg_pick.ps1 - SPEC T765)',
'#',
'# QUAL linha vale quando um nome tem varias: precedencia de LIVRO',
'#   core > da > hh > anarch > bh > m20 > w20',
'# A ficha e da linha VAMPIRO e mortal (SPEC G) entao o V20 core manda; o eixo Vampire vem',
'# antes na ordem que o research/README.md ja usa, e Mage e Werewolf so entram onde Vampire',
'# nao tem o traco. E ESTA tabela que T765 le para o bloco 1 de I21 - nao a de cima, que tem',
'# uma linha por (nome, livro) e serviu para DECIDIR o dedupe de I105b.',
'#',
'# O bloco 2 de I21 imprime o nome do PICKER, nao o do livro: `Artifacts` e `Requisitions`',
'# ficam no plural por decisao do user 2026-08-28, e o livro escreve os dois no singular.',
'#',
'# colunas: item do picker <TAB> livro <TAB> pag impressa',
'#'
)
$foot = @('# <<< BG_PICK_END')
[IO.File]::WriteAllText($p, ((@($keep.ToArray()) + $hdr + @($out.ToArray()) + $foot) -join "`n") + "`n", $enc)
"BG_PICK gravado: $($out.Count) itens"
