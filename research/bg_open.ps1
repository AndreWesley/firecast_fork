# Abre o inicio de cada cabecalho listado e imprime as 3 primeiras linhas de prosa.
# Le um dump ja em ordem de leitura (bg_dump.ps1). ASCII puro (SPEC B84).
param([Parameter(Mandatory=$true)][string]$Dump,
      [Parameter(Mandatory=$true)][string[]]$Heads,
      [int]$Lines = 3)
$ErrorActionPreference = 'Stop'
$rows = [IO.File]::ReadAllLines($Dump)
$want = @{}; foreach ($h in $Heads) { $want[$h] = $true }
$pg = ''
for ($i = 0; $i -lt $rows.Count; $i++) {
    if ($rows[$i] -match '^===== \S+ (p\.\S+)') { $pg = $Matches[1]; continue }
    $t = $rows[$i].Trim() -replace '[*$]+$', ''
    $t = $t.Trim()
    if (-not $want.ContainsKey($t)) { continue }
    $body = @()
    for ($k = $i + 1; $k -lt [Math]::Min($rows.Count, $i + 14) -and $body.Count -lt $Lines; $k++) {
        $c = $rows[$k].Trim()
        if ($c.Length -lt 30) { continue }
        if ($c -match '^=====') { break }
        $body += $c
    }
    "### $t | $pg"
    foreach ($b in $body) { "    $b" }
}
