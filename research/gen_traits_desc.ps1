# Writes descFamily_en.lua / descFamily_pt.lua at the plugin root from the sheet's OWN tables
# (SPEC T850, I148d, V432, I21, V210, V24). One generator for the traits modules: T971 adds the
# Clan pair to $KINDS. Block 3 of every entry is MECHANICS and nothing else:
#     Disciplines: A, B, C            (pt: Disciplinas: ...)
#     <blank line>
#     Weakness: <sentence>            (pt: Fraqueza: ...)
# Owners, never copies (SPEC V135): the trio is CLANS in WoD20th.lfm (an open trio takes the
# book's phrase from research/clan_disc_open.tsv); the family sentence is FAMILY_WEAKNESS in
# WoD20th.lfm and its [pt] line in localization.lang (SPEC V412f); book and page come from
# research/family_source.tsv. A discipline's Portuguese name is its .lang line too - no
# translation table is born here.
#
# ASCII only: PS 5.1 reads a BOM-less .ps1 as ANSI, so every accented literal is built from its
# code point (memory: powershell-bom-e-crlf). Run from anywhere: paths hang off $PSScriptRoot.
$ErrorActionPreference = 'Stop'
$root   = Split-Path $PSScriptRoot -Parent
$plugin = Join-Path $root 'Plugins\Sheets\World of Darkness 20th Anniversary Edition'
$utf8   = New-Object System.Text.UTF8Encoding($false)

function ReadU($p) {
    $t = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($p))
    if ($t.Length -gt 0 -and $t[0] -eq [char]0xFEFF) { $t = $t.Substring(1) }
    return $t
}
function Rows($p) {
    if (-not (Test-Path -LiteralPath $p)) { throw "missing $p" }
    $out = New-Object System.Collections.ArrayList
    foreach ($l in ((ReadU $p) -split "\r?\n")) {
        if ($l -eq '' -or $l.StartsWith('#')) { continue }
        [void]$out.Add(($l -split "`t"))
    }
    , $out.ToArray()
}

# Book code -> title for block 1: the table of research/README.md, the spelling every module
# on disk already carries.
$BOOK_TITLE = @{
    core   = 'Vampire: The Masquerade 20th Anniversary Edition'
    da     = 'Vampire: The Dark Ages 20th Anniversary Edition'
    lob    = 'Lore of the Bloodlines'
    gr     = 'Ghouls & Revenants'
    anarch = 'Anarchs Unbound'
    bh     = ('The Black Hand: A Guide to the Tal' + [string][char]0x2019 + 'Mahe' + [string][char]0x2019 + 'Ra')
}
$PAGE_LABEL = @{ en = 'p.'; pt = ('p' + [string][char]0xE1 + 'g.') }
$DISC_LABEL = @{ en = 'Disciplines: '; pt = 'Disciplinas: ' }
$WEAK_LABEL = @{ en = 'Weakness: ';    pt = 'Fraqueza: ' }

$lfm = ReadU (Join-Path $plugin 'WoD20th\WoD20th.lfm')

