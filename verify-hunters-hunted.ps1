# Build gate for the WoD20th sheet. Checks SPEC.md V1, V3, V4, V5, V8-V40.
# With -Build it also runs the real compile and checks V6 + V7.
#
# Lives at repo root, NOT inside the plugin dir: rdk packs every file under the
# plugin folder into the .rpk, so a .ps1 there would ship to users.
#
# ASCII only, on purpose: PowerShell 5.1 reads a BOM-less .ps1 as ANSI, so a stray
# accented character here would rot the file depending on how it was saved.
#
#   .\verify-hunters-hunted.ps1            # static checks only
#   .\verify-hunters-hunted.ps1 -Build     # + rdk -l, asserts the .rpk actually changed

param([switch]$Build)

$ErrorActionPreference = 'Stop'
$plugin = Join-Path $PSScriptRoot "Plugins\Sheets\World of Darkness 20th Anniversary Edition"
$dir    = Join-Path $plugin "WoD20th"
$rpk    = Join-Path $plugin "output\World of Darkness 20th Anniversary Edition.rpk"
$langFile = Join-Path $plugin "localization.lang"
$fail   = 0

function Fail($msg) { Write-Host "FAIL  $msg"; $script:fail++ }
function Pass($msg) { Write-Host "ok    $msg" }
function Doc($path) { $x = New-Object System.Xml.XmlDocument; $x.LoadXml([System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($path))); $x }

# The Lua of a file with the comments stripped - XML comments and `--` lines both. Declared
# up here with Doc and ListOf, not halfway down beside its first caller: PowerShell resolves a
# function at CALL time, so a check written above the definition dies with CommandNotFound -
# the same shape as SPEC B51/V223 in Lua, one language over.
function CodeOf($path) {
    $t = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($path))
    $t = [regex]::Replace($t, '(?s)<!--.*?-->', '')
    $t = [regex]::Replace($t, '(?m)^\s*--.*$', '')
    $t
}

# ---- SPEC V210: the book text is one module PER LANGUAGE ------------------------------
# T495 split desc<X>.lua into desc<X>_en.lua and desc<X>_pt.lua: half of every module was the
# language the session never opens, so requiring one meant parsing two (SPEC R92f). The
# generator markers migrated verbatim to BOTH halves, so the region kept the shape every
# parser here was written against - what changed is that `en` and `pt` are no longer paired
# INSIDE one file. The pairing is a join across two files now, and this is where it is made:
# five checks used to carry their own paired regex, and five copies of one parser is how a
# split like this leaves half of them reading nothing and passing (SPEC B7, V209).
#
# Returns the entries of ONE half in file order - Key, Body, and Rest, which is whatever the
# entry holds after the body and is where the optional medieval daEn/daPt lives (SPEC T470).
# $null when the file is not there or its markers are gone, so each caller says what the
# absence costs in its own words rather than passing by omission (SPEC V209).
function DescEntries($path, $marker, $lang) {
    if (-not (Test-Path -LiteralPath $path)) { return $null }
    $txt = ([System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($path))) -replace "`r`n", "`n"
    $region = [regex]::Match($txt, '-- >>> ' + $marker + '_BEGIN[^\n]*\n(.*?)-- <<< ' + $marker + '_END', 'Singleline')
    if (-not $region.Success) { return $null }
    $rx = [regex]('(?ms)^\s*\["([^"]+)"\]\s*=\s*\{\s*' + $lang + '\s*=\s*\[==\[(.*?)\]==\]\s*,?\s*(.*?)\},')
    $out = New-Object System.Collections.ArrayList
    foreach ($m in $rx.Matches($region.Groups[1].Value)) {
        [void]$out.Add([pscustomobject]@{ Key = $m.Groups[1].Value; Body = $m.Groups[2].Value; Rest = $m.Groups[3].Value })
    }
    , $out.ToArray()
}

# Key -> body for one half, ORDINAL. A case-insensitive map folds nothing on today's keys, but
# `Shadow` and `Shadows` are two numina one letter apart (SPEC V273) and the next pair added
# may differ only in case - which would silently become one entry on the way in.
function DescMap($entries) {
    $d = New-Object 'System.Collections.Generic.Dictionary[string,string]' ([StringComparer]::Ordinal)
    foreach ($e in $entries) { if (-not $d.ContainsKey($e.Key)) { $d[$e.Key] = $e.Body } }
    , $d
}

$files = Get-ChildItem -LiteralPath $dir -Filter *.lfm | Sort-Object Name
# ---- PICKER_LIST: where a picker list LIVES now (SPEC I27, 68th round) ---------------
# T493 moved every picker list out of items=/values= and into one map on the root form.
# SPEC V20 says a check reads the REAL artifact, and after T493 the real artifact is this
# map - so every list check below sources from here. Leaving them on the XML attribute is
# B7 in the other direction: the collectors come up empty and the checks pass having
# verified nothing (SPEC V209).
#
# Found by MARKER, never by line number (SPEC V211b): the T490 build shifted every gate
# line past 1935 by 33, which is why a coordinate is not a contract here.
$rootLfmTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20th.lfm")))
$plRegion   = [regex]::Match($rootLfmTxt, '(?s)PICKER_LIST_BEGIN(.*?)PICKER_LIST_END')
$PICKER     = @{}
if ($plRegion.Success) {
    foreach ($m in [regex]::Matches($plRegion.Groups[1].Value, '(?s)\["(\w+)"\]\s*=\s*\{(.*?)\n\s*\},')) {
        $vals = @()
        foreach ($q in [regex]::Matches($m.Groups[2].Value, '"((?:[^"\\]|\\.)*)"')) {
            $vals += ($q.Groups[1].Value -replace '\\"', '"' -replace '\\\\', '\')
        }
        $PICKER[$m.Groups[1].Value] = $vals
    }
}
# The three aliases are IDENTITY in Lua, not copies (SPEC V211c) - mirror them here so
# every field root resolves to the one authored list standing behind it.
$PICKER_ALIAS = @{}
foreach ($a in [regex]::Matches($rootLfmTxt, 'PICKER_LIST\["(\w+)"\]\s*=\s*PICKER_LIST\["(\w+)"\];')) {
    $PICKER_ALIAS[$a.Groups[1].Value] = $a.Groups[2].Value
    if ($PICKER.ContainsKey($a.Groups[2].Value)) { $PICKER[$a.Groups[1].Value] = $PICKER[$a.Groups[2].Value] }
}

# Which key a comboBox reads. Mirrors fieldRoot() in WoD20.6: drop "cbo", drop the row number,
# lowercase the first letter. Template combos are named cbo$(field) in the SOURCE, so their
# key comes from what their INSTANCES bind - the gate sees the XML unexpanded.
$TPL_KEY = @{}
$allTxt  = @{}
foreach ($f in $files) { $allTxt[$f.Name] = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName)) }
foreach ($tn in ($allTxt.Values | ForEach-Object { [regex]::Matches($_, '<template\s+name="([^"]+)"') } | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)) {
    foreach ($u in $allTxt.Values) {
        foreach ($i in [regex]::Matches($u, "<$tn\b[^>]*field=`"([^`"]+)`"")) {
            $TPL_KEY[$tn] = ($i.Groups[1].Value -replace '_\d+$', '')
        }
    }
}

function PickerKeyOf($comboName, $fieldAttr, $tplName) {
    if ($fieldAttr) {
        $k = $fieldAttr -replace '_?\$\([^)]*\)$', '' -replace '_\d+$', ''
        if ($k -match '^[A-Za-z]+$') { return $k.Substring(0, 1).ToLower() + $k.Substring(1) }
    }
    if ($tplName -and $TPL_KEY.ContainsKey($tplName)) { return $TPL_KEY[$tplName] }
    if ($comboName -and $comboName.StartsWith("cbo")) {
        $k = $comboName.Substring(3) -replace '_?\d+$', ''
        if ($k -match '^[A-Za-z]+$') { return $k.Substring(0, 1).ToLower() + $k.Substring(1) }
    }
    return $null
}

# The list a comboBox NODE offers, wherever it lives: PICKER_LIST for the migrated ones,
# the inline attribute for WoD20.3/WoD20.6 which T493 left alone. One accessor so no check has to
# know which world its combo is in (SPEC V20).
function ListOf($cb, $tplName) {
    $k = PickerKeyOf $cb.GetAttribute("name") $cb.GetAttribute("field") $tplName
    if ($k -and $PICKER.ContainsKey($k)) { return $PICKER[$k] }
    $a = $cb.GetAttribute("items"); if (-not $a) { $a = $cb.GetAttribute("values") }
    if ($a) { return @([regex]::Matches($a, "'([^']*)'") | ForEach-Object { $_.Groups[1].Value }) }
    return @()
}

# The template a node sits inside, or $null. Templates do not nest in this sheet.
# LocalName, never .Name: PowerShell's XML adapter shadows the .NET Name property with the
# element's name= ATTRIBUTE, so $p.Name on <template name="RitualRow"> returns "RitualRow"
# and a test against 'template' silently never matches. That is a check verifying nothing.
function TplOf($node) {
    $p = $node.ParentNode
    while ($p -ne $null -and $p.NodeType -eq 'Element') {
        if ($p.LocalName -eq 'template') { return $p.GetAttribute("name") }
        $p = $p.ParentNode
    }
    return $null
}

$PICKER_SCOPE = @('WoD20th.lfm', 'WoD20.1.lfm', 'WoD20.2.lfm', 'WoD20.7.lfm', 'WoD20.12.lfm', 'WoD20.13.lfm', 'WoD20.14.lfm')


# ---- SPEC I24: the book text lives in one .lua module per area, at the plugin root ------
# Not inside the plugin's sheet folder: `require` is resolved by the host and the only PROVEN
# layout is a module beside module.xml (Plugins/Sheets/DnD5e/common.lua, required as
# require("common.lua") from a <script> CDATA). Discovered by pattern, not by a literal list,
# so T479-T481 add a module without touching this line (same idea as V59's file count).
$descModules = @(Get-ChildItem -LiteralPath $plugin -Filter "desc*.lua" -ErrorAction SilentlyContinue | Sort-Object Name)

# ---- XML well-formedness -----------------------------------------------------
foreach ($f in $files) {
    try { [xml](Get-Content -Raw -LiteralPath $f.FullName) | Out-Null; Pass "XML $($f.Name)" }
    catch { Fail "XML $($f.Name): $($_.Exception.Message)" }
}

# ---- template names are module-global: two files cannot define the same one ------
# rdk fails this with NO message at all - it prints "Compilando..." and exits 1, never reaching
# the lint pass. Cost an hour once (a virtues mirror on the Combat tab copied <template
# name="Attribute"> from the Main tab). No working sheet in the repo reuses a template name
# across files. Cheap to check, invisible to debug.
$tplOwners = @{}
foreach ($f in $files) {
    $raw = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    foreach ($m in [regex]::Matches($raw, '<template\s+name="([^"]+)"')) {
        $nm = $m.Groups[1].Value
        if (-not $tplOwners.ContainsKey($nm)) { $tplOwners[$nm] = @() }
        $tplOwners[$nm] += $f.Name
    }
}
$tplDupes = @($tplOwners.GetEnumerator() | Where-Object { $_.Value.Count -gt 1 })
if ($tplDupes) { foreach ($d in $tplDupes) { Fail "template '$($d.Key)' is defined in $($d.Value -join ' and ') - rdk exits 1 with no message" } }
else { Pass "template names unique across files ($($tplOwners.Count) templates)" }

# ---- V59: a control name is global across the sheet's files ---------------------
# B19: the theme backdrop shipped with one shared name="themePaper" on eight tabs. rdk
# printed "Compilando..." exited 1 with no message and DELETED the .rpk - the same silent
# death as a duplicated <template name>, which is checked just above, in another family.
# Template and event names are excluded (templates have their own check; <event name="onClick">
# is an event id, not a control), and so is any name holding $( ): those expand per call.
$ctrlNames = @{}
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//*[@name]")) {
        if ($n.LocalName -in @('template','event','form')) { continue }
        $nm = $n.GetAttribute("name")
        if ($nm -like '*$(*') { continue }
        if (-not $ctrlNames.ContainsKey($nm)) { $ctrlNames[$nm] = New-Object System.Collections.Generic.HashSet[string] }
        [void]$ctrlNames[$nm].Add($f.Name)
    }
}
$nameDupes = @($ctrlNames.GetEnumerator() | Where-Object { $_.Value.Count -gt 1 })
if ($nameDupes.Count -gt 0) {
    foreach ($d in $nameDupes) { Fail "V59 control name '$($d.Key)' is declared in $(($d.Value | Sort-Object) -join ', ') - rdk dies with no message (SPEC B19)" }
} else { Pass "V59 all $($ctrlNames.Count) control names are unique across the sheet's files" }

# ---- localization.lang, parsed once -------------------------------------------
# Ordinal dictionaries on purpose: PowerShell's default hashtable is case-insensitive,
# which silently collapsed Armor/ARMOR and Experience/EXPERIENCE (20 keys masked).
$ptK = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
$enK = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
$ptVal = New-Object 'System.Collections.Generic.Dictionary[string,string]' ([StringComparer]::Ordinal)
$cur = ''
foreach ($l in [string[]][System.IO.File]::ReadAllLines($langFile, [System.Text.Encoding]::UTF8)) {
    if ($l -match '^\[(\w+)\]') { $cur = $Matches[1]; continue }
    if ($l -cmatch '^wod\.(.+?)=(.*)$') {
        if ($cur -eq 'pt') { [void]$ptK.Add($Matches[1]); if (-not $ptVal.ContainsKey($Matches[1])) { $ptVal[$Matches[1]] = $Matches[2] } }
        elseif ($cur -eq 'en') { [void]$enK.Add($Matches[1]) }
    }
}

# ---- collect fields, expanding templates ------------------------------------
$allFields  = @{}   # expanded field name -> list of "file:tag"  (input widgets only)
$linkFields = @()   # <dataLink field="x"> - observes an existing field, never owns it (V1, B.3)
$allImages  = @()
$radios     = @()   # radioButton - shares its field with its group BY DESIGN (V1 exception, V30)

foreach ($f in $files) {
    $xml = Doc $f.FullName

    $tpl = @{}
    foreach ($t in $xml.SelectNodes("//template")) {
        $pats = @()
        foreach ($n in $t.SelectNodes(".//*[@field]")) {
            $pats += [pscustomobject]@{
                Field = $n.GetAttribute("field")
                Tag   = $n.LocalName
                Value = $n.GetAttribute("fieldValue")
                Group = $n.GetAttribute("groupName")
            }
        }
        $tpl[$t.GetAttribute("name")] = $pats
    }

    foreach ($n in $xml.SelectNodes("//*")) {
        $inTemplate = $false
        $p = $n.ParentNode
        while ($p -ne $null -and $p.NodeType -eq 'Element') {
            if ($p.LocalName -eq 'template') { $inTemplate = $true; break }
            $p = $p.ParentNode
        }

        foreach ($a in @('src','checkedImage','uncheckedImage')) {
            if ($n.HasAttribute($a)) { $allImages += [pscustomobject]@{ File=$f.Name; Path=$n.GetAttribute($a) } }
        }

        if ($inTemplate) { continue }

        if ($tpl.ContainsKey($n.LocalName)) {
            foreach ($pat in $tpl[$n.LocalName]) {
                $expanded = $pat.Field
                foreach ($a in $n.Attributes) { $expanded = $expanded.Replace("`$($($a.Name))", $a.Value) }
                if ($expanded -match '\$\(') { Fail "unresolved placeholder '$expanded' in $($f.Name) <$($n.LocalName)>"; continue }
                # A radio group shares one field on purpose - the option is in fieldValue, so N
                # radios on one field is exclusion, not two owners (SPEC V1 exception / V30).
                if ($pat.Tag -eq 'radioButton') {
                    $val = $pat.Value
                    foreach ($a in $n.Attributes) { $val = $val.Replace("`$($($a.Name))", $a.Value) }
                    if ($val -match '\$\(') { Fail "unresolved fieldValue '$val' in $($f.Name) <$($n.LocalName)>"; continue }
                    $radios += [pscustomobject]@{ File=$f.Name; Field=$expanded; Value=$val; Group=$pat.Group; Via="<$($n.LocalName)>" }
                    continue
                }
                if (-not $allFields.ContainsKey($expanded)) { $allFields[$expanded] = @() }
                $allFields[$expanded] += "$($f.Name):<$($n.LocalName)>"
            }
        }
        elseif ($n.HasAttribute("field")) {
            $v = $n.GetAttribute("field")
            if ($v -match '\$\(') { continue }
            if ($n.LocalName -eq 'dataLink') { $linkFields += [pscustomobject]@{ File=$f.Name; Field=$v }; continue }
            if ($n.LocalName -eq 'radioButton') {
                $radios += [pscustomobject]@{ File=$f.Name; Field=$v; Value=$n.GetAttribute("fieldValue"); Group=$n.GetAttribute("groupName"); Via='<radioButton>' }
                continue
            }
            if (-not $allFields.ContainsKey($v)) { $allFields[$v] = @() }
            $allFields[$v] += "$($f.Name):<$($n.LocalName)>"
        }
    }
}

# ---- V1: no duplicate field among input widgets ------------------------------
# Radios are excluded above and re-registered here as ONE owner per group field, so the
# group still counts as a real owner for V8 without tripping the duplicate check.
foreach ($rf in ($radios | ForEach-Object { $_.Field } | Sort-Object -Unique)) {
    if ($allFields.ContainsKey($rf)) { Fail "V1 field '$rf' is owned by both a radio group and $($allFields[$rf] -join ', ')" }
    else { $allFields[$rf] = @("radio group ($(@($radios | Where-Object { $_.Field -eq $rf }).Count) options)") }
}

# ---- V36: declared mirrors are the OTHER exception to one-owner-per-field --------
# A mirror is literally two widgets on one `field`: the NDB is the single source of truth, so
# both stay in step with no Lua. That is the whole point of the Combat and Progress copies.
# The list is the declaration from SPEC I3 - anything multi-owned and NOT here is the accident
# V1 exists to catch, and anything here that is NOT multi-owned is a declaration gone stale.
$mirrors = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
# healthLevels was a mirror until the 82nd round: the two HEALTH boxes each carried the
# combo. It moved to the storyteller's box, where ONE widget owns it, so listing it here
# would be the stale declaration V36's second half exists to catch (SPEC I35, V234).
1..10 | ForEach-Object { [void]$mirrors.Add("health_$_") }
1..10 | ForEach-Object { [void]$mirrors.Add("willpower_c$_") }
# The 94th round adds two of a different shape: a PICKER and a typed twin on one field, one
# visible at a time behind a storyteller flag (SPEC I71, V274b). The NDB is still the single
# source of truth and still keeps them in step - what the flag changes is which one the reader
# can reach, not what either of them writes.
[void]$mirrors.Add("hedgeAffiliation")
[void]$mirrors.Add("clanFamily")
# Virtues were a mirror until the 12th round; they are display-only on the Combat tab now
# (SPEC V51), so the Main tab owns them alone and they must NOT be listed here.

$dupes = @($allFields.GetEnumerator() | Where-Object { $_.Value.Count -gt 1 })
$undeclared = @($dupes | Where-Object { -not $mirrors.Contains($_.Key) })
if ($undeclared) { foreach ($d in $undeclared) { Fail "V1 duplicate field '$($d.Key)' -> $($d.Value -join ', ')" } }
else { Pass "V1 no undeclared duplicate field ($($allFields.Count) fields, $($radios.Count) radios in $(@($radios | ForEach-Object { $_.Field } | Sort-Object -Unique).Count) group(s))" }

$mirrorNames = @($dupes | ForEach-Object { $_.Key })
$staleMirror = @($mirrors | Where-Object { $mirrorNames -notcontains $_ })
if ($staleMirror) { foreach ($s in $staleMirror) { Fail "V36 '$s' is declared a mirror but only one widget owns it - the declaration is stale" } }
else { Pass "V36 all $($mirrors.Count) declared mirrors really are mirrored" }

# ---- V8: every dataLink observes a field some input widget owns ---------------
# The one exception is a field no widget can own: the storyteller's snapshot is hidden from the
# player by having no widget at all, so the usual "some input owns it" test reads it as a dead
# link (SPEC B25). The list is closed and declared in SPEC I3 - a name has to be put here on
# purpose, which is not the same as letting any unowned field through.
$luaOwned = @('baseline', 'xpTotal', 'xpFree', 'xpManual', 'xpOrder')
foreach ($l in $linkFields) {
    if ($allFields.ContainsKey($l.Field)) { Pass "V8 dataLink '$($l.Field)' observes a real field" }
    elseif ($luaOwned -contains $l.Field) { Pass "V8 dataLink '$($l.Field)' observes a declared Lua-owned field (SPEC I3)" }
    else { Fail "V8 dataLink '$($l.Field)' in $($l.File) observes no existing field - dead link" }
}

# ---- V3: every referenced image exists --------------------------------------
foreach ($img in ($allImages | Sort-Object Path -Unique)) {
    if (Test-Path -LiteralPath (Join-Path $dir $img.Path)) { Pass "V3 image $($img.Path)" }
    else { Fail "V3 missing image '$($img.Path)' referenced by $($img.File)" }
}

# ---- V4: dataType id unique across the repo ---------------------------------
$hits = Select-String -Path (Join-Path $PSScriptRoot "Plugins\Sheets\*\*.lfm"),(Join-Path $PSScriptRoot "Plugins\Sheets\*\*\*.lfm") `
        -Pattern 'AndreOliveira\.Styllern\.WoD20th' -ErrorAction SilentlyContinue
if ($hits.Count -eq 1) { Pass "V4 dataType unique (1 declaration)" } else { Fail "V4 dataType appears $($hits.Count)x" }

# ---- V5: dot counts per trait ------------------------------------------------
function DotCount($base) { ($allFields.Keys | Where-Object { $_ -match "^$([regex]::Escape($base))_\d+$" }).Count }
function BoxCount($base) { ($allFields.Keys | Where-Object { $_ -match "^$([regex]::Escape($base))_c\d+$" }).Count }

$expect = @{}
'strength','dexterity','stamina','charisma','manipulation','appearance','perception','inteligence','wits',
'conscience','selfControl','courage'                                                                      | % { $expect[$_] = 4 }  # dot 1 is a fixed image
# Appearance is the exception: its dot 1 is a real checkBox so the rating can drop to zero
# (SPEC T95), which makes it the only attribute with five owned dots instead of four.
$expect['appearance'] = 5
'alertness','athletics','awareness','brawl','empathy','expression','intimidation','leadership','streetwise','subterfuge',
'animalKen','crafts','etiquette','firearms','larceny','melee','performance','ride','stealth','survival',
'academics','enigmas','finance','investigation','law','medicine','occult','politics','science','technology',
'faith',
'customTalent_1','customTalent_2','customSkill_1','customSkill_2','customKnowledge_1','customKnowledge_2'  | % { $expect[$_] = 5 }
$expect['humanity'] = 10
$expect['willpower'] = 10
# SPEC V5 says "backgrounds 5" dots, but only the ROW count was ever checked - a background
# row could have shipped with four dots and passed.
#
# The count itself is not written here: it is read off BACKGROUND_ROWS, the one place the
# sheet declares it (SPEC V145). A gate holding its own copy of that number is a third place
# to forget.
$bgRootTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20th.lfm")))
$bgDecl = [regex]::Match($bgRootTxt, '(?m)^\s*BACKGROUND_ROWS = (\d+);')
$bgRows = if ($bgDecl.Success) { [int]$bgDecl.Groups[1].Value } else { 0 }
if (-not $bgDecl.Success) { Fail "V145 BACKGROUND_ROWS is not declared on the root form - the row count would be a literal in every loop again" }
1..$bgRows | ForEach-Object { $expect["background_$_"] = 5 }
# Numina tab: hedge rows + psychic rows, 5 dots each (SPEC V5 after T56/T57). The two counts
# stopped being a literal `10` in the 90th round: each list declares its own on the root form
# and every loop reads it, so a row drawn in the XML and walked by no loop cannot pass as a
# dot that costs nothing (SPEC I59, I60, V263, and B46 for what a stale literal buys).
$nmDecl = [regex]::Match($bgRootTxt, '(?m)^\s*NUMINA_ROWS\s*=\s*(\d+);')
$nmRows = if ($nmDecl.Success) { [int]$nmDecl.Groups[1].Value } else { 0 }
if (-not $nmDecl.Success) { Fail "V263 NUMINA_ROWS is not declared on the root form - the hedge row count would be a literal in every loop" }
elseif ($nmRows -ge 1) { 1..$nmRows | ForEach-Object { $expect["numina_$_"] = 5 } }
$psDecl = [regex]::Match($bgRootTxt, '(?m)^\s*PSYCHIC_ROWS\s*=\s*(\d+);')
$psRows = if ($psDecl.Success) { [int]$psDecl.Groups[1].Value } else { 0 }
if (-not $psDecl.Success) { Fail "V263 PSYCHIC_ROWS is not declared on the root form - the psychic row count would be a literal in every loop" }
elseif ($psRows -ge 1) { 1..$psRows | ForEach-Object { $expect["psychic_$_"] = 5 } }
# Specialities are ONE dot per row (SPEC V147), and the row count is read off the sheet's own
# declaration for the same reason BACKGROUND_ROWS is: a tenth row drawn in the XML and walked
# by neither loop would be a dot that costs nothing and never reaches the log.
$spDecl = [regex]::Match($bgRootTxt, '(?m)^\s*SPECIALITY_ROWS = (\d+);')
$spRows = if ($spDecl.Success) { [int]$spDecl.Groups[1].Value } else { 0 }
if (-not $spDecl.Success) { Fail "V147 SPECIALITY_ROWS is not declared on the root form - the row count would be a literal in every loop" }
elseif ($spRows -ge 1) { 1..$spRows | ForEach-Object { $expect["speciality_$_"] = 1 } }

foreach ($k in ($expect.Keys | Sort-Object)) {
    $got = DotCount $k
    if ($got -eq $expect[$k]) { Pass "V5 $k = $got dots" } else { Fail "V5 $k = $got dots, expected $($expect[$k])" }
}
$wb = BoxCount 'willpower'
if ($wb -eq 10) { Pass "V5 willpower = 10 boxes" } else { Fail "V5 willpower = $wb boxes, expected 10" }

# Each numina table is 8 pickers + 2 free rows (SPEC T56/T57); backgrounds are however many
# BACKGROUND_ROWS says (9 until the 46th round moved the box to the Traits tab, 20 after).
foreach ($grp in @(@('numina',$nmRows), @('psychic',$psRows), @('background',$bgRows), @('health',10), @('speciality',$spRows))) {
    $n = ($allFields.Keys | Where-Object { $_ -match "^$($grp[0])_\d+$" }).Count
    if ($n -eq $grp[1]) { Pass "V5 $($grp[0]) = $n rows" } else { Fail "V5 $($grp[0]) = $n rows, expected $($grp[1])" }
}

# The third numina table is a single row (SPEC T81), so it has no `_N` series to count:
# assert the picker field itself instead. Its 5 dots are covered by $expect['faith'] above,
# which brings the Powers tab to 21 rows.
if ($allFields.ContainsKey('faith')) { Pass "V5 faith = 1 row (21st numina row)" }
else { Fail "V5 no 'faith' field - the TRUE FAITH row is missing" }

# The seven semantic health names are gone: the track is positional now (SPEC T96), counted by
# the `health` group above. They are asserted as burned names in the orphan check below.

# ---- V35: a field that changed tabs lives exactly once, in its NEW file ----------
# Removing it from the old file and adding it to the new one is one change. Doing only
# half leaves either two owners (V1) or a saved rating that vanishes with no rename to
# blame (V2) - and neither half fails on its own, which is why this check names both
# ends. `faith_1`..`_5` went Main -> Powers (T79/T81); the nine inventory fields went
# Combat -> Inventory (T76/T77).
#
# Armour moved TWICE: Combat -> Inventory in T76/T77, then back in T87 because armour is
# combat gear. Its old home is therefore WoD20.8 and its new one WoD20.3 - the reverse of the
# other rows here. `transportation` and `other` are no longer listed: they own no widget
# at all now and are checked as declared orphans below instead.
$movedTo  = @{
    'WoD20.7.lfm' = @('faith_1','faith_2','faith_3','faith_4','faith_5')
    'WoD20.8.lfm' = @('items','gear','equipment')
    'WoD20.3.lfm' = @('armorClass','armorRating','armorPenalty','armorDescription')
}
$movedFrom = @{ 'WoD20.7.lfm' = 'WoD20.1.lfm'; 'WoD20.8.lfm' = 'WoD20.3.lfm'; 'WoD20.3.lfm' = 'WoD20.8.lfm' }
$movedBad  = @()
$movedSeen = 0
foreach ($newFile in $movedTo.Keys) {
    $oldFile = $movedFrom[$newFile]
    foreach ($fld in $movedTo[$newFile]) {
        $movedSeen++
        if (-not $allFields.ContainsKey($fld)) {
            $movedBad += "'$fld' has no owner - it left $oldFile and never arrived in $newFile"
            continue
        }
        $owners = @($allFields[$fld])
        $where  = @($owners | ForEach-Object { ($_ -split ':')[0] } | Sort-Object -Unique)
        if ($owners.Count -gt 1) { $movedBad += "'$fld' has $($owners.Count) owners ($($owners -join ', ')) - the move duplicated it" }
        if ($where -contains $oldFile) { $movedBad += "'$fld' is still declared in $oldFile" }
        if ($where -notcontains $newFile) { $movedBad += "'$fld' lives in {$($where -join ', ')}, expected $newFile" }
    }
}
if ($movedBad) { foreach ($m in $movedBad) { Fail "V35 $m" } }
else { Pass "V35 all $movedSeen migrated fields sit exactly once, in their new file" }

# ---- I3 declared orphans: these names must own NO widget -------------------------
# `transportation` and `other` lost their Inventory boxes by request (SPEC C, 3rd round).
# Their text is still sitting in already-saved sheets. If either name were reused for a new
# field, an old sheet would silently pour stale content into an unrelated box - so the names
# stay burned, and SPEC I3 lists them as orphans. This is the check that keeps that promise.
#
# Owning is not the only way to name a field. A dataLink can WATCH one, and a watch on a dead
# name simply never fires - it breaks nothing loudly, it just stops redrawing. WoD20.9 watched
# `stBackgroundsXP` to repaint the experience log, and the 88th round turned that flag into a
# price: the watch would have gone on pointing at a name no widget writes any more, and the log
# would have sat still while the storyteller changed what a background costs.
#
# V8 does not reach these: it reads `field=`, and every list of this shape is `fields=`. So the
# orphan check asks BOTH questions - who owns it, and who is listening for it (SPEC V209, V20).
$watched = @{}
foreach ($f in $files) {
    foreach ($dl in (Doc $f.FullName).SelectNodes("//dataLink")) {
        $names = "$($dl.GetAttribute('field')) $($dl.GetAttribute('fields'))"
        foreach ($m in [regex]::Matches($names, '[A-Za-z_][A-Za-z0-9_]*')) {
            if (-not $watched.ContainsKey($m.Value)) { $watched[$m.Value] = @() }
            if ($watched[$m.Value] -notcontains $f.Name) { $watched[$m.Value] += $f.Name }
        }
    }
}
if ($watched.Count -eq 0) { Fail "I3 no dataLink watch was read across the sheet - the dead-watch leg of this check verifies nothing (SPEC V209, V20)" }
else { Pass "I3 $($watched.Count) distinct field name(s) are watched by a dataLink somewhere on the sheet" }

foreach ($orphan in @('stShowMagika','transportation','other','bruised','hurt','injured','wounded','mauled','crippled','incapacitated','personalidade','natureza','experience','spentXP','stFreeDots','freeDots','ritual_21','ritual_22','ritual_23','ritual_24','ritual_25','stBackgroundsXP')) {
    if ($allFields.ContainsKey($orphan)) {
        Fail "I3 '$orphan' is a declared orphan but $($allFields[$orphan] -join ', ') owns it - choose a different field name"
    } elseif ($watched.ContainsKey($orphan)) {
        Fail "I3 '$orphan' owns no widget but $($watched[$orphan] -join ', ') still WATCHES it - a dataLink on a dead name never fires, so whatever it redraws quietly stops (SPEC V2, V8)"
    } else { Pass "I3 declared orphan '$orphan' owns no widget and nothing watches it" }
}

# The three Base of Operations boxes added to Inventory (SPEC T89). Named explicitly so a
# typo produces a loud failure instead of a box that renders fine and saves nowhere.
foreach ($fld in @('baseDefenses','baseArmaments','baseOther')) {
    if (-not $allFields.ContainsKey($fld)) { Fail "V1 '$fld' has no widget - a Base of Operations box is missing" }
    else {
        $own = @($allFields[$fld])
        $wh  = @($own | ForEach-Object { ($_ -split ':')[0] } | Sort-Object -Unique)
        if ($own.Count -eq 1 -and $wh[0] -eq 'WoD20.8.lfm') { Pass "V1 '$fld' owned once, in WoD20.8.lfm" }
        else { Fail "V1 '$fld' owned by $($own -join ', ') - expected exactly one widget in WoD20.8.lfm" }
    }
}

# ---- collect every user-visible string ---------------------------------------
# label/checkBox/button text, template `nome=` args, tab titles, Lua t("..."), picker items.
$visible = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
$visiblePickerItems = 0
$padded  = @()
foreach ($f in $files) {
    $raw = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    $xml = Doc $f.FullName
    foreach ($n in $xml.SelectNodes("//*")) {
        foreach ($a in @('text','nome')) {
            if (-not $n.HasAttribute($a)) { continue }
            $v = $n.GetAttribute($a)
            if (-not $v -or $v -match '\$\(' -or $v.Trim() -eq '') { continue }
            if ($n.LocalName -in @('label','checkBox','button') -or $a -eq 'nome') {
                [void]$visible.Add($v.Trim())
                if ($v -match '   ') { $padded += "$($f.Name): '$v'" }   # 3+ spaces
            }
        }
    }
    # Tab titles are translated too (WoD20.6 handles cls == "tab"), so they are visible strings.
    foreach ($n in $xml.SelectNodes("//tab[@title]")) { [void]$visible.Add($n.GetAttribute("title").Trim()) }
    # runtime strings built in Lua go through the t() helper
    [regex]::Matches($raw, 't\("([^"]+)"\)') | ForEach-Object { [void]$visible.Add($_.Groups[1].Value) }
    # Picker items are user-visible too (SPEC V17). Read them off the XML `items=` attribute,
    # NOT out of a Lua table: the lists live inline in the templates now, and a checker that
    # greps for the old Lua form would pass silently while verifying nothing.
    # Only `cbo*` pickers count - the colour and theme combos are values, not prose.
    foreach ($cb in $xml.SelectNodes("//comboBox[@name]")) {
        if ($cb.GetAttribute("name") -notlike 'cbo*') { continue }
        # The list lives in PICKER_LIST now (SPEC I27, T493). ListOf still falls back to the
        # inline attribute for the pickers T493 left alone, so both worlds land here.
        foreach ($it in (ListOf $cb (TplOf $cb))) {
            if ($it -ne '') { [void]$visible.Add($it); $visiblePickerItems++ }
        }
    }
}

# ---- V13/V14/V15: the picker pattern (SPEC R.4) -------------------------------
# The free-text `edit` was dropped by request on 2026-08-17, so the picker comboBox IS the
# field now. A picker without a field would render fine and silently save nothing.
$pickerBad = @()
$listReport = @()
foreach ($f in $files) {
    $xml = Doc $f.FullName
    foreach ($n in $xml.SelectNodes("//comboBox")) {
        $nm = $n.GetAttribute("name")
        if ($nm -like 'cbo*' -and -not $n.HasAttribute("field")) { $pickerBad += "$($f.Name): picker '$nm' owns no field - it would save nothing" }
    }
    foreach ($cb in $xml.SelectNodes("//comboBox[@name]")) {
        $nm = $cb.GetAttribute("name")
        if ($nm -notlike 'cbo*') { continue }
        $items = @(ListOf $cb (TplOf $cb))
        if ($items.Count -eq 0) { continue }
        $listReport += [pscustomobject]@{ Name = "$($f.Name)/$nm"; Items = $items }
    }
}
if ($pickerBad) { foreach ($b in $pickerBad) { Fail "V13 $b" } } else { Pass "V13 every picker comboBox owns its field" }

foreach ($l in $listReport) {
    $dupe = $l.Items | Group-Object | Where-Object Count -gt 1
    if ($dupe) { Fail "V14 $($l.Name) has duplicates: $(($dupe | ForEach-Object { $_.Name }) -join ', ')" }
    # Most pickers carry a leading empty entry that is not an option; cboSheetTheme is the
    # declared exception and has none, so counting it the same way under-reported it by one.
    elseif ($l.Items[0] -eq '') { Pass "V14 $($l.Name) has $($l.Items.Count - 1) unique entries" }
    else { Pass "V14 $($l.Name) has $($l.Items.Count) unique entries" }
    # cboSheetTheme is the declared exception (SPEC V15, 11th round): a state combo with a real
    # default, not prose to be cleared - there is no such thing as a sheet with no theme.
    # cboGame joined it in the 32nd round for the same reason and one more: it is locked, so an
    # empty row would be a value nobody could get back out of (SPEC V109).
    if ($l.Name -like '*cboSheetTheme*' -or $l.Name -like '*cboGame*') { Pass "V15 $($l.Name) n/a - state combo with a default (declared exception)" }
    elseif ($l.Items[0] -eq '') { Pass "V15 $($l.Name) starts empty" } else { Fail "V15 $($l.Name) first entry is '$($l.Items[0])', expected empty" }
}

# The three checks above are only worth as much as what the collector saw: a picker named
# without the `cbo` prefix, or one that lost its inline `items=`, drops out of $listReport
# and every check on it becomes a silent no-op (SPEC V20 / B.7). Name the new ones.
foreach ($must in @('WoD20.6.lfm/cboGame','WoD20.7.lfm/cboHedgeAttr','WoD20.6.lfm/cboSheetTheme')) {
    if ($listReport | Where-Object { $_.Name -eq $must }) { Pass "V14/V15/V17 $must reaches the list checks" }
    else { Fail "V14/V15/V17 $must was never collected - its list is unchecked" }
}

# cboGame is a closed roster, not an open vocabulary: assert the names themselves, so a
# dropped, renamed or added entry fails instead of passing as "no duplicates" (SPEC V109).
# Three since the 32nd round, and no leading empty one to discount.
$gameList = @($listReport | Where-Object { $_.Name -eq 'WoD20.6.lfm/cboGame' })
if ($gameList.Count -eq 1) {
    $wantGames = @('Vampire', 'Mortal', 'Mage')
    $gotGames = @($gameList[0].Items)
    if (($gotGames -join '|') -eq ($wantGames -join '|')) { Pass "V109 cboGame offers exactly $($wantGames -join ', ')" }
    else { Fail "V109 cboGame offers '$($gotGames -join ', ')', expected '$($wantGames -join ', ')'" }
}

# ---- V9: source language is English - no non-ASCII in authored strings -------
# Deliberately a codepoint range, not a list of accented letters: this file is read
# as ANSI by PowerShell 5.1 when it has no BOM, so non-ASCII literals here would rot.
# TWO codepoints are excused, and both are written as escapes for the same reason
# (SPEC V195, B42). U+2019: the core prints forty-two path and ritual names with a
# typographic apostrophe - Devil's Touch, Grave's Decay, Boukephos' Gateway - so this
# check was calling correct English "not English". U+00F0 joined it in the 92nd round
# for `Forn Jafnadr`, an Old Norse affiliation the M20 Sorcerer prints with an eth
# (SPEC I66). Spelling is not language, and neither codepoint occurs in Portuguese, so
# the door stays shut on what this check defends: every other non-ASCII codepoint still
# fails, and an authored Portuguese string is caught exactly as before.
$ptChars = $visible | Where-Object { $_ -match '[^\x00-\x7F\u2019\u00F0]' }
if ($ptChars) { foreach ($s in $ptChars) { Fail "V9 non-English string '$s' - source must be English" } }
else { Pass "V9 all $($visible.Count) visible strings authored in English" }

# ---- V11: no label aligns columns with padding runs (B.5) -------------------
if ($padded) { foreach ($s in $padded) { Fail "V11 padding run used for alignment -> $s" } }
else { Pass "V11 no label uses padding runs" }

# ---- V10: every visible string has a key in BOTH [pt] and [en] ---------------
$noPt = @($visible | Where-Object { -not $ptK.Contains($_) })
$noEn = @($visible | Where-Object { -not $enK.Contains($_) })
if ($noPt) { foreach ($s in $noPt) { Fail "V10 no [pt] key for '$s'" } } else { Pass "V10 all visible strings have a [pt] key" }
if ($noEn) { foreach ($s in $noEn) { Fail "V10 no [en] key for '$s'" } } else { Pass "V10 all visible strings have an [en] key" }

# ---- V16 + V25: a label must be wide enough for the LONGER of its EN and PT text
# Crude on purpose: no font metrics available offline, so estimate at ~6.5px/char for the
# default proportional font. Only flags clear overflow, not tight fits.
#
# V25 exists because V16 alone was blind (SPEC B.11): a template label carries
# text="$(nome)", which the `$(` guard skipped, so EVERY row label in the sheet escaped
# the check. "Animal Ken" is "Empatia com Animais" (19 chars, ~124px) in a label that
# was 80px wide, and WILLPOWER is "FORCA DE VONTADE" (16 chars) in a 60px one.
$PX_PER_CHAR = 6.5
function NeededPx($txt) {
    $longest = $txt.Length
    if ($ptVal.ContainsKey($txt) -and $ptVal[$txt].Length -gt $longest) { $longest = $ptVal[$txt].Length }
    [math]::Ceiling($longest * $PX_PER_CHAR)
}
$tooNarrow = @()
foreach ($f in $files) {
    $xml = Doc $f.FullName

    # V25 first: map each template's placeholder labels to the width they render in
    $tplLabel = @{}
    foreach ($t in $xml.SelectNodes("//template")) {
        $arr = @()
        foreach ($lb in $t.SelectNodes(".//label[@text][@width]")) {
            $w = 0; if (-not [int]::TryParse($lb.GetAttribute("width"), [ref]$w)) { continue }
            if ($lb.GetAttribute("text") -match '^\$\((\w+)\)$') { $arr += [pscustomobject]@{ Attr = $Matches[1]; Width = $w } }
        }
        if ($arr.Count) { $tplLabel[$t.GetAttribute("name")] = $arr }
    }
    foreach ($n in $xml.SelectNodes("//*")) {
        if (-not $tplLabel.ContainsKey($n.LocalName)) { continue }
        foreach ($slot in $tplLabel[$n.LocalName]) {
            if (-not $n.HasAttribute($slot.Attr)) { continue }
            $txt = $n.GetAttribute($slot.Attr).Trim()
            if (-not $txt) { continue }
            $need = NeededPx $txt
            if ($need -gt $slot.Width) { $tooNarrow += "$($f.Name): <$($n.LocalName)> $($slot.Attr)='$txt' (pt '$($ptVal[$txt])') needs ~${need}px, template label width=$($slot.Width)px" }
        }
    }

    # V16: plain literal labels
    foreach ($n in $xml.SelectNodes("//label[@text][@width]")) {
        $txt = $n.GetAttribute("text").Trim()
        if (-not $txt -or $txt -match '\$\(') { continue }
        $w = 0; if (-not [int]::TryParse($n.GetAttribute("width"), [ref]$w)) { continue }
        $need = NeededPx $txt
        if ($need -gt $w) { $tooNarrow += "$($f.Name): '$txt' (pt '$($ptVal[$txt])') needs ~${need}px, width=${w}px" }
    }
}
if ($tooNarrow) { foreach ($t in $tooNarrow) { Fail "V16/V25 $t" } } else { Pass "V16/V25 every label fits its longest translation (templates included)" }

# ---- V26: sibling rows share a dot column and an input column (SPEC B.12) -----
# Rows are `<layout left=N>` wrappers around a template call. Two rows drawn at the same
# `left` inside the same box must use templates whose first dot sits at the same x, else
# the dot columns visibly stagger - which is how Humanity (x=60) drifted from Conscience
# (x=80), and Concept's edit (x=90) from the Nature picker (x=112).
$misaligned = @()
foreach ($f in $files) {
    $xml = Doc $f.FullName

    $geom = @{}
    foreach ($t in $xml.SelectNodes("//template")) {
        $dot = $null; $inp = $null
        foreach ($c in $t.SelectNodes(".//*")) {
            $x = 0; if (-not [int]::TryParse($c.GetAttribute("left"), [ref]$x)) { continue }
            # A fixed <image> IS dot 1 in the Attribute template, so it counts as a dot.
            if ($null -eq $dot -and $c.LocalName -in @('image','imageCheckBox','checkBox')) { $dot = $x }
            if ($null -eq $inp -and $c.LocalName -in @('edit','comboBox')) { $inp = $x }
        }
        $geom[$t.GetAttribute("name")] = [pscustomobject]@{ Dot = $dot; Input = $inp }
    }
    if ($geom.Count -eq 0) { continue }

    foreach ($box in $xml.SelectNodes("//layout")) {
        $byLeft = @{}
        foreach ($row in $box.SelectNodes("layout")) {
            $lf = $row.GetAttribute("left")
            foreach ($call in $row.SelectNodes("*")) {
                if (-not $geom.ContainsKey($call.LocalName)) { continue }
                if (-not $byLeft.ContainsKey($lf)) { $byLeft[$lf] = @() }
                $byLeft[$lf] += [pscustomobject]@{ Tpl = $call.LocalName; G = $geom[$call.LocalName] }
            }
        }
        foreach ($lf in $byLeft.Keys) {
            $rows = $byLeft[$lf]
            if ($rows.Count -lt 2) { continue }
            $dots = @($rows | Where-Object { $null -ne $_.G.Dot } | ForEach-Object { $_.G.Dot } | Sort-Object -Unique)
            if ($dots.Count -gt 1) {
                $who = ($rows | Where-Object { $null -ne $_.G.Dot } | ForEach-Object { "$($_.Tpl)@$($_.G.Dot)" } | Sort-Object -Unique) -join ', '
                $misaligned += "$($f.Name): rows at left=$lf have dots at {$($dots -join ', ')} -> $who"
            }
            $dotless = @($rows | Where-Object { $null -eq $_.G.Dot -and $null -ne $_.G.Input })
            $ins = @($dotless | ForEach-Object { $_.G.Input } | Sort-Object -Unique)
            if ($ins.Count -gt 1) {
                $who = ($dotless | ForEach-Object { "$($_.Tpl)@$($_.G.Input)" } | Sort-Object -Unique) -join ', '
                $misaligned += "$($f.Name): rows at left=$lf have inputs at {$($ins -join ', ')} -> $who"
            }
        }
    }
}
if ($misaligned) { foreach ($m in $misaligned) { Fail "V26 $m" } } else { Pass "V26 sibling rows share their dot and input columns" }

# ---- V37: sibling rows on one line must not draw over each other (SPEC B16) -------
# The Background tab shipped a 310px-wide template in columns spaced 265 apart, so the third
# column's label sat inside the second column's edit. Two rows were affected and the gate was
# green throughout: V16/V25 measure text against its own label width, never a row's footprint
# against its neighbour's. This measures the footprint.
$overlaps = @()
foreach ($f in $files) {
    $xml = Doc $f.FullName

    $tplWidth = @{}
    foreach ($t in $xml.SelectNodes("//template")) {
        $mx = 0
        foreach ($c in $t.SelectNodes(".//*")) {
            $l = 0; $w = 0
            if ([int]::TryParse($c.GetAttribute("left"), [ref]$l) -and [int]::TryParse($c.GetAttribute("width"), [ref]$w)) {
                if (($l + $w) -gt $mx) { $mx = $l + $w }
            }
        }
        $tplWidth[$t.GetAttribute("name")] = $mx
    }
    if ($tplWidth.Count -eq 0) { continue }

    foreach ($box in $xml.SelectNodes("//layout")) {
        $rows = @()
        foreach ($row in $box.SelectNodes("layout")) {
            $l = 0
            if (-not [int]::TryParse($row.GetAttribute("left"), [ref]$l)) { continue }
            $t2 = 0; [void][int]::TryParse($row.GetAttribute("top"), [ref]$t2)
            $need = 0; $who = ''
            foreach ($call in $row.SelectNodes("*")) {
                if ($tplWidth.ContainsKey($call.LocalName) -and $tplWidth[$call.LocalName] -gt $need) {
                    $need = $tplWidth[$call.LocalName]; $who = $call.LocalName
                }
            }
            if ($need -gt 0) { $rows += [pscustomobject]@{ L = $l; T = $t2; R = $l + $need; Tpl = $who } }
        }
        for ($i = 0; $i -lt $rows.Count; $i++) {
            for ($j = $i + 1; $j -lt $rows.Count; $j++) {
                if ($rows[$i].T -eq $rows[$j].T -and $rows[$i].L -lt $rows[$j].R -and $rows[$j].L -lt $rows[$i].R) {
                    $overlaps += "$($f.Name) top=$($rows[$i].T): <$($rows[$i].Tpl)> spans $($rows[$i].L)..$($rows[$i].R) and <$($rows[$j].Tpl)> starts at $($rows[$j].L)"
                }
            }
        }
    }
}
if ($overlaps) { foreach ($o in ($overlaps | Sort-Object -Unique)) { Fail "V37 $o" } }
else { Pass "V37 no sibling row draws over its neighbour" }

# ---- V40: and two BOXES on one tab must not overlap either (SPEC V40, T112) --------
# V37 measures a row against its neighbour inside one box; nothing ever measured box against
# box, though the tabs have had side-by-side columns since T30 (COMBAT ends at x=650, the right
# column starts at 670). T111 drops VIRTUES into the 280px gutter between ARMOR and that column,
# where a 10px slip would draw one box over another and still pass green.
# Boxes without all four numbers (align="client", flow layouts) are skipped: they have no
# rectangle to compare.
$boxHits = @()
$boxCount = 0
$paneByRect = 0
foreach ($f in $files) {
    $xml = Doc $f.FullName
    foreach ($sb in $xml.SelectNodes("//scrollBox")) {
        $boxes = @()
        # A tab pane is not a neighbouring box: the panes stack on ONE rect by design and exactly
        # one is ever visible (SPEC I32, proved in Firecast at T521). Overlap is the mechanism
        # here, not the bug.
        #
        # They were told apart by holding an <import> until the 90th round, when the three Numina
        # panes landed with their content INLINE - no import to hold, because the book left the
        # .lfm in SPEC I24 and the reason to split the file went with it. Three legal panes would
        # have reddened this check on code that is right (SPEC B7). The import was only ever a
        # PROXY for the sentence above; sharing the exact rect with another sibling IS that
        # sentence, so it is measured now instead of assumed (SPEC V262d).
        #
        # A strip is not a pane by either door - numStrip and vampStrip carry their own rect - so
        # they go on being weighed against the panes, which is B41 coming through the geometry
        # door (SPEC V221).
        $paneRect = @{}
        foreach ($bx in $sb.SelectNodes("layout")) {
            $k = "$($bx.GetAttribute('left'))/$($bx.GetAttribute('top'))/$($bx.GetAttribute('width'))/$($bx.GetAttribute('height'))"
            if ($k -notmatch '^\d+/\d+/\d+/\d+$') { continue }
            if ($paneRect.ContainsKey($k)) { $paneRect[$k]++ } else { $paneRect[$k] = 1 }
        }
        foreach ($bx in $sb.SelectNodes("layout")) {
            if ($bx.SelectSingleNode("import")) { continue }
            $pk = "$($bx.GetAttribute('left'))/$($bx.GetAttribute('top'))/$($bx.GetAttribute('width'))/$($bx.GetAttribute('height'))"
            if ($paneRect.ContainsKey($pk) -and $paneRect[$pk] -gt 1) { $paneByRect++; continue }
            $bl = 0; $bt = 0; $bw = 0; $bh = 0
            if (-not ([int]::TryParse($bx.GetAttribute("left"), [ref]$bl) -and
                      [int]::TryParse($bx.GetAttribute("top"), [ref]$bt) -and
                      [int]::TryParse($bx.GetAttribute("width"), [ref]$bw) -and
                      [int]::TryParse($bx.GetAttribute("height"), [ref]$bh))) { continue }
            $ttl = $bx.SelectSingleNode("label")
            $nm = if ($ttl) { $ttl.GetAttribute("text") } else { "box" }
            $boxes += [pscustomobject]@{ L = $bl; T = $bt; R = $bl + $bw; B = $bt + $bh; Name = $nm }
        }
        $boxCount += $boxes.Count
        for ($i = 0; $i -lt $boxes.Count; $i++) {
            for ($j = $i + 1; $j -lt $boxes.Count; $j++) {
                $p = $boxes[$i]; $q = $boxes[$j]
                if ($p.L -lt $q.R -and $q.L -lt $p.R -and $p.T -lt $q.B -and $q.T -lt $p.B) {
                    $boxHits += "$($f.Name): '$($p.Name)' ($($p.L),$($p.T))-($($p.R),$($p.B)) overlaps '$($q.Name)' ($($q.L),$($q.T))-($($q.R),$($q.B))"
                }
            }
        }
    }
}
if ($boxHits) { foreach ($o in ($boxHits | Sort-Object -Unique)) { Fail "V40 $o" } }
elseif ($boxCount -eq 0) { Fail "V40 measured zero boxes - the check reads nothing (SPEC V20)" }
else { Pass "V40 none of the $boxCount positioned boxes draws over its neighbour" }

# ---- V38: a checkBox with text needs the same width check as a label (SPEC B17) ---
# V16 only ever looked at //label. "Wounded (-2)" is "Ferido Gravemente (-2)" in pt, ~143px,
# and it sat in a 125px checkBox from T3 until this was found by hand.
$narrowChecks = @()
foreach ($f in $files) {
    $xml = Doc $f.FullName
    foreach ($n in $xml.SelectNodes("//checkBox[@text][@width]")) {
        $txt = $n.GetAttribute("text").Trim()
        if (-not $txt -or $txt -match '\$\(') { continue }
        $w = 0; if (-not [int]::TryParse($n.GetAttribute("width"), [ref]$w)) { continue }
        $need = NeededPx $txt
        if ($need -gt $w) { $narrowChecks += "$($f.Name): checkBox '$txt' (pt '$($ptVal[$txt])') needs ~${need}px, width=${w}px" }
    }
}
if ($narrowChecks) { foreach ($c in $narrowChecks) { Fail "V38 $c" } }
else { Pass "V38 every checkBox fits its longest translation" }

# ---- V39: the health level table (SPEC C, V39) ------------------------------------
# Ten explicit lists, LITERAL from the user - 4 skips Crippled instead of trimming from the top,
# so there is no rule to derive and nothing to cross-check against except the shape itself.
$rootPath = Join-Path $dir "WoD20th.lfm"
$root = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($rootPath))
$canonHealth = @('Bruised','Hurt (-1)','Injured (-1)','Wounded (-2)','Mauled (-2)','Crippled (-5)','Incapacitated')
$lvlBlock = [regex]::Match($root, 'HEALTH_LEVELS\s*=\s*\{(.*?)\n\s*\};', 'Singleline')
if (-not $lvlBlock.Success) { Fail "V39 HEALTH_LEVELS not found on the root form" }
else {
    $seen = @{}
    foreach ($m in [regex]::Matches($lvlBlock.Groups[1].Value, '\[(\d+)\]\s*=\s*\{([^}]*)\}')) {
        $n = [int]$m.Groups[1].Value
        $items = @([regex]::Matches($m.Groups[2].Value, '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value })
        $seen[$n] = $items
    }
    $bad = @()
    foreach ($n in 1..10) {
        if (-not $seen.ContainsKey($n)) { $bad += "no list for $n levels"; continue }
        $items = $seen[$n]
        if ($items.Count -ne $n) { $bad += "list for $n has $($items.Count) entries" }
        if ($items[-1] -ne 'Incapacitated') { $bad += "list for $n ends in '$($items[-1])', not Incapacitated" }
        foreach ($it in $items) { if ($canonHealth -notcontains $it) { $bad += "list for $n has unknown level '$it'" } }
    }
    if ($bad) { foreach ($b in ($bad | Sort-Object -Unique)) { Fail "V39 $b" } }
    else { Pass "V39 all 10 health level lists are well formed" }

    # The renderer writes these labels itself, so its pt table is the only thing that translates
    # them - the WoD20.6 map never sees them. Same check V22 runs on that map.
    $ptBlock = [regex]::Match($root, 'HEALTH_PT\s*=\s*\{(.*?)\n\s*\};', 'Singleline')
    if (-not $ptBlock.Success) { Fail "V39 HEALTH_PT not found - the labels could never translate" }
    else {
        $htDrift = @()
        foreach ($m in [regex]::Matches($ptBlock.Groups[1].Value, '\["([^"]+)"\]\s*=\s*"([^"]*)"')) {
            $k = $m.Groups[1].Value; $v = $m.Groups[2].Value
            if (-not $ptVal.ContainsKey($k)) { $htDrift += "'$k' not in [pt]" }
            elseif ($ptVal[$k] -cne $v) { $htDrift += "'$k': table='$v' lang='$($ptVal[$k])'" }
        }
        foreach ($c in $canonHealth) {
            if ($ptBlock.Groups[1].Value -notmatch [regex]::Escape("[""$c""]")) { $htDrift += "'$c' has no pt entry" }
        }
        if ($htDrift) { foreach ($d in ($htDrift | Sort-Object -Unique)) { Fail "V39 HEALTH_PT $d" } }
        else { Pass "V39 HEALTH_PT covers all 7 levels and matches localization.lang" }
    }

    # Read WoD20.6 here rather than using $hh6: that variable is not assigned until the V12 block
    # further down, so referencing it at this point would silently test an empty string.
    $hh6Early = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.6.lfm")))
    if ($hh6Early -match 'string\.sub\(dynName, 1, 3\) == "dyn"') { Pass "V31/V39 the traversal skips Lua-owned (dyn*) text" }
    else { Fail "V31/V39 WoD20.6 traversal has no dyn* guard - it would restore stale health labels" }
}

# ---- V41 - V43: the four-symbol damage mark (SPEC C 6th round) -------------------
# The health box stopped being a checkBox: it holds " ", "/", "X" or "*", cycles on click and
# resets on right-click. Three things can rot silently - a second copy of the list drifting from
# the first, a mark box wired for click but not for right-click, and the normalisation that keeps
# a pre-6th-round boolean from rendering as "true" in the box.
$markMatches = [regex]::Matches($root, 'HEALTH_MARKS\s*=\s*\{([^}]*)\}')
if ($markMatches.Count -ne 1) { Fail "V41 HEALTH_MARKS declared $($markMatches.Count)x on the root form, expected exactly 1" }
else {
    $marks = @([regex]::Matches($markMatches[0].Groups[1].Value, '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value })
    $wantMarks = @(' ', '/', 'X', '*')
    $sameOrder = $marks.Count -eq $wantMarks.Count
    if ($sameOrder) { for ($i = 0; $i -lt $marks.Count; $i++) { if ($marks[$i] -cne $wantMarks[$i]) { $sameOrder = $false } } }
    if ($sameOrder) { Pass "V41 HEALTH_MARKS = the four symbols, space first, in cycle order" }
    else { Fail "V41 HEALTH_MARKS = {'$($marks -join "','")'} - expected {' ','/','X','*'} in that order" }
}
$strayMarks = @($files | Where-Object { $_.Name -ne 'WoD20th.lfm' } |
                Where-Object { [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($_.FullName)) -match 'HEALTH_MARKS\s*=' })
if ($strayMarks) { foreach ($s in $strayMarks) { Fail "V41 $($s.Name) declares its own HEALTH_MARKS - the two tabs would drift" } }
else { Pass "V41 the mark list lives only on the root form" }

# V42: an unknown value (boolean, nil, junk) must be written back as the empty mark by the
# renderer, or the box shows "true" until someone clicks it.
if ($root -match 'markIndex\(mark\)\s*==\s*1' -and $root -match 'setField\("health_"\s*\.\.\s*i, HEALTH_MARKS\[1\]\)') {
    Pass "V42 renderHealthTrack normalises an unknown mark to the empty one"
} else {
    Fail "V42 no normalisation in renderHealthTrack - a pre-6th-round boolean would render as 'true'"
}

# V43: every mark box answers BOTH buttons. Checked on the template, which is where the box is
# declared once per tab; the ten rows per tab are template calls and are counted by V5.
$markBoxes = 0
foreach ($f in $files) {
    $xml = Doc $f.FullName
    foreach ($t in $xml.SelectNodes("//template")) {
        $lbl = $t.SelectSingleNode(".//label[@field]")
        if ($null -eq $lbl -or $lbl.GetAttribute("field") -notmatch '^health_') { continue }
        $markBoxes++
        $box = $lbl.ParentNode
        $where = "$($f.Name) <template $($t.GetAttribute('name'))>"
        if ($box.GetAttribute("onClick") -notmatch 'cycleHealthMark') { Fail "V43 $where mark box has no cycleHealthMark on onClick" }
        if ($box.GetAttribute("onMenu") -notmatch 'healHealthMark') { Fail "V43 $where mark box has no healHealthMark on onMenu - right-click would do nothing" }
        if ($box.GetAttribute("hitTest") -ne 'true') { Fail "V43 $where mark box has no hitTest - it would never see a click" }
    }
}
if ($markBoxes -eq 0) { Fail "V43 no health mark box found - the check reads nothing (SPEC V20)" }
else { Pass "V43 all $markBoxes mark boxes answer click and right-click" }

# ---- V44 + V45: clearing a mark heals the BOTTOM of the track (SPEC C 7th round) --
# The click the player makes and the row that empties are deliberately different rows, so the
# two ways to get it wrong are: cycleHealthMark emptying the row it was handed, and the heal
# scanning rows the player cannot see (a mark left above a shortened track eats the click).
function LuaFn($txt, $name) {
    $m = [regex]::Match($txt, "(?ms)function\s+$name\s*\(.*?\r?\n\t\t\tend;")
    if ($m.Success) { return $m.Value }
    return ''
}
$cycFn  = LuaFn $root 'cycleHealthMark'
$healFn = LuaFn $root 'healHealthMark'
$rendFn = LuaFn $root 'renderHealthTrack'

if (-not $cycFn) { Fail "V44 cycleHealthMark not found on the root form" }
elseif ($cycFn -match 'HEALTH_MARKS\[1\]') { Fail "V44 cycleHealthMark can still write the empty mark - it would clear the clicked row instead of healing" }
elseif ($cycFn -notmatch 'healHealthMark\(') { Fail "V44 cycleHealthMark never calls healHealthMark - the fourth click would do nothing" }
else { Pass "V44 cycleHealthMark heals instead of emptying the clicked row" }

if (-not $healFn) { Fail "V44 healHealthMark not found on the root form" }
else {
    if ($healFn -notmatch 'for\s+\w+\s*=\s*\w+\s*,\s*1\s*,\s*-1') { Fail "V44 healHealthMark does not scan the track downwards - it would clear the topmost mark, not the last" }
    else { Pass "V44 healHealthMark clears the bottom-most mark" }

    if ($healFn -notmatch 'healthLevels') { Fail "V45 healHealthMark is not bounded by healthLevels - a mark on a hidden row would eat the click" }
    else { Pass "V45 healHealthMark only looks at rows the player can see" }
}

if ($rendFn -match 'healHealthMark\(') { Fail "V45 renderHealthTrack calls healHealthMark - normalising an old value is not healing" }
else { Pass "V45 the renderer never heals" }

# ---- V46 + V47: marks stay grouped, worst first (SPEC C 8th round) ---------------
# Upgrading a mark in the middle of the stack leaves the track out of order, and a new mark
# started on a far-down empty row leaves a gap. Both are fixed by regrouping, so the checks are:
# the routine exists, it walks severity downwards, it is called from the two paths that can
# break the order, and it takes its severity order from HEALTH_MARKS rather than a copy.
$regroupFn = LuaFn $root 'regroupHealthMarks'
if (-not $regroupFn) { Fail "V46 regroupHealthMarks not found on the root form" }
else {
    if ($regroupFn -notmatch 'for\s+\w+\s*=\s*#HEALTH_MARKS\s*,\s*2\s*,\s*-1') { Fail "V46 regroupHealthMarks does not walk HEALTH_MARKS from the worst down - the grouping order would not be severity" }
    else { Pass "V46 regroupHealthMarks lays marks out worst-first" }

    if ($regroupFn -notmatch 'healthLevels') { Fail "V47 regroupHealthMarks is not bounded by healthLevels - it would shuffle rows the player cannot see" }
    else { Pass "V47 regroupHealthMarks only touches visible rows" }

    if ($regroupFn -match '\{\s*"') { Fail "V47 regroupHealthMarks declares its own symbol list - it must read HEALTH_MARKS (SPEC V41)" }
    else { Pass "V47 regroupHealthMarks reads the one symbol list" }
}
if ($cycFn -notmatch 'regroupHealthMarks\(') { Fail "V46 cycleHealthMark never regroups - an upgrade in the middle of the stack would stay out of order" }
else { Pass "V46 cycleHealthMark regroups after changing a mark" }
if ($rendFn -notmatch 'regroupHealthMarks\(') { Fail "V46 renderHealthTrack never regroups - a sheet marked before the 8th round would open out of order" }
else { Pass "V46 the renderer groups what it finds on an older sheet" }

# ---- V27: a section title spanning its box must actually be centred on it -----
# `horzTextAlign="center"` centres inside the label, not inside the box, so a title with
# left="5" and width=<box width> sits 5px right of centre (SPEC B.13). Column headers are
# narrow relative to their box, so only labels spanning >=80% of the box are section titles.
$offCentre = @()
foreach ($f in $files) {
    $xml = Doc $f.FullName
    foreach ($box in $xml.SelectNodes("//layout")) {
        $bw = 0; if (-not [int]::TryParse($box.GetAttribute("width"), [ref]$bw)) { continue }
        foreach ($lb in $box.SelectNodes("label")) {
            if ($lb.GetAttribute("horzTextAlign") -ne "center") { continue }
            if ($lb.HasAttribute("rotationAngle")) { continue }
            $w = 0; if (-not [int]::TryParse($lb.GetAttribute("width"), [ref]$w)) { continue }
            if ($w -lt ($bw * 0.8)) { continue }
            $lf = 0; [void][int]::TryParse($lb.GetAttribute("left"), [ref]$lf)
            if ($lf -ne 0 -or $w -ne $bw) { $offCentre += "$($f.Name): '$($lb.GetAttribute('text'))' left=$lf width=$w in a ${bw}px box" }
        }
    }
}
if ($offCentre) { foreach ($o in $offCentre) { Fail "V27 $o" } } else { Pass "V27 every section title is centred on its box" }

# ---- V77: a section title is not glued to the box border (SPEC 26th round) --------
# The outline is 3px thick (THEME_STROKE), so a title at top=0 sits on the border itself.
# 44 titles were shifted to 4 in one sweep; without a check the next box copied from an
# older file goes straight back to 0, exactly the drift V68 exists for on the corner.
# The Progress tab is out by request - the user asked for every tab but that one.
$titleTop = @()
$titleCount = 0
foreach ($f in $files) {
    if ($f.Name -eq 'WoD20.9.lfm') { continue }
    foreach ($box in (Doc $f.FullName).SelectNodes("//layout[rectangle[@color='black']]")) {
        $ttl = $box.SelectSingleNode("label[@horzTextAlign='center']")
        if ($null -eq $ttl) { continue }
        $t = 0
        if (-not [int]::TryParse($ttl.GetAttribute("top"), [ref]$t)) { continue }
        $titleCount++
        if ($t -lt 4) { $titleTop += "$($f.Name): '$($ttl.GetAttribute('text'))' sits at top=$t - the title would touch the 3px outline" }
    }
}
if ($titleCount -eq 0) { Fail "V77 no section title found - the check reads nothing (SPEC V20)" }
elseif ($titleTop) { foreach ($t in $titleTop) { Fail "V77 $t" } }
else { Pass "V77 all $titleCount section titles clear the box border" }

# ---- V68: and every section box carries the SAME corner ---------------------------
# The corner detail - cornerType over a radius - lives in the XML rather than in the palettes
# (SPEC V66), so it is authored 53 times and nothing kept those 53 in step. A box copied from
# an older file would sit among its siblings with a different corner and read as a mistake.
# Exactly the drift that produced B18, on another property.
#
# The two deliberate outliers are excluded the same way V48 excludes them: they are not black.
# The avatar frame is DimGray and keeps its own radius; the health mark box is transparent.
#
# The third declared exception is the strip floor, and it is the FIRST that is black: the
# other two fall out for free because the XPath below only takes black, and this one does
# not. It is cut by CONSTRUCTION rather than by name, and emphatically not by "authors no
# corner" - that last one would be a hole wide enough for B18 to walk straight back through,
# since any box that simply forgot its radius would then be excused in silence. A strip floor
# is an align="client" rectangle whose parent layout also holds clickable rectangles;
# measured across the sheet that matches ONE layout (tabStrip) and no section box, because
# the health track's clickable rectangles are not siblings of their box background.
# The corner is not dropped, it changes owner: V229 requires the floor to author none
# (SPEC I33, user request 2026-08-22).
$corners = @{}
$boxSeen = 0
$floorCut = 0
foreach ($f in $files) {
    foreach ($r in (Doc $f.FullName).SelectNodes("//rectangle[@color='black']")) {
        if ($r.GetAttribute("align") -eq 'client' -and $r.ParentNode.SelectSingleNode("rectangle[@onClick]")) { $floorCut++; continue }
        $boxSeen++
        $key = "{0}|{1}|{2}" -f $r.GetAttribute("cornerType"), $r.GetAttribute("xradius"), $r.GetAttribute("yradius")
        if (-not $corners.ContainsKey($key)) { $corners[$key] = New-Object System.Collections.Generic.HashSet[string] }
        [void]$corners[$key].Add($f.Name)
    }
}
if ($floorCut -ne 1) { Fail "V68 the strip-floor cut matched $floorCut rectangle(s), expected exactly 1 - a wider cut is a hole B18 walks back through (SPEC V209)" }
elseif ($boxSeen -lt 60) { Fail "V68 only $boxSeen black section box(es) were read, expected at least 60 - this check is covering less than the sheet has (SPEC V209)" }
elseif ($corners.Count -eq 0) { Fail "V68 no black section box found - the check has nothing to measure" }
elseif ($corners.Count -gt 1) {
    foreach ($k in $corners.Keys) {
        $p = $k -split '\|'
        Fail "V68 section boxes with cornerType='$($p[0])' radius $($p[1])/$($p[2]) in $(($corners[$k] | Sort-Object) -join ', ') - the corner must match across every box"
    }
} else {
    $p = ($corners.Keys | Select-Object -First 1) -split '\|'
    Pass "V68 all $boxSeen section boxes share cornerType='$($p[0])' radius $($p[1])/$($p[2]), and the one strip floor is cut out by construction"
}


# ---- V69: the Main tab closes on ONE line, and the map says which ------------------
# V40 only asks that two boxes never overlap, so growing VIRTUES and shrinking the
# HUMANITY/WILLPOWER box under it by the wrong amount would leave the middle column
# ending short and still pass green - the 18th round moves both, and this keeps it honest.
#
# The ruler has moved twice. It was the BACKGROUNDS box beside it until the 46th round,
# then the literal y=810 the grid comment declared. The 50th round raised the whole bottom
# row and that literal had to be hand-edited again - a gate measuring the round instead of
# the rule. So it is READ from the map comment now and cross-checked against every box that
# is supposed to close on it, the avatar included: the comment cannot rot either.
#
# HEALTH is the declared exception: its authored height is the ten-row case and the renderer
# shrinks it to the chosen track (V49), so it hangs exactly 6px below the line - a corner
# taken in the 11th round, and measured here rather than skipped.
$HEALTH_TEN_ROW_OVERHANG = 1
$mainRawForMap = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.1.lfm")))
$mapY = [regex]::Match($mainRawForMap, 'Everything closes on x=\d+ / y=(\d+)')
$mainDocV69 = Doc (Join-Path $dir "WoD20.1.lfm")
$mainBottom = @{}
foreach ($bx in $mainDocV69.SelectNodes("//scrollBox/layout")) {
    $bt = 0; $bh = 0
    if (-not ([int]::TryParse($bx.GetAttribute("top"), [ref]$bt) -and
              [int]::TryParse($bx.GetAttribute("height"), [ref]$bh))) { continue }
    foreach ($lb in $bx.SelectNodes("label")) {
        $t = $lb.GetAttribute("text")
        if ($t) { $mainBottom[$t] = $bt + $bh }
    }
}
$avatarImg = @($mainDocV69.SelectNodes("//scrollBox/image[@field='avatar']"))[0]
$avatarBottom = if ($avatarImg) { [int]$avatarImg.GetAttribute("top") + [int]$avatarImg.GetAttribute("height") } else { -1 }
$closers = @("HUMANITY", "SPECIALTIES")
$missing = @($closers | Where-Object { -not $mainBottom.ContainsKey($_) })
if (-not $mapY.Success) { Fail "V69 the tab's grid comment no longer says where the tab closes - the ruler would be a literal in the gate again (SPEC V20)" }
elseif ($missing.Count -gt 0) { Fail "V69 $($missing -join '/') not found on WoD20.1 - the check measured nothing (SPEC V20)" }
elseif ($avatarBottom -lt 0) { Fail "V69 the avatar image was not found on WoD20.1 - it closes the left column and V69 measures it since the 50th round" }
elseif (-not $mainBottom.ContainsKey("HEALTH")) { Fail "V69 HEALTH not found on WoD20.1 - its declared overhang went unmeasured (SPEC V20)" }
else {
    $line = [int]$mapY.Groups[1].Value
    $off = @()
    foreach ($c in $closers) { if ($mainBottom[$c] -ne $line) { $off += "$c ends at $($mainBottom[$c])" } }
    if ($avatarBottom -ne $line) { $off += "the avatar ends at $avatarBottom" }
    if ($off.Count -gt 0) { Fail "V69 the map says the tab closes on y=$line but $($off -join ', ') - the Main bottom row must close on one line" }
    elseif (($mainBottom["HEALTH"] - $line) -ne $HEALTH_TEN_ROW_OVERHANG) { Fail "V69 HEALTH hangs $($mainBottom['HEALTH'] - $line)px below the line, not the $HEALTH_TEN_ROW_OVERHANG px the ten-row case is allowed (SPEC V49)" }
    else { Pass "V69 HUMANITY, SPECIALTIES and the avatar all close on y=$line; HEALTH hangs the declared $HEALTH_TEN_ROW_OVERHANG px at ten rows" }
}
# ---- V48: a section box is filled black (SPEC B18) -------------------------------
# ABILITIES shipped with the Mage sheet's transparent fill, so the tab background showed
# through and it read as grey beside its black siblings. Nothing measured colour until now.
# A section box is a layout holding a rectangle AND a centred title - which is exactly what
# leaves out the two deliberate non-black rectangles: the avatar frame (DimGray, no title) and
# the health mark box (#00000000, declared inside a template and sitting on a black box).
$greyBoxes = 0
$litBoxes = 0
foreach ($f in $files) {
    $xml = Doc $f.FullName
    foreach ($box in $xml.SelectNodes("//layout")) {
        $rect = $box.SelectSingleNode("rectangle")
        if ($null -eq $rect) { continue }
        $title = $null
        foreach ($lb in $box.SelectNodes("label")) {
            if ($lb.GetAttribute("horzTextAlign") -eq "center") { $title = $lb; break }
        }
        if ($null -eq $title) { continue }
        $litBoxes++
        $fill = $rect.GetAttribute("color")
        if ($fill -ne 'black') {
            $greyBoxes++
            Fail "V48 $($f.Name): box '$($title.GetAttribute('text'))' is filled '$fill', not black - the tab shows through it"
        }
    }
}
if ($litBoxes -eq 0) { Fail "V48 no section box found - the check reads nothing (SPEC V20)" }
elseif ($greyBoxes -eq 0) { Pass "V48 all $litBoxes section boxes are filled black" }

# ---- V51: willpower on the Combat tab - dots read-only, boxes editable -----------
# The point of the box is spending willpower mid-fight without letting anyone raise the
# permanent rating from here, so the two halves must stay split: dots with no field at all
# (painted from the real values) over boxes that own willpower_c* and mirror the Main tab.
$hh3x = Doc (($files | Where-Object { $_.Name -eq 'WoD20.3.lfm' }).FullName)
$hh3t = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.3.lfm")))
$wpTpl = $hh3x.SelectSingleNode("//template[@name='WillpowerMirror']")
if ($null -eq $wpTpl) { Fail "V51 WoD20.3 has no WillpowerMirror template" }
else {
    $wpDots = @($wpTpl.SelectNodes("imageCheckBox"))
    $wpBoxes = @($wpTpl.SelectNodes("checkBox"))
    $owning = @($wpDots | Where-Object { $_.HasAttribute("field") })
    $clickable = @($wpDots | Where-Object { $_.GetAttribute("autoChange") -ne 'false' })

    if ($wpDots.Count -ne 10) { Fail "V51 WillpowerMirror has $($wpDots.Count) dots, expected 10" }
    elseif ($owning.Count -gt 0) { Fail "V51 $($owning.Count) willpower dots own a field - they would be a second owner of the Main tab rating (V1)" }
    elseif ($clickable.Count -gt 0) { Fail "V51 $($clickable.Count) willpower dots lack autoChange='false' - a click would toggle a display-only dot" }
    else { Pass "V51 all 10 willpower dots are display only" }

    $boxFields = @($wpBoxes | ForEach-Object { $_.GetAttribute("field") } | Where-Object { $_ -match '^willpower_c\d+$' })
    if ($boxFields.Count -ne 10) { Fail "V51 WillpowerMirror has $($boxFields.Count) willpower_c* boxes, expected 10" }
    else { Pass "V51 all 10 willpower boxes mirror the Main tab" }

    if ($hh3t -notmatch 'paintWillpower') { Fail "V51 WoD20.3 never paints the willpower dots - they would stay empty" }
    elseif ($hh3t -notmatch "'willpower_1'") { Fail "V51 the WoD20.3 dataLink does not observe willpower_* - the dots would not follow the Main tab" }
    else { Pass "V51 the dots are painted and follow the Main tab" }
}

# Virtues joined the display-only side in the 12th round: same rule, same two ways to break it.
$vTpl = $hh3x.SelectSingleNode("//template[@name='VirtueMirror']")
if ($null -eq $vTpl) { Fail "V51 WoD20.3 has no VirtueMirror template" }
else {
    $vDots = @($vTpl.SelectNodes("imageCheckBox"))
    $vOwning = @($vDots | Where-Object { $_.HasAttribute("field") })
    $vClickable = @($vDots | Where-Object { $_.GetAttribute("autoChange") -ne 'false' })

    if ($vDots.Count -eq 0) { Fail "V51 VirtueMirror has no dots to check" }
    elseif ($vOwning.Count -gt 0) { Fail "V51 $($vOwning.Count) virtue dots own a field - virtues are display-only on this tab since the 12th round" }
    elseif ($vClickable.Count -gt 0) { Fail "V51 $($vClickable.Count) virtue dots lack autoChange='false' - a click would toggle a display-only dot" }
    else { Pass "V51 all $($vDots.Count) virtue dots are display only" }

    # Anchored on the paint CALL, not just the name: the list can be renamed or emptied while
    # the token still appears somewhere in the file.
    if ($hh3t -notmatch 'paint\(form,\s*RO_VIRTUES\[') { Fail "V51 WoD20.3 never paints the virtue dots - they would stay empty" }
    elseif ($hh3t -notmatch 'RO_VIRTUES\s*=\s*\{\s*"conscience"') { Fail "V51 RO_VIRTUES does not list the three virtues" }
    elseif ($hh3t -notmatch "'conscience_2'") { Fail "V51 the WoD20.3 dataLink does not observe the virtue fields - the dots would not follow the Main tab" }
    else { Pass "V51 the virtue dots are painted and follow the Main tab" }
}

# ---- V49: the health box height follows the track length (SPEC C 10th round) -----
# The renderer computes the height from a pitch that lives in Lua while the rows themselves are
# positioned in the .lfm files. Measure the real spacing and compare - if someone re-spaces the
# rows, the Lua constant has to move with them. The declared height must be the TEN-row case:
# the renderer only shrinks, so the file stays the worst case for the box-overlap check (V40).
$pitchLua = 0; $padLua = 0
if ($root -match 'HEALTH_ROW_PITCH\s*=\s*(\d+)') { $pitchLua = [int]$Matches[1] }
if ($root -match 'HEALTH_BOX_PAD\s*=\s*(\d+)')   { $padLua   = [int]$Matches[1] }
if ($pitchLua -eq 0 -or $padLua -eq 0) { Fail "V49 HEALTH_ROW_PITCH / HEALTH_BOX_PAD not found on the root form" }
else {
    $measured = 0
    foreach ($pair in @(@('WoD20.1.lfm','dynHealth_'), @('WoD20.3.lfm','dynHealth3_'))) {
        $fx = $files | Where-Object { $_.Name -eq $pair[0] }
        if (-not $fx) { Fail "V49 $($pair[0]) missing"; continue }
        $xml = Doc $fx.FullName

        $r1 = $xml.SelectSingleNode("//layout[@name='$($pair[1])row1']")
        $r2 = $xml.SelectSingleNode("//layout[@name='$($pair[1])row2']")
        $bx = $xml.SelectSingleNode("//layout[@name='$($pair[1])box']")
        if ($null -eq $r1 -or $null -eq $r2) { Fail "V49 $($pair[0]) has no $($pair[1])row1/row2 - the renderer could not find its rows"; continue }
        if ($null -eq $bx) { Fail "V49 $($pair[0]) has no <layout name='$($pair[1])box'> - the renderer cannot resize the box"; continue }

        $measured++
        $pitchXml = [int]$r2.GetAttribute("top") - [int]$r1.GetAttribute("top")
        $hXml = [int]$bx.GetAttribute("height")
        if ($pitchXml -ne $pitchLua) { Fail "V49 $($pair[0]) rows are $pitchXml apart but HEALTH_ROW_PITCH is $pitchLua - the box would not end under the last row" }
        else { Pass "V49 $($pair[0]) row pitch ($pitchXml) matches HEALTH_ROW_PITCH" }

        $hMax = 10 * $pitchLua + $padLua
        if ($hXml -ne $hMax) { Fail "V49 $($pair[0]) box height=$hXml but the ten-row case is $hMax - the file must declare the tallest it can get (V40 reads this file)" }
        else { Pass "V49 $($pair[0]) box declares the ten-row height ($hXml)" }
    }
    if ($measured -eq 0) { Fail "V49 no health box measured - the check reads nothing (SPEC V20)" }

    if ($rendFn -notmatch 'height\s*=.*HEALTH_ROW_PITCH') { Fail "V49 renderHealthTrack never sets the box height from the pitch - the box would stay ten rows tall" }
    elseif ($rendFn -notmatch 'healthLevels') { Fail "V49 renderHealthTrack does not read healthLevels for the height" }
    else { Pass "V49 the renderer sizes the box from the chosen track length" }
}

# ---- V12: combo items are values - items must agree with the Lua comparison ---
# The theme combo was removed on 2026-08-17. Absent is fine; present-but-inconsistent is not.
$hh6 = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.6.lfm")))
if ($hh6 -match 'field="theme"[^>]*items="\{([^}]*)\}"') {
    $items = ([regex]::Matches($Matches[1], "'([^']*)'") | ForEach-Object { $_.Groups[1].Value })
    if ($hh6 -match 'theme\s*==\s*"([^"]+)"') {
        $cmp = $Matches[1]
        if ($items -contains $cmp) { Pass "V12 theme comparison '$cmp' is one of {$($items -join ', ')}" }
        else { Fail "V12 Lua compares theme == '$cmp' but items are {$($items -join ', ')} - theme switching is broken" }
    } else { Fail "V12 theme combo present but no comparison found in WoD20.6.lfm" }
} else { Pass "V12 n/a - no theme combo (removed)" }

# ---- V21: language traversal starts at the ROOT, not at this form (SPEC B.9) --
if ($hh6 -match 'recursiveFindControls\s*\(\s*self') { Fail "V21 traversal still starts at self - sibling tabs unreachable" }
elseif ($hh6 -notmatch 'getParent\(\)') { Fail "V21 no getParent() walk found - traversal cannot reach the sheet root" }
else { Pass "V21 traversal walks up to the sheet root" }

# ---- V109 + V110: the Game box is locked, defaulted, and kept inside its roster ---
# Information, not a choice. Which makes what it holds the sheet's problem: a value outside
# the three - one of the four longer names this sheet used to offer, or nothing at all - would
# sit in a box nobody can open, so the load puts it back inside the roster.
$gameNode = @((Doc (Join-Path $dir "WoD20.6.lfm")).SelectNodes("//comboBox[@name='cboGame']"))
if ($gameNode.Count -ne 1) { Fail "V109 expected exactly one cboGame, found $($gameNode.Count)" }
elseif ($gameNode[0].GetAttribute("enabled") -ne 'false') { Fail "V109 cboGame is editable - the game is information, not a choice" }
elseif ($hh6 -notmatch 'dataLink field="game" defaultValue="Mortal"') { Fail "V109 cboGame has no default - a new sheet would show an empty locked box" }
elseif ($root -notmatch 'setField\("game", "Mortal"\)') { Fail "V110 nothing normalises a game outside the roster - the locked box would hold a value nobody can clear" }
else { Pass "V109/V110 cboGame is locked, defaulted and normalised on load" }

# ---- V22: translation is non-destructive and the PT map matches localization.lang
if ($hh6 -notmatch 'originalText\[') { Fail "V22 no snapshot table - translating in place cannot be undone" }
else { Pass "V22 original English is snapshotted before translating" }

$embedded = New-Object 'System.Collections.Generic.Dictionary[string,string]' ([StringComparer]::Ordinal)
$mapBlock = [regex]::Match($hh6, 'local PT = \{(.*?)\n\s*\};', 'Singleline')
if (-not $mapBlock.Success) { Fail "V22 PT map not found in WoD20.6.lfm" }
else {
    foreach ($m in [regex]::Matches($mapBlock.Groups[1].Value, '\["([^"]+)"\]\s*=\s*"([^"]*)"')) {
        $embedded[$m.Groups[1].Value] = $m.Groups[2].Value
    }
    $drift = @()
    foreach ($k in $embedded.Keys) {
        if (-not $ptVal.ContainsKey($k)) { $drift += "'$k' in map but not in [pt]" }
        elseif ($ptVal[$k] -cne $embedded[$k]) { $drift += "'$k': map='$($embedded[$k])' lang='$($ptVal[$k])'" }
    }
    if ($drift) { foreach ($d in $drift) { Fail "V22 PT map out of sync - $d" } }
    else { Pass "V22 PT map ($($embedded.Count) entries) matches localization.lang" }
}

# ---- V28: the map must also COVER every visible string (SPEC B.14) ------------
# V22 only checks map -> lang. Without the reverse, a new string can have a [pt] key,
# be missing from the embedded map, never translate at runtime, and still pass green.
$uncovered = @($visible | Where-Object { -not $embedded.ContainsKey($_) })
if ($uncovered) { foreach ($s in $uncovered) { Fail "V28 '$s' has a [pt] key but is absent from the PT map - it would never translate" } }
else { Pass "V28 PT map covers all $($visible.Count) visible strings" }

# ---- V23: language is a two-value combo, not a bool ---------------------------
if ($hh6 -match 'field="localization"') { Fail "V23 old boolean 'localization' field still present" }
elseif ($hh6 -notmatch 'field="language"') { Fail "V23 no 'language' field found" }
else {
    $lm = [regex]::Match($hh6, 'field="language"[^>]*values="\{([^}]*)\}"')
    $lv = @([regex]::Matches($lm.Groups[1].Value, "'([^']*)'") | ForEach-Object { $_.Groups[1].Value })
    if ($lv.Count -eq 2 -and $lv -contains 'en' -and $lv -contains 'pt') { Pass "V23 language combo values = {$($lv -join ', ')}" }
    else { Fail "V23 language combo values are {$($lv -join ', ')}, expected {en, pt}" }
}

# ---- V24: picker values stay canonical English -------------------------------
# Same two-codepoint excuse V9 carries, and for the same names (SPEC V195, B42): a
# canonical value out of the core keeps the book's typographic apostrophe, and the one
# out of M20 Sorcerer keeps its eth (SPEC I66).
$notEn = @()
$v24Seen = 0
foreach ($f in $files) {
    $xml = Doc $f.FullName
    foreach ($cb in $xml.SelectNodes("//comboBox[@name]")) {
        if ($cb.GetAttribute("name") -notlike 'cbo*') { continue }
        foreach ($v in (ListOf $cb (TplOf $cb))) {
            $v24Seen++
            if ($v -ne '' -and $v -match '[^\x00-\x7F\u2019\u00F0]') { $notEn += "$($f.Name): stored value '$v' is not English" }
        }
    }
}
if ($notEn) { foreach ($n in $notEn) { Fail "V24 $n" } }
elseif ($v24Seen -eq 0) { Fail "V24 no picker value was read - the check verifies nothing (SPEC V20, B7, V209c)" }
else { Pass "V24 all $v24Seen picker values are canonical English" }

# ---- V195: a straight apostrophe inside a list would split the item in two -------
# The other half of the exception above, and the half that makes it compulsory rather
# than convenient. A list attribute is written {'a', 'b'}, so an ASCII ' INSIDE an entry
# is the delimiter: Firecast's parser and the regex two blocks up would both read
# "Devil's Touch" as "Devil" followed by rubbish, silently and identically. That is why
# the forty-two names keep U+2019 instead of being flattened to a straight quote.
#
# Measured on the STRUCTURE of the whole attribute, not by hunting for the character
# (SPEC V20): a well-formed list is quoted entries separated by commas and nothing else,
# so any stray quote breaks the shape no matter where it lands. Every comboBox, not only
# the cbo* pickers - a split entry is just as wrong in a state combo.
$listShape = '^\{\s*''[^'']*''(\s*,\s*''[^'']*'')*\s*\}$'
$listBad  = @()
$listSeen = 0
foreach ($f in $files) {
    foreach ($cb in (Doc $f.FullName).SelectNodes("//comboBox")) {
        foreach ($a in @('items','values')) {
            if (-not $cb.HasAttribute($a)) { continue }
            $listSeen++
            $raw = $cb.GetAttribute($a)
            $id = $cb.GetAttribute("name"); if (-not $id) { $id = $cb.GetAttribute("field") }; if (-not $id) { $id = 'comboBox' }
            if ($raw -notmatch $listShape) { $listBad += "$($f.Name): $id $a= is not a list of quoted entries - a straight apostrophe inside one splits it (SPEC V195)" }
        }
    }
}
if ($listBad) { foreach ($b in $listBad) { Fail "V195 $b" } }
elseif ($listSeen -eq 0) { Fail "V195 no items=/values= attribute was read - the check verifies nothing (SPEC V20, B7)" }
else { Pass "V195 all $listSeen list attributes are quoted entries and commas, with no straight apostrophe to split them" }

# ---- V194: the era renames the LABEL, never the value (SPEC I22, T469) ---------------
# B23 is the bug this exists to stop happening a second time: the 19th round expressed an era
# as a rename of the row, so the same name changed which field it stood for and ratings walked
# between traits when the sheet changed period. ERA_NAME is the answer - one table of DISPLAY
# strings keyed by the canonical value - and this is what keeps it a display table.
#
# Three things, and the third is the one with teeth: a display must never turn up as a stored
# value. "Creatio Ignis (The Creation of Fire)" is what a Dark Ages sheet SHOWS for Lure of
# Flames; the moment it is also something a picker can save, a character built in one era
# stops opening the same in another (SPEC V2, V24).
$eraTbl = [regex]::Match($root, '(?ms)-- >>> ERA_NAME_BEGIN[^\n]*\n(.*?)-- <<< ERA_NAME_END')
$eraMap = New-Object 'System.Collections.Generic.Dictionary[string,string]' ([StringComparer]::Ordinal)
if ($eraTbl.Success) {
    foreach ($m in [regex]::Matches($eraTbl.Groups[1].Value, '\["([^"]+)"\]\s*=\s*"([^"]*)"')) { $eraMap[$m.Groups[1].Value] = $m.Groups[2].Value }
}

# Every value a picker offers, split two ways: the vampire tab's, which is what ERA_NAME is
# allowed to rename, and the sheet's whole set, which is where a display must never appear.
$vampVals = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
$anyVals  = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
foreach ($f in $files) {
    $isVamp = $f.Name -in @('WoD20.12.lfm', 'WoD20.13.lfm', 'WoD20.14.lfm')
    foreach ($cb in (Doc $f.FullName).SelectNodes("//comboBox")) {
        foreach ($v in (ListOf $cb (TplOf $cb))) {
            if ($v -eq '') { continue }
            [void]$anyVals.Add($v)
            if ($isVamp) { [void]$vampVals.Add($v) }
        }
    }
}

$eraDrift = @()
if (-not $eraTbl.Success) { $eraDrift += "the ERA_NAME region is gone from the root form - nothing below reads anything (SPEC V20, B7)" }
elseif ($eraMap.Count -eq 0) { $eraDrift += "the ERA_NAME region parsed to zero rows - the check verifies nothing (SPEC V20, B7)" }
elseif ($vampVals.Count -eq 0) { $eraDrift += "the vampire pickers offer no value at all - there is nothing for ERA_NAME to key by (SPEC V20)" }
else {
    foreach ($k in $eraMap.Keys) {
        if (-not $vampVals.Contains($k)) { $eraDrift += "'$k' is keyed in ERA_NAME but no vampire picker offers it - a display rule for a row nobody can choose" }
    }
    foreach ($d in @($eraMap.Values | Sort-Object -Unique)) {
        if (-not $ptK.Contains($d))          { $eraDrift += "display '$d' has no [pt] key - the era name skips the translation every other label goes through (SPEC V17)" }
        if (-not $enK.Contains($d))          { $eraDrift += "display '$d' has no [en] key (SPEC V17)" }
        if (-not $embedded.ContainsKey($d))  { $eraDrift += "display '$d' is absent from the PT map - it would never translate at runtime (SPEC V28, B14)" }
        if ($anyVals.Contains($d))           { $eraDrift += "display '$d' is ALSO a stored value - a sheet saved in one era would not open the same in another (SPEC V2, V24, B23)" }
    }
}
if ($eraDrift) { foreach ($e in $eraDrift) { Fail "V194 $e" } }
else { Pass "V194 all $($eraMap.Count) era names rename a value the pickers offer, carry both keys, and none of them is a value" }

# The renamer itself: one reader, and the two switches that already walk the sheet call it.
# A dataLink of its own on sheetTheme would be a second era trigger, which is the drift T469
# was written to make impossible.
$eraFn = [regex]::Match($root, '(?ms)function eraName\(v, era\)(.*?)\n\t\t\tend;')
if (-not $eraFn.Success) { Fail "V194 eraName is not declared on the root form - ERA_NAME has no reader" }
elseif ($eraFn.Groups[1].Value -notmatch 'ERA_NAME\[v\]') { Fail "V194 eraName does not read ERA_NAME - the table is dead again" }
elseif ($eraFn.Groups[1].Value -notmatch '"Dark Ages"' -or $eraFn.Groups[1].Value -notmatch '"Classical Age"') { Fail "V194 eraName does not gate on both medieval eras - one table serves the two (SPEC C, I22)" }
elseif ($hh6 -notmatch 'c\.items = shown;') { Fail "V194 nothing writes a picker's items in WoD20.6 - the era and the language would both stop reaching the rows" }
elseif ($hh6 -notmatch 'pickerItems\(c, lang, currentTheme\(\), levels\);') { Fail "V194 applyLanguage no longer rebuilds the items through pickerItems" }
elseif ($hh6 -notmatch 'pickerItems\(c, \(sheet ~= nil and sheet\.language\) or "en", v, levels\);') { Fail "V194 applyTheme no longer rebuilds the items - changing era would leave the old era's words on the rows (SPEC T469)" }
elseif ($hh6 -match 'dataLink[^>]*field="sheetTheme"[^>]*pickerItems') { Fail "V194 a second era trigger was added - the era must ride applyTheme's own walk (SPEC T469)" }
else { Pass "V194 one reader of ERA_NAME, called from both switches, with no era trigger of its own" }

# ---- V196: a picker must be wide enough for what it offers (SPEC B43) ---------------
# V16 has measured //label since the first round and never once looked at a comboBox, so
# every picker on the sheet went 58 rounds unmeasured. That was survivable while the lists
# were short words; T460 put 384 book names in them and three of the four could not hold
# their own contents. A comboBox CLIPS - it does not wrap - so the text simply disappears,
# exactly the way a checkBox did in B17.
#
# Two axes, because the list has two (SPEC V24): the language, which NeededPx already folds
# in, and the ERA. A value can DISPLAY as something much longer than itself: WoD20.13's widest
# entry is "Potestas Tempestatum (Poder sobre as Tempestades)", the Dark Ages name for
# "Weather Control" - fifteen characters that render as forty-nine. Sizing off the canonical
# values alone would have passed a picker that clips in two of the four eras.
#
# The list is read WHERE IT LIVES - ListOf, which resolves PICKER_LIST for the migrated
# pickers and falls back to the inline attribute for the ones T493 left alone (SPEC I27,
# V209 leg f). Until the 87th round this check read //comboBox[@items][@width] instead, and
# T493 had removed items= from precisely the five vampire rows: 5 of the sheet's 17 combos
# were measured and NONE of the five carrying the longest strings it owns - 284 rituals and
# 64 paths (SPEC B56). ListOf was written for this in the 68th round and had zero callers.
#
# Same ruler as V16 - one $PX_PER_CHAR for labels and pickers alike - plus room for the
# dropdown arrow, measured off cboNature: 25 characters living comfortably in 215px.
$ARROW = 24
$comboNarrow = @()
$comboSeen = 0
$comboVamp = 0
foreach ($f in $files) {
    foreach ($cb in (Doc $f.FullName).SelectNodes("//comboBox[@width]")) {
        $w = 0; if (-not [int]::TryParse($cb.GetAttribute("width"), [ref]$w)) { continue }
        $shown = @(ListOf $cb (TplOf $cb) | Where-Object { $_ -ne '' })
        # The era axis is scoped by SENSE, not by the cbo* prefix (SPEC V197, B44): only the
        # Vampire rows are renamed, so only they may be sized for a Dark Ages name. Measuring
        # WoD20.7 against "Potestas Tempestatum" would demand width for a string it never shows.
        $fieldTpl = $cb.GetAttribute("field")
        $isVampRow = $fieldTpl -match '^\$\((field)\)$' -and $f.Name -in @('WoD20.12.lfm', 'WoD20.13.lfm', 'WoD20.14.lfm')
        if ($isVampRow) {
            $canon = @($shown)
            foreach ($v in $canon) { if ($eraMap.ContainsKey($v)) { $shown += $eraMap[$v] } }
        }
        if ($shown.Count -eq 0) { continue }
        $comboSeen++
        if ($isVampRow) { $comboVamp++ }
        $worst = ''; $need = 0
        foreach ($it in $shown) { $n = NeededPx $it; if ($n -gt $need) { $need = $n; $worst = $it } }
        $need += $ARROW
        $id = $cb.GetAttribute("name"); if (-not $id) { $id = $cb.GetAttribute("field") }; if (-not $id) { $id = 'comboBox' }
        if ($need -gt $w) { $comboNarrow += "$($f.Name): picker $id is ${w}px but '$worst' (pt '$($ptVal[$worst])') needs ~${need}px - a comboBox clips, it does not wrap" }
    }
}
# Two zero-guards, and neither is a control count: the old one asked whether ANY combo had
# been measured, and WoD20.6 keeps three inline lists alive, so it stayed green through the
# whole of B56. The first guard measures COVERAGE against the sheet's own census, the second
# names the rows that carry the worst case - a list that resolves to nothing there is exactly
# the failure this check exists to catch (SPEC V209).
if ($comboNarrow) { foreach ($c in $comboNarrow) { Fail "V196 $c" } }
elseif ($comboSeen -lt 17) { Fail "V196 only $comboSeen of the sheet's 17 pickers resolved to a list - this check is covering less than the sheet has (SPEC V209, B56)" }
elseif ($comboVamp -lt 4) { Fail "V196 only $comboVamp of the 4 vampire row pickers were measured - they carry the longest strings the sheet owns (SPEC V209, B56)" }
else { Pass "V196 all $comboSeen pickers fit their longest item ($comboVamp vampire rows read from PICKER_LIST), in both languages and every era" }

# ---- V197: the era rename is scoped by SENSE, not by the cbo* prefix (SPEC B44) -------
# ERA_NAME is keyed by the canonical value and a value does not carry its sense. "Weather
# Control" is a Thaumaturgy path on the Vampire tab and a hedge magic path on WoD20.7; renaming
# every picker showed the hedge wizard a Latin blood-sorcery name. V194 proves the KEY sits
# in a vampire picker; this proves the EFFECT does not leave one. Third time this same rule
# has been asked for - B15 for hedge magic, T472 for path, B44 for this.
$scopeFn = [regex]::Match($hh6, '(?ms)local function pickerItems\(c, lang, era, levels\)(.*?)\n\t\t\tend;')
$vampTbl = [regex]::Match($hh6, '(?ms)local VAMP_ROW = \{(.*?)\}')
if (-not $scopeFn.Success) { Fail "V197 pickerItems is gone from WoD20.6 - nothing builds a picker's items" }
elseif (-not $vampTbl.Success) { Fail "V197 VAMP_ROW is not declared - the era has no scope and renames the whole sheet (SPEC B44)" }
else {
    $wantRoots = @('clanDisc', 'disc', 'mainPath', 'secPath', 'ritual')
    $gotRoots = @([regex]::Matches($vampTbl.Groups[1].Value, '(\w+)\s*=\s*true') | ForEach-Object { $_.Groups[1].Value })
    $body = $scopeFn.Groups[1].Value
    $missing = @($wantRoots | Where-Object { $gotRoots -notcontains $_ })
    $extra = @($gotRoots | Where-Object { $wantRoots -notcontains $_ })
    if ($missing) { Fail "V197 VAMP_ROW is missing $($missing -join ', ') - those rows would stop being renamed by the era (SPEC I16)" }
    elseif ($extra) { Fail "V197 VAMP_ROW carries $($extra -join ', ') on top of the five vampire rows - the era would reach a picker that is not one" }
    elseif ($body -notmatch 'local vamp\s+= isVampireRow\(nm\);') { Fail "V197 pickerItems does not ask whether the row is a vampire one" }
    elseif ($body -notmatch 'if vamp then v = eraName\(v, era\); end;') { Fail "V197 the era rename is not gated on that answer - every cbo* would be renamed again (SPEC B44)" }
    elseif ($body -notmatch 'if lang == "pt" then v = PT\[v\] or v; end;') { Fail "V197 the language axis is gone - a translation is sheet-wide and must not be scoped with the era" }
    else { Pass "V197 the era renames the five vampire rows only; the language axis stays sheet-wide" }
}

# The gate must scope it the same way, or it sizes a picker for a name it never shows. Proved
# by a value that IS an ERA_NAME key and IS offered outside the Vampire tab.
$leak = @()
foreach ($k in $eraMap.Keys) {
    foreach ($f in $files) {
        if ($f.Name -in @('WoD20.12.lfm', 'WoD20.13.lfm', 'WoD20.14.lfm')) { continue }
        foreach ($cb in (Doc $f.FullName).SelectNodes("//comboBox[@values]")) {
            foreach ($m in [regex]::Matches($cb.GetAttribute("values"), "'([^']*)'")) {
                if ($m.Groups[1].Value -eq $k) { $leak += "$($f.Name)/$($cb.GetAttribute('name')) offers '$k'" }
            }
        }
    }
}
if ($leak.Count -eq 0) { Pass "V197 no ERA_NAME key is shared with a non-vampire picker today - the scope is untested but armed" }
else { Pass "V197 $($leak.Count) shared name(s) - $($leak -join '; ') - kept unrenamed off the Vampire tab by the scope above" }

# ---- V29 - V33: the Powers tab description block ------------------------------
# The block shows book text: read-only, no field, fed from the DESC table by the renderer.
$hh7Path = Join-Path $dir "WoD20.7.lfm"
if (-not (Test-Path $hh7Path)) { Fail "V29 WoD20.7.lfm missing - the Powers tab is gone" }
else {
    $hh7 = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($hh7Path))
    $hh7x = Doc $hh7Path

    # V29: read-only, and no `field=` - a field here would write book text into the character.
    # Scoped to edtNuminaDesc until the 55th round, when the Vampire tab added three more
    # description blocks and the check would have gone on passing while none of them was
    # read. V29 was never about one widget: it is the rule for the DESCRIPTION block, so the
    # blocks are found by their owning box - every one of them, in every file.
    $descBlocks = @()
    foreach ($f in $files) {
        foreach ($lay in (Doc $f.FullName).SelectNodes("//layout[label/@text='DESCRIPTION']")) {
            foreach ($te in $lay.SelectNodes("textEditor")) { $descBlocks += @{ File = $f.Name; Node = $te } }
        }
    }
    if ($descBlocks.Count -eq 0) { Fail "V29 no DESCRIPTION block found in any file - the check reads nothing (SPEC V20)" }
    else {
        $descBad = @()
        foreach ($d in $descBlocks) {
            $nm = $d.Node.GetAttribute("name")
            if ($d.Node.GetAttribute("readOnly") -ne 'true') { $descBad += "$($d.File)/$nm is not readOnly - the reader could type over the book text" }
            if ($d.Node.HasAttribute("field")) { $descBad += "$($d.File)/$nm owns field '$($d.Node.GetAttribute('field'))' - book text would be saved onto the character (SPEC R12)" }
        }
        if ($descBad) { foreach ($d in $descBad) { Fail "V29 $d" } }
        else { Pass "V29 all $($descBlocks.Count) description blocks are readOnly and own no field" }
    }

    # V30: TWO groups since the 90th round (SPEC I58) - numinaSel drives the Hedge Magic block
    # and psychicSel the Psychic Phenomena one. It was one group for both boxes while they shared
    # a single DESCRIPTION; with a block per pane, one group would make the psychic block paint a
    # hedge numina's text and back, which is a wrong answer nobody would read as a bug.
    #
    # So what is measured is the PAIRING, not the count: every radio answers to one of the two
    # pane fields, its groupName agrees with its field, and its row belongs to that pane. The
    # True Faith row has no radio at all - one Path, nothing to select (SPEC I61).
    $numinaRadios = @($radios | Where-Object { $_.File -eq 'WoD20.7.lfm' })
    if ($numinaRadios.Count -eq 0) { Fail "V30 no radios on the Numina tab - nothing selects a numina" }
    else {
        $selGroups = @{ 'numinaSel' = '^numina_\d+$'; 'psychicSel' = '^psychic_\d+$'; 'hedgeRitualSel' = '^hedgeRitual_\d+$' }
        $rf = @($numinaRadios | ForEach-Object { $_.Field } | Sort-Object -Unique)
        $stray = @($rf | Where-Object { -not $selGroups.ContainsKey($_) })
        if ($stray) { Fail "V30 numina radios answer to {$($stray -join ', ')} - the panes bind numinaSel, psychicSel and hedgeRitualSel and nothing else" }
        elseif ($rf.Count -ne 3) { Fail "V30 the Numina tab binds $($rf.Count) radio field(s) ($($rf -join ', ')), expected one per row-driven pane" }
        else { Pass "V30 the $($numinaRadios.Count) radios split across exactly the three pane fields" }

        $pairBad = @()
        foreach ($r in $numinaRadios) {
            if (-not $selGroups.ContainsKey($r.Field)) { continue }
            if ($r.Group -ne $r.Field) { $pairBad += "the radio for '$($r.Value)' sits in groupName '$($r.Group)' but binds field '$($r.Field)' - the two name one group" }
            elseif ($r.Value -notmatch $selGroups[$r.Field]) { $pairBad += "'$($r.Value)' answers to '$($r.Field)' - that row belongs to the other pane, whose block would never show it" }
        }
        if ($pairBad) { foreach ($p in $pairBad) { Fail "V30 $p" } }
        else { Pass "V30 every radio's groupName matches its field and every row answers to its own pane" }

        $dupVals = @($numinaRadios | Group-Object Value | Where-Object Count -gt 1)
        if ($dupVals) { foreach ($d in $dupVals) { Fail "V30 fieldValue '$($d.Name)' used by $($d.Count) radios - two rows would answer as one" } }
        else { Pass "V30 all $($numinaRadios.Count) fieldValues distinct" }

        foreach ($r in $numinaRadios) {
            if (-not $allFields.ContainsKey($r.Value)) { Fail "V30 radio points at '$($r.Value)' but no row owns that field" }
        }
        $rowFields = @($allFields.Keys | Where-Object { $_ -match '^(numina|psychic|hedgeRitual)_\d+$' })
        $covered = @($numinaRadios | ForEach-Object { $_.Value })
        $noRadio = @($rowFields | Where-Object { $covered -notcontains $_ })
        if ($noRadio) { foreach ($n in $noRadio) { Fail "V30 row '$n' has no radio - it can never be described" } }
        else { Pass "V30 every one of the $($rowFields.Count) numina rows has a radio" }
    }

    # V31: language switch re-renders from DESC; the traversal must not touch the block
    if ($hh7 -match "fields\s*=\s*`"\{[^`"]*'language'") { Pass "V31 the dataLink observes 'language' - the block follows the language switch" }
    else { Fail "V31 dataLink does not observe 'language' - the description would stay in the old language" }
    if ($hh6 -match "cls\s*==\s*`"textEditor`"") { Fail "V31 WoD20.6 translates textEditor in place - it would overwrite the rendered description" }
    else { Pass "V31 WoD20.6 traversal leaves textEditor alone" }

    # V32: every picker item must have a description in both languages.
    # Read the region between the generator markers, not `local DESC = {...};`: the entries are
    # generated one per line and close with `]==] },`, so a regex expecting a newline before the
    # brace matches nothing and reports 43 phantom failures (this check was wrong once already).
    # T478 moved the table out of the .lfm and into descNumina.lua (SPEC I24 / V189), and T495
    # then split that in two, one module per language (SPEC V210). The markers migrated
    # verbatim both times, so the region still has the shape this parser was written for - what
    # moved is that the two languages of an entry sit in two FILES, and the pairing this check
    # is about is made by key across them.
    $numEn = DescEntries (Join-Path $plugin "descNumina_en.lua") 'DESC' 'en'
    $numPt = DescEntries (Join-Path $plugin "descNumina_pt.lua") 'DESC' 'pt'
    # V189: one DESC per area, in a module - the .lfm keeps the renderer only. A table left
    # behind in the .lfm would be a second copy of the same text, free to drift (SPEC I24).
    # Measured across ALL the .lfm files, not just WoD20.7, so T479-T481 are covered too.
    $dupTables = @($files | Where-Object {
        ([System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($_.FullName))) -match '(?m)^\s*local\s+DESC\s*=\s*\{'
    })
    if ($dupTables) { foreach ($d in $dupTables) { Fail "V189 $($d.Name) still declares its own DESC table - the text would live in two files at once (SPEC I24)" } }
    else { Pass "V189 all $($files.Count) .lfm files carry the renderer only; the book text lives in the desc*.lua modules" }
    if ($null -eq $numEn -or $null -eq $numPt) {
        Fail "V32 descNumina_en.lua or descNumina_pt.lua is missing from the plugin root, or its DESC markers are gone - the Powers tab has no text to render (SPEC I24, V210, V209)"
    }
    else {
        $descKeys = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
        $thin = @()
        # The two languages of an entry are joined by KEY across the halves. A key on one side
        # and not the other is the very empty block V32 forbids - it just opens in one language
        # instead of in both, which is harder to notice rather than easier.
        $ptBody = DescMap $numPt
        foreach ($e in $numEn) {
            [void]$descKeys.Add($e.Key)
            if ($e.Body.Trim().Length -lt 200) { $thin += "'$($e.Key)' has no usable en text" }
            if (-not $ptBody.ContainsKey($e.Key)) { $thin += "'$($e.Key)' is in the [en] half and nowhere in the [pt] one" }
            elseif ($ptBody[$e.Key].Trim().Length -lt 200) { $thin += "'$($e.Key)' has no usable pt text" }
        }
        if ($descKeys.Count -eq 0) { Fail "V32 the DESC region parsed to zero entries - the parser or the generated shape drifted" }
        foreach ($t in $thin) { Fail "V32 $t" }

        # Which pickers this check is about: the ones a RADIO can point at, whose chosen item
        # becomes the DESC key the block looks up. That is the two numina lists and nothing else.
        #
        # It used to be 'every cbo* on the tab except cboFaith' - an exclusion by NAME, which
        # held only while those were the only pickers there. The Hedge Magic box put an ATTRIBUTE
        # picker on the tab in the 90th round (SPEC I60) and the check demanded a book entry for
        # 'Strength'. Naming what is IN scope closes the other door too: a numina list added
        # under a new name cannot slip out of the check by simply not being excluded (SPEC V20).
        $numinaLists = @('numina', 'psychic')
        $numinaItems = @()
        foreach ($cb in $hh7x.SelectNodes("//comboBox[@name]")) {
            if ($cb.GetAttribute("name") -notlike 'cbo*') { continue }
            if ($numinaLists -notcontains (PickerKeyOf $cb.GetAttribute("name") $cb.GetAttribute("field") (TplOf $cb))) { continue }
            foreach ($it in (ListOf $cb (TplOf $cb))) {
                if ($it -ne '' -and $numinaItems -notcontains $it) { $numinaItems += $it }
            }
        }
        $missing = @($numinaItems | Where-Object { -not $descKeys.Contains($_) })
        if ($missing) { foreach ($m in $missing) { Fail "V32 picker offers '$m' but DESC has no entry - its radio would open an empty block" } }
        elseif ($numinaItems.Count -eq 0) { Fail "V32 no numina picker items found to check" }
        else { Pass "V32 all $($numinaItems.Count) picker items have en+pt descriptions ($($descKeys.Count) DESC entries)" }
        # 'True Faith' is reached by the fixed key the faith row uses, not by a picker item
        # (SPEC V50), so it is not dead text.
        $orphans = @($descKeys | Where-Object { $numinaItems -notcontains $_ -and $_ -ne 'True Faith' })
        if ($orphans) { foreach ($o in $orphans) { Fail "V32 DESC entry '$o' matches no picker item - dead text or a spelling drift" } }

        # ---- V50: every religion opens the True Faith text ----------------------------
        # V50 measured a MECHANISM the 90th round removed: it asked that the faith ROW be
        # special-cased in the renderer so that any of the four religions resolved to the one
        # True Faith entry. True Faith now has a pane of its own with a single row and no radio,
        # so there is no selection to special-case and the block reads the fixed key directly
        # (SPEC I58, I61). Keeping the old legs would fail correct code (SPEC B7); V265 replaces
        # them in T594 by measuring the opposite - that no picker drives that block at all.
        #
        # The one leg that outlives the mechanism stays here, because it is about the BOOK and
        # not about the widget: the entry the block is hard-wired to has to exist.
        if (-not $descKeys.Contains('True Faith')) { Fail "V50 DESC has no 'True Faith' entry - the True Faith block would open empty (SPEC I61)" }
        else { Pass "V50 the True Faith block has its fixed entry in DESC" }
    }

    # ---- V78: one list per box, split by book chapter (SPEC T236) -----------------
    # Both pickers declare their combo as name="cbo$(field)", so a collector keyed on the
    # combo NAME cannot tell the two boxes apart and every list check on them would read the
    # same bucket (SPEC V20). Read each template BY NAME instead.
    # Twenty-seven since the 94th round: the three books were swept whole and six paths the
    # sheet did not carry came back with a page each - Chronomancy, Dowsing and Spirit-Chasing
    # from the Sorcerer's Companion, Curses and the two Theurgy Vias from HH2 (SPEC I69, R107,
    # R108). The roster is spelled out rather than counted because 'Shadows' (ch.1) and 'Shadow'
    # (ch.2) are one letter apart and a count would pass with the pair swapped.
    $hedgeCanon = @('Alchemy','Chronomancy','Conjuration','Conveyance','Curses','Divination','Dowsing','Ephemera','Enchantment','Fascination','Fortune','Healing','Hellfire','Illusion','Maelstroms','Necromancy','Necronics','Oneiromancy','Quintessence Manipulation','Shadows','Shapeshifting','Spirit-Chasing','Starlight','Summoning, Binding, and Warding','Via Geniorum','Via Necromantiae','Weather Control')
    $psychicCanon = @('Animal Psychics','Anti-Psychic','Astral Projection','Biocontrol','Channeling','Clairvoyance','Cyberkinesis','Cyberpathy','Ectoplasmic Generation','Mind Shields','Precognition','Psychic Healing','Psychic Hypnosis','Psychic Invisibility','Psychic Vampirism','Psychokinesis','Psychometry','Psychoportation','Pyrokinesis','Shadow','Synergy','Telepathy')
    $boxItems = @{}
    foreach ($box in @(@('HedgePicker', $hedgeCanon), @('PsychicPicker', $psychicCanon))) {
        $tpl = $box[0]
        $canon = $box[1]
        # The two boxes are told apart by the FIELD ROOT their rows bind - HedgePicker draws
        # numina_*, PsychicPicker draws psychic_* - because after SPEC I27 the template no
        # longer carries the list that used to distinguish them (SPEC V78, 68th round).
        $cb = $hh7x.SelectSingleNode("//template[@name='$tpl']//comboBox")
        if ($null -eq $cb) { Fail "V78 template '$tpl' carries no picker - its list is unchecked (SPEC V20)"; continue }
        $got = @((ListOf $cb $tpl) | Where-Object { $_ -ne '' })
        $boxItems[$tpl] = $got
        # 'Shadows' (ch.1) and 'Shadow' (ch.2) are different numina one letter apart, so match
        # the names themselves - counting them would pass with the pair swapped.
        $extra = @($got | Where-Object { $canon -notcontains $_ })
        $absent = @($canon | Where-Object { $got -notcontains $_ })
        foreach ($e in $extra) { Fail "V78 $tpl offers '$e' - it belongs to the other box (SPEC R.14)" }
        foreach ($a in $absent) { Fail "V78 $tpl is missing '$a' (SPEC R.14)" }
        if ($extra.Count -eq 0 -and $absent.Count -eq 0) { Pass "V78 $tpl offers exactly its $($canon.Count) book entries" }
        # values carry the saved data (SPEC V24): if they drift from items the sheet would
        # store a name the box no longer offers.
        $vals = @((ListOf $cb $tpl) | Where-Object { $_ -ne '' })
        if (($got -join '|') -ne ($vals -join '|')) { Fail "V78 $tpl items and values disagree - the picker would save a different name than it shows" }
    }
    if ($boxItems.Count -eq 2) {
        $shared = @($boxItems['HedgePicker'] | Where-Object { $boxItems['PsychicPicker'] -contains $_ })
        if ($shared) { Fail "V78 offered by BOTH boxes: $($shared -join ', ')" }
        else { Pass "V78 no numina is offered by both boxes" }
        $total = $boxItems['HedgePicker'].Count + $boxItems['PsychicPicker'].Count
        if ($total -eq 49) { Pass "V78 the two boxes still cover all 49 numina" }
        else { Fail "V78 the two boxes cover $total numina, expected 49 - a name was dropped in the split (SPEC V32, I69)" }
    }

    # V33: no silent blank - each unresolved path must produce its own visible text
    foreach ($state in @('NO_SELECTION','EMPTY_ROW','NO_ENTRY')) {
        $sm = [regex]::Match($hh7, "local $state = \{(.*?)\};", 'Singleline')
        if (-not $sm.Success) { Fail "V33 $state message missing - that path would leave the block blank" }
        elseif ($sm.Groups[1].Value -notmatch 'en\s*=' -or $sm.Groups[1].Value -notmatch 'pt\s*=') { Fail "V33 $state lacks an en or pt message" }
        elseif ($hh7 -notmatch "pick\($state,") { Fail "V33 $state is declared but never used" }
        else { Pass "V33 $state is declared in both languages and used" }
    }
    # V33 asks that the renderer be CALLED, not where from - so this stayed green through T488.
    # Only the wording moved: it used to say onNodeReady, and after I26 that trigger is onShow.
    # A green check whose message names a wiring that no longer exists is B6 in miniature - the
    # next reader trusts the sentence, not the regex.
    if ($hh7 -match 'renderNuminaDesc\(self\)') { Pass "V33 renderer is wired (dataLink + onShow)" }
    else { Fail "V33 renderNuminaDesc is never called" }
}

# ---- V34: one PT wording for the hedge-magic family ---------------------------
# B.15: the Powers tab shipped four renderings of one term ("magia menor", "mago menor",
# "magos menores", "bruxo menor") and never the canonical one. Locked glossary (SPEC C):
#   hedge magic -> magia estatica | hedge magician & hedge wizard -> mago estatico
#   sorcerer -> feiticeiro
# The regex hunts the BANNED wording, so this file stays ASCII (see the header note) -
# it never has to spell the accented replacement.
$banned = [regex]'(?i)(?:mag(?:o|a|os|as|ia|ias)|brux(?:o|a|os|as))\s+menor(?:es)?'
$bannedHits = 0
# The description modules are scanned too: T478 moved 380 KB of [pt] prose out of WoD20.7.lfm
# and into descNumina.lua, and a glossary check that only reads .lfm would have gone quiet on
# the very text it was written for (SPEC V34, amended in the 64th round).
foreach ($p in (@($files | ForEach-Object { $_.FullName }) + @($descModules | ForEach-Object { $_.FullName }) + @($langFile))) {
    $txt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($p))
    foreach ($m in $banned.Matches($txt)) {
        $ln = ($txt.Substring(0, $m.Index) -split "`n").Count
        Fail "V34 $(Split-Path $p -Leaf):$ln '$($m.Value)' - hedge magic is 'magia estatica', hedge magician/wizard is 'mago estatico' (SPEC B.15)"
        $bannedHits++
    }
}
if ($bannedHits -eq 0) { Pass "V34 no banned hedge-magic wording in the .lfm files, the $($descModules.Count) description module(s) or the .lang" }

# ---- V52..V58: the sheet theme (SPEC 14th round) --------------------------------
# The Theme combo stopped being dead state in the 14th round: its three values are the keys
# a palette table is looked up by, and picking one repaints the whole sheet at runtime.
# Everything below reads the real artifacts - the XML attributes and the Lua source - rather
# than any intermediate the code could be refactored away from (SPEC V20 / B.7).

# The palette table itself, and the names it declares. Everything downstream counts from this
# rather than from a number written into the gate, so a fifth period added later cannot slip
# past a check that still expects four (SPEC V20 / B.7).
$themesMatch = [regex]::Match($hh6, 'local THEMES = \{(.*?)\n\t\t\t\};', 'Singleline')
if (-not $themesMatch.Success) { Fail "V52/V53/V63 THEMES block not found - every palette check is a no-op" }
$themesBlock = $themesMatch.Groups[1].Value
$themeKeys = @([regex]::Matches($themesBlock, '(?m)^\t{4}\["([^"]+)"\] = \{') | ForEach-Object { $_.Groups[1].Value })
if ($themeKeys.Count -eq 0) { Fail "V52/V53/V63 no palette found inside THEMES" }
else { Pass "V52 THEMES declares $($themeKeys.Count) palettes: $($themeKeys -join ', ')" }

$themeFn = [regex]::Match($hh6, 'local function applyTheme\(v, from\)(.*?)\n\t\t\tend;', 'Singleline')
if (-not $themeFn.Success) { Fail "V52..V58 applyTheme not found in WoD20.6.lfm - every theme check below is a no-op" }
else {
    $body = $themeFn.Groups[1].Value

    # V52: the three values, the table that answers them, and the fallback.
    $themeCb = @($listReport | Where-Object { $_.Name -eq 'WoD20.6.lfm/cboSheetTheme' })
    $wantThemes = @('Modern Nights', 'Victorian Era', 'Dark Ages', 'Classical Age')
    if ($themeCb.Count -ne 1) { Fail "V52 cboSheetTheme was never collected - its value list is unchecked" }
    elseif (Compare-Object $themeCb[0].Items $wantThemes) {
        Fail "V52 cboSheetTheme offers {$($themeCb[0].Items -join ', ')}, expected {$($wantThemes -join ', ')}"
    } else { Pass "V52 cboSheetTheme offers the $($wantThemes.Count) declared themes" }

    # The combo saves what it shows, so items and values must not drift apart (SPEC V24).
    $themeNode = (Doc (Join-Path $dir "WoD20.6.lfm")).SelectSingleNode("//comboBox[@name='cboSheetTheme']")
    if ($null -eq $themeNode) { Fail "V52 cboSheetTheme node missing" }
    elseif ($themeNode.GetAttribute("items") -ne $themeNode.GetAttribute("values")) {
        Fail "V52 cboSheetTheme items and values differ - a [pt] sheet would save a translated theme name"
    } else { Pass "V52 cboSheetTheme items and values agree" }

    # Palette names are read out of the THEMES block at its own indent level, not from a list
    # written here: adding a period to the combo and forgetting its palette has to fail, and so
    # does a palette nothing can reach. Both directions are checked below.
    foreach ($w in $wantThemes) {
        if ($themeKeys -contains $w) { Pass "V52 THEMES answers '$w'" }
        else { Fail "V52 '$w' is offered by the combo but has no THEMES entry - picking it would do nothing" }
    }
    $strayThemes = @($themeKeys | Where-Object { $wantThemes -notcontains $_ })
    if ($strayThemes.Count -gt 0) { Fail "V52 THEMES declares $($strayThemes -join ', ') - the combo does not offer it, so it can never be picked" }
    else { Pass "V52 no palette is stranded outside the combo" }

    # V63: a period declares the whole shape or none of it. With four palettes hand-written,
    # a missing `paper` or `corner` is a sheet painted halfway (SPEC I5).
    # Eight keys since the 16th round: `corner` went away entirely (V66) and `strokeSize`
    # became one shared constant (V67), so neither belongs to a period any more.
    $required = @('form','fill','stroke','font','fontFamily','dotOn','dotOff','paper')
    foreach ($k in $themeKeys) {
        $pal = [regex]::Match($themesBlock, "(?ms)^\t{4}\[""$([regex]::Escape($k))""\] = \{(.*?)^\t{4}\},")
        if (-not $pal.Success) { Fail "V63 palette '$k' could not be read - its shape is unchecked"; continue }
        $missing = @($required | Where-Object { $pal.Groups[1].Value -notmatch "(?m)^\t{5}$_\s*=" })
        if ($missing.Count -gt 0) { Fail "V63 palette '$k' is missing $($missing -join ', ')" }
        else { Pass "V63 palette '$k' declares all $($required.Count) keys" }
    }

    # V54: the ledger records the value the XML authored, once, before that property is first
    # painted. Overwriting it on a later repaint would record Victorian and call it authored -
    # and every later period would then map from the wrong original.
    #
    # The other half of V54 was retired in the 16th round: there is no palette-less option left
    # to restore to, so `Modern` naming a real palette is now correct rather than a violation.
    if ($hh6 -notmatch 'local themePainted = \{\}') { Fail "V54 no ledger - the authored values are not recorded" }
    elseif ($hh6 -notmatch 'if rec\[prop\] == nil then rec\[prop\] = original; end;') { Fail "V54 the ledger is overwritten on repaint - it would record Victorian and call it Modern" }
    else { Pass "V54 the authored value is recorded once and never overwritten" }

    # V66: the corner detail belongs to the XML. cornerType="innerLine" over a radius is
    # authored on 53 boxes, so it already holds in every period - three palettes were writing
    # corner = 0 over it and flattening it. Three rectangles carry a radius of their own (the
    # health mark box, the avatar frame), which a single theme-wide radius would deform.
    if ($themesBlock -match '(?m)^\s+corner\s*=') { Fail "V66 a palette declares `corner` again - a theme-wide radius flattens the boxes that set their own" }
    elseif ($body -match '"(xradius|yradius)"') { Fail "V66 applyTheme writes a corner radius - the XML owns that detail (SPEC C, 16th round)" }
    else { Pass "V66 no palette touches the corner radius" }

    # V67: one outline width, declared once. The requirement is that the four MATCH, and four
    # copies that agree today can drift tomorrow - so the equality is structural, like
    # HEALTH_MARKS on the root form (SPEC V41).
    if ($themesBlock -match '(?m)^\s+strokeSize\s*=') { Fail "V67 a palette declares its own strokeSize - the outlines must be one shared width" }
    elseif ($hh6 -notmatch 'local THEME_STROKE = (\d+);') { Fail "V67 THEME_STROKE is not declared" }
    else {
        $null = $hh6 -match 'local THEME_STROKE = (\d+);'
        $strokeVal = $Matches[1]
        if ($body -notmatch 'paint\(c, "strokeSize", THEME_STROKE') { Fail "V67 applyTheme does not paint the shared width" }
        else { Pass "V67 one shared outline width ($strokeVal) for all $($themeKeys.Count) periods" }
    }

    # V61: writing a property is NOT free - every font setter detaches the control from the
    # theme before it writes, so writing back a value just read still changes the sheet. That
    # assumption cost B21: Modern rewrote every text control at load and came back wrong.
    if ($hh6 -match 'local function put\(') { Fail "V61 the old unconditional put() is back - it writes properties the XML never authored (SPEC B21)" }
    elseif ($hh6 -notmatch 'if value == nil then return; end;') { Fail "V61 paint() does not refuse an unmapped target - it would write over an unknown colour" }
    elseif ($hh6 -notmatch 'if original == nil then return; end;') { Fail "V61 paint() does not refuse a property the XML never authored - that write could not be undone (SPEC B21)" }
    else { Pass "V61 paint() writes only a mapped value over an authored one" }

    # Everything the repaint does must go through paint(), or the ledger has holes. The backdrop
    # is the one exception: it exists only for the theme, so its authored state is known.
    $direct = @([regex]::Matches($body, 'c\.(\w+)\s*=[^=]') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
    $allowedDirect = @('src','visible')
    $strayDirect = @($direct | Where-Object { $allowedDirect -notcontains $_ })
    if ($strayDirect.Count -gt 0) { Fail "V61 applyTheme writes $($strayDirect -join ', ') outside paint() - those changes are not in the ledger" }
    else { Pass "V61 every repaint goes through paint(), only the backdrop is written directly" }

    # V62: restoring reads the ledger, and the ORIGINAL value is what a repaint maps from -
    # otherwise Light -> Dark would look its palette up in a colour Light had already written.
    # V62: restore() went with the palette-less baseline in the 16th round, but the ledger did
    # not - it is what makes Victorian -> Classical map from the ORIGINAL colour instead of the
    # one Victorian left behind.
    if ($hh6 -notmatch 'if rec ~= nil and rec\[prop\] ~= nil then return rec\[prop\]; end;') { Fail "V62 authored() does not prefer the ledger - a second period would map from the first period's colours" }
    elseif ($body -notmatch 'authored\(c, "color"\)') { Fail "V62 the repaint maps from the live value, not the authored one" }
    else { Pass "V62 repaints map from the authored value, not the previous period" }

    # And with no palette-less option left, the lookup must never resolve to nil.
    if ($body -notmatch 'THEMES\[v\] or THEMES\[THEME_DEFAULT\]') { Fail "V52 applyTheme can still resolve to nil - a stale saved value would leave the sheet unpainted" }
    else { Pass "V52 an unknown saved value falls back to the default palette" }


    # V55: the rdk generates findClass starting from `self`, so it only ever reaches the tab
    # it runs on - which is why the five base sheets only ever painted their Credits tab
    # (SPEC R21 / B.9). The theme must use the same root walk the translation does.
    # Match the CALL, not the word: the code comments name findClass to explain why it is not
    # used, and a check that cannot tell those apart is a check nobody can keep green.
    if ($hh6 -match 'findClass\s*\(') { Fail "V55 WoD20.6 calls findClass - it stops at this tab (SPEC R21/B.9)" }
    elseif ($body -notmatch 'rootOf\(from\)') { Fail "V55 applyTheme does not walk to the sheet root - eight tabs would stay unpainted" }
    else { Pass "V55 the repaint walks from the sheet root" }

    # V57: no geometry. The overlap checks above measure the static XML; if the theme moved or
    # resized anything, a sheet could collide at runtime with the gate still green.
    $geo = [regex]::Matches($body, '"(left|top|width|height)"|\.(left|top|width|height)\s*=')
    if ($geo.Count -gt 0) { Fail "V57 applyTheme writes geometry ($($geo.Count) hit(s)) - V37/V40/V49 only measure the static XML" }
    else { Pass "V57 applyTheme writes no geometry" }

    # V56: an ornament that is not there must degrade to no ornament, never to a sheet that is
    # half painted or covered by a backdrop it cannot switch off.
    if ($body -notmatch 't\.paper == nil') { Fail "V56 applyTheme does not handle a palette with no backdrop" }
    elseif ($body -notmatch 'c\.visible = false') { Fail "V56 the backdrop is never hidden - Modern would keep the paper" }
    else { Pass "V56 a missing backdrop degrades to no backdrop" }
}

# V53: every colour the XML authors must be a key in EVERY palette. Without this a
# box added later keeps its black fill in the middle of the parchment and nothing complains -
# the same blind spot that let ABILITIES ship translucent (SPEC B18).
$paletteOk = $true
foreach ($section in @(
    @{ Attr = 'color';       Lua = 'fill';   Nodes = "//rectangle[@color]" },
    @{ Attr = 'strokeColor'; Lua = 'stroke'; Nodes = "//*[@strokeColor]" },
    @{ Attr = 'fontColor';   Lua = 'font';   Nodes = "//*[@fontColor]" })) {

    $authored = New-Object System.Collections.Generic.HashSet[string]
    foreach ($f in $files) {
        foreach ($n in (Doc $f.FullName).SelectNodes($section.Nodes)) {
            [void]$authored.Add($n.GetAttribute($section.Attr))
        }
    }

    # Anchored to the start of a line: the normaliser below the table declares
    # `local fill, stroke, font = {}, {}, {}` and an unanchored pattern counted that as a map.
    $blocks = @([regex]::Matches($hh6, "(?m)^\s*$($section.Lua)\s*=\s*\{(.*?)\}", 'Singleline'))
    if ($blocks.Count -ne $themeKeys.Count) {
        Fail "V53 expected one '$($section.Lua)' map per palette ($($themeKeys.Count)), found $($blocks.Count) - the check cannot see them all"
        $paletteOk = $false
        continue
    }

    foreach ($b in $blocks) {
        $keys = @([regex]::Matches($b.Groups[1].Value, '\["([^"]+)"\]') | ForEach-Object { $_.Groups[1].Value })
        foreach ($a in $authored) {
            if ($keys -notcontains $a) {
                Fail "V53 '$a' is authored as $($section.Attr)= but is not a key in one of the '$($section.Lua)' maps - it would keep its Modern colour"
                $paletteOk = $false
            }
        }
    }
}
if ($paletteOk) { Pass "V53 every authored colour is mapped by all $($themeKeys.Count) palettes" }

# V58: V3 walks the XML for src=/checkedImage=, so art a palette points at from Lua never got
# checked. A typo there is a dot that silently stops rendering the moment a theme is picked.
#
# V60: and it must be the PLUGIN-ABSOLUTE path. The rdk rewrites src=/checkedImage= at compile
# time - the generated Lua carries "/WoD20th/images/prime_on.png" - so a relative path
# handed to a setter at runtime resolves to nothing and the art quietly fails to load. This
# check measures the FORM of the path; V58 below measures the file. B20 passed V58 green while
# every dot in both Victorian themes was broken, because only the file was ever checked.
$artPrefix = '/WoD20th/images/'
$themeArt = @([regex]::Matches($hh6, '(?:dotOn|dotOff|paper)\s*=\s*"([^"]+)"') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
if ($themeArt.Count -eq 0) { Fail "V58/V60 no theme art referenced - the palettes point at nothing" }
else {
    foreach ($img in $themeArt) {
        if (-not $img.StartsWith($artPrefix)) {
            Fail "V60 palette path '$img' is not plugin-absolute - the rdk only resolves the relative form at compile time (SPEC B20)"
            continue
        }
        # Strip only the sheet folder: what is left ("images/x.png") is the path on disk.
        $onDisk = Join-Path $dir ($img.Substring('/WoD20th/'.Length))
        if (Test-Path -LiteralPath $onDisk) { Pass "V58/V60 theme art $img" }
        else { Fail "V58 theme art $img is referenced by a palette but missing from images/" }
    }
}

# V65: fixed art follows the palette too. The first dot of an attribute or a virtue cannot be
# switched off, so it is a plain <image> rather than an imageCheckBox - and being neither a
# colour nor a checkbox, it fell through every net and stayed white in all four periods (B22).
# V53 makes this promise for every colour the XML authors; this is the same promise for art.
$fixedArt = @()
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//image[@src]")) {
        if ($n.GetAttribute("name") -like 'themePaper*') { continue }
        $fixedArt += [pscustomobject]@{ File = $f.Name; Leaf = (Split-Path $n.GetAttribute("src") -Leaf) }
    }
}
if ($fixedArt.Count -eq 0) { Fail "V65 no fixed <image src> found - the check has nothing to measure, so it proves nothing" }
else {
    $unmapped = @($fixedArt | Where-Object { @('prime_on.png','prime_off.png') -notcontains $_.Leaf })
    if ($unmapped.Count -gt 0) {
        foreach ($u in $unmapped) { Fail "V65 $($u.File) shows fixed art '$($u.Leaf)' that no palette remaps - it would stay Modern inside every period" }
    } else { Pass "V65 all $($fixedArt.Count) fixed <image src> use art the palettes remap" }
}
if ($hh6 -notmatch 'local DOT_ON\s+= "prime_on\.png";') { Fail "V65 the base dot name is gone - applyTheme cannot recognise the fixed dot" }
elseif ($themeFn.Success -and $themeFn.Groups[1].Value -notmatch 'art == DOT_ON') { Fail "V65 applyTheme no longer remaps the fixed dot (SPEC B22)" }
else { Pass "V65 applyTheme remaps the fixed dot to the palette" }

# V64: and nothing else lives in images/. Art belongs to a theme; when a theme is dropped its
# art has to go with it, or the folder turns into a graveyard that still ships inside the .rpk.
# The 15th round deleted the light Victorian, and its three files with it.
$referencedArt = New-Object System.Collections.Generic.HashSet[string]
foreach ($img in $themeArt) { [void]$referencedArt.Add((Split-Path $img -Leaf)) }
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//*[@src] | //*[@checkedImage] | //*[@uncheckedImage]")) {
        foreach ($a in @('src','checkedImage','uncheckedImage')) {
            if ($n.HasAttribute($a)) { [void]$referencedArt.Add((Split-Path $n.GetAttribute($a) -Leaf)) }
        }
    }
}
$orphanArt = @(Get-ChildItem -LiteralPath (Join-Path $dir "images") -Filter *.png |
                Where-Object { -not $referencedArt.Contains($_.Name) })
if ($orphanArt.Count -gt 0) {
    foreach ($o in $orphanArt) { Fail "V64 images/$($o.Name) is referenced by nothing - art of a dropped theme still shipping in the .rpk" }
} else { Pass "V64 all $($referencedArt.Count) images in images/ are referenced by the XML or a palette" }

# The backdrop is declared per tab, and Settings is left out ON PURPOSE: if the draw order or
# hitTest ever behaved differently than assumed, a full-tab image over the Settings tab would
# cover the very combo used to switch back to Modern.
$paperTabs = @()
foreach ($f in $files) {
    $n = (Doc $f.FullName).SelectSingleNode("//image[starts-with(@name,'themePaper')]")
    if ($null -ne $n) {
        $paperTabs += $f.Name
        if ($n.GetAttribute("hitTest") -ne 'false') { Fail "V56 $($f.Name) backdrop does not set hitTest=false - it would eat clicks" }
        if ($n.GetAttribute("visible") -ne 'false') { Fail "V56 $($f.Name) backdrop is not hidden - Modern would ship with paper" }
        foreach ($g in @('left','top','width','height')) {
            if ($n.HasAttribute($g)) { Fail "V57 $($f.Name) backdrop declares $g - it must be align=client so the box checks stay meaningful" }
        }
    }
}
# Read off the files rather than counted off the root's tabs: the 51st round split ONE tab
# into a shell plus three sub-forms (SPEC I16), so "one backdrop per root <tab>" stopped
# describing the sheet. What actually decides it is whether a form carries CONTENT - every
# content form wraps its widgets in a <scrollBox>, and a shell that only holds a tabControl
# has none. Derived, so a tab added later is picked up without editing a number here.
$wantPaper = @($files | Where-Object {
    $_.Name -ne 'WoD20.6.lfm' -and $null -ne (Doc $_.FullName).SelectSingleNode("//scrollBox")
} | ForEach-Object { $_.Name })
$missPaper = @($wantPaper | Where-Object { $paperTabs -notcontains $_ })
$extraPaper = @($paperTabs | Where-Object { $wantPaper -notcontains $_ })
if ($paperTabs -contains 'WoD20.6.lfm') { Fail "V56 the Settings tab has a backdrop - a covered theme combo cannot be switched back" }
elseif ($missPaper) { Fail "V56 $($missPaper -join ', ') carries content but no backdrop" }
elseif ($extraPaper) { Fail "V56 $($extraPaper -join ', ') carries a backdrop but no content to put it behind" }
else { Pass "V56 all $($wantPaper.Count) content forms carry a hidden, click-through backdrop; Settings and the Vampire shell have none" }

# ---- V190: align=client is exclusive per container -----------------------------------
# SPEC B41. The backdrop is align=client and so is a tabControl; put side by side they claim
# one client rect and whichever loses is simply not drawn - which is how the Vampire tab
# shipped with its sub-tabs opening onto nothing. The sheet had obeyed this for fifty rounds
# without it ever being written down: one align=client per container, everything else placed
# with left/top/width/height.
$alignClash = @()
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//*")) {
        $kids = @($n.ChildNodes | Where-Object { $_.NodeType -eq 'Element' -and $_.GetAttribute('align') -eq 'client' })
        # The tab panes are the one licensed exception (SPEC I32, T521): N align=client siblings
        # with at most one authored visible. B41 does NOT forbid this and never did - there the
        # two siblings were both VISIBLE (the theme paper lit OVER the tabControl), so it was
        # overlap, not sizing. The Firecast probe of T521 answered the case B41 never tested.
        # Scoped, not revoked: every pane must hold an <import> and none may be authored open,
        # so a second visible client sibling anywhere still reddens this.
        $panes = @($kids | Where-Object { $_.SelectSingleNode("import") })
        if ($panes.Count -eq $kids.Count -and $panes.Count -gt 1) {
            $openPanes = @($panes | Where-Object { $_.GetAttribute('visible') -ne 'false' })
            if ($openPanes.Count -eq 0) { continue }
        }
        if ($kids.Count -gt 1) {
            $who = ($kids | ForEach-Object { "$($_.LocalName)/$($_.GetAttribute('name'))" }) -join ' + '
            $alignClash += "$($f.Name) <$($n.LocalName)>: $who"
        }
    }
}
if ($alignClash) { foreach ($a in $alignClash) { Fail "V190 two controls claim one client rect - $a" } }
else { Pass "V190 no container hands align=client to more than one child" }

# ---- V188: the Vampire tab is ONE tabControl with three SIBLING tabs -----------------
# 54th round. It shipped as two nested controls - a `Blood Sorcery` tab holding a second
# tabControl with `Paths` and `Rituals` inside it - and the inner control drew its tabs
# without their labels, so the sub-tabs were two unmarked click targets (SPEC R49). The
# grouping moved into the titles instead, which is why the titles are checked here and not
# just the names: `Blood Sorcery: Paths` is now the ONLY thing telling the player those two
# tabs belong together, so a title edited back to `Paths` silently loses the grouping.
#
# Read off the XML because that is the point of the invariant: the structure is authored,
# never built by Lua, so a sheet whose script did not run still opens with it (SPEC V18, V94).
$vampX   = Doc (Join-Path $dir "WoD20.11.lfm")
# Rewritten for the strip (SPEC I32, T523): the control is gone, the CONTRACT is not. Three
# sibling panes, one per file, and the grouping still lives in the titles - which moved from
# @title into each button's label, so that is where it is read now.
$wantVamp = [ordered]@{
    'tabDisc'    = @('Disciplines',            'WoD20.12.lfm')
    'tabPaths'   = @('Blood Sorcery: Paths',   'WoD20.13.lfm')
    'tabRituals' = @('Blood Sorcery: Rituals', 'WoD20.14.lfm')
}
$vampBad = @()
foreach ($nm in $wantVamp.Keys) {
    $pane = $vampX.SelectSingleNode("//layout[@name='$nm']")
    $lbl  = $vampX.SelectSingleNode("//rectangle[@name='btnTab$($nm.Substring(3))']/label")
    if ($null -eq $pane) { $vampBad += "no pane named $nm"; continue }
    if ($null -eq $pane.SelectSingleNode("import[@file='$($wantVamp[$nm][1])']")) { $vampBad += "$nm does not import $($wantVamp[$nm][1])" }
    if ($null -eq $lbl) { $vampBad += "$nm has no button label - nothing shows its title" }
    elseif ($lbl.GetAttribute("text") -ne $wantVamp[$nm][0]) { $vampBad += "$nm reads '$($lbl.GetAttribute("text"))', expected '$($wantVamp[$nm][0])' - the grouping lives in the title (SPEC R49)" }
}
if ($vampBad) { foreach ($b in $vampBad) { Fail "V188 $b" } }
else { Pass "V188 the Vampire tab is three sibling panes, each titled and each importing its own file" }

# No tabControl inside a tabControl, in any file: that is the shape R49 broke. Checked per
# file because a nested control is authored in one - the root reaching WoD20.11 through an
# <import> is the arrangement that WORKS and is what the two names below account for.
$nestedCtl = @()
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//tabControl//tabControl")) {
        $nestedCtl += "$($f.Name): $($n.GetAttribute('name')) sits inside another tabControl"
    }
}
$allCtl = @()
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//tabControl")) { $allCtl += "$($f.Name)/$($n.GetAttribute('name'))" }
}
# The census flipped from "exactly two" to "none at all" in the 78th round (SPEC I32). Both
# strips are ours now, and a native tabControl coming back is not a style slip - it is a
# control the theme cannot reach, because gui.TabItem has no colour, font or background to
# set and rdk refuses the attributes outright (SPEC B19, B49, V226).
if ($nestedCtl) { foreach ($n in $nestedCtl) { Fail "V188 $n - R49 says the inner one loses its tab labels" } }
elseif ($allCtl.Count -ne 0) { Fail "V188 the sheet carries $($allCtl.Count) native tabControl(s) ($($allCtl -join ', ')) - both strips are ours since I32 and a native one cannot be themed" }
else { Pass "V188 no native tabControl left in the sheet - both strips are ours" }

# ---- V198: the description require is deferred, and the module is data only ----------
# SPEC I24 / V198. The <script> CDATA of a .lfm is copied RAW into constructNew_<form>() -
# you can read it back in output/rdkObjs/WoD20th/*.lfm.lua - so a require at the top of
# the CDATA runs once per sheet OPENED, not once per app. The .lfm shrinks, the .rpk shrinks,
# the parse does not, and the gate stays green while nothing was actually deferred: the same
# shape of silent failure as B.6. So this measures POSITION, not existence.
#
# Position is read off the indentation, which is what the files are actually written with: the
# nearest preceding line with FEWER leading tabs must be a `function` header. Mutation (SPEC
# V20): move the require to the top of the CDATA and this goes red, because the shallower line
# above it is then `<![CDATA[`.
# T495: the require names a HALF and builds it from the language - require("desc<X>_" .. lang
# .. ".lua") - so the anchor is the module STEM, not a whole file name. Left on the old literal
# this check would have matched nothing and passed by omission, which is B7 walking in through
# the door held open by the check written to shut it (SPEC V209, V210b).
$reqRx = [regex]'require\s*\(\s*["'']desc[A-Za-z0-9]*[_.]'
$reqSeen = 0
$reqBad  = @()
foreach ($f in $files) {
    $txt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName)) -replace "`r`n", "`n"
    $lines = $txt -split "`n"
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if (-not $reqRx.IsMatch($lines[$i])) { continue }
        $reqSeen++
        $ind = ($lines[$i] -replace '^(\t*).*$', '$1').Length
        $enclosing = $null
        for ($j = $i - 1; $j -ge 0; $j--) {
            if ($lines[$j].Trim() -eq '') { continue }
            $jind = ($lines[$j] -replace '^(\t*).*$', '$1').Length
            if ($jind -ge $ind) { continue }
            $enclosing = $lines[$j]
            break
        }
        if ($null -eq $enclosing -or $enclosing -notmatch '(?:^|\s)function\b') {
            $reqBad += "$($f.Name):$($i + 1) '$($lines[$i].Trim())' sits outside a function body - it would run on every sheet open (SPEC I24, V198)"
        }
    }
}
if ($reqBad) { foreach ($r in $reqBad) { Fail "V198 $r" } }
elseif ($reqSeen -eq 0) { Fail "V198 no .lfm requires a description module - the check reads nothing (SPEC V20)" }
else { Pass "V198 all $reqSeen description require(s) sit inside a function body, so the parse is paid once and cached" }

# ---- V206: the description require is not REACHABLE from onNodeReady ----------------
# SPEC I26 / V206, the backprop of B47. V198 above measures where the require SITS, and it has
# sat in the right place since T478 with the gate green - while onNodeReady called the renderer
# on EVERY open and dragged all four modules (2,754,357 bytes) in behind it. Position in the
# FILE is not reach in the FLOW. V198 was written citing B6 and fell to B6; this is the other
# half, and the two only work as a pair. Same lesson as B30 and B34: the gate reads source and
# cannot count a call at runtime, so what it cannot count it must forbid outright.
#
# Two legs, because the fix has two and either alone is a half-fix (SPEC I26):
#   (a) no render<Area>Desc call inside an onNodeReady event, in any .lfm;
#   (b) every render<Area>Desc body opens with the isShowing guard - onShow firing for a form
#       inside an INACTIVE tab is not measured yet (SPEC R92b), so the trigger alone is a bet.
# Mutation (SPEC V20), one per leg: put renderDiscDesc(self) back in WoD20.12's onNodeReady -> (a)
# goes red; drop the guard from any of the four renderers -> (b) goes red.
$readyRx    = [regex]'(?s)<event\s+name="onNodeReady"\s*>(.*?)</event>'
$descCallRx = [regex]'\brender\w*Desc\s*\('
$v206Bad    = @()
$v206Seen   = 0
foreach ($f in $files) {
    $txt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName)) -replace "`r`n", "`n"

    foreach ($m in $readyRx.Matches($txt)) {
        foreach ($c in $descCallRx.Matches($m.Groups[1].Value)) {
            $v206Bad += "$($f.Name) reaches $($c.Value)) from onNodeReady - that fires on every open, before the tab is on screen, and pulls the whole book module in with it (SPEC B47)"
        }
    }

    $lines = $txt -split "`n"
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match '^\s*function\s+(render\w*Desc)\s*\(') {
            $name = $Matches[1]
            $v206Seen++
            $ind = ($lines[$i] -replace '^(\t*).*$', '$1').Length
            $guarded = $false
            for ($j = $i + 1; $j -lt $lines.Count; $j++) {
                $jind = ($lines[$j] -replace '^(\t*).*$', '$1').Length
                if (($lines[$j].Trim() -eq 'end;') -and ($jind -le $ind)) { break }
                if ($lines[$j] -match 'form\.isShowing\s*==\s*false') { $guarded = $true }
            }
            if (-not $guarded) {
                $v206Bad += "$($f.Name):$($i + 1) $name paints with no isShowing guard - if onShow fires for a form in an inactive tab the parse comes back (SPEC I26, R92b)"
            }
        }
    }
}
if ($v206Bad) { foreach ($b in $v206Bad) { Fail "V206 $b" } }
elseif ($v206Seen -eq 0) { Fail "V206 no render<Area>Desc found in any .lfm - the check reads nothing (SPEC V20)" }
else { Pass "V206 all $v206Seen description renderer(s) carry the isShowing guard, and none is reached from onNodeReady" }

# ---- V207: renderVampPickers runs at most ONCE per open ------------------------------
# SPEC V207, the backprop of B48. T484 wired the filter into the onNodeReady of BOTH WoD20.13
# and WoD20.14 because each tab asked for its own without looking at its sibling. The filter is
# the SHEET's, not a tab's (SPEC V203): renderVampPickers xpFinds from the ROOT and refilters
# all 45 combos in one pass, so the second call re-walked 1900 controls to write the very same
# lists again. Nothing LOOKED wrong - it was pure work - which is exactly why no check caught
# it, and why this one counts the wiring instead of trying to measure an effect.
#
# dataLink onChange calls are deliberately NOT counted: those fire when a row actually
# changes, which is when the lists genuinely have to be rebuilt (SPEC V181, V200). Only the
# OPEN path is capped.
#
# Zero is red as well (SPEC V20 / B7): with no call on the open path a SAVED sheet would open
# offering rituals the character cannot learn, and a check phrased only as "at most one" would
# call that clean - the same silent no-op B7 is made of. Mutation, one per leg: put
# renderVampPickers(self) back in WoD20.14 onNodeReady -> red on the count; delete WoD20.13 as well
# -> red on the zero-guard.
$vampCallRx = [regex]'\brenderVampPickers\s*\('
$vampCalls  = @()
foreach ($f in $files) {
    $txt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName)) -replace "`r`n", "`n"
    foreach ($m in $readyRx.Matches($txt)) {
        foreach ($c in $vampCallRx.Matches($m.Groups[1].Value)) { $vampCalls += $f.Name }
    }
}
if ($vampCalls.Count -gt 1) {
    Fail "V207 renderVampPickers is called from $($vampCalls.Count) onNodeReady event(s) ($(($vampCalls | Sort-Object -Unique) -join ', ')) - the filter is sheet-wide (SPEC V203), so every pass after the first re-walks 1900 controls to write the same lists again (SPEC B48)"
}
elseif ($vampCalls.Count -eq 0) {
    Fail "V207 no onNodeReady calls renderVampPickers - a saved sheet would open with every path and ritual offered unfiltered, and a check phrased as 'at most one' would pass on it (SPEC V20, B7)"
}
else { Pass "V207 renderVampPickers runs once per open, from $($vampCalls[0])" }

# The module is DATA (SPEC I24): one table, no function, no state, no SDK require. A module
# that pulled in gui/ndb/locale would be a second door for building the block, and V31's
# "one way to render" would stop being true.
$modBad = @()
foreach ($m in $descModules) {
    $txt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($m.FullName)) -replace "`r`n", "`n"
    $code = ($txt -split "`n" | Where-Object { $_ -notmatch '^\s*--' }) -join "`n"
    if ($code -notmatch '(?m)^\s*return\s*\{') { $modBad += "$($m.Name) does not return a table - require would hand the renderer a nil" }
    if ($code -match '(?m)^\s*(local\s+)?function\b') { $modBad += "$($m.Name) declares a function - the module is data, not code (SPEC I24)" }
    if ($code -match 'require\s*\(\s*["''](?:gui|ndb|locale|firecast|rrpg)') { $modBad += "$($m.Name) requires an SDK module - a data table must not reach the host (SPEC I24)" }
}
if ($modBad) { foreach ($m in $modBad) { Fail "V189 $m" } }
elseif ($descModules.Count -eq 0) { Fail "V189 no desc*.lua module found beside module.xml - the text has nowhere to live (SPEC I24)" }
else { Pass "V189 all $($descModules.Count) description module(s) return one table and nothing else" }

# ---- V210: one description module per language, and no require names a constant --------
# SPEC T495 / R92f: half of every desc<X>.lua was the language the session never opens, so
# requiring one module meant parsing two. Two legs:
#   (a) the two halves of an area carry the SAME keys, 1:1 - the split was a move, not a cut,
#       and losing content is the one thing the user ruled out;
#   (b) no .lfm requires a description module under a CONSTANT name - the language enters by
#       concatenation, so no renderer can end up nailed to one half in silence.
# The medieval body follows the same line: daEn belongs in the [en] file and daPt in the [pt]
# one (SPEC T495). There is no daEn/daPt written yet, so that leg is armed and quiet.
#
# Mutation (SPEC V20): delete one key from one half -> red on (a); put a literal
# require("descDisc.lua") back into WoD20.12 -> red on (b). Probe (SPEC V222b): edit the BODY
# of an entry -> green, because the shape of the text belongs to V192 and V273, not here.
$v210Bad = @()
$v210Keys = 0
foreach ($a210 in @(
    @('descDisc', 'DISC_DESC'),
    @('descNumina', 'DESC'),
    @('descPath', 'PATH_DESC'),
    @('descRitual', 'RITUAL_DESC'))) {
    $half210 = @{}
    $gone210 = $false
    foreach ($lang210 in @('en', 'pt')) {
        $half210[$lang210] = DescEntries (Join-Path $plugin "$($a210[0])_$lang210.lua") $a210[1] $lang210
        if ($null -eq $half210[$lang210]) { $v210Bad += "$($a210[0])_$lang210.lua is not at the plugin root, or its $($a210[1]) markers are gone - half the book has nowhere to live (SPEC V209)"; $gone210 = $true }
    }
    if ($gone210) { continue }
    if ($half210['en'].Count -eq 0 -or $half210['pt'].Count -eq 0) {
        $v210Bad += "$($a210[0]) parsed to $($half210['en'].Count) [en] and $($half210['pt'].Count) [pt] entries - a side with nothing in it makes every comparison below true by default (SPEC V209)"
        continue
    }
    $v210Keys += $half210['en'].Count
    $set210 = @{}
    foreach ($lang210 in @('en', 'pt')) {
        $s = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
        foreach ($e210 in $half210[$lang210]) { [void]$s.Add($e210.Key) }
        $set210[$lang210] = $s
    }
    foreach ($k210 in $set210['en']) { if (-not $set210['pt'].Contains($k210)) { $v210Bad += "$($a210[0]) carries '$k210' in [en] and not in [pt] - the split dropped text the user ruled out dropping (SPEC V210a)" } }
    foreach ($k210 in $set210['pt']) { if (-not $set210['en'].Contains($k210)) { $v210Bad += "$($a210[0]) carries '$k210' in [pt] and not in [en] - the split dropped text the user ruled out dropping (SPEC V210a)" } }
    # daEn to the [en] half, daPt to the [pt] one: a medieval body written into the wrong file
    # is text the renderer of that language can never reach (SPEC T495, T470).
    foreach ($lang210 in @('en', 'pt')) {
        $wrong210 = $(if ($lang210 -eq 'en') { 'daPt' } else { 'daEn' })
        foreach ($e210 in $half210[$lang210]) {
            if ($e210.Rest -match "\b$wrong210\s*=") { $v210Bad += "$($a210[0])_$lang210.lua '$($e210.Key)' carries a $wrong210 body - the medieval text of a language belongs in that language's file (SPEC V210, T495)" }
        }
    }
}
# (b) read off the code with the comments stripped: this sheet is thick with prose that NAMES
# the old call, and a check that reddens on a comment is the false positive V222 was written
# for - it was measured twice already, on 'denied' and on maxDiscLevel(.
$v210Req = 0
foreach ($f210 in $files) {
    $code210 = CodeOf $f210.FullName
    foreach ($m210 in [regex]::Matches($code210, 'require\s*\(\s*"desc[^"]*"\s*\)')) {
        $v210Bad += "$($f210.Name) has $($m210.Value) - a constant module name pins that renderer to one language and the other half would never be read (SPEC V210b)"
    }
    $v210Req += ([regex]::Matches($code210, 'require\s*\(\s*"desc[A-Za-z0-9]+_"\s*\.\.')).Count
}
if ($v210Req -eq 0) { $v210Bad += "no .lfm builds a description module name out of the language - leg (b) read nothing and would pass on anything (SPEC V209, B7)" }
if ($v210Bad) { foreach ($b210 in $v210Bad) { Fail "V210 $b210" } }
else { Pass "V210 four areas in eight modules, $v210Keys entries keyed alike on both sides, and all $v210Req require(s) name the half by language" }

# ---- V192: a DESCRIPTION entry carries its source header (SPEC I21) ------------------
# 54th round, the user's ask: a description opens with the book and the exact page it came
# from, then the item's name, then the text - three blocks, two blank lines apart. The header
# lives INSIDE the string, never concatenated at render time (SPEC I21), so it is checkable
# here and there is only one way to build the block.
#
# This measures FORM, not existence: the three tables are still empty until SPEC T444-T446,
# and an empty region passes. What it must not let through is an entry that is on file but
# malformed - no source line, or a name block that drifted from the key the picker looks up.
$descForm = @()
$descSeen = 0
$srcRx  = [regex]'^.+,\s+(p\.|p(\xE1|a)g\.)\s*\d+$'
# T470: an entry may carry a SECOND body under daEn/daPt, written from the Dark Ages book.
# It is optional, but when it is there it is the SAME three blocks (SPEC I21) - a medieval
# body with no source line would open a description the reader cannot trace back to a page.
$eraRx  = [regex]'(?ms)\b(daEn|daPt)\s*=\s*\[==\[(.*?)\]==\]'
# T479-T481 moved the three tables out of the .lfm files and into one module per area
# (SPEC I24 / V189) and T495 then split each into two halves, one per language (SPEC V210).
# The markers migrated verbatim both times, so the region has the shape it always had - what
# changed is that a language is a FILE now, and this check reads each half on its own terms.
# Which key is missing from which half is V210's business; this one measures FORM.
foreach ($area in @(
    @('descDisc', 'DISC_DESC'),
    @('descPath', 'PATH_DESC'),
    @('descRitual', 'RITUAL_DESC'))) {
    $half192 = @{}
    $gone192 = $false
    foreach ($lang in @('en', 'pt')) {
        $half192[$lang] = DescEntries (Join-Path $plugin "$($area[0])_$lang.lua") $area[1] $lang
        if ($null -eq $half192[$lang]) { $descForm += "$($area[0])_$lang.lua is not at the plugin root, or its $($area[1]) markers are gone - the area has no [$lang] text to render (SPEC I24, V210)"; $gone192 = $true }
    }
    if ($gone192) { continue }
    foreach ($lang in @('en', 'pt')) {
        foreach ($e in $half192[$lang]) {
            $key = $e.Key
            $descSeen++
            $blocks = @(($e.Body.Trim()) -split "`n`n`n")
            if ($blocks.Count -ne 3) { $descForm += "$($area[0])_$lang.lua '$key' is $($blocks.Count) block(s), not source + name + text two blank lines apart" }
            else {
                if (-not $srcRx.IsMatch($blocks[0].Trim())) { $descForm += "$($area[0])_$lang.lua '$key' opens with '$($blocks[0].Trim())' - block one is '<book>, p. <page>'" }
                if ($blocks[1].Trim() -ne $key) { $descForm += "$($area[0])_$lang.lua '$key' names itself '$($blocks[1].Trim())' - block two is the picker value the entry is keyed by" }
                if ($blocks[2].Trim().Length -lt 1) { $descForm += "$($area[0])_$lang.lua '$key' has a header and no description under it" }
            }
            # The optional medieval body, same shape, checked only when the entry carries one.
            foreach ($er in $eraRx.Matches($e.Rest)) {
                $tag = $er.Groups[1].Value
                $descSeen++
                $eb = @(($er.Groups[2].Value.Trim()) -split "`n`n`n")
                if ($eb.Count -ne 3) { $descForm += "$($area[0])_$lang.lua '$key' [$tag] is $($eb.Count) block(s), not source + name + text two blank lines apart"; continue }
                if (-not $srcRx.IsMatch($eb[0].Trim())) { $descForm += "$($area[0])_$lang.lua '$key' [$tag] opens with '$($eb[0].Trim())' - block one is '<book>, p. <page>'" }
                if ($eb[1].Trim() -ne $key) { $descForm += "$($area[0])_$lang.lua '$key' [$tag] names itself '$($eb[1].Trim())' - block two is the picker value the entry is keyed by" }
                if ($eb[2].Trim().Length -lt 1) { $descForm += "$($area[0])_$lang.lua '$key' [$tag] has a header and no description under it" }
            }
        }
    }
}

# T470: the reader picks the body by ERA before it picks it by LANGUAGE, and the block is
# re-rendered when the era changes. Without the dataLink field, switching theme would leave
# the previous era's text on screen - stale, not blank, so V33 would never see it (SPEC V20:
# drop 'sheetTheme' from a dataLink, or the pickEra call, and this goes red).
foreach ($area in @('WoD20.12.lfm', 'WoD20.13.lfm', 'WoD20.14.lfm')) {
    $txt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir $area))) -replace "`r`n", "`n"
    if ($txt -notmatch '(?m)^\s*local function pickEra\(entry, lang\)') { $descForm += "$area has no pickEra - the medieval body would never be read (SPEC T470)"; continue }
    if ($txt -notmatch 'daEn' -or $txt -notmatch 'daPt') { $descForm += "$area pickEra reads neither daEn nor daPt (SPEC T470)" }
    if ($txt -notmatch 'era == "Dark Ages" or era == "Classical Age"') { $descForm += "$area pickEra does not test both medieval themes (SPEC C, I22)" }
    if ($txt -notmatch '(?m)^\s*return pickEra\(entry, lang\);') { $descForm += "$area builds the entry text with pick, not pickEra - the second body is dead data (SPEC T470)" }
    $descLink = [regex]::Match($txt, '<dataLink fields="\{([^"]*)\}"[^>]*onChange="render\w+Desc\(self\);"')
    if (-not $descLink.Success) { $descForm += "$area has no dataLink feeding the description renderer" }
    elseif ($descLink.Groups[1].Value -notmatch "'sheetTheme'") { $descForm += "$area description dataLink does not observe 'sheetTheme' - changing era would leave the old body on screen (SPEC T470)" }
}
if ($descForm) { foreach ($d in $descForm) { Fail "V192 $d" } }
elseif ($descSeen -eq 0) { Pass "V192 the three DESC regions are still empty (SPEC T444-T446); the form check is armed" }
else { Pass "V192 all $descSeen description strings open with their book, page and name (SPEC I21)" }

# ---- V193: the description block closes with the column beside it --------------------
# 55th round. The rituals box went from 20 rows to 25 and grew 550 -> 675; had the
# DESCRIPTION been left at 550, nothing would have OVERLAPPED - the two boxes stand side by
# side - so V40 would have passed it and the only symptom would be a black tail on the tab.
# The relation held in all three areas by convention and by nothing else.
#
# Measured as a RELATION, not against the literals (the same move V171 makes): the block
# opens at the top of the left column and ends where the lowest box on the left ends, and its
# textEditor fills that minus the 35px title band. So it survives the NEXT row-count change,
# which is the whole point - the layout gate is still open.
foreach ($areaFile in @('WoD20.12.lfm', 'WoD20.13.lfm', 'WoD20.14.lfm')) {
    $ax  = Doc (Join-Path $dir $areaFile)
    $box = @($ax.SelectNodes("//scrollBox/layout"))
    $descBox = @($box | Where-Object { $null -ne $_.SelectSingleNode("label[@text='DESCRIPTION']") })
    $leftBox = @($box | Where-Object { $null -eq $_.SelectSingleNode("label[@text='DESCRIPTION']") })
    if ($descBox.Count -ne 1) { Fail "V193 $areaFile holds $($descBox.Count) DESCRIPTION boxes - the area has exactly one"; continue }
    if ($leftBox.Count -lt 1) { Fail "V193 $areaFile has a DESCRIPTION box and no column beside it to measure against (SPEC V20)"; continue }
    $leftTop = ($leftBox  | ForEach-Object { [int]$_.GetAttribute("top") } | Measure-Object -Minimum).Minimum
    $leftEnd = ($leftBox  | ForEach-Object { [int]$_.GetAttribute("top") + [int]$_.GetAttribute("height") } | Measure-Object -Maximum).Maximum
    $dTop    = [int]$descBox[0].GetAttribute("top")
    $dEnd    = $dTop + [int]$descBox[0].GetAttribute("height")
    $edit    = $descBox[0].SelectSingleNode("textEditor")
    if ($dTop -ne $leftTop) { Fail "V193 $areaFile DESCRIPTION opens at $dTop, the column beside it at $leftTop" }
    elseif ($dEnd -ne $leftEnd) { Fail "V193 $areaFile DESCRIPTION closes at $dEnd, the column beside it at $leftEnd - $([Math]::Abs($dEnd - $leftEnd))px of one box faces nothing" }
    elseif ($null -eq $edit) { Fail "V193 $areaFile DESCRIPTION carries no textEditor - the renderer has nothing to write to" }
    elseif (([int]$edit.GetAttribute("top") + [int]$edit.GetAttribute("height")) -ne ($dEnd - $dTop - 10)) {
        Fail "V193 $areaFile the description text ends at $([int]$edit.GetAttribute('top') + [int]$edit.GetAttribute('height')) inside a $($dEnd - $dTop)px box - it does not fill what the box grew to"
    }
    else { Pass "V193 $areaFile DESCRIPTION runs $dTop..$dEnd with its column, and the text fills it" }
}

# ---- V175: the clan discipline row is locked unless the storyteller opened it ---------
# SPEC I8g. The four CLAN DISCIPLINES combos are the clan's own three-plus, not the player's
# picks, so they are read-only until stEditClanDisc is ticked. Written the way V162 writes
# the speciality lock - enabled and opacity in the same breath - because a row that is
# disabled but still bright reads as a bug in the sheet rather than as a rule.
$lockFn = LuaFn $root 'renderClanDiscLock'
$discX  = Doc (Join-Path $dir "WoD20.12.lfm")
$discRaw = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.12.lfm")))
$lockLinks = @($discX.SelectNodes("//dataLink[@field='stEditClanDisc']") | ForEach-Object { $_.GetAttribute("onChange") })
$discReady = [regex]::Match($discRaw, '<event name="onNodeReady">(.*?)</event>', 'Singleline')
if (-not $lockFn) { Fail "V175 renderClanDiscLock not found on the root form - nothing locks the clan combos" }
elseif ($lockFn -notmatch 'sheet\.stEditClanDisc == true') { Fail "V175 the lock does not read stEditClanDisc as an explicit true - nil would fall open on an old sheet (SPEC V89, V80)" }
elseif ($lockFn -notmatch '(?m)^\s*c\.enabled = open;') { Fail "V175 the lock does not write c.enabled - nothing would stop the four combos being edited" }
elseif ($lockFn -match 'c\.opacity') { Fail "V175 the lock still paints opacity - a locked dropdown has to keep its text readable (SPEC I41, V241)" }
elseif ($lockLinks -notcontains 'renderClanDiscLock(self);') { Fail "V175 WoD20.12 has no dataLink on stEditClanDisc - flipping the flag would not repaint the lock" }
elseif (-not $discReady.Success -or $discReady.Groups[1].Value -notmatch 'renderClanDiscLock\(self\);') { Fail "V175 WoD20.12 does not paint the lock on open - the tab would come up bright until the flag moved" }
else { Pass "V175 the clan combos are locked from stEditClanDisc, fail-closed, and the look is written with the state" }

# ---- V179: a main path dot is read-only, and owns nothing --------------------------
# SPEC I16/V51. The main path's rating IS the blood sorcery's rating, painted per render.
# Giving these dots a field would put a second number on the sheet to drift from the first,
# and giving them an onClick would sell the player a dot the discipline already paid for.
$pathX   = Doc (Join-Path $dir "WoD20.13.lfm")
$roTpl   = $pathX.SelectSingleNode("//template[@name='MainPathRow']")
if ($null -eq $roTpl) { Fail "V179 MainPathRow is not declared on WoD20.13 - the read-only row is gone" }
else {
    $roDots = @($roTpl.SelectNodes("imageCheckBox"))
    $owning = @($roDots | Where-Object { $_.HasAttribute("field") -or $_.HasAttribute("onClick") })
    $bright = @($roDots | Where-Object { $_.GetAttribute("opacity") -ne '0.40' })
    $live   = @($roDots | Where-Object { $_.GetAttribute("autoChange") -ne 'false' })
    if ($roDots.Count -ne 5) { Fail "V179 MainPathRow carries $($roDots.Count) dots, not the five the scale has" }
    elseif ($owning) { Fail "V179 $($owning.Count) main path dot(s) own a field or an onClick - the rating belongs to the discipline (SPEC I9, I10)" }
    elseif ($live) { Fail "V179 $($live.Count) main path dot(s) still toggle themselves - autoChange must be false" }
    elseif ($bright) { Fail "V179 $($bright.Count) main path dot(s) are drawn at full brightness - a read-only widget is dimmed (SPEC V111)" }
    else { Pass "V179 all five main path dots are read-only: no field, no click, no self-toggle, dimmed" }
}

# ---- V70/V74/V75/V76: the era ability lists (SPEC I7, 21st round) ----------------
# A row on the Main tab is a slot: the era decides which ability sits there and the renderer
# rebinds the dots to that ability's field. Two bugs came out of getting this wrong - B23 (a
# name changing field between eras) and B24 (one field carrying several names) - so what is
# checked here is the shape that makes both impossible: one name, one field, both ways.
#
# None of these strings live in the XML, which is why the width and translation checks further
# up cannot see them - the same blind spot as B11 and B17, one family further out.
$rootLfm = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20th.lfm")))

# ABILITY_FIELD: name -> field.
$abilityField = @{}
$afBlock = [regex]::Match($rootLfm, 'ABILITY_FIELD = \{(.*?)\n\t{3}\};', 'Singleline')
if (-not $afBlock.Success) { Fail "V74 ABILITY_FIELD not found on the root form - every era check is a no-op (SPEC V20)" }
else {
    foreach ($m in [regex]::Matches($afBlock.Groups[1].Value, '\["([^"]+)"\]\s*=\s*"(\w+)"')) { $abilityField[$m.Groups[1].Value] = $m.Groups[2].Value }
}

# ERA_ABILITIES: era -> column -> ten names. A column may point at a shared list declared just
# above it (BASE_TALENTS), so those are resolved first - the alternative is writing the same ten
# names four times, which is exactly how lists drift apart.
$sharedLists = @{}
foreach ($m in [regex]::Matches($rootLfm, 'local ([A-Z_]+) = \{("[^}]*")\};')) {
    $names = @()
    foreach ($s in [regex]::Matches($m.Groups[2].Value, '"([^"]+)"')) { $names += $s.Groups[1].Value }
    $sharedLists[$m.Groups[1].Value] = $names
}
$eraLists = @{}
$eaBlock = [regex]::Match($rootLfm, 'ERA_ABILITIES = \{(.*?)\n\t{3}\};', 'Singleline')
if (-not $eaBlock.Success) { Fail "V75 ERA_ABILITIES not found on the root form - the era lists are unchecked (SPEC V20)" }
else {
    foreach ($m in [regex]::Matches($eaBlock.Groups[1].Value, '\["([^"]+)"\]\s*=\s*\{(.*?)\n\t{4}\}', 'Singleline')) {
        $cols = @{}
        foreach ($c in [regex]::Matches($m.Groups[2].Value, '(\w+)\s*=\s*(\{[^}]*\}|[A-Z_]+)')) {
            $raw = $c.Groups[2].Value
            if ($raw -match '^[A-Z_]+$') {
                if ($sharedLists.ContainsKey($raw)) { $cols[$c.Groups[1].Value] = $sharedLists[$raw] }
                else { Fail "V75 $($m.Groups[1].Value)/$($c.Groups[1].Value) points at $raw, which is not a list declared on the root form" }
            } else {
                $names = @()
                foreach ($s in [regex]::Matches($raw, '"([^"]+)"')) { $names += $s.Groups[1].Value }
                $cols[$c.Groups[1].Value] = $names
            }
        }
        $eraLists[$m.Groups[1].Value] = $cols
    }
}

# The Main tab authors the Victorian list: a sheet whose renderer never ran shows the base era,
# coherent rather than half-bound. field= and nome= per row are read here for that comparison.
$authoredRows = @{}
$mainDoc = Doc (Join-Path $dir "WoD20.1.lfm")
foreach ($r in $mainDoc.SelectNodes("//Ability")) {
    $col = $r.GetAttribute("col"); $num = $r.GetAttribute("num")
    if (-not $col -or -not $num) { Fail "V76 an <Ability> row has no col/num - the renderer addresses rows by slot"; continue }
    $authoredRows["$col/$num"] = @{ Field = $r.GetAttribute("field"); Name = $r.GetAttribute("nome") }
}

if ($abilityField.Count -eq 0 -or $eraLists.Count -eq 0) { Fail "V74/V75 the era tables read empty - the checks below measure nothing (SPEC V20)" }
else {
    # V74: one name, one field - and the other way round too. B24 was the reverse direction
    # going unchecked: `enigmas` carried Enigmas, Computer and Philosophy, so two dots in one
    # surfaced as two dots in another the moment the era changed.
    $fieldOwner = @{}
    $bijection = @()
    foreach ($n in $abilityField.Keys) {
        $f = $abilityField[$n]
        if ($fieldOwner.ContainsKey($f)) { $bijection += "'$f' is the field of both '$($fieldOwner[$f])' and '$n' - a rating would surface under the other name (SPEC B24)" }
        else { $fieldOwner[$f] = $n }
    }
    if ($bijection) { foreach ($b in ($bijection | Sort-Object -Unique)) { Fail "V74 $b" } }
    else { Pass "V74 all $($abilityField.Count) ability names own a field of their own" }

    # V75: ten names per column per era, all distinct, all with a field.
    $listBad = @()
    foreach ($era in $eraLists.Keys) {
        foreach ($col in @('talents', 'skills', 'knowledges')) {
            if (-not $eraLists[$era].ContainsKey($col)) { $listBad += "$era has no $col list"; continue }
            $names = $eraLists[$era][$col]
            if ($names.Count -ne 10) { $listBad += "$era/$col has $($names.Count) names, the column has 10 slots" }
            $seen = @{}
            foreach ($n in $names) {
                if (-not $abilityField.ContainsKey($n)) { $listBad += "$era/$col lists '$n', which has no field in ABILITY_FIELD" }
                if ($seen.ContainsKey($n)) { $listBad += "$era/$col lists '$n' twice" } else { $seen[$n] = $true }
            }
        }
    }
    if ($listBad) { foreach ($b in ($listBad | Sort-Object -Unique)) { Fail "V75 $b" } }
    else { Pass "V75 all $($eraLists.Count) eras fill their 3 columns with 10 named abilities" }

    # V70: an era name is a visible string like any other - both keys, the embedded map that
    # actually translates at runtime, and a width that fits the 125px template label.
    $eraBad = @()
    $eraStrings = New-Object System.Collections.Generic.HashSet[string]
    foreach ($era in $eraLists.Keys) { foreach ($col in $eraLists[$era].Keys) { foreach ($n in $eraLists[$era][$col]) { [void]$eraStrings.Add($n) } } }
    foreach ($txt in $eraStrings) {
        if (-not $ptK.Contains($txt)) { $eraBad += "'$txt' has no [pt] key" }
        if (-not $enK.Contains($txt)) { $eraBad += "'$txt' has no [en] key" }
        if (-not $embedded.ContainsKey($txt)) { $eraBad += "'$txt' is missing from the PT map - it would never translate at runtime" }
        $need = NeededPx $txt
        if ($need -gt 125) { $eraBad += "'$txt' (pt '$($ptVal[$txt])') needs ~${need}px, the Ability label is 125px" }
    }
    if ($eraBad) { foreach ($b in ($eraBad | Sort-Object -Unique)) { Fail "V70 $b" } }
    else { Pass "V70 all $($eraStrings.Count) ability names translate and fit the row" }

    # V76, static half: what the XML authors has to BE an era - the Victorian one - with each
    # row bound to the field its own name owns. Otherwise a sheet whose renderer never ran shows
    # a mix no era ever had.
    $authBad = @()
    $vic = $eraLists['Victorian Era']
    if ($null -eq $vic) { $authBad += "Victorian Era has no list, so the authored rows cannot be checked against it" }
    else {
        foreach ($col in @('talents', 'skills', 'knowledges')) {
            for ($i = 1; $i -le 10; $i++) {
                $row = $authoredRows["$col/$i"]
                if ($null -eq $row) { $authBad += "$col slot $i is not authored on WoD20.1"; continue }
                $want = $vic[$col][$i - 1]
                if ($row.Name -cne $want) { $authBad += "$col slot $i authors '$($row.Name)', the Victorian list says '$want'" }
                elseif ($abilityField[$want] -cne $row.Field) { $authBad += "$col slot $i authors field='$($row.Field)' for '$want', which owns '$($abilityField[$want])'" }
            }
        }
    }
    if ($authBad) { foreach ($b in $authBad) { Fail "V76 $b" } }
    else { Pass "V76 the authored rows are the Victorian era, each bound to its own field" }
}

# V76, runtime half: rebinding without reloading would leave the dot showing the previous
# field's state, which looks exactly like the bug this round was opened for.
if ($hh6 -notmatch 'if c\.field ~= full then c\.field = full; end;') { Fail "V76 the renderer never rebinds a dot - the slots would keep the authored field" }
elseif ($hh6 -notmatch 'local want = sheet\[full\] == true;') { Fail "V76 the renderer rebinds without reloading checked - the dot would show the old field's state" }
else { Pass "V76 the renderer rebinds each dot and reloads it from the NDB" }

# The Combat mirror: one row follows the era, and it resolves the name off the era's own list
# instead of a second table that could drift (the reason HEALTH_MARKS is declared once, V41).
$hh3Text = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.3.lfm")))
if ($rootLfm -notmatch 'function eraRangedName\(') { Fail "V74 eraRangedName is missing - the Combat mirror cannot follow the era" }
elseif ($hh3Text -notmatch 'ReadOnlyTrait field="ranged"') { Fail "V74 the Combat ranged row is not a slot - Archery has its own field now" }
elseif ($hh3Text -notmatch 'paintAs\(form, "ranged", ABILITY_FIELD\[eraRangedName\(\)\], 1\)') { Fail "V74 the ranged row is not painted from the era's own ranged skill" }
elseif ($hh3Text -notmatch "'archery_1'" -or $hh3Text -notmatch "'sheetTheme'") { Fail "V74 the WoD20.3 dataLink does not observe archery_* and sheetTheme - the mirror would go stale" }
else { Pass "V74 the Combat mirror follows the era's ranged skill" }

# V72: the labels are dyn*, so the language traversal skips them (V31). That makes the renderer
# the ONLY thing that writes them, and it has to run on both switches - hanging it off the era
# alone leaves a [pt] sheet in English until the era is touched.
if ($hh6 -notmatch 'local function renderAbilityLabels\(') { Fail "V72 renderAbilityLabels is missing - the era labels would never be written" }
else {
    $langEvt = [regex]::Match($hh6, '<dataLink field="language".*?</dataLink>', 'Singleline')
    $themeEvt = [regex]::Match($hh6, '<dataLink field="sheetTheme".*?</dataLink>', 'Singleline')
    if (-not $langEvt.Success -or $langEvt.Value -notmatch 'renderAbilityLabels\(') { Fail "V72 the language dataLink does not call renderAbilityLabels - era labels would fall back to English on a [pt] sheet" }
    elseif (-not $themeEvt.Success -or $themeEvt.Value -notmatch 'renderAbilityLabels\(') { Fail "V72 the sheetTheme dataLink does not call renderAbilityLabels - switching era would repaint but not rename" }
    else { Pass "V72 the era labels are rendered on load and on both switches" }
}

# And the templates have to carry the dyn* / slot names the renderer looks for.
$abilityLbl = $mainDoc.SelectSingleNode("//template[@name='Ability']/label")
$abilityDot = $mainDoc.SelectSingleNode("//template[@name='Ability']/imageCheckBox")
$roLbl = (Doc (Join-Path $dir "WoD20.3.lfm")).SelectSingleNode("//template[@name='ReadOnlyTrait']/label")
if ($null -eq $abilityLbl -or $abilityLbl.GetAttribute("name") -ne 'dynAbil$(col)$(num)') { Fail "V76 the Ability label is not named per slot - the renderer cannot find it and the translation would fight it" }
elseif ($null -eq $abilityDot -or $abilityDot.GetAttribute("name") -ne 'abil$(col)$(num)_1') { Fail "V76 the Ability dots are not named per slot - nothing could rebind them" }
elseif ($null -eq $roLbl -or $roLbl.GetAttribute("name") -ne 'dynRo$(field)') { Fail "V72 the ReadOnlyTrait label is not named dynRo - the Combat rows would keep their authored name" }
else { Pass "V72/V76 both row templates hand their label and dots to the renderer" }

# ==== 27th round: storyteller tab + derived experience ledger =====================

# ---- V79 + V80: the storyteller gate, and that it fails CLOSED -------------------
# The one tab a player must not reach. Every way the check can go wrong - no room, no player
# object, an API that raises - has to read as "not the storyteller", so the test is not that
# the gate exists but that its failure paths return false.
$stFn = LuaFn $root 'isStoryteller'
if (-not $stFn) { Fail "V79 isStoryteller not found on the root form" }
elseif ($stFn -notmatch 'Firecast\.getMesaDe') { Fail "V79 isStoryteller does not ask the room who this is (SPEC R29)" }
elseif ($stFn -notmatch 'isMestre') { Fail "V79 isStoryteller never reads isMestre" }
elseif ($stFn -notmatch 'pcall') { Fail "V80 isStoryteller does not wrap the API call - a raise would escape instead of hiding the tab" }
elseif ($stFn -notmatch 'if mesa == nil then return false') { Fail "V80 isStoryteller does not close on a sheet outside a room" }
elseif ($stFn -notmatch 'if me == nil then return false') { Fail "V80 isStoryteller does not close on a missing player object" }
elseif ($stFn -notmatch 'return ok and res == true') { Fail "V80 isStoryteller does not close on a failed pcall" }
else { Pass "V79/V80 storyteller gate reads the room and fails closed" }

# ---- V89: which flag drives which tab, and the default each one carries ----------
# Numina has been visible since the sheet shipped, so a sheet saved before this round - nil in
# all three flags - must keep it. That is the difference between `~= false` and `== true`, and
# swapping them would silently take a tab away from every existing character.
$visFn = LuaFn $root 'applyTabVisibility'
if (-not $visFn) { Fail "V89 applyTabVisibility not found on the root form" }
elseif ($visFn -notmatch 'tabNumina\s*=\s*sheet\.stShowNumina ~= false') { Fail "V89 tabNumina does not default to visible - an existing sheet would lose the tab" }
elseif ($visFn -notmatch 'tabDisciplines\s*=\s*sheet\.stShowDisciplines == true') { Fail "V89 tabDisciplines does not default to hidden" }
elseif ($visFn -notmatch 'tabStoryteller\s*=\s*isStoryteller\(\)') { Fail "V89 tabStoryteller is not wired to the gate" }
else { Pass "V89 three tabs switch on their own flag, Numina defaulting visible" }

# ---- V92: a hidden tab is an EMPTY tab -------------------------------------------
# Whether the host takes the tab button away with the tab is still an open question (SPEC
# R31). Hiding the contents as well is what makes the answer stop mattering.
if (-not $visFn) { } # already reported above
# V92 asked the old code to walk the tab's children because nothing confirmed the host took
# the tab BUTTON away with the tab (SPEC R31). The strip is ours now, so the button is a
# control we hide ourselves, and the pane IS the contents - hiding it hides everything it
# holds, which the T521 probe watched happen. The promise is unchanged; what changed is that
# it is now kept by construction rather than by a loop. What is still worth checking is that
# BOTH halves are written: a pane hidden with its button left on screen is a dead tab.
elseif ($visFn -notmatch 'pane\.visible = live') { Fail "V92 applyTabVisibility never hides the pane - denied content would stay on screen (SPEC R31)" }
elseif ($visFn -notmatch 'btn\.visible  = want') { Fail "V92 the tab button does not follow the flag - a denied tab would still offer its button" }
elseif ($visFn -notmatch 'local live = want and \(nm == activeTab\)') { Fail "V92 the pane is not gated by BOTH the flag and the active tab - one of the two would win alone" }
else { Pass "V92 a denied tab loses its button and its contents" }

# ---- V217 (revokes V93): recalculating visibility moves nobody --------------------
# The jump to Main was paid on every toggle by the only person who can toggle - the
# checkboxes live on the Storyteller tab (SPEC I8, V95) - to cover the rare reader sitting
# on the tab as it went. That reader now stays put and finds the tab empty, never holding
# denied content, because V92 above still hides the children. ABSENCE is the only way this
# can be measured at all: SPEC R33 says there is no tab-change event and no trustworthy
# tabIndex, so runtime cannot answer it and the source is all there is.
#
# Comments come off first. V92's prose and V217's own both say "a denied tab" in plain
# English, and prose is not what this measures - code is. NoComments is defined further
# down this file, too late to call from here, so the strip is inline. The patterns are
# code-SHAPED for the same reason: a trailing comment survives the strip (NoComments only
# eats whole lines), and a check that reddens over prose sends the next round hunting a
# comment. Proven by mutation: `-- a denied tab` must NOT redden this.
$visFnCode = [regex]::Replace([string]$visFn, '(?m)^\s*--.*$', '')
if (-not $visFn) { } # already reported above
elseif ($visFnCode -match ':activate\(\)') { Fail "V217 applyTabVisibility still activates a tab - hiding one must leave the reader where they are (SPEC V93 revoked)" }
elseif ($visFnCode -match 'denied\s*=|if\s+denied') { Fail "V217 the shown-to-hidden flag is still live in applyTabVisibility - a dead variable is how the jump crawls back" }
else { Pass "V217 hiding a tab moves nobody" }

# The four switched tabs must exist under those names, and every tab needs one (SPEC I1b).
# The panes ARE the tabs since the 78th round (SPEC I32): a <layout> holding an <import>,
# which in the root form is exactly the eleven and nothing else. Selecting on the import
# rather than on a name prefix keeps tabStrip out without naming it.
$tabNodes = (Doc $rootPath).SelectNodes("//layout[import]")
$tabNames = @($tabNodes | ForEach-Object { $_.GetAttribute("name") })
$unnamed = @($tabNames | Where-Object { -not $_ })
$wantTabs = @('tabNumina', 'tabDisciplines', 'tabStoryteller')
$missingTabs = @($wantTabs | Where-Object { $tabNames -notcontains $_ })
if ($tabNodes.Count -ne 11) { Fail "V89 expected 11 panes (SPEC I1b/I1c, I32), found $($tabNodes.Count)" }
elseif ($unnamed.Count) { Fail "V89 $($unnamed.Count) pane(s) carry no name - the renderer addresses them by name" }
elseif ($missingTabs) { foreach ($t in $missingTabs) { Fail "V89 no pane named $t - its flag would switch nothing" } }
else { Pass "V89 all 11 panes named, including the three the renderer switches" }

# ---- V81 + V82: saving the initial character is one-shot, and says so ------------
# The only irreversible action on this sheet. It must ask first, refuse a second write, and
# leave a button that cannot be pressed again.
$stDoc = Join-Path $dir "WoD20.10.lfm"
if (-not (Test-Path $stDoc)) { Fail "V81 WoD20.10.lfm (Storyteller tab) is missing" }
else {
    $stTxt  = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($stDoc))
    $saveFn = LuaFn $stTxt 'saveBaseline'
    $stateFn = LuaFn $stTxt 'renderBaselineState'

    if (-not $saveFn) { Fail "V81 saveBaseline not found on WoD20.10" }
    elseif ($saveFn -notmatch 'Dialogs\.confirmOkCancel') { Fail "V81 saveBaseline writes without asking (SPEC R30) - the action cannot be undone" }
    elseif (([regex]::Matches($saveFn, 'sheet\.baseline ~= nil and sheet\.baseline ~= ""')).Count -lt 2) { Fail "V81 saveBaseline does not re-check the baseline inside the callback - a second client could overwrite it" }
    elseif ($saveFn -notmatch 'setField\("baseline", ndb\.exportXML\(sheet\)\)') { Fail "V81 saveBaseline does not snapshot the sheet (SPEC R32)" }
    else { Pass "V81 baseline is written once, behind a confirmation" }

    if (-not $stateFn) { Fail "V82 renderBaselineState not found on WoD20.10" }
    elseif ($stateFn -notmatch 'btnSaveBaseline\.enabled = not saved') { Fail "V82 the Save button stays live after the baseline exists" }
    elseif ($stateFn -notmatch 'btnSaveBaseline\.opacity') { Fail "V82 the Save button locks without dimming - the dead button IS the message now, so it has to read dead (SPEC V112, V243b)" }
    elseif ($stateFn -match 'dynBaselineState') { Fail "V82 renderBaselineState still writes dynBaselineState - the state sentence was removed in the 85th round and the name is burned (SPEC I42, V243b)" }
    else { Pass "V82 Save goes dead once the baseline exists, and the dead button is the message (SPEC V243b)" }

    # No field of the ledger's own may be edited from here, and the flags must be real fields.
    $stFields = @((Doc $stDoc).SelectNodes("//*[@field]") | ForEach-Object { $_.GetAttribute("field") })
    $wantFlags = @('stBackgroundCost', 'stShowNumina', 'stShowDisciplines', 'stFreeBuy', 'stSpecCost')
    $missFlags = @($wantFlags | Where-Object { $stFields -notcontains $_ })
    if ($missFlags) { foreach ($f in $missFlags) { Fail "V89 WoD20.10 has no widget for $f" } }
    else { Pass "V89 all $($wantFlags.Count) storyteller flags are owned by WoD20.10" }
}

# ---- V94: a switched tab is AUTHORED in the state its flag defaults to ------------
# The 27th round authored all of them visible and left the hiding to the renderer, so a fresh
# sheet with every checkbox unticked opened with three tabs the player was never meant to see
# (SPEC B26). The static state fails closed too now.
# Rewritten for the strip (SPEC I32, T524). B26 was "a fresh sheet whose script never ran
# showed three tabs nobody was meant to see", and that failure moved from the <tab> to the
# BUTTON: the pane is authored hidden either way now (nothing shows until Lua picks a tab,
# which fails closed harder than before), so what has to fail closed is the button.
$stripDoc = Doc $rootPath
$openPane = @($tabNodes | Where-Object { $_.GetAttribute("visible") -ne 'false' })
$btnHidden = @('btnTabDisciplines', 'btnTabStoryteller')
$btnOpen = @($btnHidden | Where-Object {
    $b = $stripDoc.SelectSingleNode("//rectangle[@name='$_']")
    $null -eq $b -or $b.GetAttribute("visible") -ne 'false'
})
$btnNumina = $stripDoc.SelectSingleNode("//rectangle[@name='btnTabNumina']")
$hiddenByDefault = @('tabDisciplines', 'tabStoryteller')
$authoredOpen = @($tabNodes | Where-Object { $hiddenByDefault -contains $_.GetAttribute("name") -and $_.GetAttribute("visible") -ne 'false' })
$numinaTab = @($tabNodes | Where-Object { $_.GetAttribute("name") -eq 'tabNumina' })
if ($openPane.Count) { Fail "V94 $($openPane.Count) pane(s) are authored visible - a sheet whose script never ran would show content nobody chose (SPEC B26)" }
elseif ($btnOpen.Count) { foreach ($b in $btnOpen) { Fail "V94 $b is missing or authored visible - a fresh sheet would offer a tab its flag has not granted (SPEC B26)" } }
elseif ($null -eq $btnNumina) { Fail "V94 btnTabNumina does not exist - the tab its flag defaults ON for has no button" }
elseif ($btnNumina.GetAttribute("visible") -eq 'false') { Fail "V94 btnTabNumina is authored hidden - its flag defaults ON (SPEC V89)" }
else { Pass "V94 every pane authored hidden, the two managed buttons too, Numina's button open" }

# ---- V95: the switch is triggered from the ROOT, not from the tab it hides ---------
# WoD20.10 owns the checkboxes but is itself one of the four tabs being switched. A tab cannot be
# trusted to run the code that hides its neighbours - that is exactly how B26 happened.
$rootReady = [regex]::Match($root, '<event name="onNodeReady">(.*?)</event>', 'Singleline')
if ($root -notmatch "dataLink fields=""{'stShowNumina', 'stShowDisciplines'}""") { Fail "V95 the root form does not watch the two show-a-tab flags" }
elseif (-not $rootReady.Success) { Fail "V95 the root form has no onNodeReady - nothing would apply tab visibility on load" }
elseif ($rootReady.Groups[1].Value -notmatch 'applyTabVisibility\(') { Fail "V95 the root onNodeReady does not apply tab visibility" }
elseif ($stTxt -match 'applyTabVisibility') { Fail "V95 WoD20.10 still triggers the switch - it is one of the tabs being hidden (SPEC B26)" }
else { Pass "V95 the tab switch is triggered from the root form" }

# ---- V96: visibility is DERIVED, asked again every time the sheet is shown ---------
# Nothing announces a change of role in the room - neither `jogador` nor `mesa` publishes an
# event (SPEC R34) - so an answer taken once at load freezes. A storyteller who had opened
# this sheet as a player came back to it with no Storyteller tab, and the checkboxes that
# would switch it back are on that tab (SPEC B27).
$rootShow = [regex]::Match($root, '<event name="onShow">(.*?)</event>', 'Singleline')
if (-not $rootShow.Success) { Fail "V96 the root form has no onShow - tab visibility would be decided once and frozen (SPEC B27)" }
elseif ($rootShow.Groups[1].Value -notmatch 'applyTabVisibility\(') { Fail "V96 the root onShow does not recompute tab visibility" }
else { Pass "V96 tab visibility is asked again every time the sheet is shown" }

# ---- V83 + V84: the log is derived, not stored -----------------------------------
# Four columns written from ONE row list, so a line reads across, and none of them owns a
# field: a stored copy of a derived number is the one thing that can drift from what produced
# it (the same call V29 made for the description block and the total above).
$progDoc = Join-Path $dir "WoD20.9.lfm"
$progTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($progDoc))
$ledFn   = LuaFn $progTxt 'renderXPLedger'
$rowsFn  = LuaFn $root 'xpLedgerRows'

$cols = @('dynXpType', 'dynXpTrait', 'dynXpLevel', 'dynXpCost')
$colNodes = @((Doc $progDoc).SelectNodes("//textEditor") | Where-Object { $cols -contains $_.GetAttribute("name") })
$colWithField = @($colNodes | Where-Object { $_.GetAttribute("field") })
if ($colNodes.Count -ne 4) { Fail "V84 expected 4 ledger columns on WoD20.9, found $($colNodes.Count)" }
elseif ($colWithField.Count) { Fail "V84 a ledger column owns a field - the derived log would be stored twice" }
elseif (@($colNodes | Where-Object { $_.GetAttribute("readOnly") -ne 'true' }).Count) { Fail "V84 a ledger column is editable - the log is derived, not typed" }
else { Pass "V84 four read-only ledger columns, none owning a field" }

if (-not $ledFn) { Fail "V83 renderXPLedger not found on WoD20.9" }
elseif ($ledFn -notmatch 'if rows == nil then rows = xpLedgerRows\(\); end;') { Fail "V83 renderXPLedger does not rebuild the rows - it would render stale state" }
elseif ($ledFn -notmatch 'if rows == nil then') { Fail "V83 renderXPLedger has no state text for a sheet with no baseline (SPEC V33)" }
elseif (@($cols | Where-Object { $ledFn -notmatch $_ }).Count) { Fail "V83 renderXPLedger does not write all four columns - a line would stop reading across" }
else { Pass "V83 the ledger is rebuilt from scratch on every render" }

if (-not $rowsFn) { Fail "V83 xpLedgerRows not found on the root form" }
elseif ($rowsFn -notmatch 'local rows = \{\};') { Fail "V83 xpLedgerRows does not start from an empty list - rows would accumulate across renders" }
elseif ($rowsFn -notmatch 'if base == nil then return nil; end;') { Fail "V83 xpLedgerRows does not report a missing baseline" }
else { Pass "V83 xpLedgerRows starts empty and reports a missing baseline" }

# ---- V97: the report is rebuilt every time the tab is shown -----------------------
# What feeds the log is ~460 dots on other tabs. The only thing watching them was an SDK
# observer with no precedent in any sheet in this repo; while it silently did nothing, the
# report stayed frozen at whatever it showed when the sheet loaded (SPEC B28).
$progShow = [regex]::Match($progTxt, '<event name="onShow">(.*?)</event>', 'Singleline')
if (-not $progShow.Success) { Fail "V97 WoD20.9 has no onShow - the report would be built once and then frozen (SPEC B28)" }
elseif ($progShow.Groups[1].Value -notmatch 'renderXPLedger\(') { Fail "V97 WoD20.9's onShow does not rebuild the ledger" }
elseif ($progShow.Groups[1].Value -notmatch 'renderXPBoxes\(') { Fail "V97 WoD20.9's onShow does not rebuild the three numbers" }
else { Pass "V97 the Progress report is rebuilt on every show" }

# ---- V98: an empty log says WHY it is empty ---------------------------------------
# A saved character with nothing bought on top of it wrote four blank columns, which reads
# like a tab that failed - the same call V33 makes for the no-baseline case.
if ($ledFn -notmatch '#rows == 0') { Fail "V98 an empty ledger writes four blank columns - indistinguishable from a broken tab" }
elseif ($ledFn -notmatch 'xpEmptyLog\(form, translateSheetText\(') { Fail "V98 the empty-log text is not translated (SPEC V70)" }
else { Pass "V98 an empty log says nothing was bought yet" }

# ---- V99: every rating dot goes through the guard ---------------------------------
# One dot wired straight to its field is one trait that can be raised with an empty pocket,
# and nothing would show it: the log would price the point and the balance would go negative.
# That used to be every imageCheckBox on the sheet - the willpower boxes are checkBoxes and
# the Combat mirror is images. The blood pool broke the premise (SPEC V219, B50): twenty dots
# wearing the rating art that are a RESOURCE, spent and regained inside a scene, never priced
# and never in XP_TRAIT. They are named here by field PREFIX rather than by loosening the rule
# for everyone, because a loosened V134 lets ANY dot mark itself, and that is B38 walking back
# in. Same standing as willpower_c*: spent points, not a rating.
#
# quint_* is the second of that family (SPEC I60, V264b): ten dots of Quintessence, spent and
# regained like blood, with no price in I9 and no line in the ledger. Named by prefix for the
# same reason and on the same terms - the exception is NOMINAL, never a loosened rule.
$dots = @()
$dotsUnguarded = @()
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//imageCheckBox")) {
        if (-not $n.GetAttribute("field")) { continue }   # display-only mirror (V51): owns nothing, buys nothing
        if ($n.GetAttribute("field") -match '^bloodPool_\d+$') { continue }   # free resource, not a rating (V219)
        if ($n.GetAttribute("field") -match '^quint_\d+$') { continue }       # free resource, not a rating (V264b)
        $dots += $n
        if ($n.GetAttribute("onClick") -notmatch 'xpClick\(') { $dotsUnguarded += "$($f.Name) $($n.GetAttribute('field'))" }
    }
}
if ($dotsUnguarded) { foreach ($d in $dotsUnguarded) { Fail "V99 dot '$d' does not call xpClick on the click - that trait could be raised with no experience left" } }
else { Pass "V99 all $($dots.Count) rating dots ask xpClick before anything is marked" }

# ---- V134: the host marks nothing on its own (SPEC B38) ------------------------------
# Three rounds tried to let the click land and take it back. It cannot be taken back: a
# write made from inside the dot own onChange does not survive the dispatch. So the dot is
# told not to change itself, and the mark becomes the sheet decision to make.
$dotsAuto = @($dots | Where-Object { $_.GetAttribute("autoChange") -ne 'false' })
$dotsOnChange = @($dots | Where-Object { $_.GetAttribute("onChange") -ne "" })
if ($dotsAuto.Count -gt 0) { Fail "V134 $($dotsAuto.Count) rating dot(s) still mark themselves - autoChange is not false, so the host writes before anyone is asked (SPEC B38)" }
elseif ($dotsOnChange.Count -gt 0) { Fail "V134 $($dotsOnChange.Count) rating dot(s) still carry an onChange - two decision paths for one click" }
else { Pass "V134 all $($dots.Count) rating dots leave the marking to xpClick" }

# The guard only knows the traits XP_TRAIT declares, and it is built from the ledger's own
# lists so the two cannot disagree (SPEC V86). A dropped category would leave those dots
# silently unguarded - the call is there, the table just says nothing about them.
$traitTbl = [regex]::Match($root, 'XP_TRAIT = \{\};(.*?)local function numinaTypeInUse', 'Singleline')
$catMiss = @()
if (-not $traitTbl.Success) { Fail "V99 XP_TRAIT is not declared on the root form" }
else {
    foreach ($cat in @('XP_ATTRS', '"appearance"', 'ABILITY_FIELD', 'XP_CUSTOM', 'XP_VIRTUES', '"humanity"', '"willpower"', '"background_"', 'XP_NUMINA', '"faith"')) {
        if ($traitTbl.Groups[1].Value -notmatch [regex]::Escape($cat)) { $catMiss += $cat }
    }
    if ($catMiss) { foreach ($c in $catMiss) { Fail "V99 XP_TRAIT never declares $c - dots of that kind would pass the guard untouched" } }
    else { Pass "V99 XP_TRAIT covers all ten trait kinds the ledger prices" }
}

# ---- V100: experience is worked out, never booked ---------------------------------
# The balance is xpTotal minus the log. A deducted balance would be a second count of the
# same purchases, and the two would part company the first time a click was missed.
$guardFn = LuaFn $root 'xpClick'
$boxesFn = LuaFn $root 'renderXPBoxes'
$paintFn = LuaFn $root 'xpPaint'
$writes = @([regex]::Matches($root, 'setField\("xpTotal",')).Count
if (-not $guardFn) { Fail "V100 xpClick not found on the root form" }
elseif (-not $boxesFn) { Fail "V100 renderXPBoxes not found on the root form" }
elseif (-not $paintFn) { Fail "V100 xpPaint not found on the root form" }
elseif ($guardFn -match 'setField\("xpTotal",') { Fail "V100 the guard writes experience - a purchase would be counted twice (SPEC V83)" }
elseif ($writes -ne 2) { Fail "V100 xpTotal is written in $writes places - it may only be seeded once and set by the player (SPEC I11)" }
elseif ($paintFn -notmatch 'xpSpent\(\)') { Fail "V100 the boxes do not read the log - Spent would be a stored number" }
else { Pass "V100 experience is derived: one number saved, two worked out" }

# ---- V107: a write the sheet makes to ITSELF is not a click -----------------------
# The era renderer rebinds 150 dots, and both the language and the theme link fire it on
# load. With the guard live on every one of those writes that was ~300 walks of the ledger
# before the sheet drew - the freeze in B30. imageCheckBox has no onUserChange to tell a
# click from a write (SPEC R37), so the flag is how the sheet says which is which.
$eraFn = LuaFn $hh6 'renderAbilityLabels'
if ($root -notmatch 'xpQuiet = false;') { Fail "V107 xpQuiet is not declared on the root form" }
elseif ($boxesFn -notmatch 'if xpQuiet then return') { Fail "V107 the dataLink entry runs on the sheet's own writes (SPEC B30) - that entry is the one the flag exists for" }
elseif ($paintFn -notmatch 'xpQuiet = true') { Fail "V107 seeding xpTotal is not done quietly - the links watching it call straight back in" }
elseif (-not $eraFn) { Fail "V107 renderAbilityLabels not found on WoD20.6" }
elseif ($eraFn -notmatch 'xpQuiet = true') { Fail "V107 the era renderer rebinds its dots with the guard live - the sheet freezes on load (SPEC B30)" }
elseif ($eraFn -notmatch 'xpQuiet = false') { Fail "V107 the era renderer never lowers xpQuiet - the guard would stay asleep for good" }
else { Pass "V107 the sheet's own writes are quiet, and the flag comes back down" }

# ---- V108: one walk of the ledger per click ---------------------------------------
# The dot used to call the guard AND the box renderer, and each walked the whole ledger.
$dotsDouble = @($dots | Where-Object { $_.GetAttribute("onChange") -match 'renderXPBoxes' })
if ($dotsDouble) { Fail "V108 $($dotsDouble.Count) dot(s) call renderXPBoxes beside the guard - each click would walk the ledger twice" }
elseif ($guardFn -notmatch 'renderAllXPBoxes\(form, spent\)') { Fail "V108 the guard does not hand its count to the boxes - they would build the same one again" }
else { Pass "V108 a click walks the ledger once" }

# ---- V101: the guard sleeps until the character is frozen -------------------------
# Building a character spends nothing, so a balance of zero must not stop the first dot.
if ($guardFn -notmatch 'baselineOf\(\)') { Fail "V101 the guard does not look for a baseline - a character could not be built at all" }
elseif ($guardFn -notmatch '(?s)if base == nil then.{0,220}return;') { Fail "V101 the guard does not stand down without a baseline (SPEC I8c)" }
else { Pass "V101 the guard sleeps until the storyteller freezes the character" }

# ---- V103: only a point that is IN the log can be sold back -----------------------
if ($guardFn -notmatch 'traitLevel\(base,') { Fail "V103 the guard never reads the baseline rating - it would let a frozen point be sold" }
elseif ($guardFn -notmatch '(?s)if after < traitLevel\(base,.{0,80}return;') { Fail "V103 the guard does not refuse a sale that would drop the trait below the frozen character" }
else { Pass "V103 a point the storyteller froze cannot be sold back" }

# ---- V102: the three experience boxes own no field --------------------------------
# The orphan check above already refuses `experience` and `spentXP` anywhere; this is the
# other half - the boxes that replaced them must not have quietly taken a field of their own.
$xpBoxes = @('edtTotalXP', 'edtSpentXP', 'edtCurrentXP', 'edtCurrentXPMain')
$xpOwning = @()
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//edit")) {
        if ($xpBoxes -contains $n.GetAttribute("name") -and $n.GetAttribute("field")) { $xpOwning += $n.GetAttribute("name") }
    }
}
if ($xpOwning) { foreach ($b in $xpOwning) { Fail "V102 '$b' owns a field - a derived number would be stored beside the log that produces it" } }
elseif ($paintFn -notmatch 'sheet\.experience') { Fail "V102 nothing seeds xpTotal from the old balance - every sheet would come back to zero (SPEC I11)" }
else { Pass "V102 the four experience boxes own no field, and the old balance seeds the total" }

# ---- V91: xpLog is gone, and stays gone ------------------------------------------
# The free-text box the ledger replaced. Reusing the name would bring a player's old notes
# back up inside a column that means something else now (SPEC I3, orphans).
$xpLogUsers = @($files | Where-Object {
    ([System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($_.FullName))) -match 'field="xpLog"'
})
if ($xpLogUsers) { foreach ($f in $xpLogUsers) { Fail "V91 $($f.Name) still owns xpLog - it is an orphan now" } }
else { Pass "V91 xpLog owned by nothing" }

# ---- V85: ONE reading of a trait's rating ----------------------------------------
# Both sides of the diff have to count the same way, and willpower has two rows of ten - the
# dots are the rating, the boxes are spent points. Counting the boxes would price a spent
# point as a purchase.
$lvlFn = LuaFn $root 'traitLevel'
if (-not $lvlFn) { Fail "V85 traitLevel not found on the root form" }
elseif ($rowsFn -match 'willpower_c') { Fail "V85 the ledger reads the willpower BOXES - those are spent points, not rating" }
elseif ($rowsFn -notmatch 'traitLevel\(base,' -or $rowsFn -notmatch 'liveLevel\(') { Fail "V85 the ledger does not read both sides through traitLevel" }
elseif ($rowsFn -match '(?m)^\s*for i = 1, 5, 1 do') { Fail "V85 xpLedgerRows counts dots itself instead of calling traitLevel" }
else { Pass "V85 both sides of the diff read ratings through traitLevel (the live side through liveLevel, which adds only the pending click)" }

# Attributes and virtues start at _2 with a fixed first dot; Appearance is the declared
# exception (SPEC I3). Getting this wrong prices every attribute one step off.
if ($rowsFn -notmatch 'traitLevel\(base, field, 2, 5, 1\)') { Fail "V85 virtues are not read with the fixed first dot" }
elseif ($rowsFn -notmatch 'if field == "appearance" then first, fixed = 1, 0; end;') { Fail "V85 Appearance is not read as the exception it is (its first dot can be switched off)" }
else { Pass "V85 fixed first dots and the Appearance exception are read correctly" }

# ---- V104: Appearance starts at one, and only when untouched ----------------------
# It is the one attribute drawn without a fixed first dot, so a character CAN be at zero -
# but zero was never the default. nil is nobody having touched the dot; false is the player's
# decision, and a seed that ignored that would put the dot back on at every load.
$rootReady2 = [regex]::Match($root, '<event name="onNodeReady">(.*?)</event>', 'Singleline')
if (-not $rootReady2.Success) { Fail "V104 the root form has no onNodeReady - nothing would seed Appearance" }
elseif ($rootReady2.Groups[1].Value -notmatch 'sheet\.appearance_1 == nil') { Fail "V104 the Appearance seed is not guarded by nil - a dot the player switched off would come back on every load" }
elseif ($rootReady2.Groups[1].Value -notmatch 'setField\("appearance_1", true\)') { Fail "V104 nothing seeds appearance_1 - a new sheet would read Appearance 0" }
else { Pass "V104 Appearance is seeded to one, and only when nobody has touched it" }

# ---- V86: the cost table, once, and the dormant rules NOT written -----------------
# Every active rule from SPEC I9 exactly once. The dormant ones - Discipline, Path, Sphere,
# Arete - have no field to read while those tabs are empty, so writing them would be code that
# nothing can reach and nothing can test.
$costFn = LuaFn $root 'xpCost'
if (-not $costFn) { Fail "V86 xpCost not found on the root form" }
else {
    $costWant = @{
        'Attribute'  = 'return from \* 4'
        'Ability'    = 'if from == 0 then return 3; end; return from \* 2'
        'Virtue'     = 'if kind == "Virtue"    then return from \* 2'
        'Humanity'   = 'if kind == "Humanity"  then return from \* 2'
        'Willpower'  = 'if kind == "Willpower" then return from;'
        # A PRICE since the 88th round, not a flag (SPEC I51). Two keys and both anchored on the
        # kind, for the reason spelled out below: `return from * ctx.backgroundCost` is the whole
        # rule, so a bare pattern would go green off either half of it.
        'Background (first dot)' = 'kind == "Background" then[\s\S]+?if from == 0 then return ctx\.backgroundCost; end;'
        'Background (rest)'      = 'if from == 0 then return ctx\.backgroundCost; end;\s+return from \* ctx\.backgroundCost;'
        'Numina'     = 'kind == "Numina" then[\s\S]+?return from \* 7;'
        # SPEC I9b, 51st round: the two rules that were dormant since the 27th are awake now
        # that the Vampire tab owns fields to read. Sphere and Arete stay dormant below - the
        # Magika tab that would have owned them was deleted in the 39th round.
        #
        # Prices rewritten 2026-08-22 (SPEC I9). Every key is anchored on its own `kind` from
        # here on, because the new table makes bare patterns lie: both first dots now cost 20,
        # so 'Discipline (first dot)' would pass reading Path's line and vice versa - the rule
        # could be DELETED and the check would still go green (SPEC B7, V20). The non-clan rule
        # gets a key of its own for the same reason: it had none, and its old x7 was what the
        # Numina key was matching all along.
        'Discipline (first dot)' = 'kind == "Discipline" then\s+if from == 0 then return 20; end;'
        'Discipline (clan)'      = 'if ctx\.inClan then return from \* 15; end;'
        'Discipline (non-clan)'  = 'if ctx\.inClan then return from \* 15; end;\s+return from \* 25;'
        'Path (first dot)'       = 'kind == "Path" then\s+if from == 0 then return 20; end;'
        'Path (rest)'            = 'kind == "Path" then\s+if from == 0 then return 20; end;\s+return from \* 15;'
    }
    $costBad = @()
    foreach ($k in $costWant.Keys) { if ($costFn -notmatch $costWant[$k]) { $costBad += "$k is not priced as SPEC I9 states" } }
    # Read the CODE, not the prose: the comment above xpCost names the dormant rules on purpose,
    # so the check looks for a dormant kind being handled - a quoted kind string - rather than
    # for the word appearing anywhere in the file.
    foreach ($dead in @('Sphere', 'Arete')) {
        if ($costFn -match "kind == `"$dead`"") { $costBad += "$dead is priced here - SPEC I9 keeps it dormant until a field exists to read" }
        if ($rowsFn -match "`"$dead`"") { $costBad += "$dead produces ledger rows - the tab that would own it is still empty" }
    }
    # The guard that used to sit here is GONE, and its absence is the invariant now (SPEC I51):
    # a background at price 0 has to come out of the arithmetic, because a guard returning 0
    # early would make `stBackgroundCost` = 0 indistinguishable from a rule that never ran. The
    # flag it read is an ORPHAN and the name is burned on both sides (SPEC I3, V2).
    if ($costFn -match 'backgroundsXP') { $costBad += "xpCost still reads ctx.backgroundsXP - the flag became a price in the 88th round and zero comes out of the arithmetic now (SPEC I51)" }
    if ($root -match 'sheet\.stBackgroundsXP') { $costBad += "the root form still reads sheet.stBackgroundsXP - it is a declared ORPHAN since the 88th round (SPEC I3, V2, I51)" }
    if ($costFn -notmatch 'if ctx\.affinity then return from \* 6; end;') { $costBad += "the affinity path is not cheaper than the rest" }

    if ($costBad) { foreach ($b in $costBad) { Fail "V86 $b" } }
    else { Pass "V86 every active cost rule written once, every dormant one left out" }
}

# ---- V87: 21 buys the first point of a KIND, not of a numina ---------------------
# A character with static magic paying for their first psychic phenomenon pays 21 once; the
# next psychic numina costs the ordinary 7. Pricing it per numina would charge 21 every time.
if ($costFn -notmatch 'if ctx\.newType then return 21; end;') { Fail "V87 the 21 is not gated on the kind being new" }
elseif ($costFn -notmatch '(?ms)if from == 0 then.*?return 7;') { Fail "V87 an ordinary first point does not cost 7" }
elseif ($rowsFn -notmatch 'ctx\.newType\s*=\s*\(from == 0\) and not unlocked\[grp\.kind\]') { Fail "V87 the ledger does not decide newType from the kinds the baseline already had" }
elseif ($rowsFn -notmatch 'unlocked\[grp\.kind\] = true;') { Fail "V87 a kind is never marked bought - every numina of it would cost 21" }
else { Pass "V87 21 is charged once per new kind of numina" }

# ---- V88: the affinity path is the FIRST hedge row, always ------------------------
# Marked in the XML, priced in the Lua, and the two have to name the same row. Bold is the
# whole of the mark since the 28th round - the star that stood in the box's left margin came
# off at the user's request, and only the footnote under TRUE FAITH keeps one.
$numDoc = Join-Path $dir "WoD20.7.lfm"
$numTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($numDoc))
if ($numTxt -match '<label[^>]*text="\*"') { Fail "V88 the star label is back on the hedge box - bold is the whole mark now (28th round)" }
elseif ($numTxt -notmatch '<HedgePicker field="numina_1" style="bold"/>') { Fail "V88 the first hedge row is not marked bold" }
elseif ($numTxt -match '<HedgePicker field="numina_(?!1")\d+" style="bold"/>') { Fail "V88 a row other than the first is marked as the affinity path" }
elseif ($numTxt -notmatch 'text="\* The first path is the Affinity Path"') { Fail "V88 the note explaining the affinity path is missing - it rides at the right end of hedgeStrip since the 91st round (SPEC C, I64)" }
elseif ($rowsFn -notmatch 'ctx\.affinity = \(field == "numina_1"\)') { Fail "V88 the cheaper rate is not tied to numina_1" }
else { Pass "V88 numina_1 is the affinity path in both the XML and the pricing" }

# ---- V90: the two empty tabs stay empty ------------------------------------------
# A field name cannot be renamed after release without losing what players saved under it
# (SPEC V2), so none is spent before the content that would use it exists.
# WoD20.11 left this list on 2026-08-22 (SPEC B50): it carries the Dominator and Blood Pool
# boxes now, so it declares fields on purpose. Magika, the other subject this invariant was
# written for, was deleted in the 39th round. The list is empty and the check says so rather
# than looping over nothing and reporting a pass it did not earn (SPEC V209).
$emptyShells = @()
if (-not $emptyShells.Count) { Pass "V90 no empty shell left to guard - WoD20.11 carries content (B50), Magika is gone (V128)" }
foreach ($empty in $emptyShells) {
    $ep = Join-Path $dir $empty
    if (-not (Test-Path $ep)) { Fail "V90 $empty is missing" ; continue }
    $eFields = @((Doc $ep).SelectNodes("//*[@field]"))
    if ($eFields.Count) { Fail "V90 $empty declares $($eFields.Count) field(s) before it has content" }
    else { Pass "V90 $empty declares no field" }
}


# ---- V111: dimmed <=> read-only, in both directions -------------------------------
# The sheet has no other way to say "look, do not touch": a mirror dot and a real dot are the
# same art, and a read-only edit is the same box as an editable one. Opacity is the whole of
# the signal (SPEC C, 33rd round), so it has to be exact and it has to be exclusive - a live
# field wearing the dim value lies in the other direction and would teach the player to
# The theme never writes opacity (V57/V66 family), so what the XML says is what renders in
# all four eras.
# TWO numbers since 2026-08-22, one per NATURE of widget (SPEC I43, V244, user's third item):
# text that is dimmed goes to 0.75 and ART stays at 0.40. The request was literally "whenever
# some TEXT is given transparency, use 75%", and a dot is not text - it is a mark whose whole
# job is to read as on or off, and 0.40 is what tells a mirrored dot from a live one.
#
# These two are NOT the only place the numbers live: V112 (Lua, a button - TEXT) and V179
# (an attribute, main path dots - ART) each carry their own literal, because they match a
# different thing than this sweep does. Change one, change all three - they are named here by
# CHECK ID rather than by line, because line numbers rot (SPEC V209). V162 and V175 hold no
# literal at all: they forbid a combo painting opacity AT ALL (SPEC V241).
$DIM_TEXT = '0.75'
$DIM_ART  = '0.40'

# The six description panes are the ONE read-only thing that stays bright (SPEC V111(2),
# user 2026-08-22). They are read-only and they are also the text the player opened the tab
# to read, and dimming the content to signal "do not edit" charges legibility for a warning
# the frame and the missing caret already give. Named, like bloodPool_* in V219 and
# willpower_c* in V99 - loosening (a) instead would let ANY read-only widget go bright, and
# (a) exists because a mirror dot and a real dot are the same art.
$DESC_BRIGHT = @('edtDiscDesc','edtPathDesc','edtRitualDesc','edtHedgeDesc','edtPsychicDesc','edtFaithDesc','edtHedgeRitualDesc')
$comboBright = 0
$descSeen = 0
$dimSeen = 0
$dimBefore = $fail
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//edit | //textEditor | //comboBox | //checkBox | //imageCheckBox")) {
        # `enabled="false"` means READ-ONLY only while the control is on screen. A widget
        # authored `visible="false"` is HIDDEN, not locked: nobody is reading it, so there is
        # nothing to dim - and dimming it would be wrong the moment Lua reveals it, because the
        # reveal writes `visible` and `enabled` and never opacity (SPEC I71, V274c, V274d). The
        # branch below still refuses opacity on a hidden one, so this is an exemption from the
        # dim rule and not from measurement.
        $ro = ($n.GetAttribute("readOnly") -eq 'true') -or
              ($n.GetAttribute("enabled")  -eq 'false' -and $n.GetAttribute("visible") -ne 'false') -or
              ($n.LocalName -eq 'imageCheckBox' -and $n.GetAttribute("autoChange") -eq 'false' -and -not $n.GetAttribute("onClick"))
        $op = $n.GetAttribute("opacity")
        $id = $n.GetAttribute("name"); if (-not $id) { $id = $n.GetAttribute("field") }; if (-not $id) { $id = $n.LocalName }

        # A comboBox never carries opacity, locked or not (SPEC I41, V241, user
        # 2026-08-22): the property dims the control and the TEXT with it, and there is
        # no text-only opacity to reach for - so the only way to keep a locked dropdown
        # readable is not to have one. Nominal, exactly like $DESC_BRIGHT above:
        # loosening (a) for every read-only widget is a different rule, and not this one.
        if ($n.LocalName -eq 'comboBox') {
            $comboBright++
            if ($op -ne '') { Fail "V111 $($f.Name) $id is a comboBox carrying opacity '$op' - it would dim the text the player has to read (SPEC I41, V241)" }
        } elseif ($DESC_BRIGHT -contains $id) {
            $descSeen++
            if ($op -ne '') { Fail "V111 $($f.Name) $id is a description pane and still carries opacity '$op' - the text the player opened the tab to READ is the one read-only widget that stays bright (SPEC V111(2))" }
        } elseif ($ro) {
            $dimSeen++

            # Which of the two numbers this widget answers to (SPEC V244). An imageCheckBox is
            # ART - a mark that reads on or off - and everything else the sweep sees carries
            # TEXT the player has to read.
            $want = if ($n.LocalName -eq 'imageCheckBox') { $DIM_ART } else { $DIM_TEXT }
            $kind = if ($n.LocalName -eq 'imageCheckBox') { 'art' } else { 'text' }

            if ($op -ne $want) { Fail "V111/V244 $($f.Name) $id is read-only $kind but reads live (opacity '$op', expected $want)" }
        } elseif ($op -ne '') {
            Fail "V111 $($f.Name) $id is editable but reads locked (opacity '$op')"
        }
    }
}
if ($descSeen -ne $DESC_BRIGHT.Count) { Fail "V111 $descSeen of the $($DESC_BRIGHT.Count) named description panes were found - a renamed pane would fall back into the dim rule silently, or the exception is now covering nothing (SPEC V209)" }
elseif ($comboBright -lt 17) { Fail "V111 only $comboBright comboBox(es) were read, expected the 17 the sheet declares - the exception would be covering less than it exempts (SPEC V209). Seventeen DECLARATIONS, not seventeen on screen: nine of them live in a template and are drawn once per row." }
elseif ($fail -eq $dimBefore) { Pass "V111/V244 $dimSeen read-only widgets dimmed - text at $DIM_TEXT, art at $DIM_ART - $descSeen description panes and $comboBright combos left bright, every editable one untouched" }

# The fixed first dot of a virtue is an <image>, not an input, so the sweep above cannot see
# it - and a bright dot beside four dimmed ones is exactly the row reading half-locked (SPEC C).
# Only the Combat mirror has one; the same art on Main belongs to an editable row.
$imgBefore = $fail
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//image[@src]")) {
        $op   = $n.GetAttribute("opacity")
        $want = ($f.Name -eq 'WoD20.3.lfm')
        if ($want -and $op -ne $DIM_ART) { Fail "V111 $($f.Name) mirror dot1 reads live (opacity '$op', expected $DIM_ART)" }
        elseif (-not $want -and $op -ne '') { Fail "V111 $($f.Name) a dot on an editable row is dimmed (opacity '$op')" }
    }
}
if ($fail -eq $imgBefore) { Pass "V111 the fixed dot1 art is dimmed on the mirror tab and bright everywhere else" }

# ---- V244: the two numbers hold in LUA too --------------------------------------------
# The XML sweep above is only half of V244: opacity is also written at runtime, and a Lua
# write is exactly where the art number could come back in through the side door - it is the
# number that stood alone until this round, so it is the one a hand types from memory.
#
# Every runtime write on this sheet lands on a TEXT control (a button, an edit), so the ART
# literal has no business inside Lua at all. `1` and `0.75` are the two legal values: `1` is
# "not dimmed" and is not a third number for the same reason `opacity` absent is not one.
$luaDimBad  = @()
$luaDimSeen = 0
foreach ($f in $files) {
    $code = CodeOf $f.FullName
    foreach ($m in [regex]::Matches($code, '(?m)\.opacity\s*=\s*([^;\r\n]+)')) {
        $luaDimSeen++
        $expr = $m.Groups[1].Value.Trim()
        foreach ($num in [regex]::Matches($expr, '\d+\.\d+')) {
            if ($num.Value -ne $DIM_TEXT) {
                $luaDimBad += "$($f.Name) writes .opacity = $expr - Lua only ever dims TEXT, and text dims at $DIM_TEXT (SPEC I43, V244)"
            }
        }
    }
}
if ($luaDimSeen -lt 1) { Fail "V244 no runtime opacity write was found at all - the Lua leg is reading nothing (SPEC V20, V209)" }
elseif ($luaDimBad) { foreach ($b in $luaDimBad) { Fail "V244 $b" } }
else { Pass "V244 all $luaDimSeen runtime opacity writes use the text number ($DIM_TEXT) or 1" }

# ---- V112: a control that locks at runtime dims in the same breath ----------------
# btnSaveBaseline is the only one. Writing `enabled` without writing `opacity` leaves a dead
# button with a live button's face, which is the same lie V111 refuses in the XML.
$stTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.10.lfm")))
if ($stTxt -notmatch 'btnSaveBaseline\.enabled\s*=\s*not saved;') { Fail "V112 the Save button is not disabled once the baseline is saved (SPEC V82)" }
elseif ($stTxt -notmatch 'btnSaveBaseline\.opacity\s*=\s*saved and 0\.75 or 1;') { Fail "V112 the Save button locks without dimming, or dims at the wrong number - a button is TEXT and dims at 0.75 (SPEC V244)" }
else { Pass "V112 the Save button dims in the same breath it locks" }


# ---- V121: nothing redraws off a whole-node observer -------------------------------
# B34: WoD20.9 registered ndb.newObserver(sheet) and redrew the whole experience log from its
# onChanged. That fires for EVERY attribute written, including the hundreds the sheet writes
# to itself while loading, and it does not pass through xpQuiet - so the shield that fixed
# B30 never covered it. On a sheet with a saved baseline every one of those writes bought a
# full walk of ~91 traits across two nodes, and opening the sheet froze Firecast.
# A new sheet did not freeze: with no baseline the ledger returns on its first line, which is
# why this only ever showed up on a character somebody had already played.
#
# A comment is allowed to name the thing it explains, so XML comments and Lua line comments
# come out before the grep - otherwise documenting the removal would fail the check.
# Lua comment lines, dropped. Every check that reads the inside of a function is looking for
# CODE, and a comment that quotes code - "written flat rather than nested under `if want
# then`" - would otherwise answer for it: two checks went red on exactly that, reading a
# sentence about the balance branch as the balance branch (SPEC V20, the B7 failure mode).
function NoComments($t) { [regex]::Replace($t, '(?m)^\s*--.*$', '') }

$obsUsers = @($files | Where-Object { (CodeOf $_.FullName) -match 'ndb\.newObserver' })
if ($obsUsers) { foreach ($o in $obsUsers) { Fail "V121 $($o.Name) hangs a redraw off ndb.newObserver - it fires on every attribute and bypasses xpQuiet (SPEC B34)" } }
else { Pass "V121 no whole-node observer - redraws come from the click, a named dataLink or onShow" }

# The replacement path must actually be wired, or the log simply stops following purchases.
# Since the 44th round that path carries no registration: the click hands the log the sheet
# ROOT and the renderer finds its own columns from there (SPEC V133/V143, B39).
$rootTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20th.lfm")))
$ledgerTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.9.lfm")))
if ($rootTxt -notmatch 'renderXPLedger\(tabRootOf\(from\), rows\)') { Fail "V121 the click never redraws the log from the sheet root - a purchase would leave it stale" }
elseif ($rootTxt -notmatch 'xpLedgerRefresh\(form, rows\);') { Fail "V121 xpClick does not redraw the log after an accepted click" }
else { Pass "V121 the click redraws the log from the sheet root, with no handover in between" }

# ---- V122: a renderer writes a field only when the value actually changes -----------
# Writing back a value that is already there still wakes every dataLink on that field, and
# those renderers write more fields. One helper, so there is one thing to check.
if ($rootTxt -notmatch 'function setField\(name, value\)') { Fail "V122 setField is missing from the root form" }
elseif ($rootTxt -notmatch 'if sheet\[name\] ~= value then sheet\[name\] = value; end;') { Fail "V122 setField writes without comparing first - the whole point of it" }
else { Pass "V122 setField compares before it writes" }

# Every field write in the sheet goes through it. The `sheet[name]` pair inside setField
# itself is the only assignment allowed to be direct.
$directWrites = @()
foreach ($f in $files) {
    $raw = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    foreach ($m in [regex]::Matches($raw, 'sheet(\[[^\]]+\]|\.[A-Za-z_][A-Za-z0-9_]*)\s*=(?!=)')) {
        if ($m.Value -match '^sheet\[name\]') { continue }
        $directWrites += "$($f.Name): $($m.Value.Trim())"
    }
}
if ($directWrites) { foreach ($w in $directWrites) { Fail "V122 field written without comparing - $w - use setField (SPEC B34)" } }
else { Pass "V122 every field write goes through setField" }

# ---- V123: a dataLink watches only what its renderer reads --------------------------
# WoD20.3 had one link over the health track AND the ~80 mirrored trait dots, so ticking any
# trait re-rendered the health track, and that render wrote all ten health rows back.
$combatTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.3.lfm")))
$healthLinks = @([regex]::Matches($combatTxt, '<dataLink fields="\{([^}]*)\}"[^>]*renderHealthTrack'))
if ($healthLinks.Count -ne 1) { Fail "V123 expected exactly one dataLink driving renderHealthTrack on WoD20.3, found $($healthLinks.Count)" }
else {
    $watched = @($healthLinks[0].Groups[1].Value -split ',' | ForEach-Object { $_.Trim().Trim("'") })
    $strays  = @($watched | Where-Object { $_ -ne 'healthLevels' -and $_ -ne 'language' })
    if ($strays) { Fail "V123 the health link on WoD20.3 also watches $($strays -join ', ') - fields renderHealthTrack never reads (SPEC B34)" }
    else { Pass "V123 the health link on WoD20.3 watches only healthLevels and language" }
}
if ($combatTxt -notmatch '<dataLink fields="\{[^}]*\}"[^>]*renderCombatTraits\(self\);"\s*/>') { Fail "V123 the trait mirror on WoD20.3 has no link of its own" }
elseif ($combatTxt -match '<dataLink fields="\{[^}]*\}"[^>]*renderHealthTrack[^>]*renderCombatTraits') { Fail "V123 one link still drives both renderers on WoD20.3" }
else { Pass "V123 the trait mirror on WoD20.3 has its own link" }

# ---- V124: a whole-tree renderer runs once per open for the same state --------------
# language and sheetTheme both carry a defaultValue, so BOTH links fire when the sheet opens.
# renderAbilityLabels walked the whole control tree and rebound 150 dots each time.
$setTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.6.lfm")))
if ($setTxt -notmatch 'local abilityMemo') { Fail "V124 renderAbilityLabels keeps no memo - it walks the tree twice on every open" }
elseif ($setTxt -notmatch 'if abilityMemo == memo then return; end;') { Fail "V124 the memo is kept but never short-circuits" }
elseif ($setTxt -notmatch 'abilityMemo = memo;') { Fail "V124 the memo is read but never written - it would short-circuit forever" }
else { Pass "V124 renderAbilityLabels returns early when neither era nor language moved" }

# The two writes it makes per dot are compared, like setField compares (SPEC V122). These are
# control properties, not fields, so the setField check above cannot see them.
if ($setTxt -notmatch 'if c\.field ~= full then c\.field = full; end;') { Fail "V124 renderAbilityLabels rebinds a dot without checking whether the binding changed" }
elseif ($setTxt -notmatch 'if c\.checked ~= want then c\.checked = want; end;') { Fail "V124 renderAbilityLabels reloads a dot without checking whether the state changed" }
else { Pass "V124 the dot rebind writes only what actually differs" }

# ---- V125: one walk of the ledger per click, shared by all three drawers -------------
# V108 said this when there were two drawers. There are three now: the log joined the two
# boxes, and it takes the rows rather than building them again.
if ($rootTxt -notmatch 'function xpSum\(rows\)') { Fail "V125 xpSum is missing - xpSpent cannot hand its rows to anyone" }
elseif ($rootTxt -notmatch 'function xpSpent\(\)\s*\r?\n\s*return xpSum\(xpLedgerRows\(\)\);') { Fail "V125 xpSpent does not total the rows through xpSum" }
else { Pass "V125 totalling is split from walking" }

$guardFn = [regex]::Match($rootTxt, 'function xpClick\(field, form\)(.*?)\n\t\t\tend;', 'Singleline')
if (-not $guardFn.Success) { Fail "V125 xpClick not found on the root form" }
else {
    $g = NoComments $guardFn.Groups[1].Value
    # The accepted path walks once. The refused path reads the restored state a second time -
    # the rows in hand describe the state being turned down, so they cannot be reused.
    $walks = @([regex]::Matches($g, 'xpLedgerRows\(\)')).Count
    if ($walks -gt 2) { Fail "V125 xpClick walks the ledger $walks times - one for the click, at most one more to read back a refused move" }
    elseif ($g -notmatch 'local spent = xpSum\(rows\);') { Fail "V125 xpClick does not total the rows it already built" }
    elseif ($g -notmatch 'renderAllXPBoxes\(form, spent\);') { Fail "V125 xpClick makes the boxes walk the ledger again" }
    elseif ($g -notmatch 'xpLedgerRefresh\(form, rows\);') { Fail "V125 xpClick does not hand its rows to the log" }
    else { Pass "V125 one walk per accepted click, shared by the boxes and the log" }
}
if ($ledgerTxt -notmatch 'function renderXPLedger\(node, rows\)') { Fail "V125 renderXPLedger does not accept rows - it always walks the ledger itself" }
elseif ($ledgerTxt -notmatch 'if rows == nil then rows = xpLedgerRows\(\); end;') { Fail "V125 renderXPLedger cannot build its own rows when called without them" }
else { Pass "V125 renderXPLedger takes the rows when the caller has them" }

# ---- V126: the theme art is not a third of the .rpk ---------------------------------
# The four papers were 1.10 MB of a 3.72 MB package. They go behind the content, stretched to
# fill a tab, so the pixels were never being read at that size.
$pngCap   = 120KB
$pngTotal = 400KB
$papers = @(Get-ChildItem -LiteralPath (Join-Path $dir "images") -Filter *.png)
$tooBig = @($papers | Where-Object { $_.Length -gt $pngCap })
$sum = ($papers | Measure-Object -Property Length -Sum).Sum
if ($tooBig) { foreach ($p in $tooBig) { Fail "V126 images/$($p.Name) is $([int]($p.Length/1KB)) KB, over the $([int]($pngCap/1KB)) KB ceiling" } }
elseif ($sum -gt $pngTotal) { Fail "V126 images/ totals $([int]($sum/1KB)) KB, over the $([int]($pngTotal/1KB)) KB budget" }
else { Pass "V126 all $($papers.Count) images fit the ceiling ($([int]($sum/1KB)) KB total)" }

# ---- V128: three managed tabs, and Magika is gone for good ---------------------------
# The user had the empty Magika window removed in the 39th round. Its field name stays burned
# (checked with the other orphans above): a sheet saved with it ticked still carries the value.
# 51st round: WoD20.12.lfm is BACK, this time as the Disciplines area of the Vampire tab (SPEC
# C, I16). The file NAME was only ever a proxy for "the Magika tab is gone"; what actually has
# to stay gone is the tab's IDENTITY. Kept as a name check it would now fail on a file that has
# nothing to do with Magika, so the proxy is replaced by the two things it stood for: no <tab>
# anywhere in the sheet is a Magika tab, and WoD20.12, if it is on disk at all, is the file WoD20.11
# imports for Disciplines rather than a name that came loose again.
$magikaTabs = @()
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//tab")) {
        $id = (("{0} {1}" -f $n.GetAttribute('name'), $n.GetAttribute('title'))).Trim()
        if ($id -match 'Magika') { $magikaTabs += "$($f.Name): $id" }
    }
}
if ($magikaTabs) { foreach ($m in $magikaTabs) { Fail "V128 a Magika tab is back - $m" } }
else { Pass "V128 no tab in the sheet is a Magika tab" }

$hh12 = Join-Path $dir "WoD20.12.lfm"
if (Test-Path $hh12) {
    $imp = @((Doc (Join-Path $dir "WoD20.11.lfm")).SelectNodes("//import") | ForEach-Object { $_.GetAttribute("file") })
    if ($imp -notcontains "WoD20.12.lfm") { Fail "V128 WoD20.12.lfm is on disk but WoD20.11 does not import it - the freed name came loose again" }
    else { Pass "V128 WoD20.12.lfm is the Vampire tab's Disciplines area, imported by WoD20.11" }
}
else { Pass "V128 WoD20.12.lfm is not on disk" }

$managed = @('tabNumina', 'tabDisciplines', 'tabStoryteller')
$magikaLeft = @($files | Where-Object { (CodeOf $_.FullName) -match '(tabMagika|stShowMagika|"Show Magika")' })
if ($magikaLeft) { foreach ($m in $magikaLeft) { Fail "V128 $($m.Name) still refers to the Magika tab" } }
else { Pass "V128 nothing refers to the Magika tab any more" }

$shownMap = [regex]::Match($rootTxt, 'local shown = \{(.*?)\};', 'Singleline')
if (-not $shownMap.Success) { Fail "V128 applyTabVisibility has no shown map" }
else {
    $keys = @([regex]::Matches($shownMap.Groups[1].Value, 'tab[A-Za-z]+') | ForEach-Object { $_.Value })
    $extra = @($keys | Where-Object { $managed -notcontains $_ })
    $miss  = @($managed | Where-Object { $keys -notcontains $_ })
    if ($extra) { Fail "V128 the shown map carries $($extra -join ', ') - not a managed tab" }
    elseif ($miss) { Fail "V128 the shown map is missing $($miss -join ', ')" }
    else { Pass "V128 exactly three managed tabs" }
}
$langMagika = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($langFile))
if ($langMagika -match 'wod\.(Magika|Show Magika)=') { Fail "V128 localization.lang still carries a Magika key" }
else { Pass "V128 the Magika keys are out of localization.lang" }

# ---- V129 + V130: the refusal that speaks, and the one that must not -----------------
# The pop-up is what made B36 and B38 findable: it proved the click reached the sheet's own
# code (SPEC R42) while the mark stayed anyway. The refusal now happens BEFORE the mark, so
# the message describes a sheet nothing was written to. It stays fenced to the balance
# branch: selling back a point the storyteller paid for (V103) is a different refusal, and a
# message naming the wrong reason is worse than one that never comes.
$guardFn = [regex]::Match($rootTxt, 'function xpClick\(field, form\)(.*?)\n\t\t\tend;', 'Singleline')
if (-not $guardFn.Success) { Fail "V129 xpClick not found on the root form" }
else {
    $g     = NoComments $guardFn.Groups[1].Value
    $buy   = [regex]::Match($g, 'if want then(.*?)else', 'Singleline')
    $warns = @([regex]::Matches($g, 'xpWarn\("([^"]*)"\)'))
    # Six refusals speak, and each one says its own reason: want of experience (this check),
    # the three a speciality row adds - no trait chosen, the storyteller allowing none
    # (SPEC V154/V156), a gift that is not the player's to drop - and the two a secondary path
    # adds: an empty row, and a dot above what its blood sorcery allows (SPEC V183). The count
    # is a census on purpose: a refusal added without coming here first turns this red.
    # What may NOT happen is a second voice inside the balance branch, or
    # the sale refusal of V103 growing one.
    $buyWarns = @([regex]::Matches($buy.Groups[1].Value, 'xpWarn\("([^"]*)"\)'))
    if (-not $buy.Success) { Fail "V129 xpClick has no purchase branch" }
    elseif ($warns.Count -ne 7) { Fail "V129 xpClick raises $($warns.Count) pop-ups - seven refusals speak: the balance, the empty trait, the closed door, the generation ceiling (SPEC V220), the gift that is not the player's to take off (SPEC V161), the secondary path row with nothing picked in it, and the secondary path above what its blood sorcery allows (SPEC V183)" }
    elseif ($buyWarns.Count -ne 1) { Fail "V129 the balance branch raises $($buyWarns.Count) pop-ups - only the refusal for want of experience may speak there" }
    elseif ($buy.Groups[1].Value -notmatch 'xpWarn\(') { Fail "V129 the refusal for want of experience says nothing" }
    elseif ($buy.Groups[1].Value -match 'markDot\(') { Fail "V129 the refused purchase marks the dot anyway (SPEC V135)" }
    else { Pass "V129 only the balance refusal speaks, and it speaks over a sheet nothing was written to" }
}

$warnFn   = LuaFn $rootTxt 'xpWarn'
$warnMsgs = @([regex]::Matches($rootTxt, 'xpWarn\("([^"]*)"\)') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)

# The picker guard does not hand xpWarn a literal: pickRefusal RETURNS the reason and
# guardPick passes it along (SPEC V181/V182/V185). Those are pop-up messages just the same,
# and a sweep that only saw xpWarn("...") would let every one of them skip V10/V28 - which is
# the exact hole this invariant exists to close. Missing pickRefusal is a failure, not a
# quiet zero: the guard being deleted must not read as "nothing left to check".
$refusalFn = LuaFn $rootTxt 'pickRefusal'
if (-not $refusalFn) { Fail "V130 pickRefusal not found on the root form - the picker refusals cannot be checked (SPEC V186)" }
else { $warnMsgs = @(($warnMsgs + @([regex]::Matches($refusalFn, 'return "([^"]*)"') | ForEach-Object { $_.Groups[1].Value })) | Sort-Object -Unique) }

if (-not $warnFn) { Fail "V130 xpWarn not found on the root form" }
elseif ($warnFn -notmatch 'translateSheetText\(') { Fail "V130 xpWarn shows its message untranslated - a [pt] sheet would read English (SPEC V70)" }
elseif ($warnFn -notmatch 'Dialogs\.showMessage\(') { Fail "V130 xpWarn opens no dialog - the refusal would stay silent" }
elseif ($warnMsgs.Count -eq 0) { Fail "V130 no pop-up message found - nothing tells the player why the dot came back" }
else {
    $badMsg = @()
    foreach ($m in $warnMsgs) {
        if (-not $enK.Contains($m)) { $badMsg += "'$m' has no [en] key - it is not authored English (SPEC V9)" }
        elseif (-not $ptK.Contains($m)) { $badMsg += "'$m' has no [pt] key" }
        elseif (-not $embedded.ContainsKey($m)) { $badMsg += "'$m' is absent from the PT map - it would never translate" }
    }
    if ($badMsg) { foreach ($b in $badMsg) { Fail "V130 $b (a string living only in Lua escapes the XML checks of V10/V28)" } }
    else { Pass "V130 all $($warnMsgs.Count) pop-up messages are English, keyed both ways and in the PT map" }
}

# ---- V131: no path leaves the character owing experience ----------------------------
# The guard only ever runs on a dot click, so the balance box was the way round it: a typed
# -5 wrote xpTotal = -5 + spent and the sheet came up owing (SPEC B35). Refused, not clamped -
# clamping would write xpTotal = Spent, and one mistyped minus sign would cost the player
# every point they had earned.
$setFn = LuaFn $rootTxt 'xpSetCurrent'
$boxFn = LuaFn $rootTxt 'xpPaint'
if (-not $setFn) { Fail "V131 xpSetCurrent not found on the root form" }
elseif ($setFn -notmatch 'if n < 0 then') { Fail "V131 xpSetCurrent takes any number it is handed - a typed -5 leaves the character owing (SPEC B35)" }
else {
    $refusal = [regex]::Match($setFn, 'if n < 0 then(.*?)end;', 'Singleline')
    if (-not $refusal.Success) { Fail "V131 the refusal branch of xpSetCurrent cannot be read" }
    elseif ($refusal.Groups[1].Value -match 'setField\("xpTotal"') { Fail "V131 the refused balance is written anyway" }
    elseif ($refusal.Groups[1].Value -notmatch 'return;') { Fail "V131 the refusal falls through and writes the negative balance below it" }
    elseif ($refusal.Groups[1].Value -notmatch 'xpWarn\(') { Fail "V131 the refused balance says nothing - the box would snap back with no reason given" }
    elseif (@([regex]::Matches($setFn, 'setField\("xpTotal"')).Count -ne 1) { Fail "V131 xpSetCurrent writes xpTotal more than once - V100 counts two writes in the file" }
    else { Pass "V131 a balance below zero is refused, not clamped, and says so" }
}
if (-not $boxFn) { Fail "V131 xpPaint not found on the root form" }
elseif ($boxFn -notmatch 'setField\("xpTotal", math\.max\(0,') { Fail "V131 the migration seed has no floor - an old sheet holding a negative experience value is born owing (SPEC I11)" }
else { Pass "V131 the one-shot migration cannot seed a negative balance" }

# ---- V133: a click repaints from the sheet ROOT, with nothing registered -------------
# Buying a dot never writes xpTotal (V100), so no dataLink wakes up and this call is the only
# thing that moves a number after a purchase. It used to reach the other tabs through a
# registry filled at onNodeReady - a promise nobody could see being kept, and silent when it
# was not (SPEC B39). Walking from the root needs no promise: what is on the sheet is found.
$boxAllFn = LuaFn $rootTxt 'renderAllXPBoxes'
$registry = @($files | Where-Object { (CodeOf $_.FullName) -match 'xpBoxForms|registerXPBoxes|xpLedgerForm' })
if ($registry) { foreach ($r in $registry) { Fail "V133 $($r.Name) still hands a form to a registry - a tab that never opened would leave the numbers stale (SPEC B39)" } }
elseif (-not $boxAllFn) { Fail "V133 renderAllXPBoxes not found on the root form" }
elseif ($boxAllFn -notmatch 'tabRootOf\(from\)') { Fail "V133 the click's repaint does not climb to the sheet root - only the clicked tab would follow" }
elseif ($guardFn -notmatch 'renderAllXPBoxes\(form') { Fail "V133 xpClick does not repaint from the form that was clicked" }
elseif ($guardFn -match 'renderXPBoxes\(form') { Fail "V133 the guard paints only the form the dot lives on - a numina purchase would move no number (SPEC B37)" }
elseif ((LuaFn $rootTxt 'xpSetCurrent') -notmatch 'renderAllXPBoxes\(form\)') { Fail "V133 a typed balance never repaints - the box would keep the number that was refused (SPEC V131)" }
elseif ((LuaFn $rootTxt 'xpSetCurrent') -match 'renderXPBoxes\(') { Fail "V133 a typed balance repaints one tab only - the balance is drawn twice and the other copy would sit on the old number (SPEC I11)" }
else { Pass "V133 a click and a typed balance both repaint from the sheet root, with nothing registered" }

# Both tabs that carry boxes must still be reachable BY NAME from a walk: the names are what
# the painter matches on, so a rename here is what would quietly stop the repaint.
$boxFiles = @()
foreach ($bf in $files) {
    if ($bf.Name -eq 'WoD20th.lfm') { continue }
    $bd = Doc $bf.FullName
    if (@($bd.SelectNodes("//edit[starts-with(@name,'edtTotalXP') or starts-with(@name,'edtSpentXP') or starts-with(@name,'edtCurrentXP')]")).Count -gt 0) { $boxFiles += $bf }
}
$boxNames = @()
foreach ($bf in $boxFiles) {
    foreach ($n in (Doc $bf.FullName).SelectNodes("//edit[starts-with(@name,'edtTotalXP') or starts-with(@name,'edtSpentXP') or starts-with(@name,'edtCurrentXP')]")) { $boxNames += $n.GetAttribute("name") }
}
$unpainted = @($boxNames | Where-Object { $paintFn -notmatch [regex]::Escape($_) })
if ($boxFiles.Count -lt 2) { Fail "V133 expected two tabs carrying experience boxes, found $($boxFiles.Count)" }
elseif ($unpainted) { foreach ($u in $unpainted) { Fail "V133 box '$u' is on the sheet but the painter never names it - it would never follow a purchase" } }
else { Pass "V133 all $($boxNames.Count) boxes across $($boxFiles.Count) tabs are named by the painter" }

# ---- V142: a click's repaint is never silenced -----------------------------------------
# xpQuiet exists so the sheet's OWN writes do not drag a repaint along (V107). A player's
# click is not one of those, and a flag left stuck true would otherwise mute every number on
# the sheet for the rest of the session with nothing on screen to say so (SPEC B39).
if (-not $paintFn) { Fail "V142 xpPaint not found on the root form" }
elseif ($paintFn -match 'xpQuiet then return') { Fail "V142 the painting core stands down on xpQuiet - a stuck flag would mute the sheet (SPEC B39)" }
elseif ($boxAllFn -match 'xpQuiet') { Fail "V142 the click's repaint asks xpQuiet - a click is not a batch of the sheet's own writes" }
elseif ($boxesFn -notmatch 'if xpQuiet then return') { Fail "V142 the dataLink entry does not stand down - the load would repaint per write (SPEC V107/B30)" }
else { Pass "V142 the click paints unconditionally, and only the dataLink entry stands down" }

# ---- V143: one way to find a control by name -------------------------------------------
# form.<name> does not cross an <import> (SPEC B9), which is the whole reason a registry
# existed. One walker serves the boxes and the log; a second one would be a second answer to
# the same question, and the two would drift.
$finders = @([regex]::Matches($rootTxt, 'function xpFind\('))
$ledgerUsesFind = ((CodeOf (Join-Path $dir "WoD20.9.lfm")) -match 'xpFind\(node, XP_LOG')
if ($finders.Count -ne 1) { Fail "V143 xpFind is declared $($finders.Count) times on the root form - exactly one walker" }
elseif ($rootTxt -notmatch 'xpFind\(node, XP_BOXES, \{\}\)') { Fail "V143 the box painter does not find its controls through xpFind" }
elseif (-not $ledgerUsesFind) { Fail "V143 WoD20.9 does not find its columns through xpFind - a second way to reach a control by name" }
elseif ((CodeOf (Join-Path $dir "WoD20.9.lfm")) -match 'function renderXPLedger\(node, rows\)[\s\S]{0,400}?form\.dynXpType\.text' -and (CodeOf (Join-Path $dir "WoD20.9.lfm")) -notmatch 'local form = xpFind') { Fail "V143 WoD20.9 still addresses its columns off a form handed to it" }
else { Pass "V143 one walker finds every control by name, for both the boxes and the log" }

# ---- V144: the storyteller's notes are the storyteller's ------------------------------
# Two boxes that look exactly like the player's, on fields of their own. Pointing one of
# them at anotacoes* would put what the storyteller wrote inside the player's Notes tab -
# two owners of one text (V1), and the tab being hidden would stop hiding anything.
#
# THREE until the 82nd round, when the settings box took the third column (SPEC I35) and
# stNotes3 became an orphan. The count going 3 -> 2 is not the check getting weaker: the
# field pattern below narrows to stNotes1..2, so the retired name coming back anywhere -
# here or on another tab - is now a failure rather than a pass (SPEC I3, V2).
$stDocPath = Join-Path $dir "WoD20.10.lfm"
$hh5Path   = Join-Path $dir "WoD20.5.lfm"
$stNoteFields = @((Doc $stDocPath).SelectNodes("//textEditor[@field]") | ForEach-Object { $_.GetAttribute("field") })
$stElsewhere  = @()
foreach ($nf in $files) {
    if ($nf.Name -eq 'WoD20.10.lfm') { continue }
    foreach ($n in (Doc $nf.FullName).SelectNodes("//*[@field]")) {
        if ($n.GetAttribute("field") -match '^stNotes\d$') { $stElsewhere += "$($nf.Name)/$($n.GetAttribute('field'))" }
    }
}
$playerNotes = @((Doc $hh5Path).SelectNodes("//textEditor[@field]") | ForEach-Object { $_.GetAttribute("field") })
$crossed = @($stNoteFields | Where-Object { $playerNotes -contains $_ })
if ($stNoteFields.Count -ne 2) { Fail "V144 WoD20.10 carries $($stNoteFields.Count) note box(es) - the storyteller was left two when the settings box took the third column (SPEC I35)" }
elseif (@($stNoteFields | Sort-Object -Unique).Count -ne 2) { Fail "V144 the two storyteller note boxes share a field - one of them would never be read back" }
elseif ($crossed) { foreach ($c in $crossed) { Fail "V144 WoD20.10 note box owns '$c', which is the player's on WoD20.5 - the storyteller's text would show up in the player's Notes tab (SPEC V1)" } }
elseif (@($stNoteFields | Where-Object { $_ -notmatch '^stNotes[12]$' })) { Fail "V144 a storyteller note box is on a field outside stNotes1..2 - stNotes3 is an ORPHAN since the 82nd round and the name may never be reused (SPEC I3, V2)" }
elseif ($stElsewhere) { foreach ($s in $stElsewhere) { Fail "V144 $s - a storyteller field is owned outside WoD20.10, where a player can reach it" } }
else { Pass "V144 the storyteller's two notes own their own fields, and no tab shares them ($($stNoteFields -join ', '))" }

# ---- V145: one place says how many backgrounds there are -------------------------------
# The XML draws the rows, two loops on the root form walk them - one to let experience buy a
# background, one to price it for the log. The count was a literal `9` in both until the 46th
# round doubled it. A row added to the XML and to neither loop is a background nothing
# charges for and nothing shows in the log: free, and invisible.
#
# 87th round: the last five rows are TYPED (SPEC I50, V255), so the census counts both
# templates. A typed background is still a background - same five dots, same prices - and
# the two loops still walk all twenty of them.
$bgLoops   = @([regex]::Matches($rootTxt, 'for i = 1, BACKGROUND_ROWS, 1 do'))
$bgLiteral = @([regex]::Matches($rootTxt, 'for i = 1, \d+, 1 do[^\r\n]*background'))
$bgXml     = @()
foreach ($bf in $files) {
    foreach ($n in (Doc $bf.FullName).SelectNodes("//OpenAbility[@field] | //OpenAbilityFreeRow[@field]")) {
        if ($n.GetAttribute("field") -match '^background_(\d+)$') { $bgXml += [int]$Matches[1] }
    }
}
$bgMax = if ($bgXml.Count -gt 0) { ($bgXml | Measure-Object -Maximum).Maximum } else { 0 }
if ($bgRows -lt 1) { Fail "V145 BACKGROUND_ROWS is not declared - the count would be a literal in every loop again" }
elseif ($bgLoops.Count -ne 2) { Fail "V145 $($bgLoops.Count) of the two background loops read BACKGROUND_ROWS - the other one is carrying its own copy of the number" }
elseif ($bgLiteral.Count -gt 0) { Fail "V145 a background loop still counts to a literal - the XML and the ledger would drift apart" }
elseif ($bgXml.Count -ne $bgRows) { Fail "V145 the XML draws $($bgXml.Count) background row(s) but BACKGROUND_ROWS says $bgRows - the extra rows cost nothing and never reach the log" }
elseif ($bgMax -ne $bgRows) { Fail "V145 the background rows run up to background_$bgMax with BACKGROUND_ROWS at $bgRows - the loops walk 1..$bgRows and would miss it" }
elseif (@($bgXml | Sort-Object -Unique).Count -ne $bgRows) { Fail "V145 two background rows carry the same field - one of them would never be read back (SPEC V1)" }
else { Pass "V145 $bgRows background rows, one declared count, both loops reading it" }

# ---- V135: priced first, marked only if it is allowed --------------------------------
# The dot cannot flip itself any more (V134), so the order inside xpClick IS the rule: work
# out what the click is asking for, price the sheet as it WOULD be, and only then write. The
# three rounds before this one all let the mark land and tried to take it back, and a write
# made from inside the dot's own onChange never survived the dispatch (SPEC B36/B38).
$clickFn = [regex]::Match($rootTxt, 'function xpClick\(field, form\)(.*?)\n\t\t\tend;', 'Singleline')
$markFn  = LuaFn $rootTxt 'markDot'
if (-not $clickFn.Success) { Fail "V135 xpClick not found on the root form" }
else {
    $c     = NoComments $clickFn.Groups[1].Value
    $iPr   = $c.IndexOf('xpLedgerRows(field, want, key, want and okey or nil)')
    $iMark = $c.LastIndexOf('markDot(form, field, want)')
    $marks = @([regex]::Matches($c, 'markDot\('))
    if ($c -notmatch 'local want = not \(sheet\[field\] == true\);') { Fail "V135 xpClick never works out what the click is asking for - with autoChange off, nothing else does" }
    elseif ($c -match 'if undo then') { Fail "V135 xpClick still has an undo branch - a mark taken back does not stick (SPEC B36/B38)" }
    elseif ($iPr -lt 0) { Fail "V135 xpClick does not price the click before deciding" }
    elseif ($iMark -lt $iPr) { Fail "V135 xpClick marks the dot before it prices the click (SPEC B38)" }
    elseif ($marks.Count -ne 3) { Fail "V135 xpClick marks the dot in a place it should not - exactly three marks: no baseline, nothing to price, and the one the rules allowed" }
    else { Pass "V135 the click is priced first and marked only if the rules allow it" }
}
if (-not $markFn) { Fail "V135 markDot not found on the root form" }
elseif ($markFn -notmatch 'setField\(field, v\);') { Fail "V135 markDot does not write the field - the mark would not be saved" }
elseif ($markFn -notmatch 'findDot\(form, field\)') { Fail "V135 markDot never looks the dot up" }
elseif ($markFn -notmatch 'dot\.checked = v;') { Fail "V135 markDot does not paint the dot - with autoChange off nothing else will" }
else { Pass "V135 the accepted mark writes the field and paints the dot in one step" }

# ---- V136: pricing a click writes nothing ---------------------------------------------
# The ledger is asked what the sheet WOULD cost, and it answers without touching it. The
# simulation is switched on after the baseline check and put away before the only way out,
# so no later price can carry a click that has already been answered.
$rowsSim = LuaFn $rootTxt 'xpLedgerRows'
$liveFn  = LuaFn $rootTxt 'liveLevel'
if (-not $rowsSim) { Fail "V136 xpLedgerRows not found on the root form" }
elseif ($rowsSim -notmatch 'function xpLedgerRows\(clickField, clickValue, clickFree, clickOrder\)') { Fail "V136 xpLedgerRows cannot be handed a pending click" }
elseif ($rowsSim -notmatch 'simField, simValue = clickField, clickValue;') { Fail "V136 the pending click is never put in front of the ledger" }
elseif ($rowsSim -notmatch 'simTrait, simField, simValue = nil, nil, nil;') { Fail "V136 the simulation is never cleared - a later price would carry an answered click" }
elseif ($rowsSim.IndexOf('simTrait, simField, simValue = nil, nil, nil;') -gt $rowsSim.IndexOf('return rows;')) { Fail "V136 the simulation is cleared after the ledger has returned, which is never" }
elseif ($rowsSim -match 'traitLevel\(sheet,') { Fail "V136 the ledger still reads the live sheet directly - that read would miss the pending click" }
elseif ($rowsSim -match 'setField\(') { Fail "V136 pricing a click writes to the sheet (SPEC B38)" }
else { Pass "V136 the click is priced by simulation, and the simulation is put away before the ledger returns" }
if (-not $liveFn) { Fail "V136 liveLevel not found on the root form" }
elseif ($liveFn -notmatch 'traitLevel\(sheet, base, first, last, fixed\)') { Fail "V136 liveLevel does not read the sheet through traitLevel (SPEC V85)" }
elseif ($liveFn -notmatch 'if simTrait == base') { Fail "V136 liveLevel would apply the pending click to a trait it does not belong to" }
else { Pass "V136 the live side is traitLevel plus at most the one dot being clicked" }

# ---- V137: Free dots is read at the click, and nowhere else --------------------------
# "Free only if the box was ticked at the MOMENT of purchase" is not a rule anyone has to
# remember while editing: it holds because nothing except xpClick can see the flag. A
# renderer that read it would re-price the past every time the storyteller changed their
# mind, which is the lens the 31st round shipped and the user rejected (SPEC V105).
$flagReads = @()
foreach ($ff in $files) {
    foreach ($m in [regex]::Matches((CodeOf $ff.FullName), '(?<!field=")stFreeBuy')) { $flagReads += $ff.Name }
}
if ($flagReads.Count -ne 1) { Fail "V137 stFreeBuy is read in $($flagReads.Count) place(s) ($($flagReads -join ', ')) - exactly one, inside xpClick" }
elseif ($flagReads[0] -ne 'WoD20th.lfm') { Fail "V137 stFreeBuy is read from $($flagReads[0]) - the flag belongs to the click, not to a tab" }
elseif ($clickFn.Groups[1].Value -notmatch 'local free = want and sheet\.stFreeBuy == true;') { Fail "V137 xpClick does not read the flag at the click - the answer would come from somewhere else in time" }
else { Pass "V137 Free dots is read once, at the click, and by nothing else" }

# ---- V138: the stamp holds names, keyed by the rating REACHED ------------------------
# strength_5 clicked with two dots lit is level 3, and the log asks for the level, not for
# the dot - keying off the clicked field is what made the 34th round charge for points it
# had stamped (SPEC B31). '#' keeps a key from ever reading as a field name. The burned
# names stay burned: sheets from the 31st..37th rounds carry `freeDots` written under two
# incompatible schemes, and reviving it would zero the cost of whichever dot it happened to
# name (SPEC I3, V2).
$burnedUse  = @($files | Where-Object { (CodeOf $_.FullName) -match 'stFreeDots|freeDots' })
$freeWrites = @([regex]::Matches($rootTxt, 'setField\("xpFree"'))
# A tab may WATCH the stamps - WoD20.1 locks its rows off them (SPEC V164) - but naming the
# field in any other way outside the root form means a second owner of the gift.
#
# Only the `field=` attribute is dropped, not the whole tag: a handler written inside that
# same tag (onChange="setField('xpFree', ...)") is exactly the write this forbids, and
# stripping the element wholesale would have hidden it.
$freeElse   = @($files | Where-Object { $_.Name -ne 'WoD20th.lfm' -and ([regex]::Replace((CodeOf $_.FullName), '<dataLink field="xpFree"', '<dataLink')) -match 'xpFree' })
if ($burnedUse) { Fail "V138 $(($burnedUse | ForEach-Object { $_.Name }) -join ', ') names a burned field (stFreeDots/freeDots) - an old sheet would resurrect stamps under a scheme nothing reads any more (SPEC I3)" }
elseif ($freeElse) { Fail "V138 xpFree is touched outside the root form ($(($freeElse | ForEach-Object { $_.Name }) -join ', ')) - the stamp belongs to the click" }
elseif ($freeWrites.Count -ne 4) { Fail "V138 xpFree is written in $($freeWrites.Count) place(s) - exactly four: the stamp a free purchase leaves, the one a sale takes away, the gift given, and the gift revoked (SPEC V152/V159)" }
elseif ((LuaFn $rootTxt 'grantSpeciality') -notmatch 'setField\("xpFree"') { Fail "V138 the gift leaves no stamp - the free line would be charged on the next render" }
elseif ((LuaFn $rootTxt 'revokeSpeciality') -notmatch 'setField\("xpFree"') { Fail "V138 the revoked gift keeps its stamp - the row would stay locked with nothing in it (SPEC V159)" }
elseif ($clickFn.Groups[1].Value -notmatch 'trait \.\. "#" \.\. \(level \+ 1\)') { Fail "V138 the stamp is not keyed off the rating the click REACHES (SPEC B31)" }
elseif ($rowsSim -notmatch 'free\s+= \(sheet\.xpFree or ""\) \.\. "\|" \.\. \(clickFree or ""\) \.\. "\|"') { Fail "V138 the ledger never reads the stamps - every point would be priced as if the box had never been ticked" }
else { Pass "V138 the stamp keeps names keyed by the rating reached, and no burned name is back" }

# ---- V139: a stamp DISCOUNTS a price the table worked out ----------------------------
# Not a second cost table (SPEC V86): xpCost prices the point and the stamp zeroes it after
# the fact. That is also what stops a free point from making the next one cheaper - the
# price still reads the rating reached, never how many points were paid for.
$riseFn    = LuaFn $rootTxt 'pushRise'
$riseCalls = @([regex]::Matches($rootTxt, 'ctx, (field|"humanity"|"willpower"|"faith")\);'))
# Derived, not a literal: the 51st round took the ledger from ten row groups to thirteen,
# and a number typed here would have to be edited by hand every time a box is added.
$riseTotal = @([regex]::Matches($rootTxt, [regex]::Escape('pushRise(rows, "'))).Count
if (-not $riseFn) { Fail "V139 pushRise not found on the root form" }
elseif ($riseFn -notmatch 'function pushRise\(rows, kind, name, from, to, ctx, field\)') { Fail "V139 pushRise cannot tell which trait the row belongs to - it could not read a stamp" }
elseif ($riseFn -notmatch 'local cost = xpCost\(kind, lvl - 1, ctx\);') { Fail "V139 pushRise no longer prices the row through xpCost (SPEC V86)" }
elseif ($riseFn -notmatch 'string\.find\(ctx\.free, "\|" \.\. field \.\. "#" \.\. lvl \.\. "\|", 1, true\)') { Fail "V139 pushRise does not look the row's level up in the stamps" }
elseif ($riseFn.IndexOf('string.find(ctx.free') -lt $riseFn.IndexOf('local cost = xpCost(')) { Fail "V139 the discount lands before the price exists - it must zero a cost the table already worked out (SPEC V86)" }
elseif ($riseCalls.Count -ne $riseTotal) { Fail "V139 $($riseTotal - $riseCalls.Count) ledger row group(s) do not hand pushRise their field - one that does not could never go free" }
else { Pass "V139 all ten row groups carry their field, and a stamp zeroes a price xpCost worked out" }

# ---- V140: the stamp goes down with the mark, never on a refusal ---------------------
# Pricing writes nothing (V136), so the stamp reaches the sheet only after the rules have
# said yes, in the same pass as the mark. A free point skips the balance test outright
# rather than passing it on the arithmetic: `spent` does not move, but a sheet the
# storyteller has already put in the red - by charging for backgrounds after the fact -
# would refuse a point that costs nothing (SPEC C, 40th round).
$cc      = NoComments $clickFn.Groups[1].Value
$iStamp  = $cc.IndexOf('setField("xpFree"')
$iMarkOk = $cc.LastIndexOf('markDot(form, field, want)')
$buyBr   = [regex]::Match($cc, 'if want then(.*?)else', 'Singleline')
if ($iStamp -lt 0) { Fail "V140 xpClick never writes the stamp - a free point would be charged again on the next render" }
elseif ($iStamp -lt $iMarkOk) { Fail "V140 the stamp is written before the mark - a refused click would leave one behind (SPEC V135)" }
elseif (-not $buyBr.Success) { Fail "V140 xpClick has no purchase branch" }
elseif ($buyBr.Groups[1].Value -notmatch 'if not free and') { Fail "V140 a free purchase is put through the balance test - a sheet already in the red would refuse a point that costs nothing" }
elseif ($buyBr.Groups[1].Value -match 'setField\(') { Fail "V140 the purchase branch writes before the decision is made (SPEC V135)" }
else { Pass "V140 the stamp goes down with the mark, and a free point never meets the balance" }

# ---- V141: selling a point takes its stamp with it -----------------------------------
# The rule is about the moment of purchase, so a point sold and bought again obeys the flag
# of the NEW click. One key, not a sweep: a sale drops the rating by one and V103 forbids
# going below the frozen character, so no stamp can be left stranded above the rating.
if ($cc -notmatch 'elseif not want and sheet\.xpFree ~= nil then') { Fail "V141 a sale never reaches the stamps - a sold point would come back free" }
elseif ($cc -notmatch 'string\.gsub\(sheet\.xpFree, "\|" \.\. trait \.\. "#" \.\. level \.\. "\|", "\|"\)') { Fail "V141 the sale does not drop the stamp of the level it gave up" }
else { Pass "V141 a sold point hands its stamp back" }

# ---- V146: the speciality box has no coordinates of its own -------------------------
# It took the corner BACKGROUNDS emptied in the 46th round and shipped in the 47th with
# 890..1210 x 510..810 written into this check. The 50th round moved it again - the second
# time a literal here had to be hand-edited - so where the box SITS is now measured against
# KNOWLEDGES above it (V168) and the tab's closing line (V69). What stays here is what only
# this box knows: how many rows fit down, and whether one row still fits across.
#
# 82nd round: it hangs from SKILLS now, not KNOWLEDGES - the user had it trade places with
# HEALTH (item 14). Only the column name in the V168 map moved: both boxes are 290 wide on
# the same top, so nothing this check measures changed with them.
function BoxOf($doc, $title) { @($doc.SelectNodes("//layout[label/@text='$title']"))[0] }
$mainDoc = Doc (Join-Path $dir "WoD20.1.lfm")
$sb = BoxOf $mainDoc "SPECIALTIES"
$specTpl = @($mainDoc.SelectNodes("//template[@name='SpecialityRow']"))[0]
if (-not $sb) { Fail "V146 WoD20.1 declares no SPECIALTIES box - the tab's map says exactly one" }
elseif (-not $specTpl) { Fail "V146 SpecialityRow is not declared on WoD20.1" }
else {
    $sbW = [int]$sb.GetAttribute("width"); $sbH = [int]$sb.GetAttribute("height")
    $sRows = @($sb.SelectNodes("layout[SpecialityRow] | layout[SpecialityFreeRow]"))
    $sTops = @($sRows | ForEach-Object { [int]$_.GetAttribute("top") } | Sort-Object)
    $sLefts = @($sRows | ForEach-Object { [int]$_.GetAttribute("left") } | Sort-Object -Unique)
    $sWide = @($sRows | ForEach-Object { [int]$_.GetAttribute("width") } | Sort-Object -Unique)
    $sPitchBad = 0
    for ($i = 1; $i -lt $sTops.Count; $i++) { if (($sTops[$i] - $sTops[$i - 1]) -ne 30) { $sPitchBad++ } }
    # The row is measured as a SUM, not as an extent: with the widgets laid end to end,
    # each has to start at or after the one before it ends, and the last has to close on
    # the row. The first cut of this check took the furthest right edge instead, and a
    # mutation that widened the text field straight through the dot survived it green
    # (SPEC V20, B7) - the dot was still the right-most thing, it just had the edit
    # sitting on top of it.
    $rowCells = @()
    foreach ($w in $specTpl.ChildNodes) {
        if ($w.NodeType -ne 'Element') { continue }
        $wl = 0; $ww = 0
        if ([int]::TryParse($w.GetAttribute("left"), [ref]$wl) -and [int]::TryParse($w.GetAttribute("width"), [ref]$ww)) {
            $rowCells += [pscustomobject]@{ L = $wl; R = $wl + $ww; N = $w.LocalName }
        }
    }
    $rowCells = @($rowCells | Sort-Object L)
    $rowOverlap = @()
    for ($i = 1; $i -lt $rowCells.Count; $i++) {
        if ($rowCells[$i].L -lt $rowCells[$i - 1].R) { $rowOverlap += "$($rowCells[$i - 1].N) ends at $($rowCells[$i - 1].R) but $($rowCells[$i].N) starts at $($rowCells[$i].L)" }
    }
    $rowSpan = if ($rowCells.Count -gt 0) { $rowCells[-1].R } else { 0 }
    if ($sRows.Count -ne $spRows) { Fail "V146 SPECIALTIES draws $($sRows.Count) row(s) with SPECIALITY_ROWS at $spRows" }
    elseif ($sTops[0] -ne 31) { Fail "V146 the first speciality row starts at $($sTops[0]), not under the title at 31 - the title moved 4 -> 10 when every box went to a 10/10 gap (SPEC I40, V240)" }
    elseif ($sPitchBad -gt 0) { Fail "V146 $sPitchBad speciality row(s) break the pitch of 30 - the box would not hold $spRows of them" }
    elseif (($sTops[-1] + 25) -gt $sbH) { Fail "V146 the last speciality row ends at $($sTops[-1] + 25), past a box $sbH tall" }
    elseif ($sLefts.Count -ne 1 -or $sWide.Count -ne 1) { Fail "V146 the speciality rows do not share one left/width - one row would sit differently from its neighbours" }
    elseif ($sWide[0] -ne ($sbW - 2 * $sLefts[0])) { Fail "V146 the rows are $($sWide[0]) wide at left $($sLefts[0]) in a $sbW box - the right margin no longer matches the left" }
    elseif ($rowOverlap.Count -gt 0) { Fail "V146 SpecialityRow widgets sit on each other - $($rowOverlap -join '; ') - a narrower box needs the row refitted, not the widgets stacked" }
    elseif ($rowSpan -ne $sWide[0]) { Fail "V146 SpecialityRow spans $rowSpan in a row $($sWide[0]) wide - narrowing the box without refitting the row leaves the dot short of the edge or past it" }
    else { Pass "V146 SPECIALTIES holds $($sRows.Count) rows and its row spans exactly the $rowSpan it is given" }
}

# ---- V147: three fields and one dot per row, counted in one place --------------------
# Same shape as BACKGROUND_ROWS (V145): the XML draws the rows and two loops on the root form
# walk them - one to let experience buy the row, one to price it for the log. A tenth row
# added to the XML alone would be a speciality nothing charges for and nothing shows.
$specXmlRows = @()
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//SpecialityRow[@num] | //SpecialityFreeRow[@num]")) { $specXmlRows += [int]$n.GetAttribute("num") }
}
$specMax     = if ($specXmlRows.Count -gt 0) { ($specXmlRows | Measure-Object -Maximum).Maximum } else { 0 }
$specLoops   = @([regex]::Matches($rootTxt, 'for i = 1, SPECIALITY_ROWS, 1 do'))
$specLiteral = @([regex]::Matches($rootTxt, 'for i = 1, \d+, 1 do[^\r\n]*speciality'))
$specFldBad  = @()
if ($spRows -ge 1) {
    for ($i = 1; $i -le $spRows; $i++) {
        foreach ($fld in @("speciality_$i", "specialityName_$i", "speciality_${i}_1")) {
            if (-not $allFields.ContainsKey($fld)) { $specFldBad += "$fld is not owned by any widget" }
            elseif ($allFields[$fld].Count -ne 1) { $specFldBad += "$fld has $($allFields[$fld].Count) owners (SPEC V1)" }
        }
    }
}
if ($spRows -lt 1) { Fail "V147 SPECIALITY_ROWS is not declared - the count would be a literal in every loop" }
elseif ($specLoops.Count -lt 3) { Fail "V147 only $($specLoops.Count) loop(s) read SPECIALITY_ROWS over its full range - the three that walk every row are declareTrait, the ledger and freeRowOf; the lock and the gift stop at the picker rows since the 87th round (SPEC I50, V255d)" }
elseif ($specLiteral.Count -gt 0) { Fail "V147 a speciality loop still counts to a literal - the XML and the ledger would drift apart" }
elseif ($specXmlRows.Count -ne $spRows) { Fail "V147 the XML draws $($specXmlRows.Count) speciality row(s) but SPECIALITY_ROWS says $spRows" }
elseif ($specMax -ne $spRows) { Fail "V147 the speciality rows run up to num=$specMax with SPECIALITY_ROWS at $spRows - the loops walk 1..$spRows and would miss it" }
elseif (@($specXmlRows | Sort-Object -Unique).Count -ne $spRows) { Fail "V147 two speciality rows carry the same num - they would share their fields (SPEC V1)" }
elseif ($specFldBad.Count -gt 0) { foreach ($b in $specFldBad) { Fail "V147 $b" } }
else { Pass "V147 $spRows speciality rows, three owned fields each, one declared count read by both loops" }

# ---- V148: the trait picker is the two Lua tables, not a third copy of them ----------
# The grant writes a canonical trait NAME into the combo (V152), so a name the picker does not
# carry is a value the player would see as blank. Both directions are checked: an era ability
# added to ABILITY_FIELD and not to the picker, and an item in the picker that names no trait,
# are the same failure from either end (SPEC B23/B24).
$attrBlk = [regex]::Match($rootTxt, 'local XP_ATTRS = \{(.*?)\};', 'Singleline')
$abilBlk = [regex]::Match($rootTxt, 'ABILITY_FIELD = \{(.*?)\n\t\t\t\};', 'Singleline')
$mainRaw =[System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.1.lfm")))
$pickBlk = [regex]::Match($mainRaw, '<template name="SpecialityRow">(.*?)</template>', 'Singleline')
if (-not $attrBlk.Success) { Fail "V148 XP_ATTRS not found on the root form" }
elseif (-not $abilBlk.Success) { Fail "V148 ABILITY_FIELD not found on the root form" }
elseif (-not $pickBlk.Success) { Fail "V148 the SpecialityRow template is not in WoD20.1" }
else {
    $luaNames = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
    foreach ($m in [regex]::Matches($attrBlk.Groups[1].Value, '\{"([^"]+)", "[^"]+"\}')) { [void]$luaNames.Add($m.Groups[1].Value) }
    foreach ($m in [regex]::Matches($abilBlk.Groups[1].Value, '\["([^"]+)"\]\s*=\s*"[^"]+"')) { [void]$luaNames.Add($m.Groups[1].Value) }

    # Lua x Lua now, not XML x Lua: the trait list moved to PICKER_LIST (SPEC I27, V148).
    # items and values are ONE authored list there, so the pair cannot fall out of step by
    # construction - what is still worth proving is that it matches the two Lua tables.
    $pickItems = @($PICKER['speciality'])
    $pickVals  = @($PICKER['speciality'])
    $itemsAttr = [pscustomobject]@{ Success = ($pickItems.Count -gt 0) }
    $valsAttr  = [pscustomobject]@{ Success = ($pickVals.Count -gt 0) }
    $pickSet   = @($pickItems | Where-Object { $_ -ne '' })

    $missPick = @($luaNames | Where-Object { $pickSet -notcontains $_ })
    $missLua  = @($pickSet | Where-Object { -not $luaNames.Contains($_) })
    if (-not $itemsAttr.Success -or -not $valsAttr.Success) { Fail "V148 PICKER_LIST has no 'speciality' list - the trait picker offers nothing (SPEC I27, V211a)" }
    elseif ($pickItems.Count -ne $pickVals.Count) { Fail "V148 the trait picker shows $($pickItems.Count) items for $($pickVals.Count) values - one of them would save nothing" }
    elseif ($missPick.Count -gt 0) { foreach ($m in $missPick) { Fail "V148 '$m' is a trait in Lua and not in the picker - a grant on it would write a value the combo cannot show" } }
    elseif ($missLua.Count -gt 0) { foreach ($m in $missLua) { Fail "V148 '$m' is in the picker and names no trait - picking it would buy a speciality of nothing" } }
    else { Pass "V148 the trait picker carries exactly the $($pickSet.Count) traits XP_ATTRS and ABILITY_FIELD name" }
}

# ---- V149: which trait gives a speciality, and at which rating ------------------------
# SPEC_TRAIT is DERIVED from the same two tables the picker is checked against, so the fifty
# names exist once. Only the five abilities the book hands a speciality to at the first dot
# are named here - and naming them is also what stops them getting a second one at four.
$specTblBlk = [regex]::Match($rootTxt, 'SPEC_TRAIT = \{\};(.*?)XP_TRAIT = \{\};', 'Singleline')
if (-not $specTblBlk.Success) { Fail "V149 SPEC_TRAIT is not declared on the root form" }
else {
    $st = $specTblBlk.Groups[1].Value
    $stQuoted = @([regex]::Matches($st, '"([^"]+)"') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
    $wantFive = @('academics', 'crafts', 'expression', 'performance', 'technology')
    if ($st -notmatch 'for i = 1, #XP_ATTRS, 1 do SPEC_TRAIT') { Fail "V149 SPEC_TRAIT does not read the attributes off XP_ATTRS" }
    elseif ($st -notmatch 'for name, field in pairs\(ABILITY_FIELD\) do SPEC_TRAIT') { Fail "V149 SPEC_TRAIT does not read the abilities off ABILITY_FIELD" }
    elseif ($st -notmatch 'free = 4') { Fail "V149 nothing grants a speciality at four - that is the rule for every trait but five" }
    elseif ($st -notmatch 'free = 1') { Fail "V149 nothing grants a speciality at one - the five abilities that do would get nothing" }
    elseif (Compare-Object $stQuoted $wantFive) { Fail "V149 SPEC_TRAIT names [$($stQuoted -join ', ')] - it must name the five one-dot abilities and nothing else, or the fifty are typed out twice" }
    else { Pass "V149 SPEC_TRAIT is derived from the two tables, with five abilities granting at one and the rest at four" }
}

# ---- V150 + V158: the gift moves with the click, both ways, and with nothing else -----
# No observer, no sweep at load (V121). Two call sites, both inside xpClick - the character
# being built and the click the rules allowed - and each of them asks ONE question, so the
# rise and the fall cannot drift apart (SPEC V158).
$grantFn      = LuaFn $rootTxt 'grantSpeciality'
$revokeFn     = LuaFn $rootTxt 'revokeSpeciality'
$movedFn      = LuaFn $rootTxt 'specialityMoved'
$movedInClick = @([regex]::Matches($cc, 'specialityMoved\('))
$specOutside  = @()
foreach ($f in $files) {
    if ($f.Name -eq 'WoD20th.lfm') { continue }
    $raw = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    if ($raw -match 'grantSpeciality|revokeSpeciality|specialityMoved') { $specOutside += $f.Name }
}
$grantTotal  = @([regex]::Matches($rootTxt, 'grantSpeciality\('))
$revokeTotal = @([regex]::Matches($rootTxt, 'revokeSpeciality\('))
if (-not $grantFn) { Fail "V150 grantSpeciality not found on the root form" }
elseif (-not $revokeFn) { Fail "V158 revokeSpeciality not found on the root form - a gift could never be lost" }
elseif (-not $movedFn) { Fail "V158 specialityMoved not found - the two directions would each need their own call site" }
elseif ($movedInClick.Count -ne 2) { Fail "V158 xpClick asks specialityMoved $($movedInClick.Count) time(s) - once while the character is being built, once on an accepted click" }
elseif ($grantTotal.Count -ne 2) { Fail "V150 grantSpeciality is called from $($grantTotal.Count - 1) place(s) - only specialityMoved may reach it" }
elseif ($revokeTotal.Count -ne 2) { Fail "V158 revokeSpeciality is called from $($revokeTotal.Count - 1) place(s) - only specialityMoved may reach it" }
elseif ($movedFn -notmatch 'return grantSpeciality\(form, trait, level \+ 1\);') { Fail "V158 the rise does not ask for the level the click REACHES" }
elseif ($movedFn -notmatch 'return revokeSpeciality\(form, trait, level - 1\);') { Fail "V158 the fall does not ask for the level the click LEAVES BEHIND" }
elseif ($specOutside.Count -gt 0) { Fail "V150 the gift is moved by $($specOutside -join ', ') - a renderer or dataLink granting would re-grant on every load (SPEC V121)" }
elseif ($grantFn -notmatch 'if t == nil or reached ~= t\.free then return false; end;') { Fail "V150 the grant does not test the rating the click REACHED - it would fire on every dot of the trait" }
elseif ($revokeFn -notmatch 'if t == nil or reached >= t\.free then return false; end;') { Fail "V158 the revoke fires at the wrong side of the line - Expression grants at one, so selling from four to three must take nothing" }
else { Pass "V150/V158 the gift is born on the click that reaches the rating and dies on the click that leaves it" }

# ---- V151 + V160: one lookup, name AND stamp, serving the dedup and the revoke --------
# A row only counts as the gift if it carries the stamp as well as the name: a speciality
# the player PAID for on the same trait neither eats the free one nor is taken away with it.
$isFreeFn  = LuaFn $rootTxt 'isFreeRow'
$freeRowFn = LuaFn $rootTxt 'freeRowOf'
$stampFinds = @([regex]::Matches($rootTxt, 'string\.find\(sheet\.xpFree'))
if (-not $isFreeFn) { Fail "V160 isFreeRow not found - the stamp question would be asked three different ways" }
elseif (-not $freeRowFn) { Fail "V160 freeRowOf not found - the dedup and the revoke would each look the row up their own way" }
elseif ($stampFinds.Count -ne 1) { Fail "V160 the stamps are read directly in $($stampFinds.Count) places - isFreeRow is meant to be the only one" }
elseif ($isFreeFn -notmatch '"\|" \.\. field \.\. "#1\|"') { Fail "V160 isFreeRow does not key off the row's own stamp" }
elseif ($freeRowFn -notmatch 'sheet\["speciality_" \.\. i\] == name and isFreeRow\("speciality_" \.\. i\)') { Fail "V151 freeRowOf does not check name AND stamp together - a speciality the player PAID for would be taken for the gift" }
elseif ($grantFn -notmatch 'if freeRowOf\(t\.name\) ~= nil then return false; end;') { Fail "V151 the grant does not ask whether the trait already has its gift" }
elseif ($revokeFn -notmatch 'local slot = freeRowOf\(t\.name\);') { Fail "V151 the revoke does not find its row through the same lookup - it could take a paid speciality" }
else { Pass "V151/V160 one lookup, name and stamp together, serving both the dedup and the revoke" }

# ---- V152: name, mark and stamp in one step; the text stays the player's --------------
# Exactly what a free purchase writes, so the line is priced at zero by the rule that prices
# any stamped dot (V139) - there is no second cost table to disagree with it.
$nameWrites = @()
foreach ($f in $files) {
    if ($f.Name -eq 'WoD20th.lfm') { continue }
    $raw = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    if ($raw -match 'setField\("specialityName') { $nameWrites += $f.Name }
}
# The typed text has exactly ONE writer in the whole sheet, and it is the revoke taking the
# row away (SPEC V163). Anything else writing it would be Lua typing for the player.
$rootNameWrites = @([regex]::Matches($rootTxt, 'setField\("specialityName'))
if (-not $grantFn) { Fail "V152 grantSpeciality not found on the root form" }
elseif ($grantFn -notmatch 'setField\("speciality_" \.\. slot, t\.name\);') { Fail "V152 the grant never writes the trait into the row" }
elseif ($grantFn -notmatch 'markDot\(form, "speciality_" \.\. slot \.\. "_1", true\);') { Fail "V152 the grant never lights the dot - with autoChange off nothing else will (SPEC V134)" }
elseif ($grantFn -notmatch 'setField\("xpFree", stamps') { Fail "V152 the grant leaves no stamp - the free line would be charged on the next render (SPEC V139)" }
elseif ($grantFn -match 'specialityName') { Fail "V163 the grant touches specialityName - what the specialty IS is the player's to type" }
elseif ($nameWrites.Count -gt 0) { Fail "V163 $($nameWrites -join ', ') writes specialityName - only the revoke on the root form may (SPEC V159)" }
elseif ($rootNameWrites.Count -ne 1) { Fail "V163 specialityName is written in $($rootNameWrites.Count) places - exactly one, the revoke clearing the row it takes away" }
elseif ($revokeFn -notmatch 'setField\("specialityName_" \.\. slot, ""\);') { Fail "V163 the one writer is not the revoke - the text would be cleared by something that is not taking the row away" }
else { Pass "V152/V163 the gift writes trait, mark and stamp and leaves the text alone; only the revoke clears it" }

# ---- V153: a full table says so, and the dot that earned it stays bought --------------
if (-not $grantFn) { Fail "V153 grantSpeciality not found on the root form" }
else {
    $iNoSlot = $grantFn.IndexOf('if slot == nil then')
    $iWrite  = $grantFn.IndexOf('setField("speciality_" .. slot')
    if ($iNoSlot -lt 0) { Fail "V153 the grant never handles a full table - it would write into a row that does not exist" }
    elseif ($grantFn -notmatch 'xpWarn\("No free specialty slot"\);') { Fail "V153 a full table refuses in silence" }
    elseif ($iWrite -lt $iNoSlot) { Fail "V153 the grant writes before it knows there is a slot" }
    elseif ($grantFn -notmatch '(?s)if slot == nil then.*?return false;') { Fail "V153 the grant carries on after a full table - the caller would think it wrote something" }
    else { Pass "V153 a full table warns and writes nothing; the dot that earned the gift stays bought" }
}

# ---- V154 + V156: bought only where the storyteller allowed, and never blind ----------
# ONE field now, not two flags (SPEC I49, V254, 87th round): a number 0..5 is the price and
# the sentinel is the door shut. ZERO IS A PRICE - the flag pair could not tell "the table
# gives them away" from "the table does not sell them", both read as specCost() == 0, so the
# door has a reader of its own and xpClick asks THAT one. Free dots still does not open the
# door: one says WHETHER, the other says HOW MUCH.
$costSpecFn = LuaFn $rootTxt 'specCost'
$forbidFn   = LuaFn $rootTxt 'specForbidden'
$xpCostFn   = LuaFn $rootTxt 'xpCost'
$specGuard  = [regex]::Match($cc, 'if trait ~= nil and string\.match\(trait, "\^speciality_%d\+\$"\) ~= nil then(.*?)\n\t\t\t\tend;', 'Singleline')
if (-not $costSpecFn) { Fail "V154 specCost not found on the root form" }
elseif (-not $forbidFn) { Fail "V154 specForbidden not found - the closed door has no reader of its own, so zero would have to mean both price and refusal again (SPEC V254b)" }
elseif ($forbidFn -notmatch 'if sheet == nil then return true; end;') { Fail "V154 specForbidden does not fail closed on a sheet with no room (SPEC V80)" }
elseif ($forbidFn -notmatch 'sheet\.stSpecCost == SPEC_FORBIDDEN') { Fail "V154 specForbidden does not compare stSpecCost against the sentinel - the door would answer to something else than the combo writes" }
elseif ($costSpecFn -notmatch 'tonumber\(sheet\.stSpecCost\) or 3') { Fail "V154 specCost does not read stSpecCost with the same 3 the dataLink declares - a sheet that predates the combo would price differently than the XML says (SPEC V254c)" }
elseif ($xpCostFn -notmatch 'if kind == "Specialty" then return specCost\(\); end;') { Fail "V154 xpCost does not price a specialty through specCost - the log would show it free" }
elseif (-not $specGuard.Success) { Fail "V154 xpClick has no speciality branch - a row could be bought with the door shut" }
elseif ($specGuard.Groups[1].Value -match 'specCost\(\) == 0') { Fail "V154 xpClick still reads a zero price as the closed door - a specialty the table gives away would be REFUSED instead (SPEC V254b)" }
elseif ($specGuard.Groups[1].Value -notmatch 'if want and base ~= nil and specForbidden\(\) then') { Fail "V154 the closed door is not asked about, or is asked before the character is frozen (SPEC V101)" }
elseif ($specGuard.Groups[1].Value -notmatch 'xpWarn\("Specialties cannot be bought"\);') { Fail "V154 a closed door refuses in silence" }
elseif ($specGuard.Groups[1].Value -notmatch 'xpWarn\("Choose a trait first"\);') { Fail "V156 a row with no trait refuses in silence" }
elseif ($specGuard.Groups[1].Value -match 'markDot\(|setField\(') { Fail "V154/V156 the speciality branch writes before it has decided (SPEC V135)" }
elseif ($cc.IndexOf('if trait ~= nil and string.match(trait, "^speciality_%d+$")') -gt $cc.LastIndexOf('markDot(form, field, want)')) { Fail "V154/V156 the speciality refusals come after the mark - there would be nothing to refuse" }
else { Pass "V154/V156 a specialty is bought only where the storyteller allowed it, zero is a price and not a shut door, and every refusal says why" }

# ---- V157: selling a speciality does not take the typing with it ---------------------
# The sale is the ordinary one: the dot goes out and the stamp with it (V141). The trait and
# the text stay where the player left them - one click may not destroy what was typed.
if ($cc -match 'setField\("speciality_"') { Fail "V157 xpClick writes a speciality row itself - the sale would clear the trait the player chose" }
elseif ($cc -match 'setField\("specialityName') { Fail "V157 xpClick clears the speciality text - one click would destroy what was typed" }
else { Pass "V157 a sold speciality keeps its trait and its text" }

# ---- V159: the revoked gift takes the whole row with it ------------------------------
# Trait, text, dot and stamp leave together, so the slot goes back to the pool. Half a row -
# the trait still showing with the dot out - would hold a slot for ever and say nothing. The
# typed text goes with it: that is what losing the gift costs.
if (-not $revokeFn) { Fail "V159 revokeSpeciality not found on the root form" }
elseif ($revokeFn -notmatch 'setField\("speciality_" \.\. slot, ""\);') { Fail "V159 the revoke leaves the trait in the row - the slot would never come back" }
elseif ($revokeFn -notmatch 'setField\("specialityName_" \.\. slot, ""\);') { Fail "V159 the revoke leaves the text behind - the next gift would land under someone else's words" }
elseif ($revokeFn -notmatch 'markDot\(form, "speciality_" \.\. slot \.\. "_1", false\);') { Fail "V159 the revoke leaves the dot lit - with autoChange off nothing else will put it out (SPEC V134)" }
elseif ($revokeFn -notmatch 'string\.gsub\(sheet\.xpFree or "", "\|speciality_" \.\. slot \.\. "#1\|", "\|"\)') { Fail "V159 the revoke leaves the stamp - the empty row would stay locked (SPEC V161)" }
elseif ($revokeFn -notmatch 'if slot == nil then return false; end;') { Fail "V159 the revoke carries on with no row to revoke" }
else { Pass "V159 a revoked gift gives back trait, text, dot and stamp in one step" }

# ---- V161 + V162: the gift is not the player's to change ------------------------------
# Two widgets, two mechanisms, one truth each: a comboBox has no click hook, so `enabled` is
# the only lock there (the same one cboGame carries, V109); the dot has an onClick, which is
# what marks a dot editable (V111), so it is refused inside xpClick instead of being dimmed.
#
# The lock is settled BEFORE the baseline test: a gift is never the player's to take off,
# not even while the character is being built.
$renderSpecFn = LuaFn $rootTxt 'renderSpecialities'
$iSpecGuard   = $cc.IndexOf('if trait ~= nil and string.match(trait, "^speciality_%d+$")')
$iBaseTest    = $cc.IndexOf('if base == nil then')
$specDotOpacity = @($mainDoc.SelectNodes("//template[@name='SpecialityRow']//imageCheckBox[@opacity]"))
if (-not $renderSpecFn) { Fail "V161 renderSpecialities not found on the root form" }
elseif ($iSpecGuard -lt 0) { Fail "V161 xpClick has no speciality branch - the gift could be taken off with a click" }
elseif ($iSpecGuard -gt $iBaseTest) { Fail "V161 the lock is tested after the baseline check - the gift would be the player's to remove while the character is being built" }
elseif ($specGuard.Groups[1].Value -notmatch 'if not want and isFreeRow\(trait\) then') { Fail "V161 selling a stamped row is not refused - the gift would go with one click" }
elseif ($specGuard.Groups[1].Value -notmatch 'xpWarn\("Free specialties are lost only by lowering the trait"\);') { Fail "V161 the locked dot refuses in silence" }
elseif ($specDotOpacity.Count -gt 0) { Fail "V161 the speciality dot carries opacity - a dot with an onClick is editable and must not read as read-only (SPEC V111)" }
elseif ($renderSpecFn -notmatch 'c\.enabled = not locked;') { Fail "V161 the trait combo of a gift row is never switched off - it is the only lock a comboBox has" }
elseif ($renderSpecFn -notmatch '(?m)^\s*c\.enabled = not locked;') { Fail "V162 the free-row lock does not write c.enabled - a granted speciality could be retyped" }
elseif ($renderSpecFn -match 'c\.opacity') { Fail "V162 the speciality combo still paints opacity - a locked dropdown has to keep its text readable (SPEC I41, V241)" }
elseif ($renderSpecFn -match 'specialityName|markDot') { Fail "V163 the renderer touches the text or the dot - it paints the lock and nothing else" }
else { Pass "V161/V162 a gift row locks its combo and refuses its dot, and the look is written with the state" }

# ---- V164: the lock is painted from three places, and finds its controls the one way ---
# The click covers the sheet in front of the player; onNodeReady covers the sheet being
# opened; the xpFree link covers a grant made on ANOTHER client at the table. `form.<name>`
# does not cross the <import>, which is why this walks with the one finder (V143).
$mainRawTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.1.lfm")))
$renderCalls = @([regex]::Matches($rootTxt, 'renderSpecialities\('))
$specLinks2  = @($mainDoc.SelectNodes("//dataLink[@field='xpFree']"))
if (-not $renderSpecFn) { Fail "V164 renderSpecialities not found on the root form" }
elseif ($renderSpecFn -notmatch 'xpFind\(tabRootOf\(from\), names, found\);') { Fail "V164 the renderer does not use the one control finder - form.<name> does not cross the import (SPEC V143, B9)" }
elseif ($renderCalls.Count -ne 3) { Fail "V164 renderSpecialities is called from $($renderCalls.Count - 1) place(s) on the root form - the two accepted click paths and no more" }
elseif ($specLinks2.Count -ne 1) { Fail "V164 WoD20.1 carries $($specLinks2.Count) xpFree links - one, so a grant made on another client locks the row here too" }
elseif ($mainRawTxt -notmatch '<dataLink field="xpFree" onChange="renderSpecialities\(self\);"/>') { Fail "V164 the xpFree link does not repaint the lock" }
elseif ($mainRawTxt -notmatch '(?s)<event name="onNodeReady">.*?renderSpecialities\(self\);.*?</event>') { Fail "V164 opening the sheet does not paint the lock - a saved gift would show as editable" }
else { Pass "V164 the lock is painted on the click, on open and on a remote grant, through the one finder" }

# ---- V165: the rename is text, never a field ------------------------------------------
# speciality_N and specialityName_N shipped in 4.6, so they stay whatever the label says
# (SPEC V2) - the same lie `retainers` tells the GUIDES box. What must not survive is a key
# nobody reads: the old English strings are gone from the .lang and from the PT map.
$oldStrings = @('SPECIALITIES', 'Speciality', 'Specialities cannot be bought', 'No free speciality slot')
$staleKeys  = @($oldStrings | Where-Object { $enK.Contains($_) -or $ptK.Contains($_) -or $embedded.ContainsKey($_) })
$kindPush   = @([regex]::Matches($rootTxt, 'pushRise\(rows, "Specialty"'))
$fieldsKept = (($allFields.Keys | Where-Object { $_ -match '^speciality_\d+$' }).Count -eq $spRows) -and
              (($allFields.Keys | Where-Object { $_ -match '^specialityName_\d+$' }).Count -eq $spRows)
if ($staleKeys.Count -gt 0) { foreach ($s in $staleKeys) { Fail "V165 '$s' is still keyed - the old spelling would sit in the .lang and the PT map with nothing reading it" } }
elseif ($kindPush.Count -ne 1) { Fail "V165 the ledger does not push a 'Specialty' row - the kind and the label must be the same string (SPEC V12)" }
elseif ($xpCostFn -notmatch 'kind == "Specialty"') { Fail "V165 xpCost prices a kind the ledger never produces - the two halves of the rename came apart" }
elseif (-not $fieldsKept) { Fail "V165 the speciality FIELDS were renamed - they shipped in 4.6 and a saved sheet would lose them (SPEC V2)" }
else { Pass "V165 the rename is text and keys only; the fields kept the name they shipped with" }

# ---- V166: the sheet is authored hidden, and one place lights it ---------------------
# B40: the host draws before any hook of ours runs (SPEC R47), so every open showed a
# second of the sheet as the XML authors it - a look no theme has offered since the 16th
# round. The fix is not to show it, which only holds while exactly one place can show it.
# The reveal target is a <layout> since the 78th round (SPEC I32). Authored hidden for the
# same reason the tabControl was: the host paints before any hook of ours runs (SPEC R47).
$tcTag = [regex]::Match($rootLfm, '<layout name="sheetBody"[^>]*>')
$revealFn = [regex]::Match($rootLfm, '(?s)function sheetReveal\(from\)(.*?)\r?\n\t{3}end;')
$revealBody = if ($revealFn.Success) { $revealFn.Groups[1].Value } else { '' }
$tabsHHTotal = 0
foreach ($f in $files) {
    $raw = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    $tabsHHTotal += ([regex]::Matches($raw, 'sheetBody')).Count
}
$tabsHHInReveal = ([regex]::Matches($revealBody, 'sheetBody')).Count
$tabsHHInTag = ([regex]::Matches($tcTag.Value, 'sheetBody')).Count
$revealLights = ([regex]::Matches($revealBody, '\.visible\s*=\s*true')).Count
$tabsHHLoose = $tabsHHTotal - $tabsHHInReveal - $tabsHHInTag
if (-not $tcTag.Success) { Fail "V166 no sheetBody layout on the root form - nothing to reveal (SPEC I32)" }
elseif ($tcTag.Value -notmatch 'align="client"') { Fail "V166 sheetBody does not fill the form - the sheet would draw in a corner (SPEC I32)" }
elseif ($tcTag.Value -notmatch 'visible="false"') { Fail "V166 sheetBody is authored visible - the raw sheet is on screen before anything paints it (SPEC B40)" }
elseif (-not $revealFn.Success) { Fail "V166 sheetReveal not found on the root form - nothing would ever show the sheet" }
elseif ($revealLights -ne 1) { Fail "V166 sheetReveal writes visible=true $revealLights time(s) - it is the one place that lights the sheet" }
elseif ($tabsHHLoose -ne 0) { Fail "V166 sheetBody is named $tabsHHLoose time(s) outside sheetReveal and its own declaration - a second place could show the sheet early" }
else { Pass "V166 sheetBody is authored hidden and sheetReveal is the only thing that lights it" }

# ---- V167: the reveal is idempotent and cannot leave the sheet blank -----------------
# The mirror of B26: there the static state failed OPEN and showed tabs nobody asked for;
# here it fails open on purpose. A paint that never runs has to leave the sheet ugly, never
# blank, so one of the two entries must not depend on any paint. A timer cannot fire early
# and cannot depend on the paint (SPEC R44 - it is only asynchronous above zero).
$revealCallCount = -1
foreach ($f in $files) {
    $raw = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    $revealCallCount += ([regex]::Matches($raw, 'sheetReveal\(')).Count
}
$timerArm = [regex]::Match($rootLfm, 'setTimeout\(\s*function\(\)\s*sheetReveal\(self\);\s*end\s*,\s*(\d+)\s*\)')
$themeEntry = ($hh6 -match '(?s)<dataLink field="sheetTheme".*?sheetReveal\(self\);.*?</dataLink>')
$armedOnReady = ($rootLfm -match '(?s)<event name="onNodeReady">.*?setTimeout\(\s*function\(\)\s*sheetReveal')
if ($revealCallCount -lt 2) { Fail "V167 sheetReveal is called from $revealCallCount place(s) - one entry means one way to fail (SPEC I15)" }
elseif ($revealBody -notmatch 'tc\.visible ~= true') { Fail "V167 sheetReveal writes without looking - it is called more than once and must be idempotent" }
elseif (-not $timerArm.Success) { Fail "V167 no timer arms the reveal on the root form - every entry would hang off a paint that may never run (SPEC B40)" }
elseif ([int]$timerArm.Groups[1].Value -le 0) { Fail "V167 the reveal timer is armed at $($timerArm.Groups[1].Value)ms - setTimeout runs synchronously at zero (SPEC R44)" }
elseif (-not $armedOnReady) { Fail "V167 the timer is not armed from onNodeReady - the floor has to go down when the sheet opens" }
elseif (-not $themeEntry) { Fail "V167 the theme paint does not call sheetReveal - the normal entry is the last load paint there is (SPEC I15)" }
else { Pass "V167 the reveal is idempotent, armed by a $($timerArm.Groups[1].Value)ms floor and by the theme paint" }

# ---- V168: the Main tab is a three-column grid ---------------------------------------
# The 49th round lined up the two outer ends of the top row (TALENTS with VIRTUES,
# KNOWLEDGES with EXPERIENCE) and this check measured that one pair. In the 50th the user
# asked for the other three, so the rule is the grid itself: every box on the bottom row
# takes BOTH x edges from the column above it, and the three columns are one row - same
# top, same width, same height, same gap.
$bTal = BoxOf $mainDoc "TALENTS"; $bSki = BoxOf $mainDoc "SKILLS"; $bKno = BoxOf $mainDoc "KNOWLEDGES"
$bExp = BoxOf $mainDoc "EXPERIENCE"
$GRID = @(
    @{ col = "TALENTS";    under = @("VIRTUES", "HUMANITY") },
    @{ col = "SKILLS";     under = @("SPECIALTIES") },
    @{ col = "KNOWLEDGES"; under = @("HEALTH") }
)
$colW = @(); $abilRowOk = $false
$gridMissing = @()
foreach ($g in $GRID) {
    if (-not (BoxOf $mainDoc $g.col)) { $gridMissing += $g.col }
    foreach ($u in $g.under) { if (-not (BoxOf $mainDoc $u)) { $gridMissing += $u } }
}
if (-not $bExp) { $gridMissing += "EXPERIENCE" }
if ($gridMissing.Count -gt 0) { Fail "V168 not a titled box on WoD20.1: $($gridMissing -join ', ')" }
else {
    $offGrid = @()
    foreach ($g in $GRID) {
        $c = BoxOf $mainDoc $g.col
        $cL = [int]$c.GetAttribute("left"); $cR = $cL + [int]$c.GetAttribute("width")
        foreach ($u in $g.under) {
            $b = BoxOf $mainDoc $u
            $bL = [int]$b.GetAttribute("left"); $bR = $bL + [int]$b.GetAttribute("width")
            if ($bL -ne $cL -or $bR -ne $cR) { $offGrid += "$u runs $bL..$bR under $($g.col) at $cL..$cR" }
        }
    }
    $colW = @(@($bTal, $bSki, $bKno) | ForEach-Object { [int]$_.GetAttribute("width") } | Sort-Object -Unique)
    $colT = @(@($bTal, $bSki, $bKno) | ForEach-Object { [int]$_.GetAttribute("top") } | Sort-Object -Unique)
    $colH = @(@($bTal, $bSki, $bKno) | ForEach-Object { [int]$_.GetAttribute("height") } | Sort-Object -Unique)
    $talL = [int]$bTal.GetAttribute("left")
    $knoR = [int]$bKno.GetAttribute("left") + [int]$bKno.GetAttribute("width")
    $expR = [int]$bExp.GetAttribute("left") + [int]$bExp.GetAttribute("width")
    $gapA = [int]$bSki.GetAttribute("left") - ($talL + [int]$bTal.GetAttribute("width"))
    $gapB = [int]$bKno.GetAttribute("left") - ([int]$bSki.GetAttribute("left") + [int]$bSki.GetAttribute("width"))
    if ($offGrid.Count -gt 0) { Fail "V168 the grid is broken - $($offGrid -join '; ')" }
    elseif ($knoR -ne $expR) { Fail "V168 KNOWLEDGES closes at $knoR and EXPERIENCE at $expR - the grid closes on the header's right edge" }
    elseif ($colW.Count -ne 1) { Fail "V168 the three ability columns are $($colW -join '/') wide - one would read narrower than its neighbours" }
    elseif ($colT.Count -ne 1) { Fail "V168 the three ability columns start at $($colT -join '/') - they are one row and share a top" }
    elseif ($colH.Count -ne 1) { Fail "V168 the three ability columns are $($colH -join '/') tall - they are one row and share a height" }
    elseif ($gapA -ne $gapB) { Fail "V168 the column gaps are $gapA and $gapB - the row would read lopsided" }
    else { $abilRowOk = $true; Pass "V168 the grid runs $talL..${knoR}: three $($colW[0])px columns $gapA apart, each carrying the bottom row under it" }
}

# ---- V171: an ability column fits its content ----------------------------------------
# The columns shipped 390 tall with twelve rows closing at 325 - 65px of black tail under
# the last ability, which is what the user asked to be rid of. "Fits" is not a number here:
# the bottom margin is whatever ATTRIBUTES already leaves under its own last row, so the
# three columns and the box beside them agree by construction, and a thirteenth ability has
# to grow the box instead of moving into slack nobody declared.
function TailOf($box, $rowXPath) {
    $rows = @($box.SelectNodes($rowXPath))
    if ($rows.Count -eq 0) { return $null }
    $last = 0
    foreach ($r in $rows) {
        $rb = [int]$r.GetAttribute("top") + [int]$r.GetAttribute("height")
        if ($rb -gt $last) { $last = $rb }
    }
    return ([int]$box.GetAttribute("height") - $last)
}
$bAttr = BoxOf $mainDoc "ATTRIBUTES"
$refTail = if ($bAttr) { TailOf $bAttr "layout[Attribute or AttributeZeroable]" } else { $null }
if (-not $abilRowOk) { Fail "V171 not measured - the ability grid did not pass V168" }
elseif ($null -eq $refTail) { Fail "V171 ATTRIBUTES has no rows to take the bottom margin from - the ruler measured nothing (SPEC V20)" }
else {
    $tails = @()
    foreach ($n in @("TALENTS", "SKILLS", "KNOWLEDGES")) {
        $t = TailOf (BoxOf $mainDoc $n) "layout[Ability or CustomAbility]"
        if ($t -ne $refTail) { $tails += "$n leaves ${t}px" }
    }
    if ($tails.Count -gt 0) { Fail "V171 ATTRIBUTES leaves ${refTail}px under its last row but $($tails -join ', ') - the column carries dead tail (or clips its last row)" }
    else { Pass "V171 all three ability columns close ${refTail}px under their last row, the margin ATTRIBUTES sets" }
}

# ---- V169: the ABILITIES frame is gone, key and all ----------------------------------
# It was a box whose title named what the three titles inside it already said, and its
# frame cost 30px of width the names wanted. A label that no longer exists must not leave
# a key behind in the .lang or the PT map (the rule V165 wrote for the rename).
$abilTitles = @($mainDoc.SelectNodes("//label[@text='ABILITIES']"))
$looseCols = @($mainDoc.SelectNodes("/form/scrollBox/layout[label/@text='TALENTS' or label/@text='SKILLS' or label/@text='KNOWLEDGES']"))
if ($abilTitles.Count -ne 0) { Fail "V169 WoD20.1 still draws an ABILITIES title - the frame the user asked to remove is back" }
elseif ($looseCols.Count -ne 3) { Fail "V169 $($looseCols.Count) of the three ability columns are direct children of the scrollBox - nested again, V40 stops weighing them against the tab" }
elseif ($ptK.Contains("ABILITIES") -or $enK.Contains("ABILITIES")) { Fail "V169 ABILITIES is still keyed in localization.lang with no label reading it" }
elseif ($hh6 -match '\["ABILITIES"\]') { Fail "V169 ABILITIES is still in the PT map with no label reading it" }
else { Pass "V169 the ABILITIES frame is gone, the three columns stand loose and no key survives it" }

# ---- V170: the width the columns gained went to the NAMES ----------------------------
# The whole point of the request was the ability names, so the 10px each column picked up
# has to be readable as label, not as air between the last dot and the border. Ability and
# CustomAbility are measured together: they are siblings in every column (SPEC V26).
$tplA = @($mainDoc.SelectNodes("//template[@name='Ability']"))[0]
$tplC = @($mainDoc.SelectNodes("//template[@name='CustomAbility']"))[0]
$rowW = @()
foreach ($col in $looseCols) {
    foreach ($r in $col.SelectNodes("layout[Ability or CustomAbility]")) { $rowW += [int]$r.GetAttribute("width") }
}
$rowW = @($rowW | Sort-Object -Unique)
if (-not $abilRowOk) { Fail "V170 not measured - the ability row did not pass V168" }
elseif (-not ($tplA -and $tplC)) { Fail "V170 Ability or CustomAbility is not declared on WoD20.1" }
elseif ($rowW.Count -ne 1) { Fail "V170 the ability rows are $($rowW -join '/') wide - one column would hold a different name width" }
else {
    $aInput = [int](@($tplA.SelectNodes("label"))[0].GetAttribute("width"))
    $cInput = [int](@($tplC.SelectNodes("edit"))[0].GetAttribute("width"))
    $aDots = @($tplA.SelectNodes("imageCheckBox") | ForEach-Object { [int]$_.GetAttribute("left") } | Sort-Object)
    $cDots = @($tplC.SelectNodes("imageCheckBox") | ForEach-Object { [int]$_.GetAttribute("left") } | Sort-Object)
    $colInner = $colW[0] - 30
    if ($aDots[0] -ne $cDots[0]) { Fail "V170 Ability puts its first dot at $($aDots[0]) and CustomAbility at $($cDots[0]) - they are siblings in every column (SPEC V26)" }
    elseif ($rowW[0] -ne $colInner) { Fail "V170 the rows are $($rowW[0]) wide inside a $($colW[0])px column - $($colW[0] - $rowW[0])px of the column reaches no row" }
    elseif (($aDots[-1] + 25) -ne $rowW[0]) { Fail "V170 the last dot ends at $($aDots[-1] + 25) in a row $($rowW[0]) wide - the leftover is dead margin, not name" }
    elseif ($aInput -gt $aDots[0] -or $cInput -gt $cDots[0]) { Fail "V170 the name field runs under the first dot ($aInput / $cInput against $($aDots[0]))" }
    elseif (($aDots[0] - $aInput) -gt 3) { Fail "V170 $($aDots[0] - $aInput)px sit between the ability label and its first dot - that width was asked for by the names" }
    else { Pass "V170 the $($colW[0])px column hands ${aInput}px to the name and closes on its last dot" }
}

# ---- V6 + V7: real build, and proof the artifact actually changed -------------
# B.1: `rdk p` is PREPARE, not pack. It exits 0 without touching the .rpk.
# Exit 0 alone is not proof of a build - the artifact must change.

# =====================================================================================
# SPEC T448: the checks the Vampire tab was owed. V172-V189, minus the ones that already
# shipped with the structure they measure (V175/V179 in T457, V188/V192 in T463, V193 in
# T466, V189/V198 in T478-T481). Every leg below was mutated red before it was accepted
# (SPEC V20) - a check that cannot fail is worse than no check, because it reads as cover.
# =====================================================================================

function ItemsOf($xml, $tplName) {
    $tpl = @($xml.SelectNodes("//template[@name='$tplName']"))[0]
    if ($null -eq $tpl) { return $null }
    # The template still says WHICH rows it draws; the list those rows offer now comes from
    # PICKER_LIST (SPEC I27). Reading items= here would return nothing and V177/V178/V184
    # would all go quiet together - three checks, one silent no-op (SPEC V20, V209l).
    $cb = @($tpl.SelectNodes(".//comboBox"))[0]
    if ($null -eq $cb) { return $null }
    @((ListOf $cb $tplName) | Where-Object { $_ -ne '' })
}

# ---- V172: the rename was text, and only text ----------------------------------------
# 51st round: the managed tab stopped reading "Disciplines" and started reading "Vampire".
# What must NOT have moved with it: the field (`stShowDisciplines`), the control name
# (`tabDisciplines`) and the ledger category (`Discipline`) - those are saved data and 4.9
# is out (SPEC V2). Scoped to the MANAGED tab on purpose: WoD20.11's sub-tab is still titled
# "Disciplines" and SHOULD be (SPEC V188), so a check that banned the string everywhere
# would be born wrong - the same trap SPEC C spells out for `path`.
$rootXdoc = Doc (Join-Path $dir "WoD20th.lfm")
$managedTab = $rootXdoc.SelectSingleNode("//layout[@name='tabDisciplines']")
if ($null -eq $managedTab) { Fail "V172 the root form has no pane named tabDisciplines - the control name was renamed with the title (SPEC V2)" }
# The visible title moved out of @title and into the button's label (SPEC I32) - same string,
# same rule, one control further out.
$managedLbl = $rootXdoc.SelectSingleNode("//rectangle[@name='btnTabDisciplines']/label")
if ($null -eq $managedLbl) { Fail "V172 btnTabDisciplines carries no label - nothing shows the tab's title" }
elseif ($managedLbl.GetAttribute("text") -ne 'Ghoul') { Fail "V172 the managed tab reads '$($managedLbl.GetAttribute("text"))', expected 'Ghoul' (SPEC V171, V233)" }
elseif ($rootTxt -notmatch 'sheet\.stShowDisciplines') { Fail "V172 stShowDisciplines is no longer read - the field was renamed with the tab (SPEC V2)" }
elseif ($rootTxt -match '(?m)kind\s*==\s*"Ghoul"') { Fail "V172 'Ghoul' is a ledger category - the rename reached the experience log (SPEC I10)" }
elseif ($rootTxt -notmatch '(?m)kind\s*==\s*"Discipline"') { Fail "V172 the ledger no longer prices 'Discipline' - the category was renamed with the tab" }
else { Pass "V172 the rename is title and visible text; the field, the control name and the ledger category all kept their old spelling" }

# ---- V173/V174: `clan` is authored asleep, and CLANS is declared on the root form -----
# A combo that is invisible but ENABLED, or a table with one live caller, is a feature that
# shipped by accident. Both halves are measured because either one alone would let it in.
$clanCbo = $null
foreach ($f in $files) { $c = (Doc $f.FullName).SelectSingleNode("//comboBox[@field='clan']"); if ($null -ne $c) { $clanCbo = $c; $clanFile = $f.Name } }
if ($null -eq $clanCbo) { Fail "V173 no combo carries field='clan' - the dormant picker is gone (SPEC V8)" }
elseif ($clanCbo.GetAttribute("visible") -ne 'false') { Fail "V173 the clan combo in $clanFile is visible - waking it is a round of its own, not a side effect" }
elseif ($clanCbo.GetAttribute("enabled") -ne 'false') { Fail "V173 the clan combo in $clanFile is enabled - invisible and live is the worst of both (SPEC V111)" }
else {
    $clanWrites = @()
    foreach ($f in $files) {
        $t = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
        foreach ($m in [regex]::Matches($t, 'setField\(\s*"clan"|sheet\.clan\s*=')) { $clanWrites += "$($f.Name): $($m.Value)" }
    }
    if ($clanWrites) { foreach ($c in $clanWrites) { Fail "V173 something writes the clan field - $c - the field is dormant, nothing may fill it" } }
    else { Pass "V173 the clan combo is authored invisible AND disabled, and no Lua writes the field" }
}
$clansReaders = @()
foreach ($f in $files) {
    $t = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    foreach ($m in [regex]::Matches((NoComments $t), 'CLANS\s*\[')) { $clansReaders += "$($f.Name)" }
}
# The no-reader leg is REVOKED (SPEC V174, user 2026-08-22): the user asked the domitor's
# clan to fill the ghoul's Discipline slots, so CLANS has a reader ON PURPOSE now
# (renderClanDisc, SPEC I37, T547). What guarded the research by keeping it unused is V236,
# which measures the table itself. What stays here is WHERE it lives: one table on the root
# form, which is what lets V236 and renderClanDisc read the same sixty entries.
if ($rootTxt -notmatch '(?m)^\s*local CLANS\s*=\s*\{') { Fail "V174 CLANS is not declared on the root form - the check reads nothing (SPEC V20)" }
elseif ($clansReaders.Count -lt 1) { Fail "V174 nothing reads CLANS - the clan would no longer fill the Discipline slots (SPEC I37, T547)" }
else { Pass "V174 CLANS is declared on the root form and read by $(($clansReaders | Sort-Object -Unique) -join ', ')" }

# ---- V176: the selector roster is CLOSED --------------------------------------------
# Same shape V30 measures on the Numina tab, now that the Vampire tab has three of them.
# The roster is five since the 90th round and no longer one per DESCRIPTION block: the
# Numina tab split its single block into three and grew a second selector with it, while
# the True Faith block has a block and NO group - one Path, nothing to select (SPEC I61).
# The rows all share one field - that is how a radio group binds here (SPEC V1) - so the
# option is the fieldValue, and two rows answering to one value would light together.
$radioGroups = @{}
foreach ($r in $radios) { if ($r.File -in @('WoD20.12.lfm','WoD20.13.lfm','WoD20.14.lfm')) {
    if (-not $radioGroups.ContainsKey($r.File)) { $radioGroups[$r.File] = @() }
    $radioGroups[$r.File] += $r
} }
$vampGroups = @{ 'WoD20.12.lfm' = 'discSel'; 'WoD20.13.lfm' = 'pathSel'; 'WoD20.14.lfm' = 'ritualSel' }
$rgBad = @()
foreach ($k in $vampGroups.Keys) {
    $rs = @($radioGroups[$k])
    if ($rs.Count -eq 0) { $rgBad += "$k has no radio - no row of it can ever be described (SPEC V30)"; continue }
    $groups = @($rs | ForEach-Object { $_.Group } | Sort-Object -Unique)
    $fieldsUsed = @($rs | ForEach-Object { $_.Field } | Sort-Object -Unique)
    if ($groups.Count -ne 1 -or $groups[0] -ne $vampGroups[$k]) { $rgBad += "$k binds groupName {$($groups -join ', ')}, expected only '$($vampGroups[$k])'" }
    if ($fieldsUsed.Count -ne 1 -or $fieldsUsed[0] -ne $vampGroups[$k]) { $rgBad += "$k binds field {$($fieldsUsed -join ', ')} - field and groupName are the same selector" }
    $dups = @($rs | Group-Object Value | Where-Object { $_.Count -gt 1 })
    foreach ($d in $dups) { $rgBad += "$k fieldValue '$($d.Name)' is used by $($d.Count) radios - two rows would answer as one" }
    $blank = @($rs | Where-Object { [string]::IsNullOrEmpty($_.Value) })
    if ($blank) { $rgBad += "$k has $($blank.Count) radio(s) with no fieldValue - the renderer reads the row off it" }
}
$strayGroups = @()
foreach ($f in $files) {
    foreach ($g in (Doc $f.FullName).SelectNodes("//*[@groupName]")) {
        $gn = $g.GetAttribute("groupName")
        if ($gn -in @('numinaSel','psychicSel','hedgeRitualSel','discSel','pathSel','ritualSel')) { continue }
        $strayGroups += "$($f.Name): '$gn'"
    }
}
if ($strayGroups) { $rgBad += "a radio group outside the roster exists - $(($strayGroups | Sort-Object -Unique) -join '; ') - the six selectors are numinaSel, psychicSel, hedgeRitualSel, discSel, pathSel and ritualSel and there are no others (SPEC I58, I65)" }
if ($rgBad) { foreach ($r in $rgBad) { Fail "V176 $r" } }
else { Pass "V176 the three Vampire selectors bind one field each, with $((@($radioGroups.Values) | ForEach-Object { $_.Count } | Measure-Object -Sum).Sum) distinct row values between them" }

# ---- V177/V178/V184: the picker lists, the tables behind them, and the level prefix ----
# V177 is V32 for the Vampire tab: every item a picker offers must open text in BOTH
# languages, or its radio opens an empty box. V178 measures the OTHER direction plus the
# sibling rule: the two path templates offer the same list, and a key may not be written
# twice in one module. V184 measures the ritual prefix the level is read off (SPEC I19).
$areaSpec = @(
    @{ File = 'WoD20.12.lfm'; Base = 'descDisc';   Marker = 'DISC_DESC';   Templates = @('DiscRow');                   Name = 'discipline' },
    @{ File = 'WoD20.13.lfm'; Base = 'descPath';   Marker = 'PATH_DESC';   Templates = @('MainPathRow','SecPathRow');  Name = 'path' },
    @{ File = 'WoD20.14.lfm'; Base = 'descRitual'; Marker = 'RITUAL_DESC'; Templates = @('RitualRow');                 Name = 'ritual' })
$areaBad = @(); $areaOk = @()
foreach ($a in $areaSpec) {
    $x = Doc (Join-Path $dir $a.File)
    $lists = @{}
    foreach ($t in $a.Templates) {
        $it = ItemsOf $x $t
        if ($null -eq $it) { $areaBad += "V178 $($a.File) has no <template name='$t'> with an items= list - the rows have nothing to offer"; continue }
        $lists[$t] = $it
    }
    if ($lists.Count -ne $a.Templates.Count) { continue }
    # V178: sibling boxes read ONE list. Declared twice is allowed; DIVERGING is not.
    $first = $a.Templates[0]
    foreach ($t in $a.Templates) {
        if (($lists[$t] -join "$([char]1)") -ne ($lists[$first] -join "$([char]1)")) {
            $only = @(@($lists[$t] | Where-Object { $lists[$first] -notcontains $_ }) + @($lists[$first] | Where-Object { $lists[$t] -notcontains $_ }))
            $areaBad += "V178 $($a.File) $t and $first offer different $($a.Name) lists - $(($only | Select-Object -First 4) -join ', ') is in one box and not its sibling"
        }
    }
    $items = @($lists[$first])
    $dupItems = @($items | Group-Object | Where-Object { $_.Count -gt 1 })
    foreach ($d in $dupItems) { $areaBad += "V178 $($a.File) offers '$($d.Name)' $($d.Count) times - one item, one line (SPEC V14)" }
    # V184: the level is READ OFF the ritual name, so the name has to carry it.
    if ($a.Name -eq 'ritual') {
        $noPrefix = @($items | Where-Object { $_ -notmatch '^[1-9]\. ' })
        foreach ($n in $noPrefix) { $areaBad += "V184 ritual '$n' carries no '<level>. ' prefix - the guard reads the level off the name and would price it at zero (SPEC I19)" }
        if ($rootTxt -notmatch '\^\(%d\+\)%\. ') { $areaBad += "V184 the root form no longer reads the level off the ritual name - a second table for the level is exactly what this invariant forbids" }
    }
    # V177: every item has text on file, in both languages - which since T495 means in both
    # HALVES, joined by key (SPEC V210). An item written into only one of them opens an empty
    # box in the other language, which is the same failure read one language later.
    $modEn = DescEntries (Join-Path $plugin "$($a.Base)_en.lua") $a.Marker 'en'
    $modPt = DescEntries (Join-Path $plugin "$($a.Base)_pt.lua") $a.Marker 'pt'
    if ($null -eq $modEn -or $null -eq $modPt) { $areaBad += "V177 $($a.Base)_en.lua or $($a.Base)_pt.lua is missing, or its $($a.Marker) markers are gone - every $($a.Name) item would open an empty box (SPEC V210, V209)"; continue }
    $keys = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
    $thin2 = @()
    $ptBody2 = DescMap $modPt
    foreach ($e in $modEn) {
        [void]$keys.Add($e.Key)
        if ($e.Body.Trim().Length -lt 1) { $thin2 += "V177 $($a.Base)_en.lua '$($e.Key)' has an empty [en] body" }
        if (-not $ptBody2.ContainsKey($e.Key)) { $thin2 += "V177 $($a.Base)_pt.lua has no '$($e.Key)' - the item would open an empty box in Portuguese" }
        elseif ($ptBody2[$e.Key].Trim().Length -lt 1) { $thin2 += "V177 $($a.Base)_pt.lua '$($e.Key)' has an empty [pt] body" }
    }
    foreach ($t in $thin2) { $areaBad += $t }
    # V178, table half: a book that repeats an item must not become two entries. Both halves,
    # because a duplicate written into one of them alone is the same unreachable second copy.
    $allKeys = @($modEn | ForEach-Object { $_.Key })
    foreach ($side in @(@('en', $modEn), @('pt', $modPt))) {
        foreach ($d in @(@($side[1] | ForEach-Object { $_.Key }) | Group-Object | Where-Object { $_.Count -gt 1 })) {
            $areaBad += "V178 $($a.Base)_$($side[0]).lua declares '$($d.Name)' $($d.Count) times - the second copy is unreachable and free to drift"
        }
    }
    if ($keys.Count -eq 0) { $areaBad += "V177 $($a.Base)_en.lua parsed to zero entries - the parser or the generated shape drifted"; continue }
    $miss = @($items | Where-Object { -not $keys.Contains($_) })
    foreach ($m in $miss) { $areaBad += "V177 the $($a.Name) picker offers '$m' and $($a.Base)_en.lua has no entry - its radio would open an empty block" }
    $orph = @($allKeys | Where-Object { $items -notcontains $_ })
    foreach ($o in ($orph | Sort-Object -Unique)) { $areaBad += "V177 $($a.Base)_en.lua carries '$o' and no picker offers it - dead text or a spelling drift" }
    if (-not ($areaBad | Where-Object { $_ -like "*$($a.Base)*" -or $_ -like "*$($a.File)*" })) {
        $areaOk += "$($items.Count) $($a.Name) items, all with en+pt text on file"
    }
}
if ($areaBad) { foreach ($b in $areaBad) { Fail $b } }
else { Pass "V177/V178/V184 $($areaOk -join '; ')" }

# ---- V180: the main path level is worked out, never saved -----------------------------
# Two numbers for one fact is how B12 and B16 both started. The dots of a main path row are
# painted from the Discipline at every render; nothing writes them, and an empty row answers
# zero rather than inheriting the row above it.
$pathLevelFn = LuaFn $rootTxt 'pathLevel'
$mainRenderFn = LuaFn $rootTxt 'renderMainPaths'
if (-not $pathLevelFn) { Fail "V180 pathLevel not found on the root form - the level would have to come from somewhere else" }
elseif ($pathLevelFn -notmatch 'return 0;') { Fail "V180 pathLevel has no zero answer - an unclaimed or empty row would inherit a level (SPEC V180)" }
elseif (-not $mainRenderFn) { Fail "V180 renderMainPaths not found - nothing paints the read-only dots" }
elseif ($mainRenderFn -match 'setField\(') { Fail "V180 renderMainPaths writes to the sheet - the painted level would become a second saved number free to disagree with the Discipline" }
elseif ($mainRenderFn -notmatch 'pathLevel\(') { Fail "V180 renderMainPaths does not read pathLevel - it is painting from something else" }
elseif ($mainRenderFn -notmatch '\.checked\s*=') { Fail "V180 renderMainPaths sets no dot - the row would never light" }
else { Pass "V180 the main path dots are painted from the Discipline at every render and nothing is written back" }

# ---- V181/V182/V185/V186: the picker guard, and the door it comes through --------------
# The refusal is REVERTED through a dataLink, never from the combo's own onChange: a write
# made inside a control's dispatch does not survive it, which is how B36 and B38 both got
# their refusals ignored. Each rule speaks its own reason (SPEC V129).
$refusalFn2 = LuaFn $rootTxt 'pickRefusal'
$guardFn2   = LuaFn $rootTxt 'guardPick'
$guardBad = @()
if (-not $refusalFn2) { $guardBad += "pickRefusal not found on the root form" }
else {
    $r = NoComments $refusalFn2
    if ($r -notmatch 'value == ""') { $guardBad += "V15 pickRefusal does not let the empty item through - the revert below it would never terminate" }
    if ($r -notmatch 'pathLevel\(value, levels\) < 1') { $guardBad += "V182 a path whose blood sorcery is not on the sheet is accepted" }
    if ($r -notmatch 'sharesDisc\(') { $guardBad += "V181 nothing compares the owners of two main paths - a blood sorcery could take two" }
    if ($r -notmatch 'MAIN_PATH_ROWS') { $guardBad += "V181 the main path rule looks at no other row - it cannot see the duplicate" }
    if ($r -notmatch 'best < 1 then return') { $guardBad += "V185 a ritual whose blood sorcery is absent is accepted" }
    if ($r -notmatch 'best < need then return') { $guardBad += "V185 a ritual above what its blood sorcery allows is accepted" }
    $reasons = @([regex]::Matches($r, 'return "([^"]*)"') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
    if ($reasons.Count -lt 4) { $guardBad += "V129 pickRefusal gives $($reasons.Count) distinct reasons - the four rules it enforces are four different problems with four different fixes" }
}
if (-not $guardFn2) { $guardBad += "guardPick not found on the root form" }
else {
    $g2 = NoComments $guardFn2
    if ($g2 -notmatch 'pickRefusal\(field, newValue, levels\)') { $guardBad += "V186 guardPick does not ask pickRefusal about the new value" }
    if ($g2 -notmatch 'pickRefusal\(field, oldValue, levels\)') { $guardBad += "V186 guardPick reverts to oldValue without testing it - two illegal values would bounce forever" }
    if ($g2 -notmatch 'setField\(field, back\)') { $guardBad += "V186 guardPick does not write the revert" }
    if ($g2 -notmatch 'xpWarn\(why\)') { $guardBad += "V186 the refusal is silent - the combo would snap back with no reason given (SPEC V129)" }
}
$onChangeGuards = @()
foreach ($f in $files) {
    foreach ($cb in (Doc $f.FullName).SelectNodes("//comboBox[@onChange]")) {
        if ($cb.GetAttribute("onChange") -match 'guardPick\(') { $onChangeGuards += "$($f.Name): $($cb.GetAttribute("name"))" }
    }
}
if ($onChangeGuards) { $guardBad += "V186 guardPick is called from a comboBox onChange - $(($onChangeGuards) -join '; ') - the revert would not survive the dispatch (SPEC B36, B38)" }
$guardLinks = @()
foreach ($f in $files) {
    $t = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    foreach ($m in [regex]::Matches($t, '<dataLink[^>]*guardPick\(')) { $guardLinks += $f.Name }
}
if ($guardLinks.Count -eq 0) { $guardBad += "V186 no dataLink calls guardPick - nothing enforces the picker rules at all" }
if ($guardBad) { foreach ($b in $guardBad) { Fail "V181/V182/V185/V186 $b" } }
else { Pass "V181/V182/V185/V186 the four picker rules each speak their own reason, and the revert comes through $(($guardLinks | Sort-Object -Unique).Count) dataLink(s), never a combo's onChange" }

# ---- V183/V187: the ceiling is measured on the click, never swept at load --------------
# V183: a secondary path is capped at its blood sorcery minus one, tested INSIDE xpClick
# before anything is written (SPEC V135). V187: lowering a Discipline does NOT erase the
# paths and rituals bought under it - one click may not destroy what the player built, and
# a load-time sweep is exactly the shape that reopened V121.
$clickFn2 = LuaFn $rootTxt 'xpClick'
$sweepBad = @()
if (-not $clickFn2) { $sweepBad += "V183 xpClick not found on the root form" }
else {
    $c2 = NoComments $clickFn2
    if ($c2 -notmatch 'secPath_') { $sweepBad += "V183 xpClick does not special-case a secondary path row - the cap is not enforced where the dot is bought" }
    if ($c2 -notmatch 'markDot\(') { $sweepBad += "V183 xpClick never marks the dot - the check reads nothing (SPEC V20)" }
    $capIdx  = $c2.IndexOf('secPath_')
    $markIdx = $c2.IndexOf('markDot(')
    if ($capIdx -ge 0 -and $markIdx -ge 0 -and $capIdx -gt $markIdx) { $sweepBad += "V183/V135 the secondary path cap is tested AFTER the dot is written - a refused purchase would leave the dot behind" }
}
# The erasing sweep: a loop that clears a path or ritual field outside a click handler.
foreach ($fn in @('sheetReveal', 'applyTheme', 'applyLanguage', 'renderMainPaths', 'renderVampire')) {
    $body = LuaFn $rootTxt $fn
    if (-not $body) { continue }
    foreach ($m in [regex]::Matches((NoComments $body), 'setField\("(?:secPath_|mainPath_|ritual_|disc_|clanDisc_)')) {
        $sweepBad += "V187 $fn writes $($m.Value)... - a sweep over the saved rows is how one click comes to destroy what the player built (SPEC V138, V157)"
    }
}
if ($sweepBad) { foreach ($s in $sweepBad) { Fail $s } }
else { Pass "V183/V187 the secondary path ceiling is tested on the click before anything is written, and no render or reveal clears a saved row" }

# ---- V199 - V205: the picker filter (SPEC I25) -----------------------------------------
# The rule the guard enforces AFTER a pick is now also what decides which items a picker
# OFFERS. One predicate serves both, so a list cannot hold something the guard would throw
# back - and a new rule lands in one place instead of two that drift.
$filterBad = @()

$allowFn   = LuaFn $rootTxt 'pickAllowed'
$levelsFn  = LuaFn $rootTxt 'discLevels'
$vampFn    = LuaFn $hh6 'renderVampPickers'
$pickerFn  = [regex]::Match($hh6, '(?ms)local function pickerItems\(c, lang, era, levels\)(.*?)\n\t\t\tend;')

# V199: one predicate, one body. pickAllowed is the only door the filter has to the rule,
# and it is pickRefusal phrased as a yes - nothing more.
if (-not $allowFn) { $filterBad += "V199 pickAllowed is gone from the root form - the filter has no way to ask what is legal" }
elseif ((NoComments $allowFn) -notmatch 'pickRefusal\(field, value, levels\) == nil') {
    $filterBad += "V199 pickAllowed does not answer from pickRefusal - a second copy of the rule is how the list and the guard start disagreeing (SPEC I25)"
}
# The knowledge must not leak into WoD20.6: a table read there is a second test by definition.
foreach ($tbl in @('RITUAL_DISC', 'PATH_DISC', 'BLOOD_SORCERY')) {
    if ((NoComments $hh6) -match $tbl) {
        $filterBad += "V199 WoD20.6 reads $tbl - the list is deciding legality for itself instead of asking pickAllowed (SPEC I25)"
    }
}

if (-not $pickerFn.Success) {
    $filterBad += "V199 pickerItems is gone from WoD20.6, or no longer takes the level map - nothing filters a picker (SPEC I25, V205)"
} else {
    $pk = NoComments $pickerFn.Groups[1].Value

    if ($pk -notmatch 'pickAllowed\(field, raw, levels\)') {
        $filterBad += "V199 pickerItems does not ask pickAllowed - whatever drops an item now, it is not the one rule (SPEC V199)"
    }

    # V200: the row's own value survives its own list however illegal it went. A comboBox
    # whose value is not among its values renders BLANK, so dropping it would make lowering
    # a Discipline look like the sheet had thrown the row away (SPEC V187).
    if ($pk -notmatch 'local current\s*=' -or $pk -notmatch 'sheet\[field\]') {
        $filterBad += "V200 pickerItems never reads what the row is holding - the value would leave its own list and the combo would go blank (SPEC V187)"
    }
    if ($pk -notmatch 'raw ~= current') {
        $filterBad += "V200 the filter does not spare the row's own value - lowering a Discipline would blank the rows the player already filled"
    }
    if ($pk -notmatch 'raw ~= ""') {
        $filterBad += "V15/V200 the filter does not spare the empty item - a row could not be cleared once filled"
    }

    # V201, rewritten in the 68th round with SPEC I27. The source is the AUTHORED list and it
    # is now a CONSTANT: PICKER_LIST on the root form, which nothing writes. It used to be a
    # per-handle snapshot of c.values, and BOTH branches of that ended at the XML attribute -
    # so the moment T493 took the attribute away the snapshot would have caught an EMPTY list,
    # once and for ever, and every dropdown on the sheet would have come up blank with rdk
    # exiting 0 and this gate green. A constant cannot go stale the way a snapshot can.
    if ($pk -notmatch 'PICKER_LIST\[fieldRoot\(nm\)\]') {
        $filterBad += "V201 pickerItems does not start from PICKER_LIST - reading c.values back filters an already filtered list, which shrinks every render and never grows again when the Discipline goes up (SPEC B8, I27)"
    }
    if ((NoComments $hh6) -match 'AUTHORED_VALUES') {
        $filterBad += "V201 AUTHORED_VALUES is back - the snapshot it takes is of c.values, which T493 emptied; the authored list is PICKER_LIST now (SPEC I27)"
    }
    # Second leg (SPEC V201, 68th): the authored table is CONSTANT. One table now stands
    # behind twenty-five ritual combos, so a single table.remove would poison all of them at
    # once and there is no authored copy left anywhere to recover from.
    foreach ($mut in @('table\.insert\s*\(\s*PICKER_LIST', 'table\.remove\s*\(\s*PICKER_LIST', 'table\.sort\s*\(\s*PICKER_LIST')) {
        foreach ($f in $files) {
            $t = NoComments ([System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName)))
            if ($t -match $mut) { $filterBad += "V201 $($f.Name) mutates PICKER_LIST in place - it is the authored constant twenty-five combos share (SPEC V201, I27)" }
        }
    }
    $plWrites = [regex]::Matches((NoComments $rootLfmTxt), '(?m)^\s*PICKER_LIST\["(\w+)"\]\s*=\s*(.+)$')
    foreach ($w in $plWrites) {
        if ($w.Groups[2].Value -notmatch '^PICKER_LIST\["\w+"\];') {
            $filterBad += "V201 PICKER_LIST[$($w.Groups[1].Value)] is assigned something that is not an alias - the map is authored once and never written (SPEC V201)"
        }
    }

    # V202: items and values are written as one aligned pair, item N showing value N. The
    # filter only ever REMOVES a row of the pair - it never rewrites a value (SPEC V24).
    if ($pk -notmatch 'kept\[#kept \+ 1\]' -or $pk -notmatch 'shown\[#shown \+ 1\]') {
        $filterBad += "V202 the two lists are not appended together - one can fall out of step with the other and item N stops meaning value N"
    }
    # Unconditional, not `if filter then`: that guard was right only while the XML authored
    # values=. The eight unfiltered pickers took their values from the attribute and needed
    # items alone; with the list coming from PICKER_LIST a guarded write leaves them showing
    # every entry and STORING none (SPEC V202, I27).
    if ($pk -notmatch '(?m)^\s*c\.values = kept;') {
        $filterBad += "V202 pickerItems does not write values unconditionally - an unfiltered picker would show every entry and store none (SPEC I27)"
    }
    if ($pk -match 'if filter then c\.values = kept; end;') {
        $filterBad += "V202 the values write is still gated on `filter` - correct only while the XML authored values=, which T493 removed (SPEC I27)"
    }
    if ($pk -notmatch 'c\.items = shown;') {
        $filterBad += "V202 pickerItems no longer writes items - nothing reaches the dropdown"
    }

    # V203: the filter scope is its own table and narrower than the era's. A Discipline is
    # what the player BUYS: filtering its list by what he owns leaves a new sheet nineteen
    # empty combos. Fourth time this rule is asked for - B15, T472, B44, and now this.
    if ($pk -notmatch 'isFilterRow\(nm\)') {
        $filterBad += "V203 pickerItems does not ask whether the row is a FILTERED one - the scope would be the era's five roots (SPEC V197)"
    }
}

$filterTbl = [regex]::Match($hh6, '(?ms)local FILTER_ROW = \{(.*?)\}')
if (-not $filterTbl.Success) {
    $filterBad += "V203 FILTER_ROW is not declared - the filter has no scope of its own and would reuse the era's (SPEC I25)"
} else {
    $wantFilter = @('mainPath', 'secPath', 'ritual')
    $gotFilter  = @([regex]::Matches($filterTbl.Groups[1].Value, '(\w+)\s*=\s*true') | ForEach-Object { $_.Groups[1].Value })
    $missF = @($wantFilter | Where-Object { $gotFilter -notcontains $_ })
    $extraF = @($gotFilter | Where-Object { $wantFilter -notcontains $_ })
    if ($missF) { $filterBad += "V203 FILTER_ROW is missing $($missF -join ', ') - those rows would offer everything the book has (SPEC V182, V185)" }
    if ($extraF) { $filterBad += "V203 FILTER_ROW carries $($extraF -join ', ') - a Discipline picker filtered by what the player already owns leaves a new sheet empty (SPEC C)" }
}

# V204: a row count constant that does not match the XML is a loop that stops early in
# silence. RITUAL_ROWS said 20 while WoD20.14 drew 25 for three rounds, and only survived
# because nothing read it (SPEC B46).
#
# V248(a) rides along since the 85th round: three of these boxes end in rows the storyteller
# TYPES, and those rows have a count of their own. The total constant covers BOTH kinds - a
# loop over DISC_ROWS reaches the typed rows too, because a typed discipline is still a
# discipline with dots - and the typed ones must be the LAST rows of the box, which is what
# lets every reader say "picker = total - typed" instead of carrying a list of indices.
$rowSpec = @(
    @{ Const = 'CLAN_DISC_ROWS'; File = 'WoD20.12.lfm'; Row = 'DiscRow';     Field = 'clanDisc'; Free = '';                   FreeRow = '' },
    @{ Const = 'DISC_ROWS';      File = 'WoD20.12.lfm'; Row = 'DiscRow';     Field = 'disc';     Free = 'DISC_FREE_ROWS';     FreeRow = 'DiscFreeRow' },
    @{ Const = 'MAIN_PATH_ROWS'; File = 'WoD20.13.lfm'; Row = 'MainPathRow'; Field = 'mainPath'; Free = '';                   FreeRow = '' },
    @{ Const = 'SEC_PATH_ROWS';  File = 'WoD20.13.lfm'; Row = 'SecPathRow';  Field = 'secPath';  Free = 'SEC_PATH_FREE_ROWS'; FreeRow = 'SecPathFreeRow' },
    @{ Const = 'RITUAL_ROWS';    File = 'WoD20.14.lfm'; Row = 'RitualRow';   Field = 'ritual';   Free = 'RITUAL_FREE_ROWS';   FreeRow = 'RitualFreeRow' },
	@{ Const = 'SPECIALITY_ROWS'; File = 'WoD20.1.lfm';  Row = 'SpecialityRow'; Field = 'speciality'; Free = 'SPECIALITY_FREE_ROWS'; FreeRow = 'SpecialityFreeRow'; Attr = 'num' },
	@{ Const = 'BACKGROUND_ROWS'; File = 'WoD20.2.lfm';  Row = 'OpenAbility';   Field = 'background'; Free = 'BACKGROUND_FREE_ROWS'; FreeRow = 'OpenAbilityFreeRow' }
)
foreach ($rs in $rowSpec) {
    $m = [regex]::Match($rootTxt, "(?m)^\s*$($rs.Const)\s*=\s*(\d+);")
    if (-not $m.Success) { $filterBad += "V204 $($rs.Const) is not declared on the root form - the count would live in the XML alone"; continue }
    $declared = [int]$m.Groups[1].Value
    $txt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir $rs.File)))

    # Most boxes call their template with field="<root>_<n>"; SPECIALTIES calls it with num="<n>"
    # and builds the three field names inside the template (SPEC V147). Which attribute carries
    # the index is part of the row spec, so one census answers for both shapes.
    $keyRe = if ($rs.Attr -eq 'num') { "num=`"(\d+)`"" } else { "field=`"$($rs.Field)_(\d+)`"" }
    $pickIdx = @([regex]::Matches($txt, "<$($rs.Row)\s+$keyRe") | ForEach-Object { [int]$_.Groups[1].Value })
    $freeIdx = @()
    if ($rs.FreeRow) { $freeIdx = @([regex]::Matches($txt, "<$($rs.FreeRow)\s+$keyRe") | ForEach-Object { [int]$_.Groups[1].Value }) }

    $drawn = $pickIdx.Count + $freeIdx.Count
    if ($declared -ne $drawn) {
        $filterBad += "V204 $($rs.Const) says $declared and $($rs.File) draws $drawn - every loop that reads it stops short, in silence (SPEC B46)"
    }

    if (-not $rs.Free) {
        if ($freeIdx.Count -gt 0) { $filterBad += "V248 $($rs.File) draws $($freeIdx.Count) typed row(s) for $($rs.Field), a box SPEC I45 gives none - the clan and main path boxes are picked, both of them" }
        continue
    }

    $mf = [regex]::Match($rootTxt, "(?m)^\s*$($rs.Free)\s*=\s*(\d+);")
    if (-not $mf.Success) { $filterBad += "V248 $($rs.Free) is not declared on the root form - the typed rows would be counted in the XML alone (SPEC V204)"; continue }

    $declaredFree = [int]$mf.Groups[1].Value
    if ($declaredFree -ne $freeIdx.Count) {
        $filterBad += "V248 $($rs.Free) says $declaredFree and $($rs.File) draws $($freeIdx.Count) - every reader that says 'picker = total - typed' would be reading a picker row as typed, or the other way round"
    } elseif ($freeIdx.Count -gt 0 -and $pickIdx.Count -gt 0 -and ($freeIdx | Measure-Object -Minimum).Minimum -le ($pickIdx | Measure-Object -Maximum).Maximum) {
        $filterBad += "V248 $($rs.File) has a typed $($rs.Field) row above a picked one - typed rows are the LAST ones, which is the whole of what makes 'total - typed' true (SPEC I45)"
    }
}

# V205: the Disciplines are read ONCE per render and handed down. Asking per item is
# twenty-five combos x 284 items x nineteen rows x five dots on every Discipline dot click:
# the tab locks up and there is no error for anyone to see.
if (-not $levelsFn) { $filterBad += "V205 discLevels is gone from the root form - there is no map to hand down" }
elseif ((NoComments $levelsFn) -notmatch 'CLAN_DISC_ROWS' -or (NoComments $levelsFn) -notmatch 'DISC_ROWS') {
    $filterBad += "V205 discLevels does not walk both Discipline boxes - a Discipline in an open slot would count for nothing (SPEC V178)"
}
# Word-anchored since 2026-08-22 (SPEC B50, V222): -match is case-INSENSITIVE in PowerShell,
# so the bare 'discLevel\(' also matched maxDiscLevel( and reddened a check that is about
# something else entirely. The boundary keeps it on the function this invariant names.
if ($rootTxt -match '\bdiscLevel\(') {
    $filterBad += "V205 the per-name discLevel is back - two readings of the same rating is one more than this sheet has room for (SPEC V145)"
}
if ($refusalFn2 -and (NoComments $refusalFn2) -match 'discLevels\(') {
    $filterBad += "V205 pickRefusal builds the map itself - that is the per-item walk this invariant exists to stop"
}
if ($refusalFn2 -and (NoComments $refusalFn2) -notmatch 'levels\[') {
    $filterBad += "V205 pickRefusal does not read the map it is given - the level is coming from somewhere else (SPEC V199)"
}
foreach ($fn in @('renderVampPickers', 'renderMainPaths')) {
    $body = if ($fn -eq 'renderVampPickers') { $vampFn } else { LuaFn $rootTxt $fn }
    if (-not $body) { $filterBad += "V205 $fn not found - the filter has no trigger"; continue }
    $n = ([regex]::Matches((NoComments $body), 'discLevels\(\)')).Count
    if ($n -ne 1) { $filterBad += "V205 $fn builds the level map $n time(s) - it must be built once and handed to every item" }
}
foreach ($fn in @('applyLanguage', 'applyTheme')) {
    $m = [regex]::Match($hh6, "(?ms)local function $fn\(.*?\n\t\t\tend;")
    if (-not $m.Success) { $filterBad += "V205 $fn not found in WoD20.6"; continue }
    $n = ([regex]::Matches((NoComments $m.Value), 'discLevels\(\)')).Count
    if ($n -ne 1) { $filterBad += "V205 $fn builds the level map $n time(s) - the traversal must build it once, outside its loop" }
}

# V205, second leg (SPEC T491, B48): the map is read once per render, and now the TRANSFORMED
# pair is built once per LIST rather than once per control. Twenty-five ritual combos read the
# same 284 authored items and each rebuilt them, eraName plus the PT lookup item by item, on
# every one of the three passes an opening makes. Nothing is invalidated here either: the stamp
# names what the answer depends on, so a stale entry is never SERVED, it is simply never found.
if ($pickerFn.Success) {
    $pkm = NoComments $pickerFn.Groups[1].Value

    # BOTH ends, named apart. A memo that is written and never read is the shape of SPEC B7:
    # the string is there, the work still happens, and this check reports on nothing.
    if ($pkm -notmatch 'hit\s*= memo\.lists\[key\];') {
        $filterBad += "V205 pickerItems never READS the memo - the same list is rebuilt once per control, and the ritual rows alone pay that 25 times a pass (SPEC T491, B48)"
    }
    elseif ($pkm -notmatch 'memo\.lists\[key\] = \{ kept = kept, shown = shown \};' -or $pkm -notmatch 'if hit == nil then') {
        $filterBad += "V205 pickerItems never STORES the pair it built, or does not gate the build on the miss - the read would find nothing and every control would rebuild anyway (SPEC T491)"
    }
    # discLevels() hands back a FRESH table each traversal, so this identity test IS "a new
    # render started". Drop it and a Discipline dot click repaints the list it just invalidated.
    elseif ($pkm -notmatch 'memo\.levels ~= levels') {
        $filterBad += "V205 the memo is not dropped when the level map changes - a Discipline dot click would repaint the list it just invalidated (SPEC T491, I25)"
    }
    elseif ($pkm -notmatch 'memo\.stamp ~= stamp' -or $pkm -notmatch 'tostring\(lang\) \.\. "\|" \.\. tostring\(era\)') {
        $filterBad += "V205 the memo is not stamped with language and era - switching either would leave the old era's words on the rows (SPEC T469, V197)"
    }
    # One main path per blood sorcery (SPEC V181) makes that answer per ROW: row 1 offers what
    # row 2 must not. Key those five by anything shared and one row's list reaches all five.
    elseif ($pkm -notmatch '\(root == "mainPath"\) and nm or root') {
        $filterBad += "V205 the memo key does not single out mainPath - its answer is per row, so row 1's list would be served to row 2 (SPEC V181)"
    }
    # The row's own value only changes the list when the filter would otherwise drop it
    # (SPEC V200). Leave it out of the key and a row holding an illegal value hands that value
    # to every other row on the same list.
    elseif ($pkm -notmatch 'not pickAllowed\(field, current, levels\)' -or $pkm -notmatch '\.\. "\|" \.\. odd') {
        $filterBad += "V205 the memo key ignores a row's own illegal value - it would leak into every other row sharing the list, or split the key for every filled row (SPEC V200)"
    }
}

# The trigger: what the filter READS has to be what the links WATCH (SPEC V123). Both areas
# need the nineteen Discipline slots and the ninety-five dots under them.
foreach ($fn in @('WoD20.13.lfm', 'WoD20.14.lfm')) {
    $txt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir $fn)))
    $watched = @()
    foreach ($m in [regex]::Matches($txt, '<dataLink[^>]*renderVampPickers\(')) {
        $lnk = [regex]::Match($txt.Substring($m.Index), '^<dataLink[^>]*>')
        if ($lnk.Success) { foreach ($f in [regex]::Matches($lnk.Value, "'([^']+)'")) { $watched += $f.Groups[1].Value } }
    }
    if ($watched.Count -eq 0) { $filterBad += "V203 $fn never calls renderVampPickers from a dataLink - its lists would never be rebuilt (SPEC I25)"; continue }
    $needed = @()
    1..4  | ForEach-Object { $needed += "clanDisc_$_" }
    1..15 | ForEach-Object { $needed += "disc_$_" }
    1..4  | ForEach-Object { $n = $_; 1..5 | ForEach-Object { $needed += "clanDisc_${n}_$_" } }
    1..15 | ForEach-Object { $n = $_; 1..5 | ForEach-Object { $needed += "disc_${n}_$_" } }
    $gap = @($needed | Where-Object { $watched -notcontains $_ })
    if ($gap.Count -gt 0) {
        $filterBad += "V203 $fn watches $($needed.Count - $gap.Count) of the $($needed.Count) Discipline fields - $($gap[0]) and $($gap.Count - 1) other(s) would move without the lists noticing (SPEC V123)"
    }
}
if (-not (Test-Path (Join-Path $dir 'WoD20.12.lfm'))) { $filterBad += "V203 WoD20.12.lfm is gone" }
else {
    $hh12txt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir 'WoD20.12.lfm')))
    if ($hh12txt -match 'renderVampPickers') {
        $filterBad += "V203 WoD20.12 calls renderVampPickers - the Discipline pickers are not filtered, and a new sheet would find them empty (SPEC C)"
    }
}

if ($filterBad) { foreach ($b in $filterBad) { Fail $b } }
else { Pass "V199-V205 one predicate feeds both the list and the guard; the lists filter from the authored constant, keep their own value, and are rebuilt from a map read once per render" }

# ---- V208 / V211 / V212: the map itself (SPEC I27, 68th round) -----------------------
# T493 took every picker list out of the XML and put it in one map on the root form. These
# three measure the map: that it holds each list ONCE, that every picker actually reaches
# it, and that the sixty clan names did not quietly fork into two spellings.
$v208Bad = @()

# V208a: no list is in the map twice. The three ALIASES are excluded on purpose - they are
# identity assignments (PICKER_LIST["secPath"] = PICKER_LIST["mainPath"]), which is one
# table with two keys and the exact opposite of a copy (SPEC V211c).
$plSeen = @{}
foreach ($k in ($PICKER.Keys | Sort-Object)) {
    if ($PICKER_ALIAS.ContainsKey($k)) { continue }
    $sig = ($PICKER[$k] -join ([char]1))
    if ($plSeen.ContainsKey($sig)) {
        $v208Bad += "PICKER_LIST['$k'] and PICKER_LIST['$($plSeen[$sig])'] hold the same $($PICKER[$k].Count) entries twice - one of them belongs as an alias (SPEC V211c)"
    } else { $plSeen[$sig] = $k }
}

# V208b: nothing in the migrated scope still authors a list inline. A survivor is a second
# home for a list that is supposed to have exactly one.
foreach ($f in $files) {
    if ($f.Name -notin $PICKER_SCOPE) { continue }
    foreach ($cb in (Doc $f.FullName).SelectNodes("//comboBox[@name]")) {
        if ($cb.GetAttribute("name") -notlike 'cbo*') { continue }
        if ($cb.HasAttribute("items") -or $cb.HasAttribute("values")) {
            $v208Bad += "$($f.Name)/$($cb.GetAttribute('name')) still authors items=/values= inline - the list would live in two places (SPEC I27)"
        }
    }
}
if ($v208Bad) { foreach ($b in $v208Bad) { Fail "V208 $b" } }
elseif ($PICKER.Count -eq 0) { Fail "V208 PICKER_LIST parsed to nothing - the check verifies nothing (SPEC V20, B7)" }
else { Pass "V208 $($plSeen.Count) distinct picker lists, $($PICKER.Count) keys, no list authored twice" }

# V211: the map covers every picker, is findable, and its aliases are identity.
$v211Bad = @()
if (-not $plRegion.Success) { $v211Bad += "the PICKER_LIST_BEGIN/END markers are gone from the root form - nothing below reads anything (SPEC V20, B7)" }

# (a) every cbo* in the migrated scope resolves to a key. A combo with no key falls through
# to c.values, which T493 emptied: a blank dropdown that rdk and this gate both call fine.
# This is the single most likely way the migration breaks, and the quietest.
$v211Seen = 0
foreach ($f in $files) {
    if ($f.Name -notin $PICKER_SCOPE) { continue }
    foreach ($cb in (Doc $f.FullName).SelectNodes("//comboBox[@name]")) {
        $nm = $cb.GetAttribute("name")
        if ($nm -notlike 'cbo*') { continue }
        $v211Seen++
        $k = PickerKeyOf $nm $cb.GetAttribute("field") (TplOf $cb)
        if (-not $k) { $v211Bad += "$($f.Name)/$nm resolves to no PICKER_LIST key at all" }
        elseif (-not $PICKER.ContainsKey($k)) { $v211Bad += "$($f.Name)/$nm wants PICKER_LIST['$k'] and the map has no such key - the dropdown opens EMPTY and nothing says so" }
        elseif (@($PICKER[$k]).Count -eq 0) { $v211Bad += "$($f.Name)/$nm reads PICKER_LIST['$k'], which is empty" }
    }
}
if ($v211Seen -eq 0) { $v211Bad += "no cbo* picker was examined in the migrated scope - the check verifies nothing (SPEC V20, B7)" }

# (c) the aliases are identity, never a second literal list.
foreach ($a in $PICKER_ALIAS.Keys) {
    if (-not $PICKER.ContainsKey($PICKER_ALIAS[$a])) {
        $v211Bad += "PICKER_LIST['$a'] aliases '$($PICKER_ALIAS[$a])', which the map does not declare"
    }
}
if ($v211Bad) { foreach ($b in $v211Bad) { Fail "V211 $b" } }
else { Pass "V211 all $v211Seen pickers in scope resolve to a list, found by marker, with $($PICKER_ALIAS.Count) alias(es) by identity" }

# V212: the sixty clan names exist twice - as the ordered list the picker shows, and as the
# keys of CLANS (SPEC I17), which maps a clan to its three fixed Disciplines. Not a V208
# violation: the two have different SHAPES and CLANS carries data the picker does not. What
# they share is a key set, so what they risk is DRIFT. Compared here in the SOURCE, never
# read at runtime, so CLANS stays the dormant table V174 requires.
$clanTbl = [regex]::Match($rootLfmTxt, '(?s)local CLANS = \{(.*?)\n\t+\};')
$v212Bad = @()
if (-not $clanTbl.Success) { $v212Bad += "the CLANS region is gone from the root form - the check reads nothing (SPEC V20)" }
else {
    $clanKeys = @([regex]::Matches($clanTbl.Groups[1].Value, '\["([^"]+)"\]\s*=\s*\{') | ForEach-Object { $_.Groups[1].Value })
    $clanPick = @($PICKER['clan'] | Where-Object { $_ -ne '' })
    if ($clanKeys.Count -eq 0) { $v212Bad += "CLANS parsed to zero clans - the check verifies nothing (SPEC V20, B7)" }
    elseif ($clanPick.Count -eq 0) { $v212Bad += "PICKER_LIST['clan'] is empty - there is nothing to compare CLANS against" }
    else {
        foreach ($c in $clanPick) { if ($clanKeys -notcontains $c) { $v212Bad += "'$c' is offered by the picker and absent from CLANS" } }
        foreach ($c in $clanKeys) { if ($clanPick -notcontains $c) { $v212Bad += "'$c' is keyed in CLANS and the picker does not offer it" } }
    }
}
if ($v212Bad) { foreach ($b in $v212Bad) { Fail "V212 $b" } }
else { Pass "V212 the picker and CLANS name the same $(@($PICKER['clan'] | Where-Object { $_ -ne '' }).Count) clans" }

# ---- zero-guards for the five sites that would otherwise go GREEN covering less --------
# SPEC V209 a/c/d/f/g. Each of these reads a list; none of them had a guard that fires when
# the list stops arriving, so after T493 they would have passed while verifying a fraction
# of what they used to. V24 got its guard inline above; these are the other four.
if ($visiblePickerItems -eq 0) { Fail "V17/V28 no picker item reached the visible-string set - V9, V10 and V28 all measure less and none of them says so (SPEC V20, B7, V209a)" }
else { Pass "V17/V28 $visiblePickerItems picker items reached the visible-string set" }


# ---- V213: the old sheet name does not survive anywhere in the new plugin -------------
# A half-done rename is the failure mode here, and nothing downstream reports it: WoD20.6
# carries twelve absolute "/WoD20th/images/..." theme paths and the root carries fourteen
# <import file="WoD20.<n>.lfm"/>, so one survivor points at a file that is not there. The
# rdk will not say so - B49 proved it exits 1 with no message at all - which leaves the
# source as the only place the difference is still legible.
if ($files.Count -ne 15) { Fail "V213 read $($files.Count) .lfm, expected 15 - the check would pass having looked at less (SPEC V209)" }
$v213Bad = @()
$modTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $plugin "module.xml")))
foreach ($f in $files) {
    $t = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    foreach ($pat in @('HuntersHunted', 'frmHH_', 'HH\.\d+', 'Hunters Hunted - Mortal')) {
        foreach ($m in [regex]::Matches($t, $pat)) { $v213Bad += "$($f.Name) still carries '$($m.Value)'" }
    }
}
foreach ($pat in @('HuntersHunted', 'HH\.\d+')) {
    foreach ($m in [regex]::Matches($modTxt, $pat)) { $v213Bad += "module.xml still carries '$($m.Value)'" }
}
if ($v213Bad) { foreach ($b in ($v213Bad | Select-Object -First 12)) { Fail "V213 $b" } }
else { Pass "V213 no HuntersHunted / HH.<n> leftover across 15 .lfm + module.xml" }

# ---- V213: the credit to the base plugin is an OBLIGATION, not a tolerance ------------
# The user asked for the thank-you to stay when the plugin stopped being its first
# author's, and then (2026-08-22) cut it down to a single line. This check holds that
# line in the two places the sheet itself carries it; V230 further down owns the rest of
# the rule - that the brand is gone, and that the name appears nowhere else at all.
$creditTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.6.lfm")))
$creditBad = @()
foreach ($needle in @('text="Based on the sheet plugin by Vinny (Ambesek)"',
                      '["Based on the sheet plugin by Vinny (Ambesek)"] = "Baseado no plugin de fichas de Vinny (Ambesek)"')) {
    if ($creditTxt.IndexOf($needle) -lt 0) { $creditBad += "missing: $needle" }
}
if ($creditBad) { foreach ($b in $creditBad) { Fail "V213 credit $b" } }
else { Pass "V213 the credit to the base plugin stands on the Settings tab (label + pt entry)" }

# ---- V213: the Game roster keeps its "Mortal" item ------------------------------------
# The item read "Hunters Hunted" until the 82nd round, when the user renamed it (SPEC C,
# V233): this is a mortal's sheet and the roster says so. Counting the bare word would be
# a HOLE - "Mortal" already appears inside two power names in this same file - so the
# three sites are asserted as needles, the shape the credit check above already uses.
$rosterBad = @()
foreach ($needle in @("items=""{'Vampire', 'Mortal', 'Mage'}""",
                      "values=""{'Vampire', 'Mortal', 'Mage'}""",
                      '<dataLink field="game" defaultValue="Mortal"/>')) {
    if ($creditTxt.IndexOf($needle) -lt 0) { $rosterBad += "missing: $needle" }
}
if ($rosterBad) { foreach ($b in $rosterBad) { Fail "V213 Game roster $b" } }
else { Pass "V213 the Game roster offers Vampire, Mortal, Mage and defaults to Mortal" }

# ---- V214: the old plugin no longer declares the sheet --------------------------------
# V4 hunts the NEW dataType, so a forgotten copy under the old plugin is invisible to it
# and alive for the Firecast: two sheets in the list, the old one requiring desc*.lua that
# no longer sit beside it.
$oldPlugin = Join-Path $PSScriptRoot "Plugins\Sheets\World of Darkness 20th"
$v214Bad = @()
if (-not (Test-Path -LiteralPath $oldPlugin)) { $v214Bad += "the old plugin folder is gone - V214 measured nothing (SPEC V209)" }
if (Test-Path -LiteralPath (Join-Path $oldPlugin "HuntersHunted")) { $v214Bad += "HuntersHunted/ is still under the old plugin" }
# The EIGHT halves T495 made, not the four monoliths they replaced: with the old names gone
# from the repo the old list would be vacuously true, and a forgotten copy of the new modules
# under the old plugin would light nothing (SPEC V210, V20).
foreach ($m in @('descDisc_en.lua', 'descDisc_pt.lua', 'descNumina_en.lua', 'descNumina_pt.lua',
                 'descPath_en.lua', 'descPath_pt.lua', 'descRitual_en.lua', 'descRitual_pt.lua')) {
    if (Test-Path -LiteralPath (Join-Path $oldPlugin $m)) { $v214Bad += "$m is still at the old plugin root" }
}
$v214Stale = Select-String -Path (Join-Path $oldPlugin "*\*.lfm") -Pattern 'Ambesek\.HuntersHunted\.20th' -ErrorAction SilentlyContinue
if ($v214Stale) { $v214Bad += "the old dataType is still declared in $($v214Stale[0].Filename)" }
if ($v214Bad) { foreach ($b in $v214Bad) { Fail "V214 $b" } }
else { Pass "V214 the old plugin is back to the five Ambesek sheets" }

# ---- V215: every require() resolves at the NEW plugin root -----------------------------
# require is relative to the PLUGIN root, not to the sheet folder, so moving the sheet
# without the four desc modules breaks in runtime and nowhere else: the rdk does not
# resolve require (SPEC B1) and every other check here stays green.
$v215Bad = @()
$v215Seen = 0
foreach ($f in $files) {
    $t = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    foreach ($m in [regex]::Matches($t, 'require\("([^"]+\.lua)"\)')) {
        $v215Seen++
        $mod = $m.Groups[1].Value
        if (-not (Test-Path -LiteralPath (Join-Path $plugin $mod))) { $v215Bad += "$($f.Name) requires '$mod', missing at the plugin root" }
    }
    # T495: a description module is named by the language - require("desc<X>_" .. lang ..
    # ".lua") - so BOTH halves have to be on file. Matched on the literal alone this check
    # would have counted zero and reddened on its own zero-guard while nothing was wrong.
    foreach ($m in [regex]::Matches($t, 'require\("([A-Za-z0-9]+)_"\s*\.\.\s*\w+\s*\.\.\s*"(\.lua)"\)')) {
        foreach ($lang in @('en', 'pt')) {
            $v215Seen++
            $mod = "$($m.Groups[1].Value)_$lang$($m.Groups[2].Value)"
            if (-not (Test-Path -LiteralPath (Join-Path $plugin $mod))) { $v215Bad += "$($f.Name) builds '$mod' out of the language and it is missing at the plugin root" }
        }
    }
}
if ($v215Seen -eq 0) { Fail "V215 found no require() at all - the check verified nothing (SPEC V209, B7)" }
elseif ($v215Bad) { foreach ($b in ($v215Bad | Sort-Object -Unique)) { Fail "V215 $b" } }
else { Pass "V215 all $v215Seen require() calls resolve at the plugin root" }

# ---- V216: the id charset the rdk actually enforces ------------------------------------
# Alphanumerics, underscore and dot, 5..40 - the rule is written in the module.xml that
# "rdk -p" generates. A hyphen makes rdk -c and rdk -l exit 1 with NO message and emit no
# .rpk, which is byte-for-byte the signature of a Lua syntax error (SPEC B19), so the only
# cheap place to tell the two apart is here, before the rdk runs at all (SPEC B49).
$idRule = '^[A-Za-z0-9_.]{5,40}$'
$v216Bad = @()
$idM = [regex]::Match($modTxt, '<id>([^<]*)</id>')
if (-not $idM.Success) { $v216Bad += "module.xml declares no <id>" }
elseif ($idM.Groups[1].Value -notmatch $idRule) { $v216Bad += "module.xml <id> '$($idM.Groups[1].Value)' breaks it" }
$v216Seen = 0
foreach ($f in $files) {
    $t = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    foreach ($m in [regex]::Matches($t, 'dataType="([^"]*)"')) {
        $v216Seen++
        if ($m.Groups[1].Value -notmatch $idRule) { $v216Bad += "$($f.Name) dataType '$($m.Groups[1].Value)' breaks it" }
    }
}
if ($v216Seen -eq 0) { Fail "V216 found no dataType at all - the check verified nothing (SPEC V209)" }
elseif ($v216Bad) { foreach ($b in $v216Bad) { Fail "V216 $b (alphanumerics, underscore, dot, 5..40 - SPEC B49)" } }
else { Pass "V216 <id> and $v216Seen dataType match the rdk id rule" }

# Comments come off before either of the next two checks reads the form. Both of them were
# caught reddening over PROSE by their own probe (SPEC V222): a comment saying GEN_MAX = { or
# naming declareTrait("bloodPool is a comment, not a second map and not a declaration.
$rootCode = NoComments $rootTxt

# ---- V218: one GEN->MAX map, and both readers on it ------------------------------
# The label says what the ceiling is and xpClick enforces it. Two copies is how the number
# shown and the number charged start disagreeing, and the sheet would be lying on screen
# about a rule it applies itself (SPEC B46 is the same shape: a constant with no reader).
$genDecl = [regex]::Matches($rootCode, 'GEN_MAX\s*=\s*\{')
$genReads = [regex]::Matches($rootCode, 'GEN_MAX\[')
$ceilReads = [regex]::Matches($rootCode, 'maxDiscLevel\(\)')
if ($genDecl.Count -ne 1) { Fail "V218 GEN_MAX is declared $($genDecl.Count) time(s) - the label and the ceiling must read one map" }
elseif ($genReads.Count -lt 1) { Fail "V218 nothing indexes GEN_MAX - the map has no reader" }
elseif ($ceilReads.Count -lt 3) { Fail "V218 maxDiscLevel has $($ceilReads.Count - 1) reader(s) - the label and the refusal must share it" }
else { Pass "V218 one GEN_MAX, read by the label and by the refusal" }

# ---- V219: the blood pool is free, and is not a trait -----------------------------
# Blood is spent and regained inside a scene, so these mark themselves. What must stay true
# is that nothing prices them: no declareTrait, no ledger line, no xpClick on the click.
$bpDoc = Doc (Join-Path $dir "WoD20.11.lfm")
$bpDots = @($bpDoc.SelectNodes("//imageCheckBox") | Where-Object { $_.GetAttribute("field") -match '^bloodPool_\d+$' })
if ($bpDots.Count -ne 20) { Fail "V219 the blood pool has $($bpDots.Count) dots, expected 20 (SPEC I29)" }
elseif (@($bpDots | Where-Object { $_.GetAttribute("autoChange") -eq 'false' }).Count) { Fail "V219 a blood pool dot was told not to mark itself - it is a resource, not a rating" }
elseif (@($bpDots | Where-Object { $_.GetAttribute("onClick") -ne "" }).Count) { Fail "V219 a blood pool dot runs something on the click - nothing here may reach xpClick" }
elseif ($rootCode -match 'declareTrait\("bloodPool') { Fail "V219 bloodPool is declared in XP_TRAIT - it would be priced and would write ledger lines" }
elseif ($rootCode -notmatch 'bloodPool_1 == nil') { Fail "V219 the ten-dot seed is gone - a new sheet would open empty (SPEC I29)" }
else { Pass "V219 twenty free blood pool dots, none of them a trait" }

# ---- V220: the ceiling refuses BEFORE anything is written -------------------------
# Same spot and same shape as the path ceiling it sits beside. A guard that lets the mark
# land and argues afterwards cost three rounds once already (SPEC B38, V135).
$clickBody = LuaFn $rootTxt 'xpClick'
if (-not $clickBody) { Fail "V220 xpClick not found on the root form" }
else {
    $cb = NoComments $clickBody
    $capAt = $cb.IndexOf("maxDiscLevel()")
    $markAt = $cb.IndexOf("markDot(")
    if ($capAt -lt 0) { Fail "V220 nothing in xpClick asks for the generation ceiling" }
    elseif (-not $cb.Contains('"^clanDisc_%d+$"')) { Fail "V220 the ceiling does not cover clan Discipline dots" }
    elseif (-not $cb.Contains('"^disc_%d+$"')) { Fail "V220 the ceiling does not cover out-of-clan Discipline dots" }
    elseif ($cb -notmatch 'genCap ~= nil') { Fail "V220 the ceiling applies with no generation chosen - a mortal with no domitor is not a fourteenth-generation ghoul (SPEC V220a)" }
    elseif ($markAt -ge 0 -and $capAt -gt $markAt) { Fail "V220 the ceiling is asked after the dot is marked - a mark made inside onChange does not come back (SPEC B38)" }
    else { Pass "V220 the generation ceiling refuses before anything is written" }
}

# ---- V221: the sub-tabs sit BELOW the boxes, not under them -----------------------
# V190 catches two siblings claiming one client rect. It does not catch an absolute layout
# sitting under a tabControl that still claims it - same symptom as B41 (content vanishes),
# different door, so this one measures geometry.
$vampDoc = Doc (Join-Path $dir "WoD20.11.lfm")
$vampStrip = $vampDoc.SelectSingleNode("//layout[@name='vampStrip']")
$vampPanes = @($vampDoc.SelectNodes("//scrollBox/layout[import]"))
if ($null -eq $vampStrip) { Fail "V221 vampStrip is gone from WoD20.11 - the sub-tabs have no strip (SPEC I32)" }
elseif ($vampStrip.GetAttribute("align")) { Fail "V221 vampStrip claims align='$($vampStrip.GetAttribute('align'))' - whatever is authored above it would be drawn under it (SPEC B41)" }
elseif (-not $vampPanes.Count) { Fail "V221 no sub-tab pane found in WoD20.11 - this check measured nothing (SPEC V209)" }
else {
    $lowest = 0
    foreach ($l in $vampDoc.SelectNodes("//scrollBox/layout")) {
        if ($l.SelectSingleNode("import")) { continue }   # a pane is not a box (V40)
        if ($l.GetAttribute("name") -eq 'vampStrip') { continue }
        $b = [int]$l.GetAttribute("top") + [int]$l.GetAttribute("height")
        if ($b -gt $lowest) { $lowest = $b }
    }
    $stripTop = [int]$vampStrip.GetAttribute("top")
    $stripEnd = $stripTop + [int]$vampStrip.GetAttribute("height")
    $paneTops = @($vampPanes | ForEach-Object { [int]$_.GetAttribute("top") } | Sort-Object -Unique)
    if ($lowest -eq 0) { Fail "V221 no box was found above the sub-tabs - this check measured nothing (SPEC V209)" }
    elseif ($stripTop -lt $lowest) { Fail "V221 vampStrip starts at $stripTop, inside the boxes that end at $lowest" }
    elseif ($paneTops.Count -ne 1) { Fail "V221 the sub-tab panes start at $($paneTops -join ', ') - they stack on ONE rect (SPEC I32)" }
    elseif ($paneTops[0] -lt $stripEnd) { Fail "V221 the panes start at $($paneTops[0]), under the strip that ends at $stripEnd" }
    else { Pass "V221 the strip starts at $stripTop clear of the boxes ending at $lowest, and the panes at $($paneTops[0]) clear of the strip" }
}

# ---- V223: nothing calls a `local function` from above the line declaring it ------
# Lua resolves a non-local name at COMPILE time, so a body written above the `local` that
# names it compiles to a GETGLOBAL and calls nil at runtime. That is invisible to every
# verifier this round has: `rdk -l` exits 0 because an undefined global is legal Lua, and
# the other 443 checks read structure, never order. It cost the user the Max Discipline
# Level label, dead in BOTH paths while the gate stayed green (SPEC B51, V223).
#
# Measured on the 73rd: 24 local functions on the root form and exactly ONE violation in
# the whole sheet - the one B51 is about. So this check ships with zero teeth left, by
# design: it is a regression guard, not an audit. The convention it defends is measured,
# not invented - a function called from ANOTHER .lfm is global, an internal helper is
# local - so the fix for a hit here is to move the CALLER down, never to promote the
# helper (that spends a name in a namespace shared with every plugin Firecast loads).
$orderBad = @()
$orderSeen = 0
foreach ($f in $files) {
    $ls = [System.IO.File]::ReadAllLines($f.FullName)
    $decl = @{}
    for ($i = 0; $i -lt $ls.Count; $i++) {
        $m = [regex]::Match($ls[$i], '^\s*local function ([A-Za-z_][A-Za-z0-9_]*)')
        if ($m.Success -and -not $decl.ContainsKey($m.Groups[1].Value)) { $decl[$m.Groups[1].Value] = $i }
    }
    foreach ($nm in $decl.Keys) {
        $orderSeen++
        for ($i = 0; $i -lt $decl[$nm]; $i++) {
            if ($ls[$i] -match '^\s*(--|<!--)') { continue }   # prose, not a call
            if ($ls[$i] -match ('\b' + $nm + '\s*\(')) {
                $orderBad += "$($f.Name):$($i + 1) calls $nm(), which is local from line $($decl[$nm] + 1) down"
            }
        }
    }
}
if ($orderSeen -lt 20) { Fail "V223 only $orderSeen local function(s) were collected - the root form alone had 24, so this check is measuring almost nothing (SPEC V209)" }
elseif ($orderBad.Count) { foreach ($b in $orderBad) { Fail "V223 $b - Lua compiles that as a GETGLOBAL and it is nil at runtime (SPEC B51)" } }
else { Pass "V223 all $orderSeen local functions are declared above every call to them" }

# ---- V224: the DOMINATOR box is a GRID, not four controls that happen to line up ---
# Two label columns and two input columns, both rows on the same four (SPEC I30). The
# failure this guards is drift, not a wrong pixel: B12 was sibling templates whose entry x
# fell out of step (Header edit@90 vs HeaderPicker combo@112) and B13 a title centred 5px
# off, and both survived rounds because every width and position check here reads ONE
# control at a time. Nothing measured a column, so nothing saw the column break.
#
# The header label is excluded by spanning the full box width - it is a caption, not a cell.
$gridDoc = Doc (Join-Path $dir "WoD20.11.lfm")
$gridBox = $gridDoc.SelectSingleNode("//layout[label/@name='lblMaxDisc']")
if ($null -eq $gridBox) { Fail "V224 the DOMINATOR box is gone from WoD20.11 - nothing left to measure (SPEC V209)" }
else {
    $boxW = [int]$gridBox.GetAttribute("width")
    $placed = @()
    foreach ($c in $gridBox.ChildNodes) {
        if ($c.NodeType -ne "Element" -or $c.LocalName -eq "rectangle") { continue }
        if (-not $c.HasAttribute("left")) { continue }
        if ([int]$c.GetAttribute("width") -eq $boxW) { continue }   # the caption spans the box
        $placed += $c
    }
    # A declared MIRROR is not a second cell (SPEC I71, V274b, V36): the typed twin of a picker
    # is authored on the SAME rectangle as it and starts hidden, so exactly one of the pair is
    # ever on the grid. It leaves the count only while BOTH hold - authored invisible AND exactly
    # superimposed on one other control. An edit that drifts off the combo it mirrors, or that
    # someone makes visible, is counted again and this check reddens, which is what keeps it from
    # becoming the blanket exemption V20 refuses.
    $rectOf = { param($n) "$($n.GetAttribute('left'))|$($n.GetAttribute('top'))|$($n.GetAttribute('width'))|$($n.GetAttribute('height'))" }
    $cells = @()
    foreach ($c in $placed) {
        $twins = @($placed | Where-Object { -not [object]::ReferenceEquals($_, $c) -and (& $rectOf $_) -eq (& $rectOf $c) })
        if ($c.GetAttribute("visible") -eq "false" -and $twins.Count -eq 1) { continue }
        $cells += [int]$c.GetAttribute("left")
    }
    $cols = $cells | Group-Object | Sort-Object { [int]$_.Name }
    $offGrid = @($cols | Where-Object { $_.Count -ne 2 })
    if ($cells.Count -ne 8) { Fail "V224 the DOMINATOR box holds $($cells.Count) placed controls, expected 8 - four label/input pairs (SPEC I30)" }
    elseif ($cols.Count -ne 4) { Fail "V224 the DOMINATOR box uses $($cols.Count) x positions, expected 4 - two label columns and two input columns (SPEC I30)" }
    elseif ($offGrid.Count) { Fail "V224 x=$($offGrid[0].Name) is used by $($offGrid[0].Count) control(s), not 2 - the two rows left the same column (SPEC B12)" }
    else { Pass "V224 the DOMINATOR box is a grid: 8 controls on 4 shared columns ($(($cols | ForEach-Object { $_.Name }) -join ", "))" }
}

# ---- V225: the right rule of the Vampire tab, in two legs ------------------------
# (a) content fits its container, on BOTH AXES. The first cut of this check measured width
# only - it was written answering a report of a HORIZONTAL scrollbar - and the very next
# thing the user saw was the same scrollbar on the other axis: WoD20.14 closes at 675 in a
# tabsVamp of 650 (SPEC B52). The failure mode is "content bigger than container" and it
# has two axes; one of them was built. Worse, the Pass said "fit inside tabsVamp (1395)",
# which READS as "they fit" while having compared width alone - a green claiming more than
# it measured, which is V209, in a message that cited V209.
#
# The vertical inset is bigger than the horizontal one: it holds the row of tab BUTTONS,
# not just a border (SPEC R94). Bounded by deduction rather than guessed - WoD20.13 closes
# at 610 and shows no bar, so the client is at least 610 and the inset is at most 40.
#
# This was the one the user had to find by looking: WoD20.13
# closed at 1385 inside a tabsVamp of 1210 - 175px of overflow, shipped in the 65th round and
# green ever since, because every box here was measured ALONE and each one passed. Nothing
# compared a child form against the parent that has to hold it. Same shape as V224 one round
# earlier, one level out: there the columns inside a box, here the boxes inside a tab.
#
# (b) the ruler itself. Four boxes in four files close on one number that none of them
# declares, because the user asked for that alignment (SPEC I31) - the classic way a number
# drifts. Cheap to hold: the gate already has all four files open.
$vampTop = Doc (Join-Path $dir "WoD20.11.lfm")
$tv = $vampTop.SelectSingleNode("//scrollBox/layout[import]")
if ($null -eq $tv) { Fail "V225 no sub-tab pane in WoD20.11 - there is no container left to measure against (SPEC V209)" }
else {
    $tvW = [int]$tv.GetAttribute("width")
    $tvH = [int]$tv.GetAttribute("height")
    $over = @()
    $edges = @{}
    $subsSeen = 0

    foreach ($imp in $vampTop.SelectNodes("//scrollBox/layout/import")) {
        $sub = $imp.GetAttribute("file")
        $p = Join-Path $dir $sub
        if (-not (Test-Path $p)) { $over += "$sub is imported by tabsVamp but is not on disk"; continue }
        $subsSeen++
        $widest = 0
        $lowest = 0
        foreach ($l in (Doc $p).SelectNodes("//scrollBox/layout")) {
            $r = [int]$l.GetAttribute("left") + [int]$l.GetAttribute("width")
            $b = [int]$l.GetAttribute("top") + [int]$l.GetAttribute("height")
            if ($r -gt $widest) { $widest = $r }
            if ($b -gt $lowest) { $lowest = $b }
            if ($l.SelectSingleNode("textEditor[starts-with(@name,'edt') and contains(@name,'Desc')]")) { $edges[$sub] = $r }
        }
        if (-not $widest) { $over += "$sub has no top-level layout - leg (a) measured nothing there (SPEC V209)" }
        elseif ($widest -gt $tvW) { $over += "$sub closes at x=$widest inside a pane of $tvW wide - $($widest - $tvW)px of overflow is a horizontal scrollbar (SPEC I31)" }
        elseif ($lowest -gt $tvH) { $over += "$sub ends at y=$lowest inside a pane of $tvH tall - $($lowest - $tvH)px of overflow is a vertical scrollbar (SPEC B52)" }
    }

    foreach ($l in $vampTop.SelectNodes("//scrollBox/layout")) {
        if ($l.SelectSingleNode("imageCheckBox[@field='bloodPool_1']")) {
            $edges["WoD20.11.lfm (BLOOD POOL)"] = [int]$l.GetAttribute("left") + [int]$l.GetAttribute("width")
        }
    }

    $ruler = @($edges.Values | Sort-Object -Unique)
    if ($subsSeen -lt 3) { Fail "V225 only $subsSeen sub-tab form(s) were read, expected 3 - leg (a) is covering less than the tab holds (SPEC V209)" }
    elseif ($over.Count) { foreach ($o in $over) { Fail "V225 $o" } }
    elseif ($edges.Count -ne 4) { Fail "V225 the ruler was read on $($edges.Count) box(es), expected 4 - three DESCRIPTION panes and the BLOOD POOL box (SPEC I31)" }
    elseif ($ruler.Count -ne 1) { Fail "V225 the four boxes close on $($ruler.Count) different x ($($ruler -join ', ')) - they are one ruler (SPEC I31): $(($edges.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join '; ')" }
    else { Pass "V225 the three sub-tabs fit inside their pane on both axes ($($tvW)x$($tvH)), and all four boxes close on x=$($ruler[0])" }
}

# ---- V226: the strip is themed BY CONSTRUCTION -----------------------------------
# Every button is a <rectangle> plus a <label>, and that is not a tag preference. The theme
# repaints THEME_SHAPES = { rectangle } for fill and stroke and THEME_TEXTS = { label,
# checkBox, button, comboBox, edit, textEditor, radioButton } for fontColor, so rectangle +
# label is the only pair it reaches on BOTH ends. <button> is in THEME_TEXTS for its
# fontColor alone - its face stays host-drawn, and the tabs would go back to clashing with
# the sheet, which is the whole thing I32 was asked to fix.
$stripBad = @()
$btnSeen = 0
foreach ($pair in @(@("WoD20th.lfm", "tabStrip", 11), @("WoD20.11.lfm", "vampStrip", 3), @("WoD20.7.lfm", "numStrip", 3), @("WoD20.7.lfm", "hedgeStrip", 2))) {
    $sDoc = Doc (Join-Path $dir $pair[0])
    $strip = $sDoc.SelectSingleNode("//layout[@name='$($pair[1])']")
    if ($null -eq $strip) { $stripBad += "$($pair[0]) has no $($pair[1]) - the tabs have no strip (SPEC I32)"; continue }

    foreach ($bad in $strip.SelectNodes(".//button | .//tab | .//tabControl")) {
        $stripBad += "$($pair[0]) $($pair[1]) holds a <$($bad.LocalName)> - the theme cannot paint its face (SPEC V226)"
    }

    $btns = @($strip.SelectNodes("rectangle[@onClick]"))
    if ($btns.Count -ne $pair[2]) { $stripBad += "$($pair[1]) offers $($btns.Count) button(s), expected $($pair[2])" }
    foreach ($b in $btns) {
        $btnSeen++
        $lbl = @($b.SelectNodes("label"))
        if ($lbl.Count -ne 1) { $stripBad += "$($b.GetAttribute('name')) carries $($lbl.Count) label(s) - one says the title, and the theme paints it" }
        elseif ($lbl[0].GetAttribute("hitTest") -ne 'false') { $stripBad += "$($b.GetAttribute('name'))'s label is hit-testable - it would eat the click meant for the rectangle" }
    }
}
if ($btnSeen -lt 19) { Fail "V226 only $btnSeen strip button(s) were read, expected 19 - this check is covering less than the sheet has (SPEC V209)" }
elseif ($stripBad) { foreach ($b in $stripBad) { Fail "V226 $b" } }
else { Pass "V226 all $btnSeen tab buttons are a rectangle over a label, the one pair the theme reaches on both ends" }

# ---- V227: which tab is open is SESSION state, never a field ---------------------
# A field on a Firecast sheet syncs to every client at the table - that is what makes
# dataLink worth having (SPEC V175). Store the open tab in one and the player clicking
# Combat drags the storyteller off whatever they were reading: a two-person bug that never
# shows up testing alone, which is the worst kind to ship. It is also irreversible in the
# other direction, because a field name is for ever (SPEC I3, V2).
$tabStateBad = @()
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//layout[@name='tabStrip']//*[@field] | //layout[@name='vampStrip']//*[@field] | //layout[@name='numStrip']//*[@field] | //layout[@name='hedgeStrip']//*[@field]")) {
        $tabStateBad += "$($f.Name) $($n.LocalName) owns field '$($n.GetAttribute("field"))' inside the strip"
    }
}
$rootNoCom = NoComments $rootTxt
if ($rootNoCom -match 'setField\(\s*"(activeTab|SUB_TABS|tabIndex)') { $tabStateBad += "setField writes the open tab - it would sync to every client at the table" }
if ($rootNoCom -notmatch '(?m)^\s*activeTab = ') { $tabStateBad += "activeTab is not a plain Lua global - session state has nowhere else to live" }
if ($rootNoCom -notmatch '(?m)^\s*SUB_TABS = ') { $tabStateBad += "SUB_TABS is not a plain Lua global - the open sub-tab of both strips has nowhere else to live (SPEC I58)" }
foreach ($orphan in @('activeTab', 'SUB_TABS')) {
    if ($allFields.ContainsKey($orphan)) { $tabStateBad += "'$orphan' is owned by $($allFields[$orphan] -join ', ') as a FIELD" }
}
if ($tabStateBad) { foreach ($b in $tabStateBad) { Fail "V227 $b" } }
else { Pass "V227 the open tab lives in Lua, not in a field - one reader moving does not move the others" }

# ---- V228: a tab button has an INTERIOR, not just a width ------------------------
# cornerType="innerRound" curves the border INWARD, so the drawable interior is
# width - 2*xradius, and the V16 ruler has always measured the raw width (SPEC B53). The
# arc is concave - the disc of radius r centred on the corner is OUTSIDE the shape - so at
# height y from the top the edge sits at x = sqrt(r*r - y*y): about 8.7px per side at the
# top of a glyph on a 30px pill, 0 at mid-height (SPEC R96). Nothing is CLIPPED, which is
# why no overflow check ever saw it; the title simply touches the curve and reads cramped.
#
# The radius is priced at its MAXIMUM (2*r = 28, the bite at the vertex) rather than the ~17
# measured at glyph height, and the ~11px of slack that buys is deliberate: $PX_PER_CHAR is
# one constant while the theme swaps the font family, and Georgia, Book Antiqua and Times
# New Roman all run wider than Segoe UI (SPEC R96 leaves that open for the Firecast test).
#
# The radius is CHECKED here and not assumed, because the formula is written in terms of it:
# let xradius drift and the requirement loosens silently along with the thing it measures.
# V68 cannot cover that - it reads //rectangle[@color='black'] and the pills are DimGray
# since I33.
$tabWide = @()
$tabBtnSeen = 0
foreach ($pair in @(@("WoD20th.lfm", "tabStrip"), @("WoD20.11.lfm", "vampStrip"), @("WoD20.7.lfm", "numStrip"), @("WoD20.7.lfm", "hedgeStrip"))) {
    $strip228 = (Doc (Join-Path $dir $pair[0])).SelectSingleNode("//layout[@name='$($pair[1])']")
    if ($null -eq $strip228) { $tabWide += "$($pair[0]) has no $($pair[1]) - there is no button to measure (SPEC I32)"; continue }

    foreach ($btn in $strip228.SelectNodes("rectangle[@onClick]")) {
        $bn  = $btn.GetAttribute("name")
        $lbl = $btn.SelectSingleNode("label[@text]")
        if ($null -eq $lbl) { $tabWide += "$bn carries no titled label - there is no text to measure it against"; continue }
        $tabBtnSeen++
        $txt = $lbl.GetAttribute("text")

        # The pill is measured too: it is the SHOWN half of the pair, so a narrow tabOn
        # would clip the very state this sheet uses to say which tab is open.
        $pill = $strip228.SelectSingleNode("rectangle[@name='tabOn$($bn.Substring(6))']")
        if ($null -eq $pill) { $tabWide += "$bn has no tabOn twin - the open tab would have nothing to fill it (SPEC I33)"; continue }

        foreach ($r in @($btn, $pill)) {
            $rn = $r.GetAttribute("name")
            if ($r.GetAttribute("cornerType") -ne 'innerRound') { $tabWide += "$rn is cornerType='$($r.GetAttribute('cornerType'))', not innerRound - the width below is priced for the concave arc (SPEC R96)"; continue }
            $rx = 0; $ry = 0; $rw = 0
            [void][int]::TryParse($r.GetAttribute("xradius"), [ref]$rx)
            [void][int]::TryParse($r.GetAttribute("yradius"), [ref]$ry)
            [void][int]::TryParse($r.GetAttribute("width"), [ref]$rw)
            if ($rx -ne 14 -or $ry -ne 14) { $tabWide += "$rn carries radius $rx/$ry, not the house 14/14 - the formula is written in terms of the radius, so it would loosen with it"; continue }
            $txtPx = NeededPx $txt
            $need  = $txtPx + 2 * $rx + 12
            if ($rw -lt $need) { $tabWide += "$rn is $($rw)px wide for '$txt' - it needs $need ($txtPx of text + $(2 * $rx) of arc + 12 of clearance) or the title touches the curve (SPEC B53)" }
        }
    }
}
if ($tabBtnSeen -lt 19) { Fail "V228 only $tabBtnSeen tab button(s) were measured, expected 19 - this check is covering less than the sheet has (SPEC V209)" }
elseif ($tabWide) { foreach ($t in $tabWide) { Fail "V228 $t" } }
else { Pass "V228 all $tabBtnSeen tab buttons clear the concave arc - width >= text + 2*radius + 12" }

# ---- V229: the strip has a themed floor, and the open tab may not share its colour
# The 34px strip band was the ONE region of the sheet with no paper behind it - the thirteen
# themePaper images all live in the IMPORTED forms and the root has none - so it showed the
# host background of form theme="dark" and belonged to no period at all (SPEC I33).
#
# The cure is the house idiom rather than a new mechanism: an align="client" rectangle as the
# first child, which is exactly how every section box on this sheet is built, so applyTheme
# already repaints it per period for free. It must be FIRST because the buttons are absolute
# and paint over it in document order; authored later it would bury them.
#
# And the pills must NOT be black once the floor is. That failure is silent and total: a black
# pill on a black floor breaks no build, reddens no other check, and opens the sheet with no
# tab looking open. Two different palette keys is what makes the contrast survive all four
# periods without anyone picking a colour per period by hand (SPEC V53, V57).
$stripSkin = @()
$strip229 = (Doc $rootPath).SelectSingleNode("//layout[@name='tabStrip']")
if ($null -eq $strip229) { $stripSkin += "tabStrip is gone from the root form - the tabs have no strip (SPEC I32)" }
else {
    $els229 = @($strip229.ChildNodes | Where-Object { $_.NodeType -eq 'Element' })
    $cli229 = @($els229 | Where-Object { $_.GetAttribute('align') -eq 'client' })
    if ($cli229.Count -ne 1) { $stripSkin += "tabStrip holds $($cli229.Count) align='client' child(ren), expected exactly the floor (SPEC I33, V190)" }
    elseif ($cli229[0].LocalName -ne 'rectangle') { $stripSkin += "the strip floor is a <$($cli229[0].LocalName)> - only a rectangle is in THEME_SHAPES (SPEC V226)" }
    elseif ($els229[0].GetAttribute('align') -ne 'client') { $stripSkin += "the strip floor is not the first child - authored after the buttons it would paint over them" }
    elseif ($cli229[0].GetAttribute("color") -ne 'black') { $stripSkin += "the strip floor is filled '$($cli229[0].GetAttribute('color'))', not black - it would not read as one of the section boxes (SPEC I33)" }
    else {
        # The floor is SQUARE by request (user, 2026-08-22, after seeing the 79th round on
        # screen), and it is the only square rectangle on the sheet - all 99 others author a
        # radius. A section box is an object resting on the paper and the cut corner is what
        # lifts it off; the floor is not an object but the ground itself, spanning the band
        # end to end with nothing behind it, so a concave corner there just bites four notches
        # out of the screen. V68 stepped aside for exactly this rectangle, so the corner is
        # checked HERE - stepping aside and checking nowhere would be the hole.
        foreach ($a in @('xradius', 'yradius', 'cornerType')) {
            $av = $cli229[0].GetAttribute($a)
            if ($av) { $stripSkin += "the strip floor authors $a='$av' - it is square by request (SPEC I33) and V68 gave up its corner on that basis" }
        }
    }
}
$pillSeen = 0
foreach ($pr in @(@("WoD20th.lfm", "tabStrip"), @("WoD20.11.lfm", "vampStrip"), @("WoD20.7.lfm", "numStrip"), @("WoD20.7.lfm", "hedgeStrip"))) {
    $st229 = (Doc (Join-Path $dir $pr[0])).SelectSingleNode("//layout[@name='$($pr[1])']")
    if ($null -eq $st229) { continue }
    foreach ($p in $st229.SelectNodes("rectangle[starts-with(@name,'tabOn')]")) {
        $pillSeen++
        if ($p.GetAttribute("color") -ne 'DimGray') { $stripSkin += "$($p.GetAttribute('name')) is filled '$($p.GetAttribute('color'))', not DimGray - the open tab would wear the floor's own colour and vanish into it (SPEC I33)" }
    }
}
if ($pillSeen -lt 19) { Fail "V229 only $pillSeen open-tab fill(s) were read, expected 19 - this check is covering less than the sheet has (SPEC V209)" }
elseif ($stripSkin) { foreach ($t in $stripSkin) { Fail "V229 $t" } }
else { Pass "V229 the strip floor is black and square and all $pillSeen open-tab fills are DimGray - two palette keys, so the open tab shows in every period" }
# ---- V230: the credit to the base plugin is ONE reference, not a block ----------------
# The user cut the roll-call down to a single line (SPEC C, 2026-08-22). Two ways that
# can rot, and they pull in opposite directions: the block grows back, or the line gets
# swept along with the brand and the box ends up crediting nobody. V10 and V28 do not
# catch the second one - they demand a key for a visible string that EXISTS, and a
# deleted label is not a visible string, so an empty box sails through both of them
# green. That is the B7 shape, and it is why leg (c) is written out here.
$V230_EN = 'Based on the sheet plugin by Vinny (Ambesek)'
$V230_PT = 'Baseado no plugin de fichas de Vinny (Ambesek)'
$v230Src = @()
foreach ($f in $files) { $v230Src += ,@($f.Name, [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))) }
$v230Src += ,@("module.xml", [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $plugin "module.xml"))))
$v230Lang = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($langFile))
$v230Src += ,@("localization.lang", $v230Lang)
if ($files.Count -ne 15) { Fail "V230 read $($files.Count) .lfm, expected 15 - the check would pass having looked at less (SPEC V209)" }
elseif ($v230Lang.Length -eq 0) { Fail "V230 localization.lang read empty - every needle below would pass by vacuum (SPEC V209)" }
else {
    # (a) the brand is gone outright - no exception, comments included
    $v230Brand = @()
    foreach ($p in $v230Src) {
        $n = ([regex]::Matches($p[1], 'RPGmeister')).Count
        if ($n -gt 0) { $v230Brand += "$($p[0]) still carries the brand name x$n" }
    }
    if ($v230Brand) { foreach ($b in $v230Brand) { Fail "V230 $b" } }
    else { Pass "V230 the brand name is gone from all $($v230Src.Count) source files, comments included" }

    # (b) the author is named ONLY inside the two canonical strings. Subtract them and
    # count what is left: a fixed occurrence count would break the day the PT map or the
    # .lang changes shape, and the ask was "only in that credit", not "exactly N times".
    $v230Loose = @()
    foreach ($p in $v230Src) {
        $rest = $p[1].Replace($V230_EN, '').Replace($V230_PT, '')
        $n = ([regex]::Matches($rest, 'Ambesek')).Count
        if ($n -gt 0) { $v230Loose += "$($p[0]) names the author $n time(s) outside the credit line" }
    }
    if ($v230Loose) { foreach ($b in $v230Loose) { Fail "V230 $b" } }
    else { Pass "V230 the author is named only inside the one credit line" }

    # (c) and that line really is in all four places V10/V22/V28 expect it to be
    $v230Txt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.6.lfm")))
    $v230Gone = @()
    if ($v230Txt.IndexOf('text="' + $V230_EN + '"') -lt 0) { $v230Gone += "the label is gone from WoD20.6.lfm" }
    if ($v230Txt.IndexOf('["' + $V230_EN + '"] = "' + $V230_PT + '"') -lt 0) { $v230Gone += "the PT map entry is gone from WoD20.6.lfm" }
    if ($v230Lang.IndexOf('wod.' + $V230_EN + '=' + $V230_PT) -lt 0) { $v230Gone += "the [pt] key is gone from localization.lang" }
    if ($v230Lang.IndexOf('wod.' + $V230_EN + '=' + $V230_EN) -lt 0) { $v230Gone += "the [en] key is gone from localization.lang" }
    if ($v230Gone) { foreach ($b in $v230Gone) { Fail "V230 credit $b - an empty box would pass V10 and V28 by vacuum (SPEC B7)" } }
    else { Pass "V230 the one credit line stands in all four places (label, PT map, [pt], [en])" }
}

# ---- V231: nothing is glued to the top edge, and the strip breathes LESS ---------
# All fourteen content forms started their first box at top=0 - not one file drifting, but
# how the whole sheet was born, inherited from the Mage original. The gap is 12 for content
# and 8 for the tab strip, and the SECOND number is the interesting one: the request was for
# the tab list to breathe LESS than the content it heads, so leg (c) checks the RELATION
# rather than two loose constants. Without it, two future rounds each nudging one number
# cross the hierarchy over and never redden anything (SPEC I34).
#
# The strip band is checked as 2*gap + pill, so the space above equals the space below by
# construction and neither can slide without the other lighting up. The floor rectangle is
# skipped for free: it carries no name, while all 22 pills and buttons do.
$CONTENT_GAP = 12
$gapBad = @()
$gapForms = 0
foreach ($f in $files) {
    $sb231 = (Doc $f.FullName).SelectSingleNode("//scrollBox")
    if ($null -eq $sb231) { continue }
    $tops231 = @()
    foreach ($c in $sb231.ChildNodes) {
        if ($c.NodeType -ne 'Element') { continue }
        $tv = 0
        if ([int]::TryParse($c.GetAttribute("top"), [ref]$tv)) { $tops231 += $tv }
    }
    if (-not $tops231.Count) { continue }
    $gapForms++
    $topMost = ($tops231 | Measure-Object -Minimum).Minimum
    if ($topMost -ne $CONTENT_GAP) { $gapBad += "$($f.Name) opens its first box at top=$topMost, not $CONTENT_GAP - content against the edge is what I34 was asked to fix" }
}

$stripGap = -1
$strip231 = (Doc $rootPath).SelectSingleNode("//layout[@name='tabStrip']")
if ($null -eq $strip231) { $gapBad += "tabStrip is gone from the root form - there is no strip to measure (SPEC I32)" }
else {
    $rects231 = @($strip231.SelectNodes("rectangle[@name]"))
    $rTops = @($rects231 | ForEach-Object { $_.GetAttribute("top") } | Sort-Object -Unique)
    $bandH = 0; [void][int]::TryParse($strip231.GetAttribute("height"), [ref]$bandH)
    if ($rects231.Count -ne 22) { $gapBad += "tabStrip holds $($rects231.Count) named rectangles, expected 22 - eleven pills over eleven buttons" }
    elseif ($rTops.Count -ne 1) { $gapBad += "the strip rectangles sit at top $($rTops -join ', ') - a pill and its button share one geometry" }
    else {
        [void][int]::TryParse($rTops[0], [ref]$stripGap)
        $pillH = 0; [void][int]::TryParse($rects231[0].GetAttribute("height"), [ref]$pillH)
        if ($bandH -ne (2 * $stripGap + $pillH)) { $gapBad += "the strip band is $($bandH)px for a gap of $stripGap over a $($pillH)px pill - it must be $(2 * $stripGap + $pillH), so the space above equals the space below" }
    }
}
if ($stripGap -ge 0 -and $stripGap -ge $CONTENT_GAP) { $gapBad += "the strip gap is $stripGap against a content gap of $CONTENT_GAP - the tab list must breathe LESS than the content it heads (SPEC I34)" }

if ($gapForms -lt 14) { Fail "V231 only $gapForms content form(s) were measured, expected 14 - this check is covering less than the sheet has (SPEC V209)" }
elseif ($gapBad) { foreach ($b in $gapBad) { Fail "V231 $b" } }
else { Pass "V231 all $gapForms content forms open at top=$CONTENT_GAP and the strip breathes $stripGap - less than the content, as asked" }

# ---- V232: a hidden tab leaves no HOLE in the strip -----------------------------------
# The storyteller can switch Numina and Ghoul off and both sit in the MIDDLE of the bar, so
# hiding one used to leave a gap exactly where its button had been. The strip reflows now:
# the cursor only advances past a tab that is shown (SPEC I36, user 2026-08-22).
#
# Three legs. (a) TAB_W is one number per TAB_LIST name, in that order, and it equals the
# width AUTHORED on both rectangles of the pair - there is no second truth about how wide a
# tab is. (b) the authored left chain is exactly what the reflow produces with all eleven
# shown, so the file is not born lying about the ruler the Lua applies to it. (c) the left
# write lives in the SAME loop as the visible write and the cursor advances only when the
# tab is wanted - position and state written together, the shape V112/V162 ask for.
#
# The widths are NOT read back off the control at run time: writing geometry from Lua is
# proved on this sheet (WoD20.9 writes width and height), reading it is not, and a nil
# coming back would scatter an invalid left across twenty-two rectangles in silence.
$reflowBad = @()
$tabNames = @()
$tabW = @()
$stripX0 = -1
$stripGapPx = -1
if ($rootTxt -match '(?s)>>> TAB_LIST_BEGIN.*?TAB_LIST\s*=\s*\{(.*?)\}') {
    $tabNames = @([regex]::Matches($Matches[1], '"(\w+)"') | ForEach-Object { $_.Groups[1].Value })
} else { $reflowBad += "the root form declares no TAB_LIST between its markers (SPEC I32)" }
if ($rootTxt -match '(?s)>>> TAB_W_BEGIN(.*?)<<< TAB_W_END') {
    $wBlk = $Matches[1]
    if ($wBlk -match '(?s)TAB_W\s*=\s*\{(.*?)\}') { $tabW = @([regex]::Matches($Matches[1], '\d+') | ForEach-Object { [int]$_.Value }) }
    if ($wBlk -match 'STRIP_X0\s*=\s*(\d+)') { $stripX0 = [int]$Matches[1] }
    if ($wBlk -match 'STRIP_GAP\s*=\s*(\d+)') { $stripGapPx = [int]$Matches[1] }
} else { $reflowBad += "the root form declares no TAB_W block between its markers - the reflow has no ruler (SPEC I36)" }

$tabPairSeen = 0
$strip232 = (Doc $rootPath).SelectSingleNode("//layout[@name='tabStrip']")
if ($null -eq $strip232) { $reflowBad += "tabStrip is gone from the root form (SPEC I32)" }
elseif (-not $reflowBad) {
    $btns232 = @($strip232.SelectNodes("rectangle[@onClick]"))
    if ($tabNames.Count -ne 11) { $reflowBad += "TAB_LIST names $($tabNames.Count) tab(s), expected 11" }
    elseif ($tabW.Count -ne $tabNames.Count) { $reflowBad += "TAB_W holds $($tabW.Count) width(s) for $($tabNames.Count) name(s) in TAB_LIST - one number per tab (SPEC V232a)" }
    elseif ($btns232.Count -ne $tabNames.Count) { $reflowBad += "the strip draws $($btns232.Count) button(s) for $($tabNames.Count) name(s) in TAB_LIST" }
    elseif ($stripX0 -lt 0 -or $stripGapPx -lt 0) { $reflowBad += "STRIP_X0 / STRIP_GAP are not declared beside TAB_W - the chain has no origin (SPEC V232b)" }
    else {
        $chainX = $stripX0
        for ($i = 0; $i -lt $tabNames.Count; $i++) {
            $tn = $tabNames[$i]
            # Document order must BE TAB_LIST order: the reflow lays the bar out in that order,
            # so a strip authored in another one would scramble on the first toggle.
            if ($btns232[$i].GetAttribute("name") -ne "btnTab$tn") {
                $reflowBad += "strip button $($i + 1) is $($btns232[$i].GetAttribute('name')) where TAB_LIST puts $tn - the reflow lays the bar out in TAB_LIST order"
                continue
            }
            $pill232 = $strip232.SelectSingleNode("rectangle[@name='tabOn$tn']")
            if ($null -eq $pill232) { $reflowBad += "tabOn$tn is missing - the pair is what the reflow moves (SPEC I33)"; continue }
            foreach ($r in @($btns232[$i], $pill232)) {
                $rn232 = $r.GetAttribute("name")
                $rw232 = -1
                $rl232 = -1
                [void][int]::TryParse($r.GetAttribute("width"), [ref]$rw232)
                [void][int]::TryParse($r.GetAttribute("left"), [ref]$rl232)
                if ($rw232 -ne $tabW[$i]) { $reflowBad += "$rn232 is $($rw232)px wide against TAB_W[$($i + 1)]=$($tabW[$i]) - the Lua and the XML disagree about how wide a tab is (SPEC V232a)" }
                if ($rl232 -ne $chainX) { $reflowBad += "$rn232 sits at left=$rl232 where the chain puts it at $chainX - the file must be the state the reflow produces with all eleven shown (SPEC V232b)" }
            }
            $chainX = $chainX + $tabW[$i] + $stripGapPx
            $tabPairSeen++
        }
    }
}
$vis232 = LuaFn $rootTxt 'applyTabVisibility'
if (-not $vis232) { $reflowBad += "applyTabVisibility is gone - nothing reflows the strip (SPEC I8b)" }
else {
    if ($vis232 -notmatch 'btn\.left\s*=\s*x' -or $vis232 -notmatch 'on\.left\s*=\s*x') { $reflowBad += "applyTabVisibility does not write the left of BOTH halves of the pair - the pill would stay behind its button (SPEC V232c)" }
    if ($vis232 -notmatch 'x\s*=\s*x\s*\+\s*TAB_W\[i\]\s*\+\s*STRIP_GAP') { $reflowBad += "the cursor does not advance by TAB_W[i] + STRIP_GAP - the runtime chain would not be the one the XML declares (SPEC V232b)" }
    # Leg (c) is STRUCTURAL, not a regex over the text: a lazy .{0,N} match reads straight
    # through the end; that closes the block, so the first version went GREEN on the very
    # mutation it exists to catch - the cursor advancing for a tab that is hidden. Walk the
    # lines and count block depth instead (SPEC V20: a check that cannot fail is a no-op).
    $vLines = $vis232 -split "`n"
    $iWant = -1
    for ($k = 0; $k -lt $vLines.Count; $k++) { if ($vLines[$k] -match '^\s*if want then\s*$') { $iWant = $k; break } }
    if ($iWant -lt 0) { $reflowBad += "applyTabVisibility has no if-want block around the left write - the cursor cannot be conditional on a tab being shown (SPEC V232c)" }
    else {
        $depth232 = 1
        $moveInside = $false
        for ($k = $iWant + 1; $k -lt $vLines.Count -and $depth232 -gt 0; $k++) {
            if ($vLines[$k] -match '^\s*end;\s*$') { $depth232--; continue }
            if ($vLines[$k] -match 'x\s*=\s*x\s*\+\s*TAB_W\[i\]') { $moveInside = $true }
        }
        if (-not $moveInside) { $reflowBad += "the cursor advances OUTSIDE the if-want block - a hidden tab would keep reserving its slot, which is the hole this invariant exists to close (SPEC V232c)" }
    }
}
if ($tabPairSeen -lt 11) { Fail "V232 only $tabPairSeen tab pair(s) were measured, expected 11 - this check is covering less than the strip has (SPEC V209)" }
elseif ($reflowBad) { foreach ($b in $reflowBad) { Fail "V232 $b" } }
else { Pass "V232 the strip reflows - TAB_W matches the XML on all 11 pairs, the left chain closes at $chainX, and the cursor moves only on a shown tab" }


# ---- V238: the storyteller's box has an ORDER, not just contents ----------------------
# Two legs, both of them things the user asked for out loud on 2026-08-22 and neither of
# them derivable from anything else the gate measures. (a) the two flags that hide a TAB
# come first: they are the settings that change what the table can see at all, and they had
# drifted to third and fourth under a pricing rule. (b) saving the initial character is
# last, after everything: it is the one irreversible action on this sheet (SPEC R30).
#
# This is not taste and it is not V40 in another suit. Without a check, both legs come
# undone the first time somebody adds a row in the middle - which is exactly how this box
# grew four times already (SPEC I8d, I8f, I8g).
$orderBad = @()
$stBox = BoxOf (Doc (Join-Path $dir "WoD20.10.lfm")) "STORYTELLER SETTINGS"
$stChecks = @()
if ($null -eq $stBox) { $orderBad += "WoD20.10 has no STORYTELLER SETTINGS box - the settings the tab exists for are gone (SPEC I8)" }
else {
    $stChecks = @($stBox.SelectNodes("checkBox[@name][@top]"))
    $stInputs = @($stBox.SelectNodes("checkBox[@top] | button[@top] | comboBox[@top] | edit[@top] | textEditor[@top] | radioButton[@top]"))
    if ($stChecks.Count -lt 7) { $orderBad += "the box holds $($stChecks.Count) named checkBox(es), expected at least the SEVEN flags it carries - five until the 93rd round, plus the two manual-entry flags of the 94th (SPEC I49, I51, I71, V209)" }
    else {
        $ranked = @($stChecks | Sort-Object { [int]$_.GetAttribute("top") })
        $firstTwo = @($ranked[0].GetAttribute("name"), $ranked[1].GetAttribute("name")) | Sort-Object
        $wantTwo = @('chkShowDisciplines', 'chkShowNumina')
        if (($firstTwo -join ',') -ne ($wantTwo -join ',')) {
            $orderBad += "the box opens with $($firstTwo -join ' and '), not the two Show flags - the settings that hide a tab were asked to come first (SPEC I35)"
        }
        $lowest = @($stInputs | Sort-Object { [int]$_.GetAttribute("top") })[-1]
        if ($lowest.GetAttribute("name") -ne 'btnSaveBaseline') {
            $orderBad += "the last input in the box is $($lowest.LocalName) '$($lowest.GetAttribute('name'))' at top=$($lowest.GetAttribute('top')) - Save Initial Character was asked to come after everything (SPEC I35)"
        }
    }
}
if ($stChecks.Count -lt 7) { Fail "V238 only $($stChecks.Count) flag(s) were read in the storyteller box, expected 7 or more - this check is covering less than the box has (SPEC V209)" }
elseif ($orderBad) { foreach ($b in $orderBad) { Fail "V238 $b" } }
else { Pass "V238 the storyteller box opens with the two Show flags and ends on Save Initial Character" }


# ---- V234: healthLevels has ONE owner, and it lives on the storyteller's tab ----------
# How long the health track is was never the player's call, and until the 82nd round it was
# two combos on one field - a declared mirror (SPEC I3, V36) reachable from Main and from
# Combat. It moved to the storyteller's box on the user's ask (SPEC I35).
#
# Three legs. (a) exactly one input widget owns the field, and it is in WoD20.10 - which is
# also what retires the mirror declaration, so V36's stale half now guards the way back.
# (b) neither HEALTH box carries a combo on it any more. (c) the HEALTH title of both boxes
# spans its box with left=0, so horzTextAlign centres it on the BOX rather than on the
# 215px it was left with when the combo shared the row. V27 cannot hold (c) alone: it only
# looks at labels spanning >=80% of their box, so a title narrowed back to 215 drops out of
# its reach and reads off-centre in silence - which is the whole of what item 13 was.
$hlBad = @()
$hlOwners = @()
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//*[@field='healthLevels']")) {
        if ($n.LocalName -eq 'dataLink') { continue }
        $hlOwners += "$($f.Name)/$($n.LocalName)"
    }
}
if ($hlOwners.Count -ne 1) { $hlBad += "healthLevels is owned by $($hlOwners.Count) widget(s) [$($hlOwners -join ', ')] - it is one storyteller setting, not a mirror (SPEC V1, V36)" }
elseif ($hlOwners[0] -notlike 'WoD20.10.lfm/*') { $hlBad += "healthLevels is owned in $($hlOwners[0]) - the setting belongs to the storyteller's tab (SPEC I35)" }

foreach ($pair in @(@("WoD20.1.lfm", "dynHealth_box", 290), @("WoD20.3.lfm", "dynHealth3_box", 280))) {
    $hDoc = Doc (Join-Path $dir $pair[0])
    foreach ($c in $hDoc.SelectNodes("//comboBox[@field='healthLevels']")) {
        $hlBad += "$($pair[0]) still carries a $($c.LocalName) on healthLevels - the HEALTH boxes gave the dropdown up (SPEC I35)"
    }
    $hBox = $hDoc.SelectSingleNode("//layout[@name='$($pair[1])']")
    if ($null -eq $hBox) { $hlBad += "$($pair[0]) has no $($pair[1]) - there is no HEALTH box to measure"; continue }
    $hbw = 0; [void][int]::TryParse($hBox.GetAttribute("width"), [ref]$hbw)
    if ($hbw -ne $pair[2]) { $hlBad += "$($pair[1]) is $($hbw)px wide, expected $($pair[2]) - the title width below is written against it" }
    $hTitle = $hBox.SelectSingleNode("label[@text='HEALTH']")
    if ($null -eq $hTitle) { $hlBad += "$($pair[1]) carries no HEALTH title"; continue }
    $tl = -1; $tw = -1
    [void][int]::TryParse($hTitle.GetAttribute("left"), [ref]$tl)
    [void][int]::TryParse($hTitle.GetAttribute("width"), [ref]$tw)
    if ($tl -ne 0 -or $tw -ne $hbw) { $hlBad += "$($pair[1])'s HEALTH title is left=$tl width=$tw in a $($hbw)px box - with the combo gone it must span the box, or centring centres it on nothing (SPEC V27)" }
    if ($hTitle.GetAttribute("horzTextAlign") -ne 'center') { $hlBad += "$($pair[1])'s HEALTH title is not horzTextAlign='center' - spanning the box does nothing on its own" }
}

# The two links that redraw each tab's own track are NOT owners and must stay (SPEC V123,
# B.3): they observe, and without them a change made on the storyteller's tab would leave
# the labels of the other two where they were.
foreach ($wf in @("WoD20.1.lfm", "WoD20.3.lfm")) {
    $wTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir $wf)))
    if ($wTxt -notmatch "dataLink fields=""\{'healthLevels', 'language'\}""") { $hlBad += "$wf no longer watches healthLevels - its track would keep the old length until the tab was reopened (SPEC V123)" }
}

if ($hlOwners.Count -lt 1) { Fail "V234 no widget owns healthLevels at all - the storyteller cannot set the track length (SPEC I35, V209)" }
elseif ($hlBad) { foreach ($b in $hlBad) { Fail "V234 $b" } }
else { Pass "V234 healthLevels is owned once, on the storyteller's tab, and both HEALTH titles span their box" }


# ---- V235: an empty XP log has the SHAPE of a full one --------------------------------
# The Type column used to be widened to 442 in both empty states so the state sentence could
# paint over its three empty neighbours. That is what made the tab read as broken with no
# purchases on it: the columns MOVED when there was nothing in them (SPEC I39, item 10 of
# the user's 2026-08-22 list).
#
# Two legs. (a) no column width is written from Lua at all, in any state. (b) the sentence
# has a widget of its own, authored hidden and toggled in BOTH directions - V33 and V98 are
# not being undone here, the sentence still gets said.
#
# The third leg was the box HEIGHT, written on every path through the renderer. It is gone
# with the growing box (SPEC I57, 90th round): there is no box height to write any more, and
# the column height that replaced it has one writer and one caller, which V261 measures. The
# two could not both be kept - this one demanded the write that V261a forbids - so it moved
# in the same commit rather than being left to fail correct code (SPEC B7).
#
# What stays here from that leg is the ONE empty branch: both empty states differ by their
# sentence and by nothing else, which is what makes them the same shape as a full log.
$logBad = @()
$logCode = CodeOf (Join-Path $dir "WoD20.9.lfm")
$logDoc = Doc (Join-Path $dir "WoD20.9.lfm")

if ($logCode -match 'XP_MSG_W') { $logBad += "XP_MSG_W is back - it is the width the Type column grew to in order to cover its neighbours (SPEC V235a)" }
foreach ($m in [regex]::Matches($logCode, '(?m)form\.(dynXp\w+)\.width')) {
    $logBad += "$($m.Groups[1].Value).width is written from Lua - a column that changes width between states is the whole of what item 10 reported (SPEC V235a)"
}

$emptyLbl = $logDoc.SelectSingleNode("//label[@name='dynXpEmpty']")
if ($null -eq $emptyLbl) { $logBad += "dynXpEmpty is gone - the state sentence would have to borrow a column again (SPEC V235b)" }
elseif ($emptyLbl.GetAttribute("visible") -ne 'false') { $logBad += "dynXpEmpty is authored visible - a log with rows in it would carry a sentence saying it has none (SPEC V235b)" }
if ($logCode -notmatch 'dynXpEmpty\.visible\s*=\s*true') { $logBad += "nothing ever shows dynXpEmpty - an empty log would say nothing at all (SPEC V33, V98)" }
if ($logCode -notmatch 'dynXpEmpty\.visible\s*=\s*false') { $logBad += "nothing ever hides dynXpEmpty - the sentence would sit over the first rows bought (SPEC V235b)" }
if ($logCode -notmatch 'if rows == nil or #rows == 0 then') { $logBad += "the two empty states are not one branch - they differ in their sentence and in nothing else, and splitting them is how one of them keeps a stale height (SPEC V235b)" }

$eCalls = @([regex]::Matches($logCode, '(?m)^\s*xpEmptyLog\('))
if ($eCalls.Count -ne 1) { $logBad += "xpEmptyLog is called $($eCalls.Count) time(s), expected once - both empty states go through the same call (SPEC V235b)" }

if ($null -eq $logDoc.SelectSingleNode("//textEditor[@name='dynXpType']")) { Fail "V235 WoD20.9 has no dynXpType column - this check is reading a tab that is not there (SPEC V209)" }
elseif ($logBad) { foreach ($b in $logBad) { Fail "V235 $b" } }
else { Pass "V235 the log keeps its four columns in every state - no width is written, and the sentence has a label of its own" }


# ---- V236: CLANS covers the whole picker and speaks only the picker's names -----------
# Filling Clan/Family fills the four clan Discipline slots (SPEC I37). The map that says
# which is CLANS - the table T430 froze from the books and left dormant, woken on the user's
# call in the 83rd round. The 82nd built a SECOND table of the same sixty entries before
# noticing this one (SPEC B55); it is gone, and this reads what was always here.
#
# Four legs. (a) one entry per clan the picker offers and not one more: clanFamily's list IS
# the clan list (SPEC B50). (b) every Discipline named is spelled as PICKER_LIST["disc"]
# spells it - a name off that list leaves the combo unable to resolve its own value and the
# slot opens EMPTY with nothing raised anywhere (the core writes Daimoinon, the picker offers
# Daimonion). (c) `fixed` never promises more names than there are slots. (d) an entry that
# carries `choice` or `open` is RELEASED by construction - the book leaves that slot to a
# pick or to the sire's clan - so released is DECLARED in the data rather than inferred from
# an absence, and no list of named exceptions has to be kept in step here.
$clanBad = @()
$clanEntries = @{}
$clanSeen = 0
if ($rootTxt -match '(?s)>>> CLANS_BEGIN(.*?)<<< CLANS_END') {
    $clansBlk = $Matches[1]
    foreach ($e in [regex]::Matches($clansBlk, '\["([^"]+)"\]\s*=\s*\{')) {
        $key = $e.Groups[1].Value
        # brace-match the entry: `fixed = {...}` nests, and a lazy [^}]* would cut it short
        $i = $e.Index + $e.Length
        $depth = 1
        while ($i -lt $clansBlk.Length -and $depth -gt 0) {
            if ($clansBlk[$i] -eq '{') { $depth++ } elseif ($clansBlk[$i] -eq '}') { $depth-- }
            $i++
        }
        $body = $clansBlk.Substring($e.Index + $e.Length, $i - 1 - ($e.Index + $e.Length))
        $fixed = @()
        if ($body -match 'fixed\s*=\s*\{([^}]*)\}') { $fixed = @([regex]::Matches($Matches[1], '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value }) }
        $choice = @()
        if ($body -match 'choice\s*=\s*\{([^}]*)\}') { $choice = @([regex]::Matches($Matches[1], '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value }) }
        $open = 0
        if ($body -match 'open\s*=\s*(\d+)') { $open = [int]$Matches[1] }
        if ($clanEntries.ContainsKey($key)) { $clanBad += "CLANS names '$key' twice - the second entry is the one Lua keeps, silently" }
        $clanEntries[$key] = @{ fixed = $fixed; choice = $choice; open = $open }
    }
} else { $clanBad += "the root form declares no CLANS between its markers - Clan/Family would fill nothing (SPEC I17, I37)" }

$clanList = @()
if ($PICKER.ContainsKey('clan')) { $clanList = @($PICKER['clan'] | Where-Object { $_ }) }
$discSet = @{}
if ($PICKER.ContainsKey('disc')) { foreach ($d in $PICKER['disc']) { if ($d) { $discSet[$d] = $true } } }
$discRows = 0
if ($rootTxt -match 'CLAN_DISC_ROWS\s*=\s*(\d+)') { $discRows = [int]$Matches[1] }
$released = 0

if ($clanList.Count -lt 61) { $clanBad += "the clan picker offers $($clanList.Count) entries, expected at least the 61 it carries - this check would be reading less than the sheet has (SPEC V209)" }
elseif ($discSet.Count -lt 36) { $clanBad += "the disc picker offers $($discSet.Count) names, expected at least 36 - the spelling leg below would pass on a short list" }
elseif ($discRows -lt 1) { $clanBad += "CLAN_DISC_ROWS is not declared - there is no slot count to measure against" }
else {
    foreach ($c in $clanList) {
        if (-not $clanEntries.ContainsKey($c)) { $clanBad += "'$c' is offered by the picker and has no CLANS entry - filling Clan/Family with it would do nothing (SPEC V236a)"; continue }
        $clanSeen++
        $en = $clanEntries[$c]
        if ($en.fixed.Count -gt $discRows) { $clanBad += "'$c' fixes $($en.fixed.Count) Disciplines for $discRows slots (SPEC V236c)" }
        foreach ($d in ($en.fixed + $en.choice)) {
            if (-not $discSet.ContainsKey($d)) { $clanBad += "'$c' names '$d', which the disc picker does not offer - the slot would open EMPTY with nothing raised (SPEC V236b)" }
        }
        if ($en.choice.Count -gt 0 -or $en.open -gt 0) { $released++ }
        elseif ($en.fixed.Count -eq 0) { $clanBad += "'$c' settles nothing and declares neither choice nor open - released has to be said in the data, not left to an empty entry (SPEC V236d)" }
    }
    foreach ($k in $clanEntries.Keys) {
        if ($clanList -notcontains $k) { $clanBad += "CLANS carries '$k', which the clan picker does not offer (SPEC V236a)" }
    }
}
if ($clanSeen -lt 61) { Fail "V236 only $clanSeen clan(s) were measured, expected 61 - this check is covering less than the picker offers (SPEC V209)" }
elseif ($clanBad) { foreach ($b in ($clanBad | Select-Object -First 12)) { Fail "V236 $b" } }
else { Pass "V236 CLANS answers all 61 clans in the picker's own spelling, $released of them released by choice or open" }

# ---- V237: changing clan leaves no ORPHAN dot -----------------------------------------
# The slot whose NAME changes has its five dots cleared in the same pass that writes the
# name, and the slot whose name does not change is not touched at all. The two halves have
# to arrive together: clearing always would wipe somebody's purchase every time the sheet
# opened, and writing the name alone would leave dots bought under Auspex sitting in a slot
# that now reads Celerity - which the ledger would then price under the new name (SPEC I9,
# I10b), so the table finds out weeks later through an experience total nobody can account
# for. Silent, slow and expensive: the worst shape a bug takes on this sheet.
#
# Read STRUCTURALLY, by block depth, not by a regex over the text: a lazy .{0,N} match reads
# straight through the end; that closes the guard, and would go green on the one mutation
# that matters (SPEC V232 learned this the hard way, same session).
$orphanBad = @()
$cdFn = LuaFn $rootTxt 'renderClanDisc'
if (-not $cdFn) { $orphanBad += "renderClanDisc is gone from the root form - nothing fills the clan slots (SPEC I37)" }
else {
    if ($cdFn -notmatch 'CLANS\[') { $orphanBad += "renderClanDisc does not read CLANS - it has no source for the names (SPEC I17, I37)" }
    if ($cdFn -match 'setField\("clan"') { $orphanBad += "renderClanDisc writes `clan` - the dormant combo on the Main tab stays asleep, and clanFamily is what plays the part today (SPEC V173, B50)" }

    $cdLines = $cdFn -split "`n"
    $iGuard = -1
    for ($k = 0; $k -lt $cdLines.Count; $k++) { if ($cdLines[$k] -match 'if sheet\[field\] ~= name then') { $iGuard = $k; break } }
    if ($iGuard -lt 0) { $orphanBad += "renderClanDisc has no 'if sheet[field] ~= name then' guard - it would rewrite every slot on every render and clear dots that never changed hands (SPEC V237)" }
    else {
        $depth237 = 1
        $wroteName = $false
        $clearedDots = $false
        $endGuard = $cdLines.Count
        for ($k = $iGuard + 1; $k -lt $cdLines.Count -and $depth237 -gt 0; $k++) {
            if ($cdLines[$k] -match '^\s*end;\s*$') { $depth237--; if ($depth237 -eq 0) { $endGuard = $k }; continue }
            if ($cdLines[$k] -match 'setField\(field, name\)') { $wroteName = $true }
            if ($cdLines[$k] -match 'setField\(field \.\. "_" \.\. d, false\)') { $clearedDots = $true }
        }
        if (-not $wroteName) { $orphanBad += "the name is not written inside the changed-name guard (SPEC V237)" }
        if (-not $clearedDots) { $orphanBad += "the five dots are NOT cleared inside the changed-name guard - a dot bought under one Discipline would become a dot of another (SPEC V237)" }
        # and nothing clears dots outside it: that would cost the table its purchases on every open
        for ($k = 0; $k -lt $cdLines.Count; $k++) {
            if ($k -gt $iGuard -and $k -lt $endGuard) { continue }
            if ($cdLines[$k] -match 'setField\(field \.\. "_" \.\. d, false\)') { $orphanBad += "dots are cleared OUTSIDE the changed-name guard, at line $($k + 1) of renderClanDisc - reopening a sheet would wipe what the table bought (SPEC V237)" }
        }
    }
}
# the trigger cannot live on the tab that draws the slots: it is managed, and may never open
if ($rootTxt -notmatch '<dataLink field="clanFamily">') { $orphanBad += "the root form does not watch clanFamily - a tab that is never opened cannot be the thing that keeps the slots correct (SPEC V95, B26)" }
foreach ($nf in @('WoD20.12.lfm', 'WoD20.13.lfm', 'WoD20.14.lfm', 'WoD20.11.lfm')) {
    if ((CodeOf (Join-Path $dir $nf)) -match 'renderClanDisc\(') { $orphanBad += "$nf calls renderClanDisc - it is a managed tab, and the sheet must be correct whether or not it is ever opened (SPEC V95)" }
}
if (-not $cdFn) { Fail "V237 renderClanDisc is not on the root form - this check has nothing to read (SPEC I37, V209)" }
elseif ($orphanBad) { foreach ($b in $orphanBad) { Fail "V237 $b" } }
else { Pass "V237 a clan change clears the dots of the slots whose name changed, and only those" }


# ---- V242: no bare PROSE inside Lua ---------------------------------------------------
# B54: a three-line comment written with `--` on the first line only. The other two became
# bare prose inside Lua, rdk -l exited 1 SILENTLY and DELETED the .rpk (SPEC B19, the fifth
# door to that signature), and the gate went green on a build that did not exist - it never
# runs Lua (HANDOFF section 8). Finding it cost a bisect of the root form's XML subtrees.
#
# The heuristic is deliberately NARROW: the line must fail all three tests at once - no `--`
# prefix, not one character of Lua punctuation, and reading like an English sentence of four
# words or more. Measured 0 false positives across the 15 files. A loose prose check fires on
# legitimate code, and a check people learn to ignore is worse than no check: it teaches that
# red is normal, which is how a real failure gets waved through.
#
# It does NOT replace running rdk -l before marking a task done (HANDOFF section 8). It
# catches THIS mistake - the one rdk refuses to explain - not syntax errors in general.
$proseBad = @()
$proseFiles = 0
$PROSE_PUNCT = '[=(){}\[\];:]'
$PROSE_WORDS = '^[A-Za-z][a-z]+( [A-Za-z`'',.\-]+){3,}$'
foreach ($f in $files) {
    $raw = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    $proseFiles++
    $regions = @()
    foreach ($m in [regex]::Matches($raw, '(?s)<!\[CDATA\[(.*?)\]\]>')) { $regions += $m.Groups[1].Value }
    foreach ($m in [regex]::Matches($raw, '(?s)<event[^>]*>(.*?)</event>')) { $regions += ([regex]::Replace($m.Groups[1].Value, '(?s)<!--.*?-->', '')) }

    foreach ($r in $regions) {
        $n = 0
        foreach ($line in ($r -split "`n")) {
            $n++
            $t = $line.Trim()
            if (-not $t) { continue }
            if ($t.StartsWith('--')) { continue }
            if ($t -match $PROSE_PUNCT) { continue }
            if ($t -match $PROSE_WORDS) {
                $proseBad += "$($f.Name): '$($t.Substring(0, [Math]::Min(64, $t.Length)))' reads as a comment that lost its -- prefix"
            }
        }
    }
}
if ($proseFiles -lt 15) { Fail "V242 only $proseFiles .lfm were read, expected 15 - this check is covering less than the sheet has (SPEC V209)" }
elseif ($proseBad) { foreach ($p in $proseBad) { Fail "V242 $p" } }
else { Pass "V242 no bare prose in the Lua of $proseFiles files - every comment line carries its own -- (SPEC B54)" }


# ---- V241: a locked dropdown does not dim its own TEXT --------------------------------
# `opacity` is gui.Control.props["opacity"] (rrpgGUI.lua:239) and dims the whole control,
# the text with it. A comboBox has no text-only opacity to reach for - its own props are
# transparent / field / frameRegion / items / values / text / value, and of text it inherits
# only fontColor - so the ONLY way to keep a locked dropdown readable is not to carry the
# property at all (SPEC I41, user 2026-08-22).
#
# fontColor was rejected as the replacement: applyTheme repaints THEME_TEXTS, comboBox
# included, from the colour the XML authored (SPEC V57), so a colour written from Lua is
# overwritten on the next repaint or has to join the ledger - the same argument that made the
# tab strip light its active tab with `visible` instead of with a colour (SPEC I32).
#
# This guards what is in the SOURCE. It does not promise an appearance: what a disabled
# combo looks like is the host's, and only the Firecast can answer that (SPEC R98).
$dimComboBad = @()
$dimComboSeen = 0
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//comboBox")) {
        $dimComboSeen++
        $op = $n.GetAttribute("opacity")
        if ($op -ne '') {
            $nm = $n.GetAttribute("name"); if (-not $nm) { $nm = $n.GetAttribute("field") }
            $dimComboBad += "$($f.Name) comboBox '$nm' is authored with opacity '$op' - it dims the text the player has to read (SPEC I41)"
        }
    }
}
foreach ($f in $files) {
    $code = CodeOf $f.FullName
    foreach ($m in [regex]::Matches($code, '(?m)^\s*(\w+)\.opacity\s*=')) {
        # only the combo painters are forbidden; edits, editors and dots still dim (V111)
        $fn = $m.Groups[1].Value
        if ($fn -eq 'c') { $dimComboBad += "$($f.Name) writes $($m.Groups[0].Value.Trim()) - the combo painters are the two that used to dim a dropdown (SPEC I41, V241)" }
    }
}
if ($dimComboSeen -lt 17) { Fail "V241 only $dimComboSeen comboBox(es) were read, expected the 17 the sheet declares - this check is covering less than the sheet has (SPEC V209)" }
elseif ($dimComboBad) { foreach ($b in $dimComboBad) { Fail "V241 $b" } }
else { Pass "V241 none of the $dimComboSeen dropdowns dims itself - a locked one still reads (SPEC I41)" }


# ---- V239: a box is SYMMETRIC on the X axis -------------------------------------------
# The user asked for the same gap on both sides of every box (2026-08-22, item 1). The
# NUMBER is not fixed sheet-wide: 15/15 and 10/10 both live here and both are fine - what is
# measured is that the two sides agree. Forcing one number would mean rewriting V146, whose
# row width is "the box minus 20", for the sake of sixteen boxes that were already even.
#
# Two things are excluded, and neither is a loophole. The TITLE spans the box on purpose -
# left=0 with the box's own width is how V27 centres it - so counting it would read a gap of
# zero everywhere and the rule could never be met. A ROTATED child is excluded because
# `left` is its PRE-rotation box: the three attribute headings are authored at left=-40 and
# render inside the box at x 0..20, which is the same cut V27 already makes for them.
$symBad = @()
$symSeen = 0
foreach ($f in $files) {
    foreach ($box in (Doc $f.FullName).SelectNodes("//layout[@width]")) {
        $bw = -1
        if (-not [int]::TryParse($box.GetAttribute("width"), [ref]$bw)) { continue }
        if ($bw -le 0) { continue }

        # a BOX is a layout with a backdrop: align=client, or a rect covering it from 0,0
        $back = $null
        foreach ($k in $box.ChildNodes) {
            if ($k.NodeType -ne 'Element' -or $k.LocalName -ne 'rectangle') { continue }
            $kl = -1; $kt = -1; $kw = -1
            [void][int]::TryParse($k.GetAttribute("left"), [ref]$kl)
            [void][int]::TryParse($k.GetAttribute("top"), [ref]$kt)
            [void][int]::TryParse($k.GetAttribute("width"), [ref]$kw)
            if ($k.GetAttribute("align") -eq 'client' -or ($kl -eq 0 -and $kt -eq 0 -and $kw -eq $bw)) { $back = $k; break }
        }
        if ($null -eq $back) { continue }

        $titleNode = $null
        $titleTop = [int]::MaxValue
        foreach ($k in $box.ChildNodes) {
            if ($k.NodeType -ne 'Element' -or $k.LocalName -ne 'label') { continue }
            $tl = -1; $tw = -1; $tt = 0
            [void][int]::TryParse($k.GetAttribute("left"), [ref]$tl)
            [void][int]::TryParse($k.GetAttribute("width"), [ref]$tw)
            [void][int]::TryParse($k.GetAttribute("top"), [ref]$tt)
            if ($tl -eq 0 -and $tw -eq $bw -and $tt -lt $titleTop) { $titleTop = $tt; $titleNode = $k }
        }

        $lo = [int]::MaxValue
        $hi = [int]::MinValue
        foreach ($k in $box.ChildNodes) {
            if ($k.NodeType -ne 'Element') { continue }
            if ($k -eq $back) { continue }
            if ($k.LocalName -in @('dataLink', 'script', 'event', 'template')) { continue }
            if ($k.HasAttribute("rotationAngle")) { continue }
            $kl = 0; $kw = 0
            if (-not [int]::TryParse($k.GetAttribute("left"), [ref]$kl)) { continue }
            [void][int]::TryParse($k.GetAttribute("width"), [ref]$kw)
            # the section TITLE spans the box: V27 owns it, and counting it here would make
            # every box read a left gap of zero. Only the TOPMOST spanning label is the title -
            # the credits box is four of them stacked, and the three below the heading are
            # content that happens to span, whose 0/0 is symmetric anyway.
            if ($k -eq $titleNode) { continue }
            if ($kl -lt $lo) { $lo = $kl }
            if (($kl + $kw) -gt $hi) { $hi = $kl + $kw }
        }
        if ($lo -eq [int]::MaxValue) { continue }

        $symSeen++
        $gapR = $bw - $hi
        if ($lo -ne $gapR) {
            $ttl = '(untitled)'
            foreach ($k in $box.ChildNodes) {
                if ($k.NodeType -eq 'Element' -and $k.LocalName -eq 'label' -and $k.GetAttribute("width") -eq "$bw" -and $k.GetAttribute("left") -eq '0' -and $k.GetAttribute("text")) { $ttl = $k.GetAttribute("text"); break }
            }
            $symBad += "$($f.Name) '$ttl' ($($bw)px wide) leaves $lo on the left and $gapR on the right - the two sides have to agree (SPEC I40)"
        }
    }
}
if ($symSeen -lt 71) { Fail "V239 only $symSeen box(es) were measured, expected the 71 the sheet draws - this check is covering less than the sheet has (SPEC V209)" }
elseif ($symBad) { foreach ($b in $symBad) { Fail "V239 $b" } }
else { Pass "V239 all $symSeen boxes leave the same gap on both sides" }


# ---- V240: a box is SYMMETRIC on the Y axis, and the TITLE counts -----------------------
# Ten above the topmost child and ten under the lowest, on all sixty-six boxes (user
# 2026-08-22, item 1). The title counts as the first content because it is the first thing
# the eye meets, and because that is how the user measured it when the credits box was asked
# for "more room top and bottom" in the 82nd round - 14 above the heading, 14 below the last
# line. Measuring UNDER the title instead would read 25 over 15 and call that even.
#
# The two numbers are literal and equal to each other. They are NOT V231's: that one guards
# the gap between the tab's CONTENT and the tab STRIP, is 12 against 8, and lives one level
# further out.
#
# The exclusions are V239's, for V239's reasons: the backdrop is the box, not something in
# it, and a rotated child's `top` is its PRE-rotation box. Both checks have to cut the same
# way or a box could pass one and fail the other for no reason a reader could see.
# The two boxes of the tabHedge band that are stretched to the height of HEDGE MAGIC beside
# them (SPEC I63, V267b). NAMED, and by title inside ONE file: WILLPOWER is also the name of a
# box on WoD20.1 and another on WoD20.3, and neither of those is stretched.
$STRETCHED_BAND = @('QUINTESSENCE', 'WILLPOWER')
$vpadBad = @()
$vpadSeen = 0
$stretchSeen = 0
foreach ($f in $files) {
    foreach ($box in (Doc $f.FullName).SelectNodes("//layout[@width][@height]")) {
        $bw = -1; $bh = -1
        if (-not [int]::TryParse($box.GetAttribute("width"), [ref]$bw)) { continue }
        if (-not [int]::TryParse($box.GetAttribute("height"), [ref]$bh)) { continue }
        if ($bw -le 0 -or $bh -le 0) { continue }

        $back = $null
        foreach ($k in $box.ChildNodes) {
            if ($k.NodeType -ne 'Element' -or $k.LocalName -ne 'rectangle') { continue }
            $kl = -1; $kt = -1; $kw = -1
            [void][int]::TryParse($k.GetAttribute("left"), [ref]$kl)
            [void][int]::TryParse($k.GetAttribute("top"), [ref]$kt)
            [void][int]::TryParse($k.GetAttribute("width"), [ref]$kw)
            if ($k.GetAttribute("align") -eq 'client' -or ($kl -eq 0 -and $kt -eq 0 -and $kw -eq $bw)) { $back = $k; break }
        }
        if ($null -eq $back) { continue }

        $hi = [int]::MaxValue
        $lo = [int]::MinValue
        foreach ($k in $box.ChildNodes) {
            if ($k.NodeType -ne 'Element') { continue }
            if ($k -eq $back) { continue }
            if ($k.LocalName -in @('dataLink', 'script', 'event', 'template')) { continue }
            if ($k.HasAttribute("rotationAngle")) { continue }
            if ($k.GetAttribute("align") -eq 'client') { continue }
            $kt = 0; $kh = 0
            if (-not [int]::TryParse($k.GetAttribute("top"), [ref]$kt)) { continue }
            [void][int]::TryParse($k.GetAttribute("height"), [ref]$kh)
            if ($kt -lt $hi) { $hi = $kt }
            if (($kt + $kh) -gt $lo) { $lo = $kt + $kh }
        }
        if ($hi -eq [int]::MaxValue) { continue }

        $vpadSeen++
        $gapB = $bh - $lo

        $ttl = '(untitled)'
        $ttlNode = $null
        foreach ($k in $box.ChildNodes) {
            if ($k.NodeType -eq 'Element' -and $k.LocalName -eq 'label' -and $k.GetAttribute("left") -eq '0' -and $k.GetAttribute("width") -eq "$bw" -and $k.GetAttribute("text")) { $ttl = $k.GetAttribute("text"); $ttlNode = $k; break }
        }

        # The band across the top of tabHedge closes on ONE base (SPEC I63, user 2026-08-23),
        # so the two boxes on the right are STRETCHED past what their content needs and cannot
        # leave 10 under it. They are this check's one NAMED exception - by file and title, the
        # way $DESC_BRIGHT and bloodPool_* are named - because loosening the rule for every box
        # would let any box grow a hole under its last row and call it a design (SPEC B38).
        #
        # They do not escape a ruler, they SWAP one: the content below the title band has to be
        # CENTRED in the body, top gap equal to bottom gap, which is V239 turned 90 degrees
        # (SPEC V267b). The body opens at 41 - the title band plus the 10 V240 asks under it,
        # the same 41 the list boxes count with (466 = 41 + 25*17).
        if ($f.Name -eq 'WoD20.7.lfm' -and $STRETCHED_BAND -contains $ttl) {
            $stretchSeen++

            $hiC = [int]::MaxValue
            $loC = [int]::MinValue
            foreach ($k in $box.ChildNodes) {
                if ($k.NodeType -ne 'Element') { continue }
                if ($k -eq $back -or $k -eq $ttlNode) { continue }
                if ($k.LocalName -in @('dataLink', 'script', 'event', 'template')) { continue }
                if ($k.HasAttribute("rotationAngle")) { continue }
                if ($k.GetAttribute("align") -eq 'client') { continue }
                $kt = 0; $kh = 0
                if (-not [int]::TryParse($k.GetAttribute("top"), [ref]$kt)) { continue }
                [void][int]::TryParse($k.GetAttribute("height"), [ref]$kh)
                if ($kt -lt $hiC) { $hiC = $kt }
                if (($kt + $kh) -gt $loC) { $loC = $kt + $kh }
            }

            if ($hiC -eq [int]::MaxValue) { $vpadBad += "$($f.Name) '$ttl' is stretched and holds nothing under its title - the exception is for a box that pays centring, not for an empty one (SPEC V267b)" }
            elseif ($hi -ne 10) { $vpadBad += "$($f.Name) '$ttl' opens with $hi above its title - stretched or not, the title still sits at 10 (SPEC I40, V267b)" }
            elseif (($hiC - 41) -ne ($bh - $loC)) { $vpadBad += "$($f.Name) '$ttl' ($($bh)px tall) leaves $($hiC - 41) over its content and $($bh - $loC) under it - a stretched box pays CENTRING in place of the 10 (SPEC V267b)" }
        }
        elseif ($hi -ne 10 -or $gapB -ne 10) {
            $vpadBad += "$($f.Name) '$ttl' ($($bh)px tall) opens with $hi above its first child and leaves $gapB under its last - both have to be 10 (SPEC I40)"
        }
    }
}
if ($vpadSeen -lt 71) { Fail "V240 only $vpadSeen box(es) were measured, expected the 71 the sheet draws - this check is covering less than the sheet has (SPEC V209)" }
elseif ($stretchSeen -ne 2) { Fail "V240 $stretchSeen stretched box(es) took the centring rule, expected the 2 of the tabHedge band - an exception nothing reaches is an exception that stopped measuring (SPEC V209, V267b)" }
elseif ($vpadBad) { foreach ($b in $vpadBad) { Fail "V240 $b" } }
else { Pass "V240 all $vpadSeen boxes breathe 10 above their title and 10 under their last row, and the $stretchSeen stretched ones centre their content instead" }

# ---- V243: the storyteller box closes on a column, and the state sentence is gone --------
# (a) the box is checkboxes plus a short column of entry widgets - cmbHealthLevels, cmbSpecCost,
# cmbBgCost and btnSaveBaseline since the 88th round (SPEC I49, I51) - and either ALL of them make
# one column or the box has none (SPEC V26 - B12 and B13 are this same drift, found one round
# apart). The check counts DISTINCT x rather than naming a pair, so the next one cannot join
# off-column without saying so, which is what the pair-shaped version would have let the third do.
# (b) dynBaselineState is burned: the dead button is the message now (SPEC I42, V243b, user
# 2026-08-22), and the Experience tab still says "not saved yet" inside the log that sentence
# was about (SPEC I10, V33).
$stDocX  = (Doc (Join-Path $dir "WoD20.10.lfm"))
$btnSave = $stDocX.SelectSingleNode("//button[@name='btnSaveBaseline']")
$cmbHL   = $stDocX.SelectSingleNode("//comboBox[@name='cmbHealthLevels']")
$stateW  = 0
foreach ($f in $files) { $stateW += @((Doc $f.FullName).SelectNodes("//*[@name='dynBaselineState']")).Count }

$stColBox = BoxOf $stDocX "STORYTELLER SETTINGS"
$stColX = @()
if ($null -ne $stColBox) { $stColX = @($stColBox.SelectNodes("comboBox[@left] | button[@left] | edit[@left]") | ForEach-Object { $_.GetAttribute("left") } | Sort-Object -Unique) }

if ($null -eq $btnSave) { Fail "V243 btnSaveBaseline is not on WoD20.10 - the box lost the one action it exists to offer" }
elseif ($null -eq $cmbHL) { Fail "V243 cmbHealthLevels is not on WoD20.10 - the column the button lines up with is gone (SPEC V234)" }
elseif ($stColX.Count -eq 0) { Fail "V243 no entry widget was read inside STORYTELLER SETTINGS - the column check verifies nothing (SPEC V209, V20)" }
elseif ($stColX.Count -gt 1) { Fail "V243 the entry widgets of this box sit at x = $($stColX -join ', ') - all of them make one column or the box has none (SPEC I42, I49, V26)" }
elseif ($stateW -gt 0) { Fail "V243 a widget named dynBaselineState is back - that name is burned (SPEC I42, V243b)" }
else { Pass "V243 the box closes on one entry column at x=$($stColX[0]), Save last in it, and the state sentence is gone for good" }

# ---- V245/V246/V247: the storyteller can correct Spent, and it costs a LINE ---------------
# Spent stays the sum of the log (SPEC I11, V100). What the storyteller types is stored as a
# DIFFERENCE and shown as a row, so the figure in the box and the lines under it cannot come
# apart - an absolute override would have frozen the number while purchases kept moving the
# log (SPEC I44, V246).
$xp9Doc  = (Doc (Join-Path $dir "WoD20.9.lfm"))
$spentEd = $xp9Doc.SelectSingleNode("//edit[@name='edtSpentXP']")
$paintFn = LuaFn $rootTxt 'xpPaint'
$setSpFn = LuaFn $rootTxt 'xpSetSpent'
$ledgerFn = LuaFn $rootTxt 'xpLedgerRows'

if ($null -eq $spentEd) { Fail "V245 edtSpentXP is gone from WoD20.9 - there is nothing to unlock" }
elseif ($spentEd.GetAttribute("readOnly") -ne 'true') { Fail "V245 edtSpentXP is authored unlocked - the flag defaults OFF and the sheet has to read right before any Lua runs (SPEC V80)" }
elseif ($spentEd.GetAttribute("onUserChange") -notmatch 'xpSetSpent') { Fail "V245 edtSpentXP does not hand what is typed to xpSetSpent - the box would take a number and drop it" }
elseif ($spentEd.GetAttribute("field")) { Fail "V245 edtSpentXP owns a field - Spent is derived from the log and a stored copy could only drift (SPEC V100, V102)" }
elseif (-not $paintFn) { Fail "V245 xpPaint not found on the root form - nothing paints the three numbers" }
elseif ($paintFn -notmatch 'sheet\.stEditSpentXP == true') { Fail "V245 the lock does not read stEditSpentXP as an explicit true - nil would fall OPEN on a sheet saved before this round (SPEC V80, V89)" }
elseif ($paintFn -notmatch '(?m)^\s*box\.edtSpentXP\.readOnly = not stEdit; box\.edtSpentXP\.opacity = stEdit and 1 or 0\.75;') { Fail "V245 readOnly and opacity are not written on the same line for edtSpentXP - a box that looks free and refuses the key is the lie V112 exists to stop" }
elseif (-not $setSpFn) { Fail "V246 xpSetSpent not found on the root form" }
elseif ($setSpFn -notmatch 'if rows == nil then') { Fail "V246 xpSetSpent does not refuse when no baseline is saved - it would write a correction to a log that does not exist (SPEC V33)" }
elseif ($setSpFn -notmatch 'if n < 0 then') { Fail "V246 a negative Spent is not refused (SPEC V246d, the same call V131 makes for the balance)" }
elseif ($setSpFn -notmatch 'setField\("xpManual", n - logged\)') { Fail "V246 xpSetSpent does not store the DIFFERENCE - an absolute number here freezes Spent and lets the log disagree with it (SPEC V100)" }
elseif ($setSpFn -notmatch 'xpSum\(rows\) - \(tonumber\(sheet\.xpManual\) or 0\)') { Fail "V246 the difference is not worked out against the log WITHOUT the old correction - the box would drift by its own value on every second edit" }
elseif (([regex]::Match($setSpFn, '(?s)if n < 0 then.*?end;')).Value -match 'setField') { Fail "V246 something is written before the refusal returns - a refused number must leave the sheet untouched (SPEC V131)" }
elseif (-not $ledgerFn) { Fail "V246 xpLedgerRows not found on the root form" }
elseif ($ledgerFn -notmatch 'local manual = tonumber\(sheet\.xpManual\) or 0;') { Fail "V246 the ledger does not read xpManual - the correction would move no line" }
elseif ($ledgerFn -notmatch 'if manual ~= 0 then') { Fail "V246 the MANUAL row is not conditional - a zero correction would print a row saying nothing happened (SPEC V246b)" }
elseif ($ledgerFn -notmatch 'kind = "MANUAL", name = "MANUAL", level = "MANUAL", cost = manual') { Fail "V246 the MANUAL row does not carry the word in all three columns with the correction as its cost (SPEC I44)" }
elseif ($ledgerFn.IndexOf('local manual = tonumber') -lt $ledgerFn.IndexOf('"Specialty"')) { Fail "V246 the MANUAL row is pushed before Specialty - it has no category and no slot index, so it closes the order (SPEC I10)" }
elseif (-not $ptVal.ContainsKey('MANUAL')) { Fail "V246 MANUAL has no entry in the PT map - the ledger renders it through translateSheetText like every other column text (SPEC V22, V28)" }
else {
    Pass "V245 Spent unlocks only where the storyteller allowed it, fail-closed, with the look written beside the lock"
    Pass "V246 the correction is stored as a difference and shown as the last row of the log, keyed in both languages"
}

# V247: the two boxes of the Experience tab are the same width, and that width is derived
# from the rightmost column - a column that grows while its box stands still is a log poking
# out of its own frame (SPEC I44, the relation V193 and V171 use for their own boxes).
$xpBoxes = @($xp9Doc.SelectNodes("//layout[@width]") | Where-Object { $_.GetAttribute("width") -match '^\d+$' })
$logBox  = $xp9Doc.SelectSingleNode("//layout[@name='xpLogBox']")
$costCol = $xp9Doc.SelectSingleNode("//textEditor[@name='dynXpCost']")
$lvlCol  = $xp9Doc.SelectSingleNode("//textEditor[@name='dynXpLevel']")
$expBox  = $xpBoxes | Where-Object { $_.SelectSingleNode("label[@text='EXPERIENCE']") } | Select-Object -First 1

if ($null -eq $logBox -or $null -eq $costCol -or $null -eq $lvlCol) { Fail "V247 the log box or one of its columns is missing from WoD20.9 (SPEC V20 - this check would be reading nothing)" }
elseif ($null -eq $expBox) { Fail "V247 the EXPERIENCE box was not found on WoD20.9 - the width relation has only one side" }
else {
    $costEnd = [int]$costCol.GetAttribute("left") + [int]$costCol.GetAttribute("width")
    $logW    = [int]$logBox.GetAttribute("width")
    $expW    = [int]$expBox.GetAttribute("width")
    $needLvl = NeededPx 'MANUAL'

    if ($logW -ne $expW) { Fail "V247 the log box is $logW wide and the EXPERIENCE box $expW - the two boxes of this tab close on the same x or the tab reads crooked" }
    elseif ($logW -ne ($costEnd + 16)) { Fail "V247 the log box is $logW wide and its last column ends at $costEnd - the box is the Cost column plus the 16px margin, or a column grew and the frame did not (SPEC I44)" }
    elseif ([int]$lvlCol.GetAttribute("width") -lt $needLvl) { Fail "V247 the Level column is $($lvlCol.GetAttribute('width'))px and MANUAL needs about $needLvl - the one row whose Level is a word would come up cut (SPEC V16)" }
    else { Pass "V247 both Experience boxes are $logW wide, the last column closes 16 short of it, and Level holds MANUAL" }
}

# ---- V249/V250: the typed rows' DESCRIPTION is the storyteller's to write -----------------
# Editable only where the marked row is typed AND the reader is the storyteller (SPEC I45,
# I8a). The XML stays readOnly and field-less in all three areas (SPEC V29): what the
# storyteller writes is put away by Lua, into the field of the row that is MARKED, read at
# the moment of the write - so leaving one typed row for another cannot spill into the one
# just left.
$descAreas = @(
    @{ File = 'WoD20.12.lfm'; Edit = 'edtDiscDesc';   Save = 'saveDiscDesc';   Render = 'renderDiscDesc';   Sel = 'discSel' },
    @{ File = 'WoD20.13.lfm'; Edit = 'edtPathDesc';   Save = 'savePathDesc';   Render = 'renderPathDesc';   Sel = 'pathSel' },
    @{ File = 'WoD20.14.lfm'; Edit = 'edtRitualDesc'; Save = 'saveRitualDesc'; Render = 'renderRitualDesc'; Sel = 'ritualSel' }
)
$typedBad = @()
$typedSeen = 0
foreach ($a in $descAreas) {
    $p = Join-Path $dir $a.File
    if (-not (Test-Path $p)) { $typedBad += "$($a.File) is missing"; continue }

    $txt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($p))
    $doc = Doc $p
    $ed  = $doc.SelectSingleNode("//textEditor[@name='$($a.Edit)']")
    $rFn = LuaFn $txt $a.Render
    $sFn = LuaFn $txt $a.Save
    $typedSeen++

    if ($null -eq $ed) { $typedBad += "$($a.File) has no $($a.Edit) - the block is gone"; continue }
    if ($ed.GetAttribute("readOnly") -ne 'true') { $typedBad += "$($a.File) $($a.Edit) is authored writable - the XML default is READ, and the lock opens from Lua for one reader only (SPEC V29)" }
    if ($ed.GetAttribute("field")) { $typedBad += "$($a.File) $($a.Edit) owns a field - book text must never be saved onto the character (SPEC V29)" }
    if ($ed.GetAttribute("onChange") -notmatch "$($a.Save)\(self\);") { $typedBad += "$($a.File) $($a.Edit) does not hand what is typed to $($a.Save) - the storyteller's text would live on screen and nowhere else" }

    if (-not $rFn) { $typedBad += "$($a.File) $($a.Render) not found"; continue }
    if ($rFn -notmatch 'isTypedRow\(sel\) and isStoryteller\(\)') { $typedBad += "$($a.File) $($a.Render) does not ask BOTH questions - typed row and storyteller, in that order (SPEC V249a)" }
    if ($rFn -notmatch "form\.$($a.Edit)\.readOnly = not write;") { $typedBad += "$($a.File) $($a.Render) does not write the lock beside the text - a block showing one row's text under another row's lock (SPEC V249c)" }
    if ($rFn -notmatch 'descQuiet = true;' -or $rFn -notmatch 'descQuiet = false;') { $typedBad += "$($a.File) $($a.Render) does not raise descQuiet around its own write - gui.TextEditor has onChange and no onUserChange, so the renderer's write comes back as if it were typing (SPEC V249d)" }

    if (-not $sFn) { $typedBad += "$($a.File) $($a.Save) not found"; continue }
    if ($sFn -notmatch 'if descQuiet or sheet == nil then return; end;') { $typedBad += "$($a.File) $($a.Save) does not stand down while the renderer writes (SPEC V249d)" }
    if ($sFn -notmatch 'if not isTypedRow\(sel\) or not isStoryteller\(\) then return; end;') { $typedBad += "$($a.File) $($a.Save) does not re-ask the rule - the readOnly on the control is a look, not the rule (SPEC V249a)" }
    if ($sFn -notmatch "setField\(descFieldOf\(sel\), form\.$($a.Edit)\.text\);") { $typedBad += "$($a.File) $($a.Save) does not write to the field of the MARKED row (SPEC V249c)" }
    if ($sFn -notmatch "local sel = sheet\.$($a.Sel);") { $typedBad += "$($a.File) $($a.Save) does not read the selection at the moment of the write - a stale row would take the text (SPEC V249c)" }

    # V250: the state sentence for a typed row nobody has written yet, in both languages, and
    # the same inline shape the other three states already use in these files (SPEC V33).
    if ($txt -notmatch '(?s)local NO_TEXT_YET = \{\s*en = "[^"]+",\s*pt = "[^"]+",') { $typedBad += "$($a.File) has no NO_TEXT_YET in both languages - an empty typed row would open a blank box for the player (SPEC V33, V250)" }
    if ($txt -notmatch 'return pick\(NO_TEXT_YET, lang\);') { $typedBad += "$($a.File) declares NO_TEXT_YET and never says it (SPEC V20 - a state text nothing reaches is not a state text)" }
    if ($txt -notmatch 'if isStoryteller\(\) then return ""; end;') { $typedBad += "$($a.File) shows the state sentence to the storyteller too - for him the empty box IS the input (SPEC V250)" }

    # The description fields are written by Lua alone and watched by nobody: a dataLink on one
    # would repaint the box under the cursor on every keystroke (SPEC V123, V249d).
    foreach ($dl in $doc.SelectNodes("//dataLink")) {
        $watch = "$($dl.GetAttribute('field')) $($dl.GetAttribute('fields'))"
        if ($watch -match 'Desc_\d') { $typedBad += "$($a.File) has a dataLink watching a description field - every keystroke would repaint the box the storyteller is typing in (SPEC V249d)" }
    }
}
if ($typedSeen -lt 3) { Fail "V249 only $typedSeen of the three Ghoul areas were read - this check is covering less than the sheet has (SPEC V209)" }
elseif ($typedBad) { foreach ($b in $typedBad) { Fail "V249/V250 $b" } }
else { Pass "V249/V250 all three description blocks open for the storyteller on a typed row only, write to the marked row, and say so when there is nothing written yet" }

# ---- V251: the five ritual rows that came off do not come back ---------------------------
# The names are burned like every other orphan (SPEC I3, V2): a sheet saved before the 85th
# round still carries what was in them, and a new field wearing one of those names would
# pour that stale value into an unrelated row.
$ritGhost = @($files | Where-Object { (CodeOf $_.FullName) -match 'ritual_2[1-5]' })
if ($ritGhost) { foreach ($g in $ritGhost) { Fail "V251 $($g.Name) still names a ritual row above 20 - the five that came off are burned (SPEC I46, V2)" } }
else { Pass "V251 no ritual row above 20 anywhere in the sheet" }

# ---- V252/V253: the list sorts itself, and what was just added flashes -------------------
# The fifteen PICKED rows are kept in level-then-name order and the five typed ones are left
# where the storyteller wrote them: the sort moves values between slots, and a typed ritual
# would leave its own description behind (SPEC I47, V252a, V249).
$r14 = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.14.lfm")))
$r14Doc = Doc (Join-Path $dir "WoD20.14.lfm")
$sortFn = LuaFn $r14 'sortRituals'
$flashFn = LuaFn $r14 'flashRitual'
$rankFn = LuaFn $r14 'ritualRank'
$guardLink = @($r14Doc.SelectNodes("//dataLink[contains(@onChange,'guardPick')]") | ForEach-Object { $_.GetAttribute("onChange") })

if (-not $sortFn) { Fail "V252 sortRituals not found on WoD20.14 - nothing keeps the list in order" }
elseif (-not $rankFn) { Fail "V252 ritualRank not found - the sort key would be inline and the level read in a second place (SPEC V184)" }
elseif ($rankFn -notmatch '\^\(%d\+\)%\. ') { Fail "V252 the sort key does not read the level off the name prefix - a second table for the level is exactly what V184 forbids" }
elseif ($sortFn -notmatch 'local last = RITUAL_ROWS - RITUAL_FREE_ROWS;') { Fail "V252 the sort does not stop at the picked rows - it would move the typed ones and leave their descriptions behind (SPEC V252a, V249)" }
elseif ($sortFn -notmatch 'setField\("ritual_" \.\. i, list\[i\] or ""\);') { Fail "V252 the sort does not write through setField - a list already in order has to write nothing, or the link it hangs on bounces (SPEC V122)" }
elseif ($sortFn -notmatch 'setField\("ritualSel", "ritual_" \.\. i\);') { Fail "V252 the mark does not follow its value - reordering would silently swap what the description block is showing (SPEC V252d, V176)" }
elseif ($sortFn -notmatch 'if sortQuiet or sheet == nil then return; end;') { Fail "V252 the sort does not stand down for its own writes - each one comes back through the same dataLink and would sort a half-written list (SPEC V107)" }
elseif ($guardLink.Count -lt 1) { Fail "V252 the ritual guard dataLink is gone - the sort has nothing to hang on (SPEC V20)" }
elseif ($guardLink[0] -notmatch 'guardPick\(field, oldValue, newValue\); sortRituals\(self, field, newValue\);') { Fail "V252 sortRituals does not run right after guardPick on the same link - sorting a value the guard is about to revert is work thrown away (SPEC I47, V186)" }
else { Pass "V252 the fifteen picked rituals sort by level then name, through setField, with the mark following its value" }

$hlTpl = $r14Doc.SelectSingleNode("//template[@name='RitualRow']")
$hlRect = $null
if ($hlTpl) { $hlRect = $hlTpl.SelectSingleNode("rectangle[@name='hl`$(field)']") }

if ($null -eq $hlTpl) { Fail "V253 RitualRow is gone from WoD20.14 (SPEC V20)" }
elseif ($null -eq $hlRect) { Fail "V253 the ritual row carries no highlight rectangle - there is nothing to flash (SPEC I47)" }
elseif ($hlRect.GetAttribute("visible") -ne 'false') { Fail "V253 the highlight is authored visible - every row would open lit" }
elseif ($hlRect.GetAttribute("hitTest") -ne 'false') { Fail "V253 the highlight takes the click - the row would be unusable for the second it is up" }
elseif ((@($hlTpl.ChildNodes | Where-Object { $_.NodeType -eq 'Element' })[-1]).GetAttribute("name") -ne 'hl$(field)') { Fail "V253 the highlight is not the LAST element of the row - the host paints in document order, so it would be painted OVER instead of over (SPEC I39, the reason dynXpEmpty closes the log box)" }
elseif ($hlRect.GetAttribute("color") -notmatch '^#[0-9A-Fa-f]{8}$') { Fail "V253 the highlight colour carries no alpha channel - a solid band would hide the name it is pointing at (SPEC I47)" }
elseif (-not $flashFn) { Fail "V253 flashRitual not found - nothing lights the row" }
elseif ($flashFn -notmatch 'rect\.visible = true;') { Fail "V253 flashRitual never lights the rectangle" }
elseif ($flashFn -notmatch 'setTimeout\(function\(\) rect\.visible = false; end, 1000\);') { Fail "V253 the flash is not put out after exactly 1000ms - a highlight with no timer is a highlight that stays (SPEC I47, R99)" }
elseif ($sortFn -notmatch 'flashRitual\(form, "ritual_" \.\. i\);') { Fail "V253 the flash is not fired from the sort - it has to land on the row that ended up with the value (SPEC V253d)" }
elseif ($sortFn.IndexOf('flashRitual') -lt $sortFn.IndexOf('setField("ritual_"')) { Fail "V253 the flash is looked up BEFORE the sort writes - it would light the row the value came from (SPEC V253d)" }
else { Pass "V253 the new ritual's row lights in the period's own colour, over the text, and goes out after 1000ms" }


# ---- V254: the specialty price is ONE value, and zero is a price -------------------------
# The two flags became one combo in the 87th round (SPEC I49). What this check owns is the
# part V154 cannot see from the Lua side: the list the combo OFFERS, the sentinel both halves
# have to agree on, the default written in two places, and the one item in that list that is
# prose. The prose item is the reason (d) exists at all - the traversal that enforces V17
# filters cbo* and this combo is cmb*, so nothing else on the sheet would ever ask whether
# `Purchase Forbidden` can be said in Portuguese (SPEC V209 leg a).
$specDoc  = Doc (Join-Path $dir "WoD20.10.lfm")
$specCbo  = $specDoc.SelectSingleNode("//comboBox[@name='cmbSpecCost']")
$specLink = $specDoc.SelectSingleNode("//dataLink[@field='stSpecCost']")
$deadFlag = @()
foreach ($f in $files) {
    $t = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    if ($t -match 'stSpec[34]XP') { $deadFlag += $f.Name }
}
$specItems  = @()
$specValues = @()
if ($null -ne $specCbo) {
    $specItems  = @([regex]::Matches($specCbo.GetAttribute("items"),  "'([^']*)'") | ForEach-Object { $_.Groups[1].Value })
    $specValues = @([regex]::Matches($specCbo.GetAttribute("values"), "'([^']*)'") | ForEach-Object { $_.Groups[1].Value })
}
$specSentinel = [regex]::Match($rootTxt, 'local SPEC_FORBIDDEN = "([^"]+)";')
$wantPrices = @('0', '1', '2', '3', '4', '5')
$prose = @($specItems | Where-Object { $_ -notmatch '^\d+$' })
# The closed door is found by its ITEM being prose, not by sitting last: the invariant is
# about the set of prices and the sentinel under the door, and the order they are listed in
# is free to change (SPEC V254, the declared probe).
$proseIdx = -1
for ($i = 0; $i -lt $specItems.Count; $i++) { if ($specItems[$i] -notmatch '^\d+$') { $proseIdx = $i } }
$specSentinelValue = if ($proseIdx -ge 0 -and $proseIdx -lt $specValues.Count) { $specValues[$proseIdx] } else { '' }
$specPrices = @(for ($i = 0; $i -lt $specValues.Count; $i++) { if ($i -ne $proseIdx) { $specValues[$i] } })

if ($null -eq $specCbo) { Fail "V254 cmbSpecCost is not on WoD20.10 - the price the storyteller sets has no widget (SPEC I49)" }
elseif ($specItems.Count -eq 0 -or $specValues.Count -eq 0) { Fail "V254 cmbSpecCost offers nothing - this check would be measuring an empty list (SPEC V209, V20)" }
elseif ($specCbo.GetAttribute("field") -ne 'stSpecCost') { Fail "V254 cmbSpecCost writes '$($specCbo.GetAttribute('field'))', not stSpecCost - the price would be stored somewhere the Lua does not read" }
elseif ($deadFlag.Count -gt 0) { Fail "V254 $($deadFlag -join ', ') still names stSpec3XP/stSpec4XP - those two are ORPHANS and the name is burned (SPEC I3, V2, V254a)" }
elseif ($specItems.Count -ne $specValues.Count) { Fail "V254 cmbSpecCost shows $($specItems.Count) items for $($specValues.Count) values - one of them would resolve to nothing (SPEC V12)" }
elseif ($prose.Count -ne 1) { Fail "V254 cmbSpecCost carries $($prose.Count) prose item(s), expected exactly one closed-door entry (SPEC I49)" }
elseif (@(Compare-Object @($specPrices | Sort-Object) $wantPrices).Count -gt 0) { Fail "V254 cmbSpecCost prices are {$($specPrices -join ', ')}, expected {$($wantPrices -join ', ')} - zero is a PRICE and has to be offered (SPEC V254b)" }
elseif (-not $specSentinel.Success) { Fail "V254 SPEC_FORBIDDEN is not declared on the root form - the closed door would be a bare literal in whichever line asked last" }
elseif ($specSentinelValue -ne $specSentinel.Groups[1].Value) { Fail "V254 the combo writes '$specSentinelValue' under '$($prose[0])' and the Lua compares against '$($specSentinel.Groups[1].Value)' - the door would never read as shut (SPEC V12)" }
elseif ($null -eq $specLink) { Fail "V254 no dataLink declares a default for stSpecCost - a sheet that never touched the combo would open on nothing (SPEC V254c)" }
elseif ($specLink.GetAttribute("defaultValue") -ne '3') { Fail "V254 the dataLink defaults stSpecCost to '$($specLink.GetAttribute('defaultValue'))' while specCost falls back to 3 - the two places that answer for an empty field must not disagree (SPEC V254c)" }
elseif ($rootTxt -notmatch 'tonumber\(sheet\.stSpecCost\) or 3') { Fail "V254 specCost does not fall back to the same 3 the dataLink declares (SPEC V254c)" }
elseif (-not $ptK.Contains($prose[0]) -or -not $enK.Contains($prose[0])) { Fail "V254 '$($prose[0])' has no wod. key in both .lang blocks - that is the HOST's axis, and half of leg (d) (SPEC V254d, V10)" }
elseif (-not $embedded.ContainsKey($prose[0])) { Fail "V254 '$($prose[0])' has .lang keys but is absent from the PT map in WoD20.6 - the two are different AXES, not two copies: .lang answers to the host's language and the map answers to the sheet's own, which is the one the player switches. Keying only the first is exactly how B57 shipped (SPEC V254d, I52)" }
else { Pass "V254 the specialty price is one field: $($specPrices.Count) prices plus '$($prose[0])', sentinel '$specSentinelValue', default 3 in both places, keyed on both language axes" }

# ---- V257: a cmb* combo translates its OWN items, and never its own values ---------------
# B57 in one line: pickerItems opens with a cbo* test and returns, so no cmb* had ever been
# through the axis the PLAYER switches - the sheet's own `language` field - and `Purchase
# Forbidden` shipped in English on a sheet set to Portuguese with the gate green, because the
# only check that looked at the word measured the .lang file (the HOST's axis).
#
# Four legs. (a) the branch is reached and selects BY PREFIX - a nominal test would fix the
# combo of the day and leave the next one born mute, which is the shape B57 arrived in.
# (b) it writes `items` and never `values`: the item is what the player reads and the value is
# what the NDB keeps, so switching language cannot touch stored data and a second run lands in
# the same place (SPEC V22). (c) there is no second list - `items` and `values` are the same
# content for every cmb* the branch touches, which is what makes items REBUILDABLE from values
# and is why the prose value is the English text itself (SPEC V24, V208). (d) every prose item
# of a cmb* has a key in the PT map - V28 cannot reach these, its collector filters cbo*.
#
# Leg (c) carries a declared exception, held in BOTH directions: cmbDominatorGen shows `4th`
# and stores `4` because maxDiscLevel reads the number, so it is named in CMB_DISPLAY_MAP and
# skipped. A cmb* whose lists differ and is NOT named there fails, and a name there whose lists
# match fails as a dead exception - so the list cannot quietly grow into a way out.
$cmbFn    = LuaFn $hh6 'cmbItems'
$langFn6  = LuaFn $hh6 'applyLanguage'
$cmbSkip  = @()
$mapBlk   = [regex]::Match($hh6, 'local CMB_DISPLAY_MAP = \{([^}]*)\}')
if ($mapBlk.Success) { $cmbSkip = @([regex]::Matches($mapBlk.Groups[1].Value, '(\w+)\s*=\s*true') | ForEach-Object { $_.Groups[1].Value }) }

$cmbBad   = @()
$cmbSeen  = @()
$cmbProse = @()
foreach ($f in $files) {
    foreach ($cb in (Doc $f.FullName).SelectNodes("//comboBox[@name]")) {
        $nm = $cb.GetAttribute("name")
        if ($nm.Length -lt 3 -or $nm.Substring(0, 3) -cne 'cmb') { continue }
        $cmbSeen += "$($f.Name)/$nm"

        $it = @([regex]::Matches($cb.GetAttribute("items"),  "'([^']*)'") | ForEach-Object { $_.Groups[1].Value })
        $vl = @([regex]::Matches($cb.GetAttribute("values"), "'([^']*)'") | ForEach-Object { $_.Groups[1].Value })
        $same = ($it.Count -gt 0 -and $it.Count -eq $vl.Count)
        if ($same) { for ($i = 0; $i -lt $it.Count; $i++) { if ($it[$i] -cne $vl[$i]) { $same = $false } } }
        $declared = $cmbSkip -ccontains $nm

        if ($it.Count -eq 0 -or $vl.Count -eq 0) {
            $cmbBad += "$nm authors no items/values pair in $($f.Name) - leg (c) has nothing to compare (SPEC V209)"
        } elseif ($same -and $declared) {
            $cmbBad += "$nm is named in CMB_DISPLAY_MAP but its items ARE its values - a dead exception, and the next reader will take the list as permission (SPEC V257c)"
        } elseif (-not $same -and -not $declared) {
            $cmbBad += "$nm shows a list its values cannot rebuild and is not declared in CMB_DISPLAY_MAP - the branch would overwrite what the XML authored (SPEC V257c)"
        }

        # Only the combos the branch actually touches owe the PT map a key: a declared
        # exception is never rebuilt from its values, so its values are not what gets shown.
        if (-not $declared) {
            foreach ($v in $vl) {
                if ($v -ne '' -and $v -notmatch '^\d+$') {
                    $cmbProse += $v
                    if (-not $embedded.ContainsKey($v)) { $cmbBad += "$nm offers '$v' and the PT map has no key for it - it would show in English on a sheet set to Portuguese, which is B57 exactly (SPEC V257d)" }
                }
            }
        }
    }
}

if (-not $cmbFn) { $cmbBad += "cmbItems is gone from WoD20.6 - nothing rebuilds a value combo's items when the SHEET changes language (SPEC I52, B57)" }
else {
    if ($cmbFn -notmatch 'string\.sub\(nm, 1, 3\) ~= "cmb"') { $cmbBad += "cmbItems does not select its combos by PREFIX - a nominal test covers the combo of the day and lets the next one be born mute (SPEC V257a)" }
    if ($cmbFn -match 'nm == "cmb') { $cmbBad += "cmbItems compares the name against a literal combo - the branch is by prefix or it covers one widget (SPEC V257a)" }
    if ($cmbFn -notmatch 'c\.values') { $cmbBad += "cmbItems does not read c.values - the items would be rebuilt from something other than what the NDB stores (SPEC V257b)" }
    if ($cmbFn -notmatch 'c\.items\s*=') { $cmbBad += "cmbItems writes no items - the translation reaches nothing (SPEC V257b)" }
    if ($cmbFn -match 'c\.values\s*=') { $cmbBad += "cmbItems WRITES c.values - a language switch would rewrite saved data and running it twice would not land in the same place (SPEC V257b, V22)" }
    if ($cmbFn -notmatch 'PT\[') { $cmbBad += "cmbItems never reads the PT map - the item would come out in English on a sheet set to Portuguese (SPEC V257d)" }
}
if (-not $langFn6) { $cmbBad += "applyLanguage is gone from WoD20.6 - nothing walks the sheet on a language switch" }
elseif ($langFn6 -notmatch 'cmbItems\(') { $cmbBad += "the language traversal never calls cmbItems - the branch exists and nothing reaches it (SPEC V257a)" }

if ($cmbSeen.Count -eq 0) { Fail "V257 no cmb* combo was read across the sheet - every leg of this check is measuring an empty set (SPEC V209, V20)" }
elseif ($cmbProse.Count -eq 0) { Fail "V257 the $($cmbSeen.Count) cmb* combo(s) read carry no prose item at all - leg (d) is measuring nothing, and the prose item is the whole reason this check exists (SPEC V209, B57)" }
elseif ($cmbBad) { foreach ($b in $cmbBad) { Fail "V257 $b" } }
else { Pass "V257 all $($cmbSeen.Count) cmb* combos rebuild items from values by prefix, $($cmbSkip.Count) declared display-mapped, $($cmbProse.Count) prose item(s) keyed in the PT map" }


# ---- V255: SPECIALTIES and BACKGROUNDS end in rows the storyteller TYPES ------------------
# The counts and the "typed rows come last" leg ride on V204/V248, which walk the row spec and
# now cover both boxes. What is left here is the shape of the row itself and the reader that
# has to stop short of it: the gift a trait hands out is locked by the combo's `enabled`, and
# a typed row has no combo - so a granted specialty landing in one could be typed over with
# the stamp still on it (SPEC V151, V160, V255d).
$typedSpec = @(
    @{ File = 'WoD20.1.lfm'; Tpl = 'SpecialityFreeRow';  Pick = 'SpecialityRow'; Prefix = 'edtSpeciality' },
    @{ File = 'WoD20.2.lfm'; Tpl = 'OpenAbilityFreeRow'; Pick = 'OpenAbility';   Prefix = 'edt$(field)' }
)
$typedBad2 = @()
$typedSeen = 0
foreach ($ts in $typedSpec) {
    $doc = Doc (Join-Path $dir $ts.File)
    $tpl = $doc.SelectSingleNode("//template[@name='$($ts.Tpl)']")
    if ($null -eq $tpl) { $typedBad2 += "$($ts.File) declares no $($ts.Tpl) - the typed rows have no shape (SPEC I50)"; continue }
    $typedSeen++
    $owner = @($tpl.SelectNodes("*[@field]"))[0]
    if ($null -eq $owner) { $typedBad2 += "$($ts.Tpl) owns no field at all"; continue }
    if ($owner.LocalName -ne 'edit') { $typedBad2 += "$($ts.Tpl) hands its field to a <$($owner.LocalName)> - a typed row is an <edit> or it is a picker again (SPEC V255b)" }
    if (@($tpl.SelectNodes(".//comboBox")).Count -gt 0) { $typedBad2 += "$($ts.Tpl) still carries a comboBox - the row would offer a list it is not supposed to have (SPEC V255b)" }
    $nm = $owner.GetAttribute("name")
    if ($nm -like 'cbo*') { $typedBad2 += "$($ts.Tpl) names its entry '$nm' - a cbo* name puts it back inside pickerItems and PICKER_LIST (SPEC V255c, V211a)" }
    # the dot column is the picker row's, unchanged: a typed row is bought at the same price
    $pick = $doc.SelectSingleNode("//template[@name='$($ts.Pick)']")
    if ($null -ne $pick) {
        $dotsT = @($tpl.SelectNodes("imageCheckBox") | ForEach-Object { $_.GetAttribute("left") })
        $dotsP = @($pick.SelectNodes("imageCheckBox") | ForEach-Object { $_.GetAttribute("left") })
        if (($dotsT -join ',') -ne ($dotsP -join ',')) { $typedBad2 += "$($ts.Tpl) puts its dots at {$($dotsT -join ', ')} and $($ts.Pick) at {$($dotsP -join ', ')} - the two read as one box or neither does (SPEC V26)" }
        $entT = @($tpl.SelectNodes("*[@field]"))[0].GetAttribute("left")
        $entP = @($pick.SelectNodes("*[@field]"))[0].GetAttribute("left")
        if ($entT -ne $entP) { $typedBad2 += "$($ts.Tpl) starts its entry at x=$entT and $($ts.Pick) at x=$entP (SPEC V26, B12)" }
    }
}
$renderSpecFn = LuaFn $rootTxt 'renderSpecialities'
$grantSpecFn  = LuaFn $rootTxt 'grantSpeciality'
$bound = 'for i = 1, SPECIALITY_ROWS - SPECIALITY_FREE_ROWS, 1 do'
if ($typedSeen -lt 2) { Fail "V255 only $typedSeen of the two typed templates were read - this check is covering less than the sheet has (SPEC V209)" }
elseif ($typedBad2.Count -gt 0) { foreach ($b in $typedBad2) { Fail "V255 $b" } }
elseif (-not $renderSpecFn) { Fail "V255 renderSpecialities is gone - nothing locks a granted specialty" }
elseif ($renderSpecFn -notmatch [regex]::Escape($bound)) { Fail "V255 renderSpecialities still walks every row - it looks for a combo the typed rows do not have (SPEC V255d)" }
elseif (-not $grantSpecFn) { Fail "V255 grantSpeciality is gone - the gift a trait hands out has nowhere to land" }
elseif ($grantSpecFn -notmatch [regex]::Escape($bound)) { Fail "V255 the gift can still land in a typed row - nothing there locks it, so the player could type over a granted specialty and keep the stamp (SPEC V255d, V151)" }
else { Pass "V255 both typed boxes hand their field to an <edit> on the picker's own column, and the gift stops at the picker rows" }

# ---- V256: the darker ground under the two locked XP numbers is a TRIO --------------------
# Rectangle behind, transparent edit, palette key: any one of the three missing and the effect
# is simply gone - rdk exits 0, the gate stays green and the field looks like every other one.
# That is the B6 shape, so the three are checked together. The palette leg is V53's (the colour
# is authored, so it is already inside that census); what is measured here is that the colour
# is NOT the box's own black, which would paint the ground the same shade as the box.
$xpDoc = Doc (Join-Path $dir "WoD20.9.lfm")
$xpBad = @()
$xpSeen = 0
foreach ($nm in @('edtTotalXP', 'edtSpentXP')) {
    $ed = $xpDoc.SelectSingleNode("//edit[@name='$nm']")
    if ($null -eq $ed) { $xpBad += "$nm is not on WoD20.9 - the box lost one of the two numbers it shows (SPEC I44)"; continue }
    $xpSeen++
    if ($ed.GetAttribute("transparent") -ne 'true') { $xpBad += "$nm is not transparent - it paints its own ground over the rectangle and the darker shade never shows (SPEC V256)" }
    $prev = $ed.PreviousSibling
    while ($null -ne $prev -and $prev.NodeType -ne 'Element') { $prev = $prev.PreviousSibling }
    if ($null -eq $prev -or $prev.LocalName -ne 'rectangle') { $xpBad += "$nm has no rectangle declared before it - a later sibling would paint OVER the number instead of behind it (SPEC V256)" }
    else {
        foreach ($a in @('left', 'top', 'width', 'height')) {
            if ($prev.GetAttribute($a) -ne $ed.GetAttribute($a)) { $xpBad += "the ground behind $nm is $a=$($prev.GetAttribute($a)) against the field's $($ed.GetAttribute($a)) - it would show as a band, not as the field's own ground" }
        }
        if ($prev.GetAttribute("color") -eq 'black') { $xpBad += "the ground behind $nm is authored 'black' - that is the BOX's colour in every palette, so the field would not read as darker at all (SPEC V256)" }
        if ($prev.GetAttribute("hitTest") -ne 'false') { $xpBad += "the ground behind $nm takes the click - the field under it would stop answering" }
    }
}
$xpCur = $xpDoc.SelectSingleNode("//edit[@name='edtCurrentXP']")
if ($null -ne $xpCur) {
    $p2 = $xpCur.PreviousSibling
    while ($null -ne $p2 -and $p2.NodeType -ne 'Element') { $p2 = $p2.PreviousSibling }
    if ($null -ne $p2 -and $p2.LocalName -eq 'rectangle') { $xpBad += "edtCurrentXP was given the same ground - it is the box the player TYPES in, and a lock cue on an unlocked field is decoration (SPEC V256 scope, V241)" }
}
if ($xpSeen -lt 2) { Fail "V256 only $xpSeen of the two locked XP fields were read - this check is covering less than the box has (SPEC V209)" }
elseif ($xpBad.Count -gt 0) { foreach ($b in $xpBad) { Fail "V256 $b" } }
else { Pass "V256 both locked XP numbers stand on a themed ground of their own, and Current does not" }

# ---- V258: an opaque entry field may not sit in the corner's bite ---------------------
# cornerType="innerRound" curves the border INWARD, so the disc of radius r centred on the
# vertex is OUTSIDE the shape and at height y from the edge the border sits at
# x = sqrt(r*r - y*y) (SPEC R96). B53 was that arc eating the TITLE of a tab button; this is
# the same arc eating the FRAME of an <edit>, one level in - the field's own box crosses the
# curve and reads as spilling out of the black.
#
# SCOPE is the four controls that paint a box of their own: edit, textEditor, richEdit and
# comboBox, and only while they are not transparent="true". A label paints no ground (and the
# section title is left=0 by construction, which is how V27 centres it); a dot is ART, a
# circle inside its box, so its ink never reaches the vertex; and the four DESCRIPTION panes
# plus the three ledger columns are transparent, which is the DECLARED way out of this rule -
# with no ground there is no frame to lay over the curve. Measuring ink that does not exist
# would take this from 12 findings to 84.
#
# The ruler is the SQUARE r x r, not the arc. dx*dx + dy*dy >= r*r is the exact curve, and it
# lets a 10/10 box through by 0.1px - which is precisely the "too close, it touches" the user
# reported. V228 made the same call for the same reason, pricing the arc at its maximum (2r)
# rather than at the bite measured at glyph height.
#
# r is READ from the rectangle, never the literal 14: the rule is written in terms of it, so
# a radius left to drift would loosen the requirement along with the thing it measures. That
# is the lesson V228 already paid for.
$arcBad  = @()
$arcSeen = 0
$ARC_KINDS = @('edit', 'textEditor', 'richEdit', 'comboBox')
foreach ($f in $files) {
    $xml = Doc $f.FullName

    # templates are inlined at their call site, so a row's fields are only reachable through
    # the call. The adapter shadows .Name with the name= attribute, so LocalName is the only
    # safe test here (HANDOFF section 7).
    $arcTpl = @{}
    foreach ($t in $xml.SelectNodes("//template")) { $arcTpl[$t.GetAttribute("name")] = $t }

    foreach ($box in $xml.SelectNodes("//layout[@width][@height]")) {
        $bw = -1; $bh = -1
        if (-not [int]::TryParse($box.GetAttribute("width"), [ref]$bw)) { continue }
        if (-not [int]::TryParse($box.GetAttribute("height"), [ref]$bh)) { continue }
        if ($bw -le 0 -or $bh -le 0) { continue }

        # a BOX is a layout with a backdrop, read exactly as V239 and V240 read it
        $back = $null
        foreach ($k in $box.ChildNodes) {
            if ($k.NodeType -ne 'Element' -or $k.LocalName -ne 'rectangle') { continue }
            $kl = -1; $kt = -1; $kw = -1
            [void][int]::TryParse($k.GetAttribute("left"), [ref]$kl)
            [void][int]::TryParse($k.GetAttribute("top"), [ref]$kt)
            [void][int]::TryParse($k.GetAttribute("width"), [ref]$kw)
            if ($k.GetAttribute("align") -eq 'client' -or ($kl -eq 0 -and $kt -eq 0 -and $kw -eq $bw)) { $back = $k; break }
        }
        if ($null -eq $back) { continue }
        $r = 0
        [void][int]::TryParse($back.GetAttribute("xradius"), [ref]$r)
        if ($r -le 0) { continue }   # a square box has no bite to clear

        $title = '(untitled)'
        foreach ($k in $box.ChildNodes) {
            if ($k.NodeType -eq 'Element' -and $k.LocalName -eq 'label' -and $k.GetAttribute("left") -eq '0' -and $k.GetAttribute("width") -eq "$bw" -and $k.GetAttribute("text")) { $title = $k.GetAttribute("text"); break }
        }

        # walk the subtree carrying the offset, and stop at a nested box: its children are
        # measured against ITS corners on its own pass, not against this one's.
        $stack = New-Object System.Collections.Stack
        foreach ($k in $box.ChildNodes) { if ($k.NodeType -eq 'Element') { [void]$stack.Push(@($k, 0, 0)) } }
        while ($stack.Count -gt 0) {
            $it = $stack.Pop(); $n = $it[0]; $ox = $it[1]; $oy = $it[2]
            if ($n -eq $back) { continue }
            if ($n.LocalName -in @('dataLink', 'script', 'event', 'template')) { continue }
            $nl = 0; $nt = 0; $nw = 0; $nh = 0
            [void][int]::TryParse($n.GetAttribute("left"), [ref]$nl)
            [void][int]::TryParse($n.GetAttribute("top"), [ref]$nt)
            [void][int]::TryParse($n.GetAttribute("width"), [ref]$nw)
            [void][int]::TryParse($n.GetAttribute("height"), [ref]$nh)
            $nl += $ox; $nt += $oy

            if ($n.LocalName -eq 'layout') {
                $nb = $null
                $iw = -1; [void][int]::TryParse($n.GetAttribute("width"), [ref]$iw)
                foreach ($k in $n.ChildNodes) {
                    if ($k.NodeType -ne 'Element' -or $k.LocalName -ne 'rectangle') { continue }
                    $kl = -1; $kt = -1; $kw = -1
                    [void][int]::TryParse($k.GetAttribute("left"), [ref]$kl)
                    [void][int]::TryParse($k.GetAttribute("top"), [ref]$kt)
                    [void][int]::TryParse($k.GetAttribute("width"), [ref]$kw)
                    if ($k.GetAttribute("align") -eq 'client' -or ($kl -eq 0 -and $kt -eq 0 -and $kw -eq $iw)) { $nb = $k; break }
                }
                $ir = 0; if ($null -ne $nb) { [void][int]::TryParse($nb.GetAttribute("xradius"), [ref]$ir) }
                if ($ir -gt 0) { continue }
                foreach ($k in $n.ChildNodes) { if ($k.NodeType -eq 'Element') { [void]$stack.Push(@($k, $nl, $nt)) } }
                continue
            }
            # a scrollBox carries fields the same way a plain layout does - it paints no ground
            # and bites no corner of its own, so its children are still measured against the BOX
            # they are drawn in. Walking past it instead would have dropped the four ledger
            # columns out of the census the moment the 90th round wrapped them (SPEC I57), and
            # the count guard below is what said so.
            if ($n.LocalName -eq 'scrollBox') {
                foreach ($k in $n.ChildNodes) { if ($k.NodeType -eq 'Element') { [void]$stack.Push(@($k, $nl, $nt)) } }
                continue
            }
            if ($arcTpl.ContainsKey($n.LocalName)) {
                foreach ($k in $arcTpl[$n.LocalName].ChildNodes) { if ($k.NodeType -eq 'Element') { [void]$stack.Push(@($k, $nl, $nt)) } }
                continue
            }
            if ($n.LocalName -notin $ARC_KINDS) { continue }
            if ($n.GetAttribute("transparent") -eq 'true') { continue }   # declared way out: no ground, no frame
            if ($nw -le 0 -or $nh -le 0) { continue }

            $arcSeen++
            $who = $n.GetAttribute("name"); if (-not $who) { $who = $n.GetAttribute("field") }; if (-not $who) { $who = "<$($n.LocalName)>" }
            foreach ($c in @(
                @('top-left',     $nl,             $nt),
                @('top-right',    ($bw - $nl - $nw), $nt),
                @('bottom-left',  $nl,             ($bh - $nt - $nh)),
                @('bottom-right', ($bw - $nl - $nw), ($bh - $nt - $nh)))) {
                $dx = [int]$c[1]; $dy = [int]$c[2]
                if ($dx -lt 0 -or $dy -lt 0) { continue }   # the field overruns the box: V37/V40's business, not this one's
                if ($dx -lt $r -and $dy -lt $r) {
                    $arcBad += "$($f.Name) '$title' ($($bw)x$($bh)): $who reaches its $($c[0]) corner at $dx/$dy, inside the $($r)x$($r) the concave border bites out - the field's frame lies over the curve (SPEC R96, B53)"
                }
            }
        }
    }
}
# The census is the guard, and it counts what the check actually WALKED: 328 opaque entry
# fields live inside a rounded box as of the 89th round, template calls inlined. Of those, 44
# sit near enough to a corner for the bite to be in play and 12 were inside it - but pinning
# the guard to 44 would let the walker lose 284 fields and still call itself covered, which
# is how B56 stayed green for eighteen rounds while reading 5 pickers of 17. Fewer than the
# sheet draws means the traversal broke, not that the sheet shrank; a round that deliberately
# removes rows moves this number in the same commit, the way T574 moved the three 60s.
if ($arcSeen -lt 328) { Fail "V258 only $arcSeen opaque entry field(s) were measured, expected the 328 the sheet draws inside a rounded box - this check is covering less than the sheet has (SPEC V209)" }
elseif ($arcBad) { foreach ($b in $arcBad) { Fail "V258 $b" } }
else { Pass "V258 all $arcSeen opaque entry fields clear the corner bite - none of them enters a radius square" }

# ---- V259: the two Ghoul boxes are NEIGHBOURS ----------------------------------------
# BLOOD POOL's left is DOMINATOR's width plus the house gap of 10 (SPEC I55). V239 already
# stops dead tail INSIDE a box and V225 already pins the four boxes to one ruler, but nothing
# measured the gap BETWEEN these two: shrink DOMINATOR and leave BLOOD POOL parked where it
# was and every other check stays green over 265px of nothing - the same dead tail three of
# the fourteen requests in the 82nd round were about, and the silent shape of B6.
#
# One leg on purpose. The ruler, the symmetry and the fit inside the pane all have owners.
$ghoulDoc  = Doc (Join-Path $dir "WoD20.11.lfm")
$domBox    = $ghoulDoc.SelectSingleNode("//layout[label/@name='lblMaxDisc']")
$poolBox   = $ghoulDoc.SelectSingleNode("//layout[imageCheckBox/@field='bloodPool_1']")
if ($null -eq $domBox)  { Fail "V259 the DOMINATOR box is gone from WoD20.11 - there is nothing to measure the gap from (SPEC V209)" }
elseif ($null -eq $poolBox) { Fail "V259 the BLOOD POOL box is gone from WoD20.11 - there is nothing to measure the gap to (SPEC V209)" }
else {
    $domW = -1; $poolL = -1
    [void][int]::TryParse($domBox.GetAttribute("width"), [ref]$domW)
    [void][int]::TryParse($poolBox.GetAttribute("left"), [ref]$poolL)
    if ($domW -le 0 -or $poolL -lt 0) { Fail "V259 the two boxes do not both declare their geometry (width=$domW, left=$poolL) - the gap cannot be read" }
    elseif ($poolL -ne ($domW + 10)) { Fail "V259 BLOOD POOL opens at $poolL beside a DOMINATOR $($domW) wide - that is $($poolL - $domW)px of gap where the house leaves 10, and the difference is dead space no other check can see (SPEC I55)" }
    else { Pass "V259 BLOOD POOL sits 10 to the right of DOMINATOR ($domW + 10 = $poolL) - no dead space between the two" }
}

# ---- V260: the order of the log is the STAMP, and there is one stamp ------------------
# The rows are a DIFF of the frozen character against this one, and a diff carries no
# history: "newest on top" (user 2026-08-23) can only come from something saved, which is
# why the round that asked for it added a field. Six legs (SPEC I56).
#
# (b) is the one worth naming: xpOrder is keyed exactly the way xpFree is, trait#level. Two
# stamps that drift into two key shapes is what burned `freeDots` for good in the 38th round,
# and the sheet is still carrying that name as an orphan because of it.
$ordBad  = @()
$clickC  = if ($clickFn.Success) { NoComments $clickFn.Groups[1].Value } else { '' }
$rowsC   = NoComments (LuaFn $rootTxt 'xpLedgerRows')
$riseC   = NoComments (LuaFn $rootTxt 'pushRise')
$spentC  = NoComments (LuaFn $rootTxt 'xpSetSpent')
$ordWr   = @([regex]::Matches((NoComments $rootTxt), 'setField\("xpOrder"'))
$ordFns  = @(@('xpClick', $clickC), @('xpSetSpent', $spentC)) | Where-Object { $_[1] -match 'setField\("xpOrder"' }

# (a) written in exactly two functions, and in xpClick the price stamp and the order stamp
# stand together: written apart they drift, and drift here is a line on top with no price
# against it, or a price with no place in the order.
if ($ordWr.Count -ne 3) { $ordBad += "xpOrder is written in $($ordWr.Count) place(s) - exactly three: the stamp a purchase leaves, the one a sale takes away, and the storyteller's correction moving to the top (SPEC V260a)" }
if ($ordFns.Count -ne 2) { $ordBad += "xpOrder is stamped from $($ordFns.Count) function(s) - only xpClick and xpSetSpent move a point or a correction (SPEC V260a)" }
if ($clickC -match 'setField\("xpFree"' -and $clickC -match 'setField\("xpOrder"') {
    $iFree = $clickC.LastIndexOf('setField("xpFree"')
    $iOrd  = $clickC.IndexOf('setField("xpOrder"')
    if ($iOrd -lt $iFree) { $ordBad += "the order stamp is written BEFORE the price stamp in xpClick - the two move with one mark and are read in one place (SPEC V260a)" }
}

# (b) one key grammar for both stamps, and the row carries it
if ($clickC -notmatch 'local okey = trait \.\. "#" \.\. \(want and \(level \+ 1\) or level\)') { $ordBad += "xpClick does not build the order key as trait#level - a second key grammar is what made freeDots unrecoverable (SPEC V260b, V138)" }
if ($riseC -notmatch 'key = field \.\. "#" \.\. lvl') { $ordBad += "a ledger row carries no key - there would be nothing for the stamp to be looked up by (SPEC V260b)" }
if ($rowsC -notmatch 'key = "xpManual#0"') { $ordBad += "the MANUAL row carries no key - the storyteller's correction could never take its place in the order (SPEC I44, V260b)" }

# (c) a sale hands the stamp back, exactly like the price stamp does
if ($clickC -notmatch 'elseif sheet\.xpOrder ~= nil then') { $ordBad += "a sale never reaches the order stamp - a point sold would keep its place at the top of a log it is not in (SPEC V260c)" }
if ($clickC -notmatch 'string\.gsub\(sheet\.xpOrder, "\|" \.\. okey \.\. "\|", "\|"\)') { $ordBad += "the sale does not drop the order stamp of the level it gave up (SPEC V260c)" }

# (d) the click in flight is handed in, or the row just bought comes up at the BOTTOM until
# something else redraws the sheet - green build, green gate, and the player watching (B6)
if ($rowsC -notmatch 'clickOrder') { $ordBad += "xpLedgerRows cannot be handed the stamp of the click being priced - the row just bought would sort to the bottom until the next render (SPEC V260d)" }
if ($rowsC -notmatch 'local ord = \(sheet\.xpOrder or ""\) \.\. "\|" \.\. \(clickOrder or ""\) \.\. "\|"') { $ordBad += "the walk does not append the pending click LAST - that append is the whole of why the new line lands on top (SPEC V260d)" }
if ($clickC -notmatch 'xpLedgerRows\(field, want, key, want and okey or nil\)') { $ordBad += "xpClick prices without handing over the order stamp it is about to write (SPEC V260d)" }

# (e) one sorter. Summing does not depend on order (V100) and two sorters diverge in silence.
$sortAll = @([regex]::Matches((NoComments $rootTxt), 'table\.sort\(rows'))
if ($sortAll.Count -ne 1) { $ordBad += "rows are sorted in $($sortAll.Count) place(s) - the ledger orders them once, where it builds them (SPEC V260e)" }
if ($rowsC -notmatch 'table\.sort\(rows') { $ordBad += "xpLedgerRows does not order its own rows - whoever does would be a second place that knows about order (SPEC V260e)" }
if ((NoComments $progTxt) -match 'table\.sort') { $ordBad += "WoD20.9 sorts the rows it is given - the renderer formats, it does not reorder (SPEC V260e)" }

# (f) stable tie-break. On the day of the update EVERY line is unstamped, so an unstable sort
# is not a corner case here: it deals the whole log a different way round on every render.
if ($rowsC -notmatch 'rows\[i\]\.seq = i') { $ordBad += "the rows are not decorated with their build index - table.sort is not stable, and an unstamped log would shuffle on every render (SPEC V260f)" }
if ($rowsC -notmatch 'return a\.seq < b\.seq') { $ordBad += "the sort has no stable tie-break - two rows with no stamp would come back in whatever order the sort left them (SPEC V260f)" }

if (-not $clickFn.Success -or -not $rowsC) { Fail "V260 xpClick or xpLedgerRows is missing from the root form - this check is reading nothing (SPEC V209)" }
elseif ($ordBad) { foreach ($b in $ordBad) { Fail "V260 $b" } }
else { Pass "V260 one order stamp, keyed like the price stamp, dropped on a sale, handed to the click in flight and sorted once" }

# ---- V261: the log SCROLLS, the box does not grow --------------------------------------
# The box grew with its rows until the 90th round and the tab's own scrollBox did the
# scrolling, which is what kept line N reading across all four columns. The user asked for a
# fixed box with a bar of its own (2026-08-23), and the shared parent is what carries the
# alignment now: four columns with four bars scroll four different amounts (SPEC I57).
$scrBad  = @()
# named list of its own: $cols is reused further up the file and PowerShell leaks script
# scope, so borrowing it here reads whatever the last loop left behind - which is how this
# check first came back measuring nothing at all
$LEDGER_COLS = @('dynXpType', 'dynXpTrait', 'dynXpLevel', 'dynXpCost')
$logScr  = $logDoc.SelectSingleNode("//layout[@name='xpLogBox']/scrollBox")
$logCols = @($logDoc.SelectNodes("//textEditor") | Where-Object { $LEDGER_COLS -contains $_.GetAttribute("name") })

# (a) nothing writes the box height any more, and the grower is gone by name
if ($logCode -match 'xpLogBox\.height') { $scrBad += "xpLogBox.height is written from Lua - a box that grows with its rows is the request undone (SPEC V261a)" }
if ($logCode -match 'xpLogHeight') { $scrBad += "xpLogHeight is back - it was the routine that grew the frame, and the columns' height has a writer of its own now (SPEC V261a)" }

# (b) the four columns hang off ONE scrollBox
if ($null -eq $logScr) { $scrBad += "there is no scrollBox inside xpLogBox - the rows would have nowhere to scroll and the box would have to grow again (SPEC V261b)" }
else {
    $inScroll = @($logScr.SelectNodes("textEditor") | Where-Object { $LEDGER_COLS -contains $_.GetAttribute("name") })
    if ($inScroll.Count -ne 4) { $scrBad += "$($inScroll.Count) of the four ledger columns are children of the scrollBox - a column outside it does not scroll with its row and line N stops reading across (SPEC V261b)" }
}

# (c) the heading and the state sentence do NOT scroll
if ($null -ne $logScr) {
    foreach ($k in $logScr.ChildNodes) {
        if ($k.NodeType -ne 'Element') { continue }
        if ($k.LocalName -eq 'label') { $scrBad += "a label sits inside the scrollBox ('$($k.GetAttribute("name"))$($k.GetAttribute("text"))') - the column headings and the state sentence belong to the box, not to the rows (SPEC V261c)" }
    }
}

# (d) one height, written once, for all four
$colHCalls = @([regex]::Matches($logCode, '(?m)^\s*xpColsHeight\('))
$colHWrite = @([regex]::Matches($logCode, '(?m)form\.dynXp\w+\.height\s*='))
if ($logCode -notmatch 'local function xpColsHeight\(form, h\)') { $scrBad += "there is no single writer for the column height - four heights written apart scroll four different amounts (SPEC V261d)" }
if ($colHCalls.Count -lt 2) { $scrBad += "xpColsHeight is called $($colHCalls.Count) time(s) - the empty path and the populated path must BOTH set a height, or one of them keeps a stale scroll range (SPEC V261d)" }
if ($colHWrite.Count -ne 4) { $scrBad += "$($colHWrite.Count) column height(s) are written, expected the four inside xpColsHeight - a height written anywhere else is a column scrolling on its own (SPEC V261d)" }

# (e) zero-guard: if the traversal breaks, say so instead of passing on nothing
if ($logCols.Count -ne 4) { Fail "V261 found $($logCols.Count) ledger column(s) on WoD20.9, expected 4 - this check is reading a tab that is not there (SPEC V209)" }
elseif ($scrBad) { foreach ($b in $scrBad) { Fail "V261 $b" } }
else { Pass "V261 the four columns scroll together inside a fixed box, and nothing grows the frame" }

# ---- V262: the Numina strip and its three panes (SPEC I58) ---------------------------
# Four legs. The first three are V221 and V225 applied to the sheet's SECOND sub-tab strip -
# an invariant that exempts one strip and charges the other is a patch, not a rule - and the
# fourth is the one that is genuinely new: V40's idea of what a pane IS.
#
#   (a) structure - numStrip carries no align and the three panes share ONE exact rect below it
#   (b) content fits the pane on BOTH axes (B52: proving X proves nothing about Y)
#   (c) every box that reaches past the left column closes on one ruler
#   (d) V40's pane exemption is MEASURED, not proxied by <import>
$numPath = Join-Path $dir "WoD20.7.lfm"
$v262Bad = @()
if (-not (Test-Path $numPath)) { Fail "V262 WoD20.7.lfm is missing - the Numina tab is gone" }
else {
    $numDoc   = Doc $numPath
    $numStrip = $numDoc.SelectSingleNode("//layout[@name='numStrip']")
    $numPanes = @($numDoc.SelectNodes("//scrollBox/layout[starts-with(@name,'tab')]"))

    if ($null -eq $numStrip) { Fail "V262 numStrip is gone from WoD20.7 - the sub-tabs have no strip (SPEC I32, I58)" }
    elseif ($numPanes.Count -ne 3) { Fail "V262 the Numina tab holds $($numPanes.Count) pane(s), expected the three sub-tabs (SPEC I58, V209)" }
    else {
        # (a) An absolute sibling under an align="client" control does not clash by the rule
        # V190 measures - it simply overlaps, which is B41 coming in through the geometry door.
        if ($numStrip.GetAttribute("align")) { $v262Bad += "numStrip claims align='$($numStrip.GetAttribute('align'))' - whatever is authored under it would be drawn beneath it (SPEC B41, V221)" }

        $stripEnd = [int]$numStrip.GetAttribute("top") + [int]$numStrip.GetAttribute("height")
        $paneRects = @($numPanes | ForEach-Object { "$($_.GetAttribute('left'))/$($_.GetAttribute('top'))/$($_.GetAttribute('width'))/$($_.GetAttribute('height'))" } | Sort-Object -Unique)
        if ($paneRects.Count -ne 1) { $v262Bad += "the three panes sit on $($paneRects.Count) different rects ($($paneRects -join ', ')) - they stack on ONE by design and exactly one is visible (SPEC I32, T521)" }

        $paneTop = [int]$numPanes[0].GetAttribute("top")
        $paneW   = [int]$numPanes[0].GetAttribute("width")
        $paneH   = [int]$numPanes[0].GetAttribute("height")
        if ($paneTop -lt $stripEnd) { $v262Bad += "the panes start at $paneTop, under the strip that ends at $stripEnd" }

        # (b) BOTH axes. B52 was the same overflow reported twice because the first fix
        # implemented the axis the report happened to describe.
        foreach ($pane in $numPanes) {
            $pn = $pane.GetAttribute("name")
            $maxR = 0; $maxB = 0
            foreach ($k in $pane.ChildNodes) {
                if ($k.NodeType -ne 'Element') { continue }
                $kl = 0; $kt = 0; $kw = 0; $kh = 0
                if (-not ([int]::TryParse($k.GetAttribute("left"), [ref]$kl) -and [int]::TryParse($k.GetAttribute("top"), [ref]$kt) -and
                          [int]::TryParse($k.GetAttribute("width"), [ref]$kw) -and [int]::TryParse($k.GetAttribute("height"), [ref]$kh))) { continue }
                if (($kl + $kw) -gt $maxR) { $maxR = $kl + $kw }
                if (($kt + $kh) -gt $maxB) { $maxB = $kt + $kh }
            }
            if ($maxR -eq 0) { $v262Bad += "$pn holds nothing this check can measure (SPEC V209)"; continue }
            if ($maxR -gt $paneW) { $v262Bad += "$pn reaches x=$maxR inside a pane $($paneW)px wide - a horizontal bar, which is half of B52" }
            if ($maxB -gt $paneH) { $v262Bad += "$pn reaches y=$maxB inside a pane $($paneH)px tall - a vertical bar, which is the other half" }
        }

        # (c) One ruler, and since the 91st round it is measured on the ROW, not on the box
        # (SPEC I63): the top band of tabHedge is three boxes across, so QUINTESSENCE closes at
        # 840 with WILLPOWER carrying the line to 1270 - and "every right-hand box ends on the
        # same x" would have reddened code that is right (SPEC B7).
        #
        # What the old leg was really protecting is that no strip of dead space opens anywhere
        # across a row, so that is what is measured now, and it is STRICTER than before: every
        # row of boxes has to TILE - open at 0, close at 1270, and hand over to its neighbour
        # with the 10px gutter this tab uses everywhere. Shrinking one box of a pair passes the
        # old leg (the sibling still closes the line) and fails this one on the gutter.
        # Since the 91st round the Hedge pane holds panes of its OWN (SPEC I64), and the list
        # that used to sit here moved into one of them. A collector that reads only the three
        # top panes would go on passing while measuring one row instead of two - the shape of
        # B7 - so a pane's panes are collected too: a <layout> with a name, no rectangle of its
        # own and boxes inside it is a pane by the same sentence V262d already measures.
        $numRows = @{}
        $numBoxHosts = @()
        foreach ($pane in $numPanes) {
            $numBoxHosts += $pane
            foreach ($sub in $pane.SelectNodes("layout[@name]")) {
                if ($null -eq $sub.SelectSingleNode("rectangle") -and $null -ne $sub.SelectSingleNode("layout[rectangle]")) { $numBoxHosts += $sub }
            }
        }
        foreach ($pane in $numBoxHosts) {
            foreach ($bx in $pane.SelectNodes("layout[rectangle]")) {
                $bl = 0; $bw = 0; $bt = 0
                if (-not ([int]::TryParse($bx.GetAttribute("left"), [ref]$bl) -and [int]::TryParse($bx.GetAttribute("width"), [ref]$bw) -and
                          [int]::TryParse($bx.GetAttribute("top"), [ref]$bt))) { continue }

                # A BOX, told from a strip the way V239 and V240 tell them apart: the box wears a
                # background rectangle, the strip wears loose pills. hedgeStrip lives inside this
                # pane and holds rectangles of its own, so without this it would be read as a
                # 1280-wide box that breaks the ruler it is not part of.
                $hasBack = $false
                foreach ($k in $bx.ChildNodes) {
                    if ($k.NodeType -ne 'Element' -or $k.LocalName -ne 'rectangle') { continue }
                    $kl = -1; $kt = -1; $kw = -1
                    [void][int]::TryParse($k.GetAttribute("left"), [ref]$kl)
                    [void][int]::TryParse($k.GetAttribute("top"), [ref]$kt)
                    [void][int]::TryParse($k.GetAttribute("width"), [ref]$kw)
                    if ($k.GetAttribute("align") -eq 'client' -or ($kl -eq 0 -and $kt -eq 0 -and $kw -eq $bw)) { $hasBack = $true; break }
                }
                if (-not $hasBack) { continue }
                $t = $bx.SelectSingleNode("label")
                $nm = if ($t) { $t.GetAttribute("text") } else { "box" }
                $key = "$($pane.GetAttribute('name'))@$bt"
                if (-not $numRows.ContainsKey($key)) { $numRows[$key] = @() }
                $numRows[$key] += [pscustomobject]@{ L = $bl; R = $bl + $bw; N = $nm }
            }
        }
        if ($numRows.Count -lt 5) { $v262Bad += "only $($numRows.Count) row(s) of boxes were measured, expected the 5 the three panes draw - this leg is covering less than the tab has (SPEC V209)" }
        else {
            foreach ($k in $numRows.Keys) {
                $row = @($numRows[$k] | Sort-Object L)
                $shape = ($row | ForEach-Object { "$($_.N) $($_.L)..$($_.R)" }) -join ' | '
                if ($row[0].L -ne 0) { $v262Bad += "row $k opens at x=$($row[0].L), not at 0 - a row that starts short leaves dead space no other check reads: $shape" }
                if ($row[$row.Count - 1].R -ne $paneW - 10) { $v262Bad += "row $k closes at x=$($row[$row.Count - 1].R), not on the 1270 ruler: $shape" }
                for ($i = 1; $i -lt $row.Count; $i++) {
                    $gut = $row[$i].L - $row[$i - 1].R
                    if ($gut -ne 10) { $v262Bad += "row $k hands over with a $($gut)px gutter, not the 10 this tab uses: $shape" }
                }
            }
        }
    }

    # (d) The pane exemption V40 leans on. Zero here means the leg is not wired and V40 is
    # exempting by <import> alone again - which is the shape of B7, a check that stopped
    # measuring what its message claims.
    if ($paneByRect -lt 3) { $v262Bad += "V40 exempted $paneByRect pane(s) by shared rect, expected at least the 3 the Numina tab draws - the exemption is back to trusting <import> (SPEC V209, V262d)" }

    if ($v262Bad) { foreach ($b in $v262Bad) { Fail "V262 $b" } }
    else { Pass "V262 the strip clears the panes, all three fit on both axes, $($numRows.Count) rows of boxes tile from 0 to 1270, and $paneByRect panes are exempt by rect" }
}

# ---- V263: the two numina lists count their rows in ONE place (SPEC I59, I60) ---------
# Same weld V145 puts on BACKGROUND_ROWS and V147 on SPECIALITY_ROWS, and for the reason B46
# spelled out: RITUAL_ROWS said 20 while the XML drew 25 for three green rounds, because the
# constant had no reader to disagree with it.
#
#   (a) constant == template calls in the .lfm that draws the box
#   (b) the typed rows are the LAST indices, so every reader is 'picker = total - typed'
#   (c) no count LITERAL survives in the Lua that walks them
$v263Bad = @()
$numTxt263 = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($numPath))
$rootFor263 = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($rootPath))
$rowSpec263 = @(
    @{ Const = 'NUMINA_ROWS';  Free = 'NUMINA_FREE_ROWS';  Picker = 'HedgePicker';   FreeTpl = 'NuminaFree';  Base = 'numina' },
    @{ Const = 'PSYCHIC_ROWS'; Free = 'PSYCHIC_FREE_ROWS'; Picker = 'PsychicPicker'; FreeTpl = 'PsychicFree'; Base = 'psychic' }
)
$v263Seen = 0
foreach ($rs in $rowSpec263) {
    $cm = [regex]::Match($rootFor263, "(?m)^\s*$($rs.Const)\s*=\s*(\d+);")
    $fm = [regex]::Match($rootFor263, "(?m)^\s*$($rs.Free)\s*=\s*(\d+);")
    if (-not $cm.Success) { $v263Bad += "$($rs.Const) is not declared on the root form - the row count would be a literal in every loop"; continue }
    if (-not $fm.Success) { $v263Bad += "$($rs.Free) is not declared on the root form - the typed rows would be a list of indices to forget"; continue }
    $v263Seen++
    $total = [int]$cm.Groups[1].Value
    $typed = [int]$fm.Groups[1].Value

    $pickIdx = @([regex]::Matches($numTxt263, "<$($rs.Picker)\s+field=`"$($rs.Base)_(\d+)`"") | ForEach-Object { [int]$_.Groups[1].Value })
    $freeIdx = @([regex]::Matches($numTxt263, "<$($rs.FreeTpl)\s+field=`"$($rs.Base)_(\d+)`"") | ForEach-Object { [int]$_.Groups[1].Value })

    # (a)
    if (($pickIdx.Count + $freeIdx.Count) -ne $total) { $v263Bad += "$($rs.Const) says $total but the XML draws $($pickIdx.Count + $freeIdx.Count) $($rs.Base) row(s) - a row no loop walks is a dot that costs nothing and never reaches the log (SPEC B46)" }
    if ($freeIdx.Count -ne $typed) { $v263Bad += "$($rs.Free) says $typed but the XML draws $($freeIdx.Count) typed $($rs.Base) row(s)" }

    # (b)
    if ($freeIdx.Count -gt 0 -and $pickIdx.Count -gt 0) {
        $firstFree = ($freeIdx | Measure-Object -Minimum).Minimum
        $lastPick  = ($pickIdx | Measure-Object -Maximum).Maximum
        if ($firstFree -lt $lastPick) { $v263Bad += "typed row $($rs.Base)_$firstFree sits above picker row $($rs.Base)_$lastPick - the typed rows are the LAST ones, or 'picker = total - typed' stops being true for every reader (SPEC V255a)" }
    }
}
# (c)
foreach ($m in [regex]::Matches($rootFor263, 'numinaTypeInUse\s*\(([^)]*)\)')) {
    if ($m.Groups[1].Value -match ',\s*\d+\s*$') { $v263Bad += "numinaTypeInUse is called with a literal count ($($m.Groups[1].Value.Trim())) - that is the number B46 got wrong with nobody to notice" }
}
if ($rootFor263 -notmatch 'count\s*=\s*NUMINA_ROWS' -or $rootFor263 -notmatch 'count\s*=\s*PSYCHIC_ROWS') { $v263Bad += "XP_NUMINA does not read the two constants - declareTrait and the ledger would walk a count of their own" }

if ($v263Seen -ne 2) { Fail "V263 only $v263Seen of the two numina row counts were read - this check is covering less than the tab has (SPEC V209)" }
elseif ($v263Bad) { foreach ($b in $v263Bad) { Fail "V263 $b" } }
else { Pass "V263 both numina lists declare their row count once, the typed rows are the last of each, and no count literal survives" }

# ---- V264: the HEDGE MAGIC box and the quintessence dots (SPEC I60) -------------------
#   (a) hedgeAttr is the nine of XP_ATTRS, compared in BOTH directions (the shape of V148)
#   (b) quint_* are FREE dots, a NOMINAL exception beside bloodPool_* (V219), never a loosening
#   (c) the ten sit on one row with a constant pitch
$v264Bad = @()
$attrDecl = [regex]::Match($rootFor263, '(?s)local XP_ATTRS = \{(.*?)\};')
$attrNames = @()
if ($attrDecl.Success) { $attrNames = @([regex]::Matches($attrDecl.Groups[1].Value, '\{"([^"]+)",') | ForEach-Object { $_.Groups[1].Value }) }
$hedgeList = @()
if ($PICKER.ContainsKey('hedgeAttr')) { $hedgeList = @($PICKER['hedgeAttr'] | Where-Object { $_ -ne '' }) }

if ($attrNames.Count -ne 9) { Fail "V264 XP_ATTRS parsed to $($attrNames.Count) name(s), expected 9 - leg (a) has nothing to compare against (SPEC V209)" }
elseif ($hedgeList.Count -eq 0) { Fail "V264 PICKER_LIST has no 'hedgeAttr' list - the casting-attribute picker would open blank with the gate green (SPEC B6, V211a)" }
else {
    foreach ($a in @($attrNames | Where-Object { $hedgeList -notcontains $_ })) { $v264Bad += "'$a' is an XP_ATTRS attribute the casting picker does not offer" }
    foreach ($h in @($hedgeList | Where-Object { $attrNames -notcontains $_ })) { $v264Bad += "the casting picker offers '$h', which is not one of the nine attributes" }
    if ($PICKER['hedgeAttr'][0] -ne '') { $v264Bad += "the casting picker does not start empty - there would be no way to clear it (SPEC V15)" }
}

$quintDots = @($numDoc.SelectNodes("//imageCheckBox") | Where-Object { $_.GetAttribute("field") -match '^quint_\d+$' })
if ($quintDots.Count -ne 10) { Fail "V264 $($quintDots.Count) quintessence dot(s) were read, expected 10 - this check is covering less than the box draws (SPEC V209)" }
else {
    foreach ($q in $quintDots) {
        $qf = $q.GetAttribute("field")
        if ($q.GetAttribute("onClick")) { $v264Bad += "$qf carries an onClick - quintessence is a RESOURCE and reaches xpClick through nothing (SPEC V219, I9)" }
        if ($q.GetAttribute("autoChange") -eq 'false') { $v264Bad += "$qf is autoChange='false' - a free dot marks itself, which is what makes it free" }
    }
    if ($rootFor263 -match 'declareTrait\("quint') { $v264Bad += "quint_* is declared as a trait - it would be priced, refused and logged like a rating (SPEC V219)" }

    # (c) one row, one pitch: a resource row split across two tops is V37's defect in a shape
    # nothing measures, because V37 weighs a row against its NEIGHBOUR and this is one row.
    $qTops = @($quintDots | ForEach-Object { [int]$_.GetAttribute("top") } | Sort-Object -Unique)
    if ($qTops.Count -ne 1) { $v264Bad += "the ten dots sit on $($qTops.Count) different tops ($($qTops -join ', ')) - they are one row" }
    $qLefts = @($quintDots | ForEach-Object { [int]$_.GetAttribute("left") } | Sort-Object)
    $pitches = @()
    for ($i = 1; $i -lt $qLefts.Count; $i++) { $pitches += ($qLefts[$i] - $qLefts[$i - 1]) }
    if (@($pitches | Sort-Object -Unique).Count -ne 1) { $v264Bad += "the dots are spaced $((@($pitches | Sort-Object -Unique)) -join ', ') apart - one pitch, or the row reads as two groups" }
}
if ($v264Bad) { foreach ($b in $v264Bad) { Fail "V264 $b" } }
else { Pass "V264 the casting picker is exactly the nine attributes and the ten quintessence dots are free, evenly spaced and priced by nothing" }

# ---- V265: the True Faith pane has no picker (SPEC I61) ------------------------------
# This REPLACES V50, which measured a mechanism the 90th round removed: it asked the renderer
# to special-case the faith ROW so any of four religions resolved to the one entry. There is no
# row to select any more, so what is worth measuring is the opposite - that nothing drives that
# block but the fixed key.
$v265Bad = @()
$faithPane = $numDoc.SelectSingleNode("//layout[@name='tabFaith']")
$faithDesc = $numDoc.SelectSingleNode("//textEditor[@name='edtFaithDesc']")
if ($null -eq $faithPane) { Fail "V265 there is no tabFaith pane in WoD20.7 - this check reads nothing (SPEC V209)" }
elseif ($null -eq $faithDesc) { Fail "V265 edtFaithDesc is gone - the True Faith block has no widget (SPEC V209)" }
else {
    # (a)
    $faithCombos = @($faithPane.SelectNodes(".//comboBox"))
    if ($faithCombos.Count -ne 0) { $v265Bad += "the True Faith pane holds $($faithCombos.Count) comboBox(es) - religion is TYPED, and a list there would be a picker whose choice nothing reads (SPEC I61)" }
    $faithOwner = @($faithPane.SelectNodes(".//*[@field='faith']"))
    if ($faithOwner.Count -ne 1) { $v265Bad += "the 'faith' field has $($faithOwner.Count) owner(s) in the pane, expected exactly one (SPEC V1)" }
    elseif ($faithOwner[0].LocalName -ne 'edit') { $v265Bad += "'faith' is owned by a <$($faithOwner[0].LocalName)> - the row is typed since the 90th round (SPEC I61)" }
    $faithRadios = @($faithPane.SelectNodes(".//radioButton"))
    if ($faithRadios.Count -ne 0) { $v265Bad += "the True Faith pane holds $($faithRadios.Count) radio(s) - one Path means there is nothing to select (SPEC I61, V30)" }

    # (b)
    if ($numTxt263 -match 'selected\s*==\s*"faith"') { $v265Bad += "WoD20.7 still special-cases the faith row - dead branch on a selection that cannot happen (SPEC V50, retired)" }
    if ($numTxt263 -notmatch 'DESC\["True Faith"\]') { $v265Bad += "the True Faith block does not read the fixed DESC key - it would resolve nothing and paint the NO_ENTRY message forever" }
    if ($faithDesc.HasAttribute("field")) { $v265Bad += "edtFaithDesc owns field '$($faithDesc.GetAttribute('field'))' - book text would be saved onto the character (SPEC V29, R12)" }

    # (c) the dots did not move with the widget swap
    $faithDots = @($faithPane.SelectNodes(".//imageCheckBox") | Where-Object { $_.GetAttribute("field") -match '^faith_\d+$' })
    if ($faithDots.Count -ne 5) { $v265Bad += "$($faithDots.Count) True Faith dot(s) sit beside the row, expected 5 - they moved here from the Main tab and a saved rating follows the widget (SPEC V35, V5)" }
}
if ($v265Bad) { foreach ($b in $v265Bad) { Fail "V265 $b" } }
else { Pass "V265 the True Faith pane types its religion, selects nothing, and its block reads the one fixed entry" }

# ---- V266: the typed rows of Numina hand their DESCRIPTION to the storyteller ------------
# SPEC I62 - the design the three Ghoul areas got in the 85th round (V249/V250), on the two
# Numina panes and on the ritual pane the 91st round added beside them (SPEC I65).
#
# It does NOT ride in V249's loop above. That loop measures one editor per FILE, one renderer
# per editor and a save whose name is its own; here three blocks share one file, one renderer
# and one save that takes the selector as an argument. Folding these in would mean loosening
# the literals that loop reads - paying for coverage with the coverage already there (V209).
$v266Bad = @()
$numPath266 = Join-Path $dir 'WoD20.7.lfm'
$numTxt266 = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($numPath266))
$numDoc266 = Doc $numPath266

# (a) the two keys are DERIVED. A literal here is B46 again: a row that changes kind in the
# XML leaves the Lua calling it typed, in silence.
$typedKeys = @{ 'numina' = 'NUMINA_ROWS - NUMINA_FREE_ROWS + 1'; 'psychic' = 'PSYCHIC_ROWS - PSYCHIC_FREE_ROWS + 1' }
$typedKeySeen = 0
foreach ($k in $typedKeys.Keys) {
    $m266 = [regex]::Match($rootTxt, '(?m)^\s*' + $k + '\s*=\s*(.+),\s*$')
    if (-not $m266.Success) { $v266Bad += "TYPED_ROW_FROM has no '$k' key - the last rows of that box answer isTypedRow with false and their block never opens (SPEC I62, V266a)"; continue }
    $typedKeySeen++
    if ($m266.Groups[1].Value.Trim() -ne $typedKeys[$k]) { $v266Bad += "TYPED_ROW_FROM.$k reads '$($m266.Groups[1].Value.Trim())', not the derived '$($typedKeys[$k])' - a number written by hand drifts from the XML without a word (SPEC V204, V266a)" }
}
if ($typedKeySeen -lt 2) { $v266Bad += "only $typedKeySeen of the two Numina keys were read in TYPED_ROW_FROM - this leg is covering less than the spec names (SPEC V209)" }

# (b) and (c): one helper paints a pane, and it writes the text and the lock in the SAME step.
$paintFn266 = LuaFn $numTxt266 'paintNuminaPane'
if (-not $paintFn266) { $v266Bad += "paintNuminaPane is gone - each pane would carry its own copy of the pair (SPEC V266c)" }
else {
    if ($paintFn266 -notmatch 'box\.text\s*=\s*numinaText\(selected, lang\);') { $v266Bad += "paintNuminaPane does not fill the box from numinaText(selected, lang) (SPEC V266c)" }
    if ($paintFn266 -notmatch 'box\.readOnly\s*=\s*not \(isTypedRow\(selected\) and isStoryteller\(\)\);') { $v266Bad += "paintNuminaPane does not lock the box in the step that fills it - that is a block showing one row's text under another row's lock (SPEC V266b, V266c)" }
}

$rendFn266 = LuaFn $numTxt266 'renderNuminaDesc'
if (-not $rendFn266) { $v266Bad += "renderNuminaDesc not found" }
else {
    $panes266 = @{ 'edtHedgeDesc' = 'sheet.numinaSel'; 'edtPsychicDesc' = 'sheet.psychicSel'; 'edtHedgeRitualDesc' = 'sheet.hedgeRitualSel' }
    $paneSeen266 = 0
    foreach ($k in $panes266.Keys) {
        if ($rendFn266 -match ('paintNuminaPane\(form\.' + $k + ',\s*' + [regex]::Escape($panes266[$k]) + ',')) { $paneSeen266++ }
        else { $v266Bad += "renderNuminaDesc does not paint $k from $($panes266[$k]) - a pane painted off the wrong selector shows another pane's row (SPEC V266b)" }
    }
    if ($paneSeen266 -lt 2) { $v266Bad += "only $paneSeen266 row-driven pane(s) read a selector in renderNuminaDesc, expected at least the 2 of SPEC I62 - this leg is covering less than the tab has (SPEC V209)" }
    if (([regex]::Matches($rendFn266, 'descQuiet = true;')).Count -ne 1 -or ([regex]::Matches($rendFn266, 'descQuiet = false;')).Count -ne 1) {
        $v266Bad += "renderNuminaDesc opens the descQuiet window more than once around one paint - gui.TextEditor has onChange and no onUserChange, so a second window is a second chance for the renderer's write to read as typing (SPEC V266f)"
    }
}

# (d) the write goes to the field of the row MARKED in that pane, read at the moment of the
# write - through the pane's own literal, never through the and/or idiom, which answers with
# the OTHER pane's selector whenever this one is nil.
$saveFn266 = LuaFn $numTxt266 'saveNuminaDesc'
if (-not $saveFn266) { $v266Bad += "saveNuminaDesc is gone - what the storyteller types would live on screen and nowhere else (SPEC V266d)" }
else {
    if ($saveFn266 -notmatch 'if descQuiet or sheet == nil then return; end;') { $v266Bad += "saveNuminaDesc does not stand down while the renderer writes (SPEC V266f)" }
    if ($saveFn266 -notmatch 'local sel = sheet\[selField\];') { $v266Bad += "saveNuminaDesc does not read the selection through the pane's own literal at the moment of the write (SPEC V266d)" }
    if ($saveFn266 -match 'and sheet\.\w+Sel or sheet\.\w+Sel') { $v266Bad += "saveNuminaDesc picks the selection with the and/or idiom - it answers with the other pane's selector whenever this one is nil, and the text lands on a row nobody marked (SPEC I62, V266d)" }
    if ($saveFn266 -notmatch 'if not isTypedRow\(sel\) or not isStoryteller\(\) then return; end;') { $v266Bad += "saveNuminaDesc does not re-ask the rule - the readOnly on the control is a look, the rule is the rule (SPEC V266b)" }
    if ($saveFn266 -notmatch 'setField\(descFieldOf\(sel\), box\.text\);') { $v266Bad += "saveNuminaDesc does not write to the field of the MARKED row (SPEC V266d)" }
}

# (e) True Faith is book text under a fixed key: locked for ever, and no door for a keystroke.
$faith266 = $numDoc266.SelectSingleNode("//textEditor[@name='edtFaithDesc']")
if ($null -eq $faith266) { $v266Bad += "edtFaithDesc is gone (SPEC V209)" }
else {
    if ($faith266.GetAttribute("readOnly") -ne 'true') { $v266Bad += "edtFaithDesc is authored writable - there is no row to type on in that pane (SPEC V266e)" }
    if ($faith266.GetAttribute("onChange")) { $v266Bad += "edtFaithDesc hands what is typed to '$($faith266.GetAttribute('onChange'))' - it would put into the NDB a text no reader ever looks for (SPEC V266e)" }
}

# (f) the typed branch sits ABOVE the require, the state sentence exists in both languages and
# is REACHED, and no dataLink watches a description field.
$numFn266 = LuaFn $numTxt266 'numinaText'
if (-not $numFn266) { $v266Bad += "numinaText not found" }
else {
    $iTyped266 = $numFn266.IndexOf('if isTypedRow(selected) then')
    # T495: the module name is built from the language, so the old IndexOf on the literal
    # would answer -1 for ever and the ordering leg would be SKIPPED - green while measuring
    # nothing, which is B7 arriving through the check instead of through the code. A require
    # this cannot find is therefore a Fail, not a shrug (SPEC V209, V210b).
    $mReq266 = [regex]::Match($numFn266, 'require\("descNumina_"')
    $iReq266 = $(if ($mReq266.Success) { $mReq266.Index } else { -1 })
    if ($iTyped266 -lt 0) { $v266Bad += "numinaText has no typed-row branch - a homebrew numina would show the book's 'no description on file' line and take no key (SPEC I62)" }
    elseif ($iReq266 -lt 0) { $v266Bad += "numinaText no longer builds the numina module name out of the language - the ordering leg below would measure nothing and pass (SPEC V209, V210b, B7)" }
    elseif ($iTyped266 -gt $iReq266) { $v266Bad += "numinaText reaches the require before the typed branch - a homebrew row would parse the 230 KB half it never reads (SPEC V206, V266f)" }
}
if ($numTxt266 -notmatch '(?s)local NO_TEXT_YET = \{\s*en = "[^"]+",\s*pt = "[^"]+",') { $v266Bad += "WoD20.7 has no NO_TEXT_YET in both languages - an empty typed row would open a blank box for the player (SPEC V33, V266f)" }
if ($numTxt266 -notmatch 'return pick\(NO_TEXT_YET, lang\);') { $v266Bad += "WoD20.7 declares NO_TEXT_YET and never says it (SPEC V20 - a state text nothing reaches is not a state text)" }
if ($numTxt266 -notmatch 'if isStoryteller\(\) then return ""; end;') { $v266Bad += "WoD20.7 shows the state sentence to the storyteller too - for him the empty box IS the input (SPEC V250, V266f)" }
foreach ($dl266 in $numDoc266.SelectNodes("//dataLink")) {
    $watch266 = "$($dl266.GetAttribute('field')) $($dl266.GetAttribute('fields'))"
    if ($watch266 -match 'Desc_\d') { $v266Bad += "a dataLink on WoD20.7 watches a description field - every keystroke would repaint the box the storyteller is typing in (SPEC V123, V266f)" }
}

if ($v266Bad) { foreach ($b in $v266Bad) { Fail "V266 $b" } }
else { Pass "V266 the Numina panes open for the storyteller on a typed row only, write to the row that is marked, and True Faith stays the book's" }

# ---- V267: the top band of tabHedge closes on ONE base -----------------------------------
# SPEC I63, user 2026-08-23. Leg (b) is not here: it is the named exception inside V240 above,
# where the rule it replaces lives, with its own guard on the count of stretched boxes.
$v267Bad = @()
$numDoc267 = Doc (Join-Path $dir 'WoD20.7.lfm')
$numTxt267 = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir 'WoD20.7.lfm')))
$hedgePane267 = $numDoc267.SelectSingleNode("//layout[@name='tabHedge']")

# (a) three boxes, one top, one height, and the band closes where the panes close.
if ($null -eq $hedgePane267) { Fail "V267 tabHedge is gone from WoD20.7 - this check reads nothing (SPEC V209)" }
else {
    $band267 = @()
    foreach ($bx in $hedgePane267.SelectNodes("layout[rectangle]")) {
        $bt = -1; $bl = -1; $bw = -1; $bh = -1
        if (-not ([int]::TryParse($bx.GetAttribute("top"), [ref]$bt) -and [int]::TryParse($bx.GetAttribute("left"), [ref]$bl) -and
                  [int]::TryParse($bx.GetAttribute("width"), [ref]$bw) -and [int]::TryParse($bx.GetAttribute("height"), [ref]$bh))) { continue }
        if ($bt -ne 0) { continue }
        $t267 = $bx.SelectSingleNode("label")
        $band267 += [pscustomobject]@{ N = $(if ($t267) { $t267.GetAttribute("text") } else { 'box' }); L = $bl; R = $bl + $bw; H = $bh }
    }
    if ($band267.Count -ne 3) { $v267Bad += "the band across the top of tabHedge holds $($band267.Count) box(es), expected the 3 the request asks for - HEDGE MAGIC, QUINTESSENCE and WILLPOWER (SPEC I63, V209)" }
    else {
        $heights267 = @($band267 | ForEach-Object { $_.H } | Sort-Object -Unique)
        if ($heights267.Count -ne 1) { $v267Bad += "the band closes on $($heights267.Count) different bases ($($heights267 -join ', ')) - 'the same height as the box beside it' is the request in letter (SPEC I63, V267a)" }
        $right267 = ($band267 | Measure-Object -Property R -Maximum).Maximum
        if ($right267 -ne 1270) { $v267Bad += "the band closes at x=$right267, not on the 1270 ruler the panes below it use (SPEC V262c, V267a)" }
    }
}

# (c) the ten PERMANENT dots are art, not a third editable copy of the rating.
$wpDots267 = @($numDoc267.SelectNodes("//imageCheckBox[starts-with(@name,'wpNum_')]"))
if ($wpDots267.Count -ne 10) { Fail "V267 WoD20.7 draws $($wpDots267.Count) permanent willpower dot(s), expected 10 - this check is reading a box that is not there (SPEC V209)" }
else {
    foreach ($d267 in $wpDots267) {
        $dn267 = $d267.GetAttribute("name")
        if ($d267.GetAttribute("field")) { $v267Bad += "$dn267 owns field '$($d267.GetAttribute('field'))' - the permanent rating is bought on the Main tab and this box would be a third place to write it, at no price (SPEC I9, V267c)" }
        if ($d267.GetAttribute("autoChange") -ne 'false') { $v267Bad += "$dn267 is clickable - it is a display of what the Main tab owns (SPEC V267c)" }
        if ($d267.GetAttribute("opacity") -ne '0.40') { $v267Bad += "$dn267 reads live at opacity '$($d267.GetAttribute('opacity'))' - read-only art is dimmed on this sheet (SPEC V111, V267c)" }
    }
}
$wpBoxes267 = @($numDoc267.SelectNodes("//checkBox[starts-with(@field,'willpower_c')]"))
if ($wpBoxes267.Count -ne 10) { $v267Bad += "WoD20.7 carries $($wpBoxes267.Count) temporary willpower box(es), expected 10 - spending willpower is what this box is for (SPEC I63)" }
if ($numTxt267 -notmatch 'form\["wpNum_" \.\. d\]') { $v267Bad += "nothing paints the permanent dots from the sheet - they own no field, so without the painter they are ten dots that never light (SPEC V267c)" }

# (d) a <template> name is module-global: the duplicate makes rdk exit 1 with NO message and
# take the .rpk with it (SPEC B19). Measured across the whole sheet, not just this pair.
$tplHome267 = @{}
$tplDup267 = @()
foreach ($ff267 in $files) {
    foreach ($t267b in (Doc $ff267.FullName).SelectNodes("//template[@name]")) {
        $tn267 = $t267b.GetAttribute("name")
        if ($tplHome267.ContainsKey($tn267)) { $tplDup267 += "'$tn267' is declared in both $($tplHome267[$tn267]) and $($ff267.Name)" }
        else { $tplHome267[$tn267] = $ff267.Name }
    }
}
if ($tplHome267.Count -lt 30) { Fail "V267 only $($tplHome267.Count) template(s) were read across the sheet - this leg is covering less than the sheet has (SPEC V209)" }
foreach ($d267b in $tplDup267) { $v267Bad += "$d267b - a template name is module-global, and the duplicate makes rdk exit 1 with no message at all, deleting the .rpk on its way out (SPEC B19, V267d)" }

if ($v267Bad) { foreach ($b in $v267Bad) { Fail "V267 $b" } }
else { Pass "V267 the three boxes of the band close on one base at 1270, the ten permanent dots are painted art, and no template name is declared twice" }

# ---- V268: the third strip, and the names that cannot collide -----------------------------
# SPEC I64. renderSubTabs builds ONE map keyed by name and selectTab matches a name against
# every group in SUB_TABS, so two groups sharing a pane name cross the two strips - green gate,
# rdk 0, and the symptom two tabs away from its cause.
$v268Bad = @()
$subTabRe = [regex]'(?m)^\s*\{ list = \{ ([^}]+) \}, active = "([^"]+)" \},'
$groups268 = @($subTabRe.Matches($rootTxt))
if ($groups268.Count -lt 3) { Fail "V268 SUB_TABS holds $($groups268.Count) group(s), expected the 3 the sheet draws - this check is reading less than the tab strip has (SPEC I64, V209)" }
else {
    $seen268 = @{}
    $paneNames268 = @()
    foreach ($g268 in $groups268) {
        foreach ($m268 in [regex]::Matches($g268.Groups[1].Value, '"([^"]+)"')) {
            $nm268 = $m268.Groups[1].Value
            foreach ($pfx268 in @('tab', 'tabOn')) {
                $full268 = $pfx268 + $nm268
                if ($seen268.ContainsKey($full268)) { $v268Bad += "'$full268' is named by two SUB_TABS groups - renderSubTabs keys its map by NAME and selectTab matches a name against every group, so a click on one strip would flip the other (SPEC V268a)" }
                $seen268[$full268] = $true
            }
            $paneNames268 += 'tab' + $nm268
        }
        $active268 = $g268.Groups[2].Value
        if ($paneNames268 -notcontains $active268) { $v268Bad += "a SUB_TABS group opens on '$active268', which is not one of its own panes - the strip would light nothing (SPEC I58)" }
    }

    # every pane the groups name exists, exactly once, across the sheet
    $paneHome268 = @{}
    foreach ($ff268 in $files) {
        foreach ($ly268 in (Doc $ff268.FullName).SelectNodes("//layout[@name]")) {
            $ln268 = $ly268.GetAttribute("name")
            if ($paneNames268 -notcontains $ln268) { continue }
            if ($paneHome268.ContainsKey($ln268)) { $v268Bad += "pane '$ln268' is drawn in both $($paneHome268[$ln268]) and $($ff268.Name) - xpFind answers with one of them and nobody can say which (SPEC V268a)" }
            else { $paneHome268[$ln268] = $ff268.Name }
        }
    }
    foreach ($pn268 in ($paneNames268 | Sort-Object -Unique)) {
        if (-not $paneHome268.ContainsKey($pn268)) { $v268Bad += "SUB_TABS names pane '$pn268' and no .lfm draws it - the strip would hide a pane that is not there and show nothing (SPEC I58)" }
    }
}

# (b) and (c): the strip carries no align, the two panes share ONE exact rect below it, and
# what they hold fits them on BOTH axes (SPEC B41, B52).
$hStrip268 = $numDoc267.SelectSingleNode("//layout[@name='hedgeStrip']")
$hPanes268 = @($numDoc267.SelectNodes("//layout[@name='tabHedgePaths'] | //layout[@name='tabHedgeRituals']"))
if ($null -eq $hStrip268) { Fail "V268 hedgeStrip is gone from WoD20.7 - the Paths and Rituals tabs have no strip (SPEC I64, V209)" }
elseif ($hPanes268.Count -ne 2) { Fail "V268 the Hedge Magic pane holds $($hPanes268.Count) sub-pane(s), expected 2 (SPEC I64, V209)" }
else {
    if ($hStrip268.GetAttribute("align")) { $v268Bad += "hedgeStrip claims align='$($hStrip268.GetAttribute('align'))' - whatever is authored under it would be drawn beneath it (SPEC B41, V268b)" }
    $sTop268 = [int]$hStrip268.GetAttribute("top")
    $sEnd268 = $sTop268 + [int]$hStrip268.GetAttribute("height")
    $rects268 = @($hPanes268 | ForEach-Object { "$($_.GetAttribute('left'))/$($_.GetAttribute('top'))/$($_.GetAttribute('width'))/$($_.GetAttribute('height'))" } | Sort-Object -Unique)
    if ($rects268.Count -ne 1) { $v268Bad += "the two sub-panes sit on $($rects268.Count) different rects ($($rects268 -join ' vs ')) - they stack on ONE and exactly one is visible (SPEC V268b)" }
    $pTop268 = [int]$hPanes268[0].GetAttribute("top")
    if ($pTop268 -lt $sEnd268) { $v268Bad += "the sub-panes open at y=$pTop268, inside a strip that ends at $sEnd268 - an absolute sibling does not collide, it simply covers (SPEC V268b)" }

    $pW268 = [int]$hPanes268[0].GetAttribute("width")
    $pH268 = [int]$hPanes268[0].GetAttribute("height")
    foreach ($p268 in $hPanes268) {
        $maxR268 = 0; $maxB268 = 0
        foreach ($k268 in $p268.ChildNodes) {
            if ($k268.NodeType -ne 'Element') { continue }
            $kl268 = 0; $kt268 = 0; $kw268 = 0; $kh268 = 0
            if (-not ([int]::TryParse($k268.GetAttribute("left"), [ref]$kl268) -and [int]::TryParse($k268.GetAttribute("top"), [ref]$kt268) -and
                      [int]::TryParse($k268.GetAttribute("width"), [ref]$kw268) -and [int]::TryParse($k268.GetAttribute("height"), [ref]$kh268))) { continue }
            if (($kl268 + $kw268) -gt $maxR268) { $maxR268 = $kl268 + $kw268 }
            if (($kt268 + $kh268) -gt $maxB268) { $maxB268 = $kt268 + $kh268 }
        }
        $pn268b = $p268.GetAttribute("name")
        if ($maxR268 -eq 0) { $v268Bad += "$pn268b holds nothing this check can measure (SPEC V209)"; continue }
        if ($maxR268 -gt $pW268) { $v268Bad += "$pn268b reaches x=$maxR268 inside a pane $($pW268)px wide - a horizontal bar, which is half of B52" }
        if ($maxB268 -gt $pH268) { $v268Bad += "$pn268b reaches y=$maxB268 inside a pane $($pH268)px tall - a vertical bar, which is the other half" }
    }

    # (d) the note rides in the strip, and there is exactly one of it.
    $noteRe268 = [regex]'text="\* The first path is the Affinity Path"'
    $noteAll268 = @($noteRe268.Matches($numTxt267))
    $noteInStrip268 = @($hStrip268.SelectNodes("label[@text='* The first path is the Affinity Path']"))
    if ($noteAll268.Count -ne 1) { $v268Bad += "the affinity note appears $($noteAll268.Count) time(s) in WoD20.7, expected exactly 1 (SPEC V88, V268d)" }
    if ($noteInStrip268.Count -ne 1) { $v268Bad += "the affinity note is not a label of hedgeStrip - back under the list it explains, it plus its gap wants 30px the 472 the pane has cannot give, and the seventeenth row goes off the bottom (SPEC I64, V268d)" }
}

if ($v268Bad) { foreach ($b in $v268Bad) { Fail "V268 $b" } }
else { Pass "V268 the three strips name $($seen268.Count) distinct panes and pills, hedgeStrip clears its two panes, and the affinity note rides in it" }

# ---- V269: a ritual's level is READ, and it costs one per level ---------------------------
# SPEC I65, user 2026-08-23.
$v269Bad = @()

# (a) the twelve PICKED rows wear the book's level in art: no field, no click, dimmed.
$ritPick269 = $numDoc267.SelectSingleNode("//template[@name='HedgeRitualPicker']")
$ritFree269 = $numDoc267.SelectSingleNode("//template[@name='HedgeRitualFree']")
if ($null -eq $ritPick269 -or $null -eq $ritFree269) { Fail "V269 the ritual row templates are missing from WoD20.7 - this check reads nothing (SPEC V209)" }
else {
    $pickDots269 = @($ritPick269.SelectNodes("imageCheckBox"))
    if ($pickDots269.Count -ne 5) { $v269Bad += "a picked ritual row draws $($pickDots269.Count) dot(s), expected 5 - the level it shows runs 1 to 5 (SPEC I65)" }
    foreach ($d269 in $pickDots269) {
        if ($d269.GetAttribute("field")) { $v269Bad += "a dot of HedgeRitualPicker owns field '$($d269.GetAttribute('field'))' - the level lives in the item text, and a field here is a second place to keep it, free to disagree (SPEC V269a)" }
        if ($d269.GetAttribute("onClick")) { $v269Bad += "a dot of HedgeRitualPicker is clickable - the book sets the level of a ritual that came off the list (SPEC V269a)" }
        if ($d269.GetAttribute("opacity") -ne '0.40') { $v269Bad += "a dot of HedgeRitualPicker reads live at opacity '$($d269.GetAttribute('opacity'))' - read-only art is dimmed on this sheet (SPEC V111, V269a)" }
    }

    # (b) the five TYPED rows own real dots, and only they are declared as traits.
    $freeDots269 = @($ritFree269.SelectNodes("imageCheckBox"))
    if ($freeDots269.Count -ne 5) { $v269Bad += "a typed ritual row draws $($freeDots269.Count) dot(s), expected 5 (SPEC I65)" }
    foreach ($d269b in $freeDots269) {
        if (-not $d269b.GetAttribute("field")) { $v269Bad += "a dot of HedgeRitualFree owns no field - the storyteller's homebrew has no prefix to read its level from, so the dots ARE the level (SPEC V269b, V269d)" }
        if ($d269b.GetAttribute("onClick") -notmatch 'xpClick') { $v269Bad += "a dot of HedgeRitualFree does not reach xpClick - it would mark itself for free (SPEC V99, V134, V269b)" }
    }
}
if ($rootTxt -notmatch 'for i = TYPED_ROW_FROM\.hedgeRitual, HEDGE_RITUAL_ROWS, 1 do declareTrait\("hedgeRitual_" \.\. i, 1, 5, 0\); end;') {
    $v269Bad += "declareTrait does not start at the first TYPED ritual row - the twelve picked ones carry no dot field at all, and declaring them hands xpClick a range of widgets that do not exist (SPEC V269b)"
}

# (c) ONE line per ritual, and it is the only aggregated category on the sheet.
$rowsFn269 = LuaFn $rootTxt 'xpLedgerRows'
if (-not $rowsFn269) { $v269Bad += "xpLedgerRows not found" }
else {
    if ($rowsFn269 -notmatch 'kind = "Ritual", name = slotName\(field\), level = to, cost = cost') { $v269Bad += "the ledger does not write ONE aggregated line per ritual - the request is that the change stays in the same record, because a ritual has one level (SPEC I9, V269c)" }
    if ($rowsFn269 -match 'pushRise\(rows, "Ritual"') { $v269Bad += "the ledger sends rituals through pushRise - that is one line per POINT, which is the shape every rated trait uses and the one thing a ritual is not (SPEC V269c)" }
    if ($rowsFn269 -notmatch 'if base\[field\] == live then from = hedgeRitualLevel\(field, live, base\); end;') { $v269Bad += "the ledger does not price a SWAPPED ritual from zero - a level one traded for a level three would be charged as a two-point rise (SPEC I65, V269d)" }
    if ($rowsFn269 -notmatch 'string\.find\(ctx\.free, "\|" \.\. field \.\. "#" \.\. lvl \.\. "\|", 1, true\)') { $v269Bad += "the ritual line ignores the free stamp - a level the storyteller gave away would still be charged (SPEC V139, V269c)" }
}
if ($rootTxt -notmatch 'if kind == "Ritual" then return 1; end;') { $v269Bad += "xpCost has no flat price for a ritual - one experience per level is the rule the user gave (SPEC I9)" }

# (d) ONE reader of the level. The painter on WoD20.7 calls the root's, so the art on screen
# and the price in the log cannot tell two stories.
if ($rootTxt -notmatch '(?m)^\s*function hedgeRitualLevel\(field, value, node\)') { $v269Bad += "hedgeRitualLevel is not a global on the root form - the painter on another .lfm could not reach it and would grow a copy of the grammar (SPEC V223, V269d)" }
$paintRit269 = LuaFn $numTxt267 'paintHedgeRitualDots'
if (-not $paintRit269) { $v269Bad += "paintHedgeRitualDots is gone - the picked rows own no dot field, so nothing would ever light them (SPEC V269a)" }
elseif ($paintRit269 -notmatch 'hedgeRitualLevel\(field, sheet\[field\]\)') { $v269Bad += "the dot painter does not read the level through hedgeRitualLevel - a second copy of the '<n>. ' grammar drifts from the one the log prices with (SPEC V269d)" }
if ($numTxt267 -match '\^\(%d\+\)%\. ') { $v269Bad += "WoD20.7 parses the level prefix itself - that grammar is written once, on the root form (SPEC V269d)" }

# (e) the key exists and opens empty: without it pickerItems falls back to c.values and the box
# leaves the axis that translates it, which is B57 through another door.
$ritList269 = [regex]::Match($rootTxt, '(?s)\["hedgeRitual"\] = \{(.*?)\},')
if (-not $ritList269.Success) { $v269Bad += "PICKER_LIST has no 'hedgeRitual' key - the twelve picked rows would read c.values and never see the sheet's language (SPEC V269e, B57)" }
else {
    $items269 = @([regex]::Matches($ritList269.Groups[1].Value, '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value })
    if ($items269.Count -lt 1 -or $items269[0] -ne '') { $v269Bad += "PICKER_LIST['hedgeRitual'] does not open with the empty item every picker opens with (SPEC V15, V269e)" }
}

if ($v269Bad) { foreach ($b in $v269Bad) { Fail "V269 $b" } }
else { Pass "V269 the picked ritual rows show the book's level in art, the typed ones buy theirs a point at a time, and the log carries one line per ritual" }


# ---- V270: Affiliation is a PICKER and its list lives in one place ------------------------
# SPEC I66, user 2026-08-23. The failure this guards is not a wrong pixel: a picker whose key
# the map does not hold is not a compile error - it falls through to `or c.values`, which T493
# emptied, and the dropdown opens BLANK with rdk exiting 0 (SPEC V211a, B6).
$v270Bad = @()

$affCbo270 = @()
$affEdt270 = @()
foreach ($f270 in $files) {
    $d270 = Doc $f270.FullName
    foreach ($n270 in $d270.SelectNodes("//comboBox[@field='hedgeAffiliation']")) { $affCbo270 += $n270 }
    foreach ($n270 in $d270.SelectNodes("//edit[@field='hedgeAffiliation']")) { $affEdt270 += "$($f270.Name) $($n270.GetAttribute('name'))" }
}

# (a) ONE combo owns the field, and the only <edit> allowed on it is the declared mirror twin
# of I71 - which is authored hidden. An edit that is VISIBLE is the field going back to free
# text, which is exactly what the 93rd round replaced.
if ($affCbo270.Count -ne 1) { $v270Bad += "$($affCbo270.Count) comboBox(es) bind hedgeAffiliation, expected exactly 1 - two owners of one field is the duplicate V1 refuses (SPEC V270a)" }
elseif ($affCbo270[0].GetAttribute("name") -ne 'cboHedgeAffiliation') { $v270Bad += "the affiliation picker is named '$($affCbo270[0].GetAttribute('name'))', not cboHedgeAffiliation - the name is what resolves the PICKER_LIST key (SPEC V270d)" }
if ($affEdt270.Count -gt 1) { $v270Bad += "$($affEdt270.Count) <edit> controls bind hedgeAffiliation ($($affEdt270 -join ', ')) - the only one allowed is the declared mirror twin of SPEC I71 (SPEC V270a)" }
elseif ($affEdt270.Count -eq 1 -and $affEdt270[0] -notmatch 'edtHedgeAffiliation') { $v270Bad += "an <edit> binds hedgeAffiliation and is not the declared mirror ($($affEdt270[0])) - the field went back to free text (SPEC V270a)" }

# (b) the list is inside the MARKED region V211b finds, and it is 26 distinct names plus the
# empty item. A duplicate in a picker is the item that can never be chosen.
$region270 = [regex]::Match($rootTxt, '(?s)>>> PICKER_LIST_BEGIN(.*?)<<< PICKER_LIST_END')
if (-not $region270.Success) { $v270Bad += "the PICKER_LIST markers are gone from the root form - nothing here can find the list (SPEC V211b, V209)" }
else {
    $affList270 = [regex]::Match($region270.Groups[1].Value, '(?s)\["hedgeAffiliation"\] = \{(.*?)\},\s*\n')
    if (-not $affList270.Success) { $v270Bad += "PICKER_LIST['hedgeAffiliation'] is not inside the marked region - a key outside it is a list V211 cannot reach (SPEC V270b)" }
    else {
        $affItems270 = @([regex]::Matches($affList270.Groups[1].Value, '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value })
        if ($affItems270.Count -eq 0) { $v270Bad += "PICKER_LIST['hedgeAffiliation'] parsed to zero items - this check is reading nothing (SPEC V209)" }
        else {
            if ($affItems270[0] -ne '') { $v270Bad += "the affiliation list does not open with the empty item every picker on this sheet opens with (SPEC V15, V270b)" }
            $named270 = @($affItems270 | Where-Object { $_ -ne '' })
            if ($named270.Count -ne 26) { $v270Bad += "the affiliation list carries $($named270.Count) names, expected 26 - twenty from M20 Sorcerer, one from HH2 and four from the Companion, plus Lone Practitioner (SPEC I66, R105, R107, R108)" }
            $dupAff270 = @($named270 | Group-Object | Where-Object { $_.Count -gt 1 })
            foreach ($d in $dupAff270) { $v270Bad += "'$($d.Name)' is listed $($d.Count) times - a duplicate in a picker is the item nobody can ever choose (SPEC V270b)" }

            # (c) the book's own term for the unaffiliated, and the negative leg that stops
            # somebody 'improving' it into a word the books never printed (SPEC R105 p. 79).
            if ($named270 -notcontains 'Lone Practitioner') { $v270Bad += "'Lone Practitioner' is not on the list - it is the book's term for the unaffiliated and a choice of its own, distinct from the unanswered empty item (SPEC R105, V270c)" }
            foreach ($bad270 in @('None', 'No Affiliation', 'Unaligned', 'Unaffiliated')) {
                if ($named270 -contains $bad270) { $v270Bad += "'$bad270' is on the list - the book says Lone Practitioner and this one was invented (SPEC R105, V270c)" }
            }

            # (d) the key is COMPUTED from the control name the way fieldRoot computes it -
            # drop `cbo`, lowercase the first letter, cut a trailing _<n>. Comparing two
            # literals would pass with both of them wrong together.
            if ($affCbo270.Count -eq 1) {
                $nm270 = $affCbo270[0].GetAttribute("name")
                if ($nm270.Length -gt 3 -and $nm270.Substring(0, 3) -eq 'cbo') {
                    $root270 = $nm270.Substring(3) -replace '_?\d+$', ''
                    $root270 = $root270.Substring(0, 1).ToLower() + $root270.Substring(1)
                    if ($root270 -ne 'hedgeAffiliation') { $v270Bad += "the control name resolves to PICKER_LIST['$root270'], which is not where the list lives - a wrong key opens the dropdown blank with rdk exiting 0 (SPEC V211a, V270d, B6)" }
                } else { $v270Bad += "the affiliation picker is not named cbo* - fieldRoot drops exactly three characters and would resolve to something else (SPEC V270d)" }
            }
        }
    }
}
if ($v270Bad) { foreach ($b in $v270Bad) { Fail "V270 $b" } }
else { Pass "V270 Affiliation is one comboBox on one marked list of 26 names, Lone Practitioner among them, and the control name resolves to the key that holds it" }


# ---- V271: AFFINITY and CASTING_ATTR name nothing outside the canon -----------------------
# SPEC I67, I68, user 2026-08-23. A filter value the picker does not carry does not fail loudly:
# it silently empties the row it filters.
$v271Bad = @()

function TableOf271($txt, $name) {
    $m = [regex]::Match($txt, "(?s)(?m)^\s*$name = \{\r?\n(.*?)^\s*\};")
    if (-not $m.Success) { return $null }
    $out = [ordered]@{}
    foreach ($row in [regex]::Matches($m.Groups[1].Value, '\["([^"]+)"\]\s*=\s*\{([^}]*)\}')) {
        $vals = @([regex]::Matches($row.Groups[2].Value, '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value })
        $out[$row.Groups[1].Value] = $vals
    }
    return $out
}

$affinity271 = TableOf271 $rootTxt 'AFFINITY'
$casting271 = TableOf271 $rootTxt 'CASTING_ATTR'
$numina271 = @()
$hattr271 = @()
$affNames271 = @()
if ($region270.Success) {
    $nl271 = [regex]::Match($region270.Groups[1].Value, '(?s)\["numina"\] = \{(.*?)\},\s*\n')
    if ($nl271.Success) { $numina271 = @([regex]::Matches($nl271.Groups[1].Value, '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value } | Where-Object { $_ -ne '' }) }
    $hl271 = [regex]::Match($region270.Groups[1].Value, '(?s)\["hedgeAttr"\] = \{(.*?)\},\s*\n')
    if ($hl271.Success) { $hattr271 = @([regex]::Matches($hl271.Groups[1].Value, '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value } | Where-Object { $_ -ne '' }) }
    $al271 = [regex]::Match($region270.Groups[1].Value, '(?s)\["hedgeAffiliation"\] = \{(.*?)\},\s*\n')
    if ($al271.Success) { $affNames271 = @([regex]::Matches($al271.Groups[1].Value, '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value } | Where-Object { $_ -ne '' }) }
}
$xpAttrs271 = @()
$xp271 = [regex]::Match($rootTxt, '(?s)(?m)^\s*local XP_ATTRS = \{(.*?)\};')
if ($xp271.Success) { $xpAttrs271 = @([regex]::Matches($xp271.Groups[1].Value, '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value } | Where-Object { $_ -ne '' }) }

if ($null -eq $affinity271 -or $affinity271.Count -eq 0) { $v271Bad += "AFFINITY is not declared on the root form, or parsed to zero keys - the first hedge row would filter by nothing and this check would read nothing (SPEC I67, V209)" }
elseif ($null -eq $casting271 -or $casting271.Count -eq 0) { $v271Bad += "CASTING_ATTR is not declared on the root form, or parsed to zero keys (SPEC I68, V209)" }
elseif ($numina271.Count -eq 0 -or $hattr271.Count -eq 0 -or $affNames271.Count -eq 0 -or $xpAttrs271.Count -eq 0) { $v271Bad += "one of the four lists this check compares against parsed EMPTY (numina $($numina271.Count), hedgeAttr $($hattr271.Count), affiliations $($affNames271.Count), XP_ATTRS $($xpAttrs271.Count)) - every comparison below would pass by default (SPEC V209)" }
else {
    # (a) every key of both tables is an affiliation the picker offers.
    foreach ($k in @($affinity271.Keys) + @($casting271.Keys)) {
        if ($affNames271 -notcontains $k) { $v271Bad += "'$k' is keyed in a filter table and is not an affiliation the picker offers - nobody can ever select it, so the table entry is dead (SPEC V271a, B55)" }
    }
    # (b) every path an affiliation favours is a path the numina picker carries.
    foreach ($k in $affinity271.Keys) {
        foreach ($v in $affinity271[$k]) {
            if ($numina271 -notcontains $v) { $v271Bad += "AFFINITY['$k'] favours '$v', which PICKER_LIST['numina'] does not carry - a filter value outside the list empties the whole row (SPEC V271b, I67)" }
        }
    }
    # (c) every favoured attribute is one of the nine, in the sheet's own spelling, and the
    # union of them stays inside XP_ATTRS - the same bijection V264a measures both ways.
    foreach ($k in $casting271.Keys) {
        foreach ($v in $casting271[$k]) {
            if ($hattr271 -notcontains $v) { $v271Bad += "CASTING_ATTR['$k'] favours '$v', which PICKER_LIST['hedgeAttr'] does not carry - `Inteligence` is this sheet's spelling and correcting it in one place only breaks the bijection (SPEC V271c, I3)" }
            if ($xpAttrs271 -notcontains $v) { $v271Bad += "CASTING_ATTR['$k'] favours '$v', which XP_ATTRS does not carry - an attribute that entered one side only passes every count check on the sheet (SPEC V271c, V264a)" }
        }
    }
    # (d) ABSENCE is the rule 'does not filter'. A key with an empty table is B6 by another door.
    foreach ($t in @(@('AFFINITY', $affinity271), @('CASTING_ATTR', $casting271))) {
        if ($t[1].Contains('Lone Practitioner')) { $v271Bad += "$($t[0]) has a key for 'Lone Practitioner' - the unaligned magician picks from everything, and the way this sheet says that is by having NO key (SPEC V271d, I67)" }
        foreach ($k in $t[1].Keys) {
            if ($t[1][$k].Count -eq 0) { $v271Bad += "$($t[0])['$k'] is an EMPTY table - that is a dropdown with nothing in it, which is B6 arriving through another door (SPEC V271d)" }
        }
    }
    # (e) the two counts are DIRECTED, not an oversight: only the twenty M20 Sorcerer entries
    # print a `Favored Attributes:` line, so five affiliations have paths and no attribute.
    if ($affinity271.Count -ne 25) { $v271Bad += "AFFINITY holds $($affinity271.Count) keys, expected 25 - the twenty-six affiliations less Lone Practitioner (SPEC V271e, I67)" }
    if ($casting271.Count -ne 20) { $v271Bad += "CASTING_ATTR holds $($casting271.Count) keys, expected 20 - only the M20 Sorcerer entries declare a favoured attribute (SPEC V271e, R107, R108)" }
    foreach ($k in $casting271.Keys) {
        if (-not $affinity271.Contains($k)) { $v271Bad += "'$k' favours an attribute and no path - the difference between the two tables runs one way only, and this one goes the wrong way (SPEC V271e)" }
    }
}
if ($v271Bad) { foreach ($b in $v271Bad) { Fail "V271 $b" } }
else { Pass "V271 the two filter tables name only what the three pickers carry - $($affinity271.Count) affiliations with paths, $($casting271.Count) with attributes, and Lone Practitioner in neither" }


# ---- V272: the two affiliation filters reach two controls, and the memo sees them ----------
# SPEC I67, I68, user 2026-08-23. Legs (b) and (c) are the ones that show NO symptom when they
# are wrong: the combo serves a stale list, or sheet[field] comes back nil and the stored value
# is quietly dropped - both with rdk exiting 0 and this gate green (SPEC B48, V200).
$v272Bad = @()

$pickFn272 = [regex]::Match($hh6, '(?s)local function pickerItems\(c, lang, era, levels\)(.*?)\n\t\t\tend;')
$filterName272 = [regex]::Match($hh6, '(?s)local FILTER_NAME = \{(.*?)\};')
$filterRow272 = [regex]::Match($hh6, '(?s)local FILTER_ROW = \{(.*?)\};')

if (-not $filterName272.Success) { $v272Bad += "FILTER_NAME is not declared in WoD20.6 - the two singleton filters have nothing keying them and this check reads nothing (SPEC I67, V209)" }
elseif (-not $pickFn272.Success) { $v272Bad += "pickerItems not found in WoD20.6 - every leg below would pass by default (SPEC V209)" }
else {
    # (a) exactly the two names, and the ROOT table did not grow one of them: FILTER_ROW keyed
    # by `numina` would filter all seventeen hedge rows, and only the FIRST is the Affinity Path.
    $fnNames272 = @([regex]::Matches($filterName272.Groups[1].Value, '([A-Za-z_][A-Za-z0-9_]*)\s*=\s*true') | ForEach-Object { $_.Groups[1].Value } | Sort-Object)
    if ($fnNames272.Count -eq 0) { $v272Bad += "FILTER_NAME parsed to zero names - nothing is filtered and nothing here measures it (SPEC V209)" }
    elseif (($fnNames272 -join ',') -ne 'cboHedgeAttr,cbonumina_1') { $v272Bad += "FILTER_NAME holds $($fnNames272 -join ', '), expected cboHedgeAttr and cbonumina_1 - the Affinity Path is ONE row (SPEC V272a, I67)" }
    if ($filterRow272.Success) {
        foreach ($bad272 in @('numina', 'psychic', 'hedgeAttr')) {
            if ($filterRow272.Groups[1].Value -match "(?m)^\s*$bad272\s*=") { $v272Bad += "FILTER_ROW gained '$bad272' - filtering by ROOT takes all seventeen rows of the box instead of the first (SPEC V272a, V203)" }
        }
    }

    $body272 = NoComments $pickFn272.Groups[1].Value

    # (b) the memo stamp names the affiliation. Without it the stamp holds across a change of
    # affiliation and every combo is served the list built under the old one.
    if ($body272 -notmatch 'local stamp = .*hedgeAffiliation') { $v272Bad += "the pickerItems memo is not stamped with the affiliation - switching it leaves lang and era untouched, the stamp holds, and the old list is served with rdk exiting 0 (SPEC V272b, B48)" }

    # (c) the field a SINGLETON writes. string.sub(nm,4) hands back `HedgeAttr` with the capital
    # still on it, sheet[field] is nil, and V200 lets go of the stored value in silence.
    if ($body272 -notmatch 'string\.match\(nm, "_%d\+\$"\)') { $v272Bad += "pickerItems never asks whether the control name ends in _<n> - that question is what tells a ROW from a SINGLETON, and without it cboHedgeAttr resolves to 'HedgeAttr' with the capital still on, sheet[field] comes back nil, and the row's own value is dropped with no symptom anywhere (SPEC V272c, I68, V200)" }
    elseif ($body272 -notmatch 'fieldRoot\(nm\)\s*;') { $v272Bad += "the singleton branch of the field line does not end at fieldRoot - nothing lowercases the first letter and sheet[field] is nil (SPEC V272c, I68)" }
    if ($body272 -match 'local field = filter and string\.sub\(nm, 4\) or nil;') { $v272Bad += "the pre-94th field line is back - it serves ROWS and lies to every SINGLETON picker (SPEC V272c)" }
}

# (d) what the filter READS is what the link WATCHES, and the renderer asks for the same two
# names leg (a) holds (SPEC V123).
$dl272 = [regex]::Match($numTxt267, '<dataLink[^>]*field="hedgeAffiliation"[^>]*>')
if (-not $dl272.Success) { $v272Bad += "no dataLink on WoD20.7 watches hedgeAffiliation - the two lists would only rebuild when something else happened to repaint them (SPEC V272d, V123)" }
elseif ($dl272.Value -notmatch 'renderHedgePickers\(') { $v272Bad += "the hedgeAffiliation dataLink does not call renderHedgePickers (SPEC V272d)" }
$hedgeFn272 = LuaFn $hh6 'renderHedgePickers'
if (-not $hedgeFn272) { $v272Bad += "renderHedgePickers is not declared in WoD20.6 - the dataLink calls a global that finds nil at runtime, and rdk exits 0 on that (SPEC V272d, V223, B51)" }
else {
    $askFor272 = @([regex]::Matches((NoComments $hedgeFn272), '([A-Za-z_][A-Za-z0-9_]*)\s*=\s*true') | ForEach-Object { $_.Groups[1].Value } | Sort-Object)
    if (($askFor272 -join ',') -ne 'cboHedgeAttr,cbonumina_1') { $v272Bad += "renderHedgePickers asks xpFind for $($askFor272 -join ', '), which is not the set FILTER_NAME filters - a control that is filtered and never re-rendered keeps the list it was born with (SPEC V272d)" }
    if ((NoComments $hedgeFn272) -notmatch 'discLevels\(\)') { $v272Bad += "renderHedgePickers hands pickerItems no level map - `filter` is `isFilterRow(nm) and levels ~= nil`, so a nil there turns BOTH filters off and the round does nothing (SPEC V272d, V205)" }
}

# (e) the two branches, and both of them answer YES when the table has no key: a branch that
# said no would open two empty dropdowns for Lone Practitioner.
$allowFn272 = LuaFn $rootTxt 'pickAllowed'
if (-not $allowFn272) { $v272Bad += "pickAllowed not found on the root form - the filter has no door to the rule (SPEC V209, V199)" }
else {
    $ab272 = NoComments $allowFn272
    foreach ($pair272 in @(@('numina_1', 'AFFINITY'), @('hedgeAttr', 'CASTING_ATTR'))) {
        if ($ab272 -notmatch "field == `"$($pair272[0])`"") { $v272Bad += "pickAllowed has no branch for '$($pair272[0])' - the table is data nobody reads (SPEC V272e, B55)" }
        elseif ($ab272 -notmatch $pair272[1]) { $v272Bad += "the '$($pair272[0])' branch of pickAllowed does not read $($pair272[1]) (SPEC V272e)" }
    }
}
$allows272 = LuaFn $rootTxt 'hedgeAllows'
if (-not $allows272) {
    $allows272m = [regex]::Match($rootTxt, '(?s)local function hedgeAllows\(t, value\)(.*?)\n\t\t\tend;')
    if ($allows272m.Success) { $allows272 = $allows272m.Value }
}
if (-not $allows272) { $v272Bad += "the shared body the two branches call is gone - each branch would grow its own copy of 'no key means no filter' (SPEC V272e)" }
elseif ((NoComments $allows272) -notmatch 'if ok == nil then return true; end;') { $v272Bad += "an affiliation with no entry does not open the whole list - Lone Practitioner and the unanswered empty item would face two empty dropdowns (SPEC V272e, V271d)" }

if ($v272Bad) { foreach ($b in $v272Bad) { Fail "V272 $b" } }
else { Pass "V272 the affiliation filter reaches cbonumina_1 and cboHedgeAttr only, the memo is stamped with it, the singleton field is computed through fieldRoot, and no key means no filter" }


# ---- V273: every numina description carries its source, in both languages ------------------
# SPEC I70, I21, user 2026-08-23. This is V192 in the other module: the numina text lives in
# descNumina.lua and the collector is a different one, so the rule is a SISTER and not a wider
# regex (SPEC V203, I24). V177 measures EXISTENCE and V32 the picker-to-DESC cover; this one
# measures FORMAT.
$v273Bad = @()
# The three titles are ASCII in this file on purpose: PowerShell 5.1 reads a .ps1 with no BOM
# as ANSI, so an accented or curly-quote literal typed here would arrive mojibaked and the check
# redden on correct text. Built from code points, it compares the same bytes descNumina.lua
# holds (SPEC R109).
$PAG273  = "p" + [char]0xE1 + "g."
$COMP273 = "Sorcerer" + [char]0x2019 + "s Companion"
$BOOK273 = @{
    "M20 Sorcerer"          = @(18, 76)
    "The Hunters Hunted II" = @(69, 142)
}
$BOOK273[$COMP273] = @(15, 31)
$numEn273 = DescEntries (Join-Path $plugin "descNumina_en.lua") 'DESC' 'en'
$numPt273 = DescEntries (Join-Path $plugin "descNumina_pt.lua") 'DESC' 'pt'
if ($null -eq $numEn273) { $v273Bad += "descNumina_en.lua is missing from the plugin root, or its DESC markers are gone - there is no [en] text to measure (SPEC I24, V209, V210)" }
else {
    if ($null -eq $numPt273) { $v273Bad += "descNumina_pt.lua is missing from the plugin root, or its DESC markers are gone - there is no [pt] text to measure (SPEC I24, V209, V210)" }
    else {
        # T495 put the two languages in two files, so the pair leg (d) compares is a join by
        # key. A key with no [pt] side is V210's fail, and it is named here too: without it
        # leg (d) would pass on the half it never saw (SPEC V210a).
        $ptMap273 = DescMap $numPt273
        $seen273 = 0
        foreach ($e273 in $numEn273) {
            $seen273++
            $key273 = $e273.Key
            $cite273 = @{}
            $sides273 = @(, @('en', $e273.Body, 'p.'))
            if ($ptMap273.ContainsKey($key273)) { $sides273 += , @("pt", $ptMap273[$key273], $PAG273) }
            else { $v273Bad += "'$key273' is in descNumina_en.lua and nowhere in descNumina_pt.lua - the [pt] side has no source to check (SPEC V210a)" }
            foreach ($side273 in $sides273) {
                $lang273 = $side273[0]
                $blocks273 = $side273[1] -split "`n`n`n"
                if ($blocks273.Count -lt 3) { $v273Bad += "'$key273' [$lang273] is $($blocks273.Count) block(s), expected the three of SPEC I21 - source, name, then the book text (SPEC V273)"; continue }
                # block 2 is the KEY itself. `Shadow` and `Shadows` are two different numina one
                # letter apart, so swapping them passes V177 and has to die here (SPEC V273).
                if ($blocks273[1] -ne $key273) { $v273Bad += "'$key273' [$lang273] names itself '$($blocks273[1])' in the second block - the two are different numina when they differ by one letter (SPEC V273, V177)"; continue }
                # block 1 is `<title>, p. <n>` and its pt label; the label is the ONLY thing
                # that translates, the title is a proper name (SPEC I21).
                $lbl273 = [regex]::Escape($side273[2])
                $head273 = [regex]::Match($blocks273[0], "^(.+), $lbl273 (\d+)$")
                if (-not $head273.Success) { $v273Bad += "'$key273' [$lang273] opens with '$($blocks273[0])', not '<book>, $($side273[2]) <page>' (SPEC V273, I21)"; continue }
                $bk273 = $head273.Groups[1].Value
                $pg273 = [int]$head273.Groups[2].Value
                # (b) three titles and no fourth: a book joins this sheet through SPEC R, not through
                # a typing slip in one entry.
                if (-not $BOOK273.ContainsKey($bk273)) { $v273Bad += "'$key273' [$lang273] cites '$bk273', which is not one of the three books SPEC R109 names (SPEC V273b)"; continue }
                # (c) the page is a number inside the range of the book it names.
                $range273 = $BOOK273[$bk273]
                if ($pg273 -lt $range273[0] -or $pg273 -gt $range273[1]) { $v273Bad += "'$key273' [$lang273] cites $bk273 p. $pg273, outside the $($range273[0])-$($range273[1]) the numina of that book occupy (SPEC V273c, R107, R108, R109)"; continue }
                $cite273[$lang273] = "$bk273|$pg273"
            }
            # (d) one entry is one source: a translation that changed book or page is drift that
            # nobody would ever see on screen, because only one language is open at a time.
            if ($cite273.ContainsKey('en') -and $cite273.ContainsKey('pt') -and $cite273['en'] -ne $cite273['pt']) {
                $v273Bad += "'$key273' cites $($cite273['en'] -replace '\|', ' p. ') in English and $($cite273['pt'] -replace '\|', ' p. ') in Portuguese - one entry is one source (SPEC V273d, I69)"
            }
        }
        if ($seen273 -eq 0) { $v273Bad += "the DESC region parsed to zero entries - the parser or the generated shape drifted and every leg above passed by default (SPEC V209)" }
        elseif ($seen273 -ne 50) { $v273Bad += "descNumina_en.lua holds $seen273 entries, expected 50 - the 49 the two pickers offer plus True Faith, which has no picker and is an entry all the same (SPEC I70, I61, V265a)" }
        elseif ($numPt273.Count -ne 50) { $v273Bad += "descNumina_pt.lua holds $($numPt273.Count) entries, expected 50 - the halves are read one at a time now, and a short [pt] side is text no reader of that language can reach (SPEC V210a, I70)" }
    }
}
if ($v273Bad) { foreach ($b in $v273Bad) { Fail "V273 $b" } }
else { Pass "V273 all 50 numina descriptions open with book and page in both languages, name themselves in the second block, and cite one source per entry" }


# ---- V274: the two manual-entry flags are fail-closed, and the mirror is declared ----------
# SPEC I71, user 2026-08-23. What the flag swaps is which of two widgets on ONE field the reader
# can reach - so the NDB stays the single source of truth and nothing has to be migrated.
$v274Bad = @()
$stDoc274 = Doc (Join-Path $dir "WoD20.10.lfm")
$stBox274 = $stDoc274.SelectSingleNode("//layout[label/@text='STORYTELLER SETTINGS']")
if ($null -eq $stBox274) { $v274Bad += "the STORYTELLER SETTINGS box is gone from WoD20.10 - this check reads nothing (SPEC V209)" }
else {
    # (a) the two flags exist, and NEITHER declares a default: nil is already false, and a
    # declared default would be a second answer to the same question (SPEC V80, V89, V175).
    foreach ($chk274 in @(@('chkManualAffiliation', 'stManualAffiliation'), @('chkManualClanFamily', 'stManualClanFamily'))) {
        $node274 = $stBox274.SelectSingleNode("checkBox[@name='$($chk274[0])']")
        if ($null -eq $node274) { $v274Bad += "$($chk274[0]) is not in the STORYTELLER SETTINGS box - the flag the storyteller flips is gone (SPEC V274a)" }
        elseif ($node274.GetAttribute("field") -ne $chk274[1]) { $v274Bad += "$($chk274[0]) binds '$($node274.GetAttribute('field'))', not $($chk274[1]) (SPEC V274a, I3)" }
        if ($stDoc274.SelectSingleNode("//dataLink[@field='$($chk274[1])'][@defaultValue]")) { $v274Bad += "$($chk274[1]) declares a defaultValue - the flag must be fail-closed on nil, and a default is a second place for that answer to live (SPEC V274a, V80, V89)" }
    }

    # (e) the box grew 60 and stayed symmetric: 10 above the title, 10 under the last row, and
    # Save is still the last input in it (SPEC V240, V238b).
    $h274 = [int]$stBox274.GetAttribute("height")
    if ($h274 -ne 399) { $v274Bad += "the box is $h274 tall, expected 399 - two flags of 25 at a pitch of 30 moved everything under them by 60 (SPEC V274e, I71)" }
    $kids274 = @($stBox274.ChildNodes | Where-Object { $_.NodeType -eq "Element" -and $_.LocalName -ne "rectangle" -and $_.HasAttribute("top") })
    if ($kids274.Count -eq 0) { $v274Bad += "the box holds no placed control - the two gaps below would be measured against nothing (SPEC V209)" }
    else {
        $minTop274 = ($kids274 | ForEach-Object { [int]$_.GetAttribute("top") } | Measure-Object -Minimum).Minimum
        $maxBot274 = ($kids274 | ForEach-Object { [int]$_.GetAttribute("top") + [int]$_.GetAttribute("height") } | Measure-Object -Maximum).Maximum
        if ($minTop274 -ne 10) { $v274Bad += "the box breathes $minTop274 above its title, expected 10 (SPEC V240, V274e)" }
        if (($h274 - $maxBot274) -ne 10) { $v274Bad += "the box breathes $($h274 - $maxBot274) under its last row, expected 10 (SPEC V240, V274e)" }
        $lowest274 = @($kids274 | Where-Object { $_.GetAttribute("name") } | Sort-Object { [int]$_.GetAttribute("top") })[-1]
        if ($lowest274.GetAttribute("name") -ne 'btnSaveBaseline') { $v274Bad += "the last named control in the box is '$($lowest274.GetAttribute('name'))' - Save Initial Character is the one irreversible action here and comes after everything (SPEC V238b, V274e)" }
    }
}

# (b) the two pairs are DECLARED mirrors, so V36 knows them and V1 does not call them duplicates.
foreach ($fld274 in @('hedgeAffiliation', 'clanFamily')) {
    if (-not $mirrors.Contains($fld274)) { $v274Bad += "'$fld274' carries two widgets and is not in the mirror declaration - V1 would be reading an accident where SPEC I3 wrote a decision (SPEC V274b, V36)" }
}

# (c) the AUTHORED state is the flag OFF: the picker visible by default, the typed twin hidden
# AND disabled. A sheet that never opened the storyteller's tab paints right with no Lua.
foreach ($pair274 in @(@('WoD20.7.lfm', 'cboHedgeAffiliation', 'edtHedgeAffiliation'), @('WoD20.11.lfm', 'cboClanFamily', 'edtClanFamily'))) {
    $doc274 = Doc (Join-Path $dir $pair274[0])
    $cbo274 = $doc274.SelectSingleNode("//comboBox[@name='$($pair274[1])']")
    $edt274 = $doc274.SelectSingleNode("//edit[@name='$($pair274[2])']")
    if ($null -eq $cbo274) { $v274Bad += "$($pair274[1]) is gone from $($pair274[0]) - half the mirror is missing (SPEC V274c)"; continue }
    if ($null -eq $edt274) { $v274Bad += "$($pair274[2]) is not in $($pair274[0]) - the flag would have nothing to swap the picker for (SPEC V274c)"; continue }
    if ($cbo274.GetAttribute("visible") -ne '') { $v274Bad += "$($pair274[1]) authors visible='$($cbo274.GetAttribute('visible'))' - the picker is the DEFAULT side and default is not written down (SPEC V274c, V56)" }
    if ($edt274.GetAttribute("visible") -ne 'false' -or $edt274.GetAttribute("enabled") -ne 'false') { $v274Bad += "$($pair274[2]) is not authored visible='false' enabled='false' - hidden and still enabled takes Tab focus, which shows up in no screenshot (SPEC V274c, V274d)" }
    foreach ($att274 in @('left', 'top', 'width', 'height')) {
        if ($cbo274.GetAttribute($att274) -ne $edt274.GetAttribute($att274)) { $v274Bad += "$($pair274[2]) sits at $att274=$($edt274.GetAttribute($att274)) and $($pair274[1]) at $($cbo274.GetAttribute($att274)) - one field, one rectangle, or the swap moves the row (SPEC V274c, I71)" }
    }
}

# (d) BOTH properties for ALL FOUR controls, and the four are named in one place.
$manFn274 = LuaFn $hh6 'renderManualEntry'
if (-not $manFn274) { $v274Bad += "renderManualEntry is not declared in WoD20.6 - the two dataLinks call a global that finds nil, and rdk exits 0 on that (SPEC V274d, V223, B51)" }
else {
    $mb274 = NoComments $manFn274
    foreach ($nm274 in @('cboHedgeAffiliation', 'edtHedgeAffiliation', 'cboClanFamily', 'edtClanFamily')) {
        if ($mb274 -notmatch $nm274) { $v274Bad += "renderManualEntry never names $nm274 - a control the renderer does not reach keeps whatever state the last event left it in (SPEC V274d)" }
    }
    if ($mb274 -notmatch 'c\.visible = ' -or $mb274 -notmatch 'c\.enabled = ') { $v274Bad += "renderManualEntry does not write BOTH visible and enabled - writing only visible leaves an invisible control taking Tab focus (SPEC V274d)" }
    if ($mb274 -notmatch 'stManualAffiliation' -or $mb274 -notmatch 'stManualClanFamily') { $v274Bad += "renderManualEntry does not read both flags - either entry point has to leave all four controls agreeing with them (SPEC V274d)" }
    if ($mb274 -notmatch 'rootOf\(from\)') { $v274Bad += "renderManualEntry does not walk from the ROOT - the two pairs live two tabs apart and a tab-scoped find reaches only one of them (SPEC V143, V274d)" }
}
# the flags are watched, or the swap only happens when something else repaints (SPEC V123).
foreach ($trig274 in @(@('WoD20.7.lfm', 'stManualAffiliation'), @('WoD20.11.lfm', 'stManualClanFamily'))) {
    $t274 = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir $trig274[0])))
    $lnk274 = [regex]::Match($t274, "<dataLink[^>]*field=`"$($trig274[1])`"[^>]*>")
    if (-not $lnk274.Success) { $v274Bad += "nothing in $($trig274[0]) watches $($trig274[1]) - flipping the flag would change nothing until the tab was reopened (SPEC V274d, V123)" }
    elseif ($lnk274.Value -notmatch 'renderManualEntry\(') { $v274Bad += "the $($trig274[1]) dataLink does not call renderManualEntry (SPEC V274d)" }
    if ($t274 -notmatch 'renderManualEntry\(self\);\s*\n') { $v274Bad += "$($trig274[0]) never calls renderManualEntry from its own event - the storyteller may have flipped the flag with the tab closed (SPEC V274d)" }
}

if ($v274Bad) { foreach ($b in $v274Bad) { Fail "V274 $b" } }
else { Pass "V274 both manual-entry flags are fail-closed and declared mirrors, the typed twins are authored hidden on the picker's own rectangle, and one renderer writes visible and enabled for all four" }

# ---- V275: the picker memo is keyed by what CHANGES the list, not by the field root -------
# SPEC V275, the backprop of B58. pickerItems memoises the list it just built. Key that memo by
# fieldRoot and every row of one root shares one entry - so when ONE row of a root is filtered
# and its siblings are not (cbonumina_1 is the Affinity Path and answers to the affiliation,
# cbonumina_2..17 answer to nothing - SPEC I67), whichever row paints FIRST decides the list for
# all of them: row 1 first and the other sixteen inherit its pruned list; rows 2..17 first and
# row 1 is served the whole one with its filter silently doing nothing. Neither order errors,
# both come out of rdk -l at exit 0, and nothing on screen says which one happened.
#
# V272(b) measures the STAMP - what INVALIDATES the memo. This measures the KEY - what SEPARATES
# it. Two halves of one memo, failing for different reasons, and they only work as a pair, the
# same way V198 and V206 do.
#
# Anchored on the CONSTRUCTION and never on the identifier (SPEC V222): the key is whatever
# INDEXES memo.lists, found by reading that index and then the local it is assigned from. So
# renaming the local is invisible here - that is the neighbour probe - while keying on the root
# alone goes red. Comments come off first: this file explains the OLD shape in prose two lines
# above the fix, and a check that reddens on prose is the false positive V222 exists for.
$v275Bad = @()
$code275 = CodeOf (Join-Path $dir 'WoD20.6.lfm')
$fn275 = LuaFn $code275 'pickerItems'
if (-not $fn275) { $v275Bad += "pickerItems is gone from WoD20.6 - the memo this reads has no builder left (SPEC V209)" }
else {
    # The names that filter ONE row out of a root, read from the table and never listed here: a
    # name added to FILTER_NAME has to reach the key on the same round, and a check carrying its
    # own copy of the roster would not notice (SPEC V20).
    $tbl275 = [regex]::Match($code275, '(?s)local FILTER_NAME = \{(.*?)\};')
    $names275 = @()
    if ($tbl275.Success) { $names275 = @([regex]::Matches($tbl275.Groups[1].Value, '(\w+)\s*=\s*true') | ForEach-Object { $_.Groups[1].Value }) }
    if ($names275.Count -eq 0) { $v275Bad += "FILTER_NAME declares no name - every leg below is true by default, and a filtered row keying by root would pass unseen (SPEC V209, B58)" }

    # Whatever indexes memo.lists IS the key, under any name.
    $idx275 = [regex]::Match($fn275, 'memo\.lists\[\s*(\w+)\s*\]')
    if (-not $idx275.Success) { $v275Bad += "nothing indexes memo.lists inside pickerItems - this check found no key to measure (SPEC V209)" }
    else {
        $kn275 = $idx275.Groups[1].Value
        $asg275 = [regex]::Match($fn275, "(?m)^\s*local\s+$kn275\s*=\s*(.+?);\s*$")
        if (-not $asg275.Success) { $v275Bad += "memo.lists is indexed by '$kn275' and nothing local assigns it - the key is built somewhere this cannot read (SPEC V209)" }
        else {
            $rhs275 = $asg275.Groups[1].Value.Trim()
            if ($rhs275 -notmatch 'FILTER_NAME\[') {
                $v275Bad += "the memo key is built as '$rhs275' and never asks FILTER_NAME - the filtered row and its unfiltered siblings share one entry, and whichever paints first decides the list for the rest (SPEC V275, B58)"
            }
            elseif ($rhs275 -notmatch 'FILTER_NAME\[\s*nm\s*\]\s*==\s*true\s+and\s+nm\b') {
                $v275Bad += "the memo key asks FILTER_NAME and does not answer with the NAME - '$rhs275'. Asking is not enough: the filtered row has to key by nm, or it lands back on the root it shares with its siblings (SPEC V275)"
            }
        }
    }
}
if ($v275Bad) { foreach ($b275 in $v275Bad) { Fail "V275 $b275" } }
else { Pass "V275 the picker memo keys its $($names275.Count) filtered name(s) by name and everything else by root - the filtered row cannot inherit a sibling's list" }

if ($Build) {
    $rdk = "$env:LOCALAPPDATA\FirecastSDK3\rdk.exe"
    if (-not (Test-Path $rdk)) { Fail "V6 rdk.exe not found at $rdk" }
    else {
        $b = Get-Item $rpk
        $beforeStamp, $beforeSize = $b.LastWriteTime, $b.Length
        Push-Location $plugin
        & $rdk -l | Out-Host
        $code = $LASTEXITCODE
        Pop-Location
        if ($code -eq 0) { Pass "V6 rdk -l exit 0" } else { Fail "V6 rdk -l exit $code" }
        $a = Get-Item $rpk
        if ($a.LastWriteTime -ne $beforeStamp -or $a.Length -ne $beforeSize) {
            Pass "V7 .rpk changed ($beforeSize -> $($a.Length) bytes)"
        } else { Fail "V7 .rpk unchanged after build - exit 0 was not proof (see SPEC B.1)" }
    }
}

Write-Host ""
if ($fail -eq 0) { Write-Host "ALL CHECKS PASSED"; exit 0 } else { Write-Host "$fail CHECK(S) FAILED"; exit 1 }
