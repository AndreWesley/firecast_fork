# One-level slice of the spec: the row for <Id>, then the rows that row cites.
#
# Reading a task out of SPEC.md costs what the reader asks for: measured on T826,
# `grep -C2` pulls 42868 bytes and this pulls 1540 (SPEC I133c). One level only -
# a cite of a cite is not followed, or the slice grows back into the file.
#
# ASCII only, like verify-hunters-hunted.ps1: PowerShell 5.1 reads a BOM-less .ps1
# as ANSI, so a literal section sign would rot the file depending on how it was
# saved. The section sign is built from its code point instead (SPEC I133d, V384).
#
#   .\spec-slice.ps1 T884      # a task, its interfaces and its invariants
#   .\spec-slice.ps1 V359      # an invariant and what it names
#   .\spec-slice.ps1 I115      # an interface entry

param([Parameter(Mandatory = $true)][string]$Id)

$ErrorActionPreference = 'Stop'
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch { }

$SECT = [string][char]0xA7

# Both files, always: an id that moved to SPEC-ARCHIVE.md is still a real id, and a
# slice that cannot see it hands back half a task (SPEC V384c, V386).
$lines = @()
foreach ($name in @('SPEC.md', 'SPEC-ARCHIVE.md')) {
    $p = Join-Path $PSScriptRoot $name
    if (Test-Path $p) { $lines += [System.IO.File]::ReadAllLines($p, [System.Text.Encoding]::UTF8) }
}

# A cite may name a leg - V314e is leg (e) of row V314, which is a single line. Try
# the id as written, then the row it belongs to.
function RowOf($id) {
    foreach ($try in @($id, ($id -replace '[a-z]$', ''))) {
        $pat = $null
        if     ($try -match '^[TB][0-9]+$')     { $pat = '^' + $try + '\|' }
        elseif ($try -match '^V[0-9]+$')        { $pat = '^' + $try + ':' }
        elseif ($try -match '^I[0-9]+[a-z]?$')  { $pat = '^\s*- ' + $try + ' ' }
        if ($pat) {
            $hit = $lines | Where-Object { $_ -match $pat } | Select-Object -First 1
            if ($hit) { return $hit }
        }
    }
    return $null
}

# What a row cites: the last column of a task row, plus every section-sign reference
# in the prose - the prose is where most of the real cites live.
function CitesOf($row) {
    $out = @()
    if ($row -match '^[TB][0-9]+\|') {
        $f = $row.Split('|')
        $out += ($f[$f.Length - 1] -split ',')
    }
    foreach ($m in [regex]::Matches($row, [regex]::Escape($SECT) + '([IVTB][0-9]+[a-z]?)')) {
        $out += $m.Groups[1].Value
    }
    return ($out | ForEach-Object { $_ -replace '[^A-Za-z0-9]', '' } |
            Where-Object { $_ -match '^[IVTB][0-9]+[a-z]?$' } | Select-Object -Unique)
}

$row = RowOf $Id
if (-not $row) { Write-Output "$Id is no row in SPEC.md or SPEC-ARCHIVE.md"; exit 1 }

Write-Output $row
$self = $Id -replace '[a-z]$', ''
foreach ($c in (CitesOf $row)) {
    if (($c -replace '[a-z]$', '') -eq $self) { continue }
    $r = RowOf $c
    if ($r) { Write-Output $r } else { Write-Output "?? $c is cited here and is no row" }
}
exit 0