# CLANS, brace-matched the way the gate reads it: `fixed = {...}` nests inside the entry.
$clansBlk = [regex]::Match($lfm, '(?s)>>> CLANS_BEGIN(.*?)<<< CLANS_END')
if (-not $clansBlk.Success) { throw 'CLANS markers not found in WoD20th.lfm' }
$CLANS = @{}
$blk = $clansBlk.Groups[1].Value
foreach ($e in [regex]::Matches($blk, '\["([^"]+)"\]\s*=\s*\{')) {
    $i = $e.Index + $e.Length
    $depth = 1
    while ($i -lt $blk.Length -and $depth -gt 0) {
        if ($blk[$i] -eq '{') { $depth++ } elseif ($blk[$i] -eq '}') { $depth-- }
        $i++
    }
    $body = $blk.Substring($e.Index + $e.Length, $i - 1 - ($e.Index + $e.Length))
    $fixed = @()
    if ($body -match 'fixed\s*=\s*\{([^}]*)\}') { $fixed = @([regex]::Matches($Matches[1], '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value }) }
    $choice = @()
    if ($body -match 'choice\s*=\s*\{([^}]*)\}') { $choice = @([regex]::Matches($Matches[1], '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value }) }
    $open = 0
    if ($body -match 'open\s*=\s*(\d+)') { $open = [int]$Matches[1] }
    $CLANS[$e.Groups[1].Value] = @{ fixed = $fixed; choice = $choice; open = $open }
}

# FAMILY_WEAKNESS, English. The [pt] half of every sentence is its localization.lang line
# (SPEC V412f) and is looked up below like a discipline name is.
$fw = [regex]::Match($lfm, '(?s)\n\t{3}FAMILY_WEAKNESS = \{(.*?)\n\t{3}\};')
if (-not $fw.Success) { throw 'FAMILY_WEAKNESS not found in WoD20th.lfm' }
$WEAKNESS = @{}
foreach ($m in [regex]::Matches($fw.Groups[1].Value, '\["([^"]+)"\]\s*=\s*"([^"]*)"')) { $WEAKNESS[$m.Groups[1].Value] = $m.Groups[2].Value }

# localization.lang, the [pt] half only.
$PT = New-Object 'System.Collections.Generic.Dictionary[string,string]' ([StringComparer]::Ordinal)
$half = ''
foreach ($l in ((ReadU (Join-Path $plugin 'localization.lang')) -split "\r?\n")) {
    if ($l -match '^\[(\w+)\]') { $half = $Matches[1]; continue }
    if ($half -eq 'pt' -and $l -cmatch '^wod\.(.+?)=(.*)$' -and -not $PT.ContainsKey($Matches[1])) { $PT[$Matches[1]] = $Matches[2] }
}
function Pt($en) {
    if (-not $PT.ContainsKey($en)) { throw "no [pt] line in localization.lang for '$en'" }
    return $PT[$en]
}

# The open trios, in words: name<TAB>en<TAB>pt (SPEC I148d, V432b).
$OPEN_TRIO = @{}
foreach ($r in (Rows (Join-Path $PSScriptRoot 'clan_disc_open.tsv'))) {
    if ($r.Count -ne 3) { throw "clan_disc_open.tsv: '$($r[0])' has $($r.Count) fields, not 3" }
    $OPEN_TRIO[$r[0]] = @{ en = $r[1]; pt = $r[2] }
}

function PickerList($name) {
    $m = [regex]::Match($lfm, '(?s)\["' + $name + '"\]\s*=\s*\{(.*?)\n\s*\},')
    if (-not $m.Success) { throw "PICKER_LIST[$name] not found in WoD20th.lfm" }
    , @([regex]::Matches($m.Groups[1].Value, '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value } | Where-Object { $_ -ne '' })
}

function DiscLine($name, $lang) {
    $c = $CLANS[$name]
    if ($null -eq $c) { throw "'$name' has no CLANS entry" }
    if ($c.choice.Count -gt 0 -or $c.open -gt 0) {
        if (-not $OPEN_TRIO.ContainsKey($name)) { throw "'$name' has an open trio and clan_disc_open.tsv has no phrase for it" }
        return $OPEN_TRIO[$name][$lang]
    }
    $names = @()
    foreach ($d in $c.fixed) { if ($lang -eq 'en') { $names += $d } else { $names += (Pt $d) } }
    return ($names -join ', ')
}

function Entry($name, $title, $page, $disc, $weak, $lang) {
    $head = $title + ', ' + $PAGE_LABEL[$lang] + ' ' + $page + "`n`n`n" + $name + "`n`n`n"
    $body = $DISC_LABEL[$lang] + $disc + "`n`n" + $WEAK_LABEL[$lang] + $weak
    @(
        "`t`t`t`t[""$name""] = {"
        "`t`t`t`t`t$lang = [==[$head$body]==],"
        "`t`t`t`t},"
    )
}

# Family: name<TAB>book<TAB>pag_verbete<TAB>pag_weakness<TAB>note (research/family_source.tsv).
$SRC = @{}
foreach ($r in (Rows (Join-Path $PSScriptRoot 'family_source.tsv'))) { $SRC[$r[0]] = @{ book = $r[1]; page = $r[2] } }

$KINDS = @(
    @{ Kind = 'Family'; List = 'family'; Marker = 'FAMILY_DESC'; Task = 'T850'; What = 'Revenant family traits' }
)
foreach ($k in $KINDS) {
    $list = PickerList $k.List
    foreach ($lang in @('en', 'pt')) {
        $lines = @(
            "-- $($k.What), the $lang half (SPEC I21, I148d, V432, V210, V24 / $($k.Task))."
            '--'
            "-- One entry per item of PICKER_LIST[""$($k.List)""], keyed by the value the sheet SAVES, byte for"
            '-- byte (SPEC V24). Block 3 is MECHANICS and nothing else - the Disciplines and the Weakness -'
            '-- because that is what the owner asked the ? to say (SPEC I148d). The trio is read off CLANS'
            '-- and the family sentence off FAMILY_WEAKNESS, both on the root form: the module is DERIVED'
            '-- from them and V432 reads it back against them, so a drift shows up as a red gate and not'
            '-- as a pane that disagrees with the slots (SPEC V135).'
            '--'
            '-- Three blocks separated by two blank lines (SPEC I21): source, name, body. The book title'
            '-- does not translate and neither does the name in block 2 - it is the key; only p./pag. does.'
            '--'
            '-- Data only: no function, no state, no require of gui/ndb/locale (SPEC I24).'
            '-- GENERATED by research/gen_traits_desc.ps1. Do not hand-edit: fix the table or the .tsv'
            '-- it reads and run it again.'
            ''
            'return {'
            "`t`t`t`t-- >>> $($k.Marker)_BEGIN (generated - SPEC $($k.Task))"
        )
        $seen = 0
        foreach ($name in $list) {
            if (-not $SRC.ContainsKey($name)) { throw "'$name' has no row in family_source.tsv" }
            if (-not $BOOK_TITLE.ContainsKey($SRC[$name].book)) { throw "book code '$($SRC[$name].book)' of '$name' has no title here" }
            if (-not $WEAKNESS.ContainsKey($name)) { throw "'$name' has no FAMILY_WEAKNESS row" }
            $weak = $WEAKNESS[$name]
            if ($lang -eq 'pt') { $weak = Pt $weak }
            $lines += Entry $name $BOOK_TITLE[$SRC[$name].book] $SRC[$name].page (DiscLine $name $lang) $weak $lang
            $seen++
        }
        $lines += "`t`t`t`t-- <<< $($k.Marker)_END"
        $lines += '};'
        # LF end to end, like every description module on disk (SPEC V345, B87).
        $path = Join-Path $plugin "desc$($k.Kind)_$lang.lua"
        [System.IO.File]::WriteAllBytes($path, $utf8.GetBytes((($lines -join "`n") + "`n")))
        "$([System.IO.Path]::GetFileName($path)): $seen entries, $((Get-Item $path).Length) bytes"
    }
}
