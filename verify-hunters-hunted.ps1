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
foreach ($m in @('healthLevels')) { [void]$mirrors.Add($m) }
1..10 | ForEach-Object { [void]$mirrors.Add("health_$_") }
1..10 | ForEach-Object { [void]$mirrors.Add("willpower_c$_") }
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
$luaOwned = @('baseline', 'xpTotal', 'xpFree')
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
# Powers tab: 10 hedge rows + 10 psychic rows, 5 dots each (SPEC V5 after T56/T57)
1..10 | ForEach-Object { $expect["numina_$_"] = 5; $expect["psychic_$_"] = 5 }
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
foreach ($grp in @(@('numina',10), @('psychic',10), @('background',$bgRows), @('health',10), @('speciality',$spRows))) {
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
foreach ($orphan in @('stShowMagika','transportation','other','bruised','hurt','injured','wounded','mauled','crippled','incapacitated','personalidade','natureza','experience','spentXP','stFreeDots','freeDots')) {
    if ($allFields.ContainsKey($orphan)) {
        Fail "I3 '$orphan' is a declared orphan but $($allFields[$orphan] -join ', ') owns it - choose a different field name"
    } else { Pass "I3 declared orphan '$orphan' owns no widget" }
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
foreach ($must in @('WoD20.6.lfm/cboGame','WoD20.7.lfm/cboFaith','WoD20.6.lfm/cboSheetTheme')) {
    if ($listReport | Where-Object { $_.Name -eq $must }) { Pass "V14/V15/V17 $must reaches the list checks" }
    else { Fail "V14/V15/V17 $must was never collected - its list is unchecked" }
}

# cboGame is a closed roster, not an open vocabulary: assert the names themselves, so a
# dropped, renamed or added entry fails instead of passing as "no duplicates" (SPEC V109).
# Three since the 32nd round, and no leading empty one to discount.
$gameList = @($listReport | Where-Object { $_.Name -eq 'WoD20.6.lfm/cboGame' })
if ($gameList.Count -eq 1) {
    $wantGames = @('Vampire', 'Hunters Hunted', 'Mage')
    $gotGames = @($gameList[0].Items)
    if (($gotGames -join '|') -eq ($wantGames -join '|')) { Pass "V109 cboGame offers exactly $($wantGames -join ', ')" }
    else { Fail "V109 cboGame offers '$($gotGames -join ', ')', expected '$($wantGames -join ', ')'" }
}

# ---- V9: source language is English - no non-ASCII in authored strings -------
# Deliberately a codepoint range, not a list of accented letters: this file is read
# as ANSI by PowerShell 5.1 when it has no BOM, so non-ASCII literals here would rot.
#
# ONE codepoint is excused, U+2019, and it is written as an escape for the same reason
# (SPEC V195, B42): the core prints forty-two path and ritual names with a typographic
# apostrophe - Devil's Touch, Grave's Decay, Boukephos' Gateway - so this check was
# calling correct English "not English". Spelling is not language. Every other non-ASCII
# codepoint still fails, so an authored Portuguese string is caught exactly as before.
$ptChars = $visible | Where-Object { $_ -match '[^\x00-\x7F\u2019]' }
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
foreach ($f in $files) {
    $xml = Doc $f.FullName
    foreach ($sb in $xml.SelectNodes("//scrollBox")) {
        $boxes = @()
        foreach ($bx in $sb.SelectNodes("layout")) {
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
$corners = @{}
foreach ($f in $files) {
    foreach ($r in (Doc $f.FullName).SelectNodes("//rectangle[@color='black']")) {
        $key = "{0}|{1}|{2}" -f $r.GetAttribute("cornerType"), $r.GetAttribute("xradius"), $r.GetAttribute("yradius")
        if (-not $corners.ContainsKey($key)) { $corners[$key] = New-Object System.Collections.Generic.HashSet[string] }
        [void]$corners[$key].Add($f.Name)
    }
}
if ($corners.Count -eq 0) { Fail "V68 no black section box found - the check has nothing to measure" }
elseif ($corners.Count -gt 1) {
    foreach ($k in $corners.Keys) {
        $p = $k -split '\|'
        Fail "V68 section boxes with cornerType='$($p[0])' radius $($p[1])/$($p[2]) in $(($corners[$k] | Sort-Object) -join ', ') - the corner must match across every box"
    }
} else {
    $p = ($corners.Keys | Select-Object -First 1) -split '\|'
    Pass "V68 every section box shares cornerType='$($p[0])' radius $($p[1])/$($p[2])"
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
$HEALTH_TEN_ROW_OVERHANG = 6
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
elseif ($hh6 -notmatch 'dataLink field="game" defaultValue="Hunters Hunted"') { Fail "V109 cboGame has no default - a new sheet would show an empty locked box" }
elseif ($root -notmatch 'setField\("game", "Hunters Hunted"\)') { Fail "V110 nothing normalises a game outside the roster - the locked box would hold a value nobody can clear" }
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
# Same one-codepoint excuse V9 carries, and for the same names (SPEC V195, B42): a
# canonical value out of the core keeps the book's typographic apostrophe.
$notEn = @()
$v24Seen = 0
foreach ($f in $files) {
    $xml = Doc $f.FullName
    foreach ($cb in $xml.SelectNodes("//comboBox[@name]")) {
        if ($cb.GetAttribute("name") -notlike 'cbo*') { continue }
        foreach ($v in (ListOf $cb (TplOf $cb))) {
            $v24Seen++
            if ($v -ne '' -and $v -match '[^\x00-\x7F\u2019]') { $notEn += "$($f.Name): stored value '$v' is not English" }
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
# Two axes, because `items` has two (SPEC V24): the language, which NeededPx already folds
# in, and the ERA. A value can DISPLAY as something much longer than itself: WoD20.13's widest
# entry is "Potestas Tempestatum (Poder sobre as Tempestades)", the Dark Ages name for
# "Weather Control" - fifteen characters that render as forty-nine. Sizing off items= alone
# would have passed a picker that clips in two of the four eras.
#
# Same ruler as V16 - one $PX_PER_CHAR for labels and pickers alike - plus room for the
# dropdown arrow, measured off cboNature: 25 characters living comfortably in 215px.
$ARROW = 24
$comboNarrow = @()
$comboSeen = 0
foreach ($f in $files) {
    foreach ($cb in (Doc $f.FullName).SelectNodes("//comboBox[@items][@width]")) {
        $w = 0; if (-not [int]::TryParse($cb.GetAttribute("width"), [ref]$w)) { continue }
        $shown = @([regex]::Matches($cb.GetAttribute("items"), "'([^']*)'") |
                   ForEach-Object { $_.Groups[1].Value } | Where-Object { $_ -ne '' })
        # The era axis is scoped by SENSE, not by the cbo* prefix (SPEC V197, B44): only the
        # Vampire rows are renamed, so only they may be sized for a Dark Ages name. Measuring
        # WoD20.7 against "Potestas Tempestatum" would demand width for a string it never shows.
        $fieldTpl = $cb.GetAttribute("field")
        $isVampRow = $fieldTpl -match '^\$\((field)\)$' -and $f.Name -in @('WoD20.12.lfm', 'WoD20.13.lfm', 'WoD20.14.lfm')
        if ($isVampRow) {
            foreach ($m in [regex]::Matches($cb.GetAttribute("values"), "'([^']*)'")) {
                $v = $m.Groups[1].Value
                if ($v -ne '' -and $eraMap.ContainsKey($v)) { $shown += $eraMap[$v] }
            }
        }
        if ($shown.Count -eq 0) { continue }
        $comboSeen++
        $worst = ''; $need = 0
        foreach ($it in $shown) { $n = NeededPx $it; if ($n -gt $need) { $need = $n; $worst = $it } }
        $need += $ARROW
        $id = $cb.GetAttribute("name"); if (-not $id) { $id = $cb.GetAttribute("field") }; if (-not $id) { $id = 'comboBox' }
        if ($need -gt $w) { $comboNarrow += "$($f.Name): picker $id is ${w}px but '$worst' (pt '$($ptVal[$worst])') needs ~${need}px - a comboBox clips, it does not wrap" }
    }
}
if ($comboNarrow) { foreach ($c in $comboNarrow) { Fail "V196 $c" } }
elseif ($comboSeen -eq 0) { Fail "V196 no picker was measured - the check verifies nothing (SPEC V20, B7)" }
else { Pass "V196 all $comboSeen pickers fit their longest item, in both languages and every era" }

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

    # V30: one group, one field, distinct fieldValues, each pointing at a real row
    $numinaRadios = @($radios | Where-Object { $_.File -eq 'WoD20.7.lfm' })
    if ($numinaRadios.Count -eq 0) { Fail "V30 no radios on the Powers tab - nothing selects a numina" }
    else {
        $rf = @($numinaRadios | ForEach-Object { $_.Field } | Sort-Object -Unique)
        $rg = @($numinaRadios | ForEach-Object { $_.Group } | Sort-Object -Unique)
        if ($rf.Count -eq 1) { Pass "V30 all $($numinaRadios.Count) radios share field '$($rf[0])'" }
        else { Fail "V30 numina radios split across fields {$($rf -join ', ')} - selection would not be exclusive" }
        if ($rg.Count -eq 1 -and $rg[0]) { Pass "V30 one groupName ('$($rg[0])')" }
        else { Fail "V30 groupName is {$($rg -join ', ')}, expected exactly one" }

        $dupVals = @($numinaRadios | Group-Object Value | Where-Object Count -gt 1)
        if ($dupVals) { foreach ($d in $dupVals) { Fail "V30 fieldValue '$($d.Name)' used by $($d.Count) radios - two rows would answer as one" } }
        else { Pass "V30 all $($numinaRadios.Count) fieldValues distinct" }

        foreach ($r in $numinaRadios) {
            if (-not $allFields.ContainsKey($r.Value)) { Fail "V30 radio points at '$($r.Value)' but no row owns that field" }
        }
        $rowFields = @($allFields.Keys | Where-Object { $_ -match '^(numina|psychic)_\d+$' })
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
    # T478 moved the table out of the .lfm and into descNumina.lua (SPEC I24 / V189). The
    # markers migrated verbatim, so the region has the same shape and this parser is unchanged
    # - only the file it is read from moved.
    $numinaModule = Join-Path $plugin "descNumina.lua"
    if (-not (Test-Path $numinaModule)) { Fail "V32/V189 descNumina.lua missing from the plugin root - the Powers tab has no text to render (SPEC I24)"; $descNumina = "" }
    else { $descNumina = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($numinaModule)) -replace "`r`n", "`n" }
    # V189: one DESC per area, in a module - the .lfm keeps the renderer only. A table left
    # behind in the .lfm would be a second copy of the same text, free to drift (SPEC I24).
    # Measured across ALL the .lfm files, not just WoD20.7, so T479-T481 are covered too.
    $dupTables = @($files | Where-Object {
        ([System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($_.FullName))) -match '(?m)^\s*local\s+DESC\s*=\s*\{'
    })
    if ($dupTables) { foreach ($d in $dupTables) { Fail "V189 $($d.Name) still declares its own DESC table - the text would live in two files at once (SPEC I24)" } }
    else { Pass "V189 all $($files.Count) .lfm files carry the renderer only; the book text lives in the desc*.lua modules" }
    $descBlock = [regex]::Match($descNumina, '-- >>> DESC_BEGIN[^\n]*\n(.*?)-- <<< DESC_END', 'Singleline')
    if (-not $descBlock.Success) { Fail "V32 DESC markers not found in descNumina.lua" }
    else {
        $descKeys = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
        $thin = @()
        # Anchored on the real shape: key, en long string, pt long string, in that order.
        $entryRx = [regex]'(?ms)^\s*\["([^"]+)"\]\s*=\s*\{\s*en\s*=\s*\[==\[(.*?)\]==\]\s*,\s*pt\s*=\s*\[==\[(.*?)\]==\]\s*,?\s*\},'
        foreach ($m in $entryRx.Matches($descBlock.Groups[1].Value)) {
            $k = $m.Groups[1].Value
            [void]$descKeys.Add($k)
            if ($m.Groups[2].Value.Trim().Length -lt 200) { $thin += "'$k' has no usable en text" }
            if ($m.Groups[3].Value.Trim().Length -lt 200) { $thin += "'$k' has no usable pt text" }
        }
        if ($descKeys.Count -eq 0) { Fail "V32 DESC region parsed to zero entries - the parser or the generated shape drifted" }
        foreach ($t in $thin) { Fail "V32 $t" }

        $numinaItems = @()
        foreach ($cb in $hh7x.SelectNodes("//comboBox[@name]")) {
            if ($cb.GetAttribute("name") -notlike 'cbo*') { continue }
            # The TRUE FAITH row picks a religion and always shows the True Faith text, so its
            # items are deliberately outside this check (SPEC V50, checked on its own below).
            if ($cb.GetAttribute("name") -eq 'cboFaith') { continue }
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
        if ($hh7 -notmatch 'selected\s*==\s*"faith"') { Fail "V50 WoD20.7 does not special-case the faith row - a religion would open the NO_ENTRY message" }
        elseif ($hh7 -notmatch 'value\s*=\s*"True Faith"') { Fail "V50 the faith row does not resolve to the True Faith entry" }
        elseif (-not $descKeys.Contains('True Faith')) { Fail "V50 DESC has no 'True Faith' entry - the row would open empty" }
        else { Pass "V50 every religion on the faith row opens the True Faith description" }

        $faithCb = $hh7x.SelectSingleNode("//comboBox[@name='cboFaith']")
        if ($null -eq $faithCb) { Fail "V50 cboFaith not found" }
        else {
            $faithItems = @((ListOf $faithCb (TplOf $faithCb)) | Where-Object { $_ -ne '' })
            if ($faithItems.Count -eq 0) { Fail "V50 cboFaith offers nothing" }
            else { Pass "V50 cboFaith offers $($faithItems.Count) religions, none needing a DESC entry" }
        }
    }

    # ---- V78: one list per box, split by book chapter (SPEC T236) -----------------
    # Both pickers declare their combo as name="cbo$(field)", so a collector keyed on the
    # combo NAME cannot tell the two boxes apart and every list check on them would read the
    # same bucket (SPEC V20). Read each template BY NAME instead.
    $hedgeCanon = @('Alchemy','Conjuration','Conveyance','Divination','Ephemera','Enchantment','Fascination','Fortune','Healing','Hellfire','Illusion','Maelstroms','Necromancy','Necronics','Oneiromancy','Quintessence Manipulation','Shadows','Shapeshifting','Starlight','Summoning, Binding, and Warding','Weather Control')
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
        if ($total -eq 43) { Pass "V78 the two boxes still cover all 43 numina" }
        else { Fail "V78 the two boxes cover $total numina, expected 43 - a name was dropped in the split (SPEC V32)" }
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
$vampCtl = @($vampX.SelectNodes("//tabControl"))
$wantVamp = [ordered]@{
    'tabDisc'    = @('Disciplines',            'WoD20.12.lfm')
    'tabPaths'   = @('Blood Sorcery: Paths',   'WoD20.13.lfm')
    'tabRituals' = @('Blood Sorcery: Rituals', 'WoD20.14.lfm')
}
if ($vampCtl.Count -ne 1) { Fail "V188 WoD20.11 declares $($vampCtl.Count) tabControls - the Vampire tab is ONE control with three sibling tabs (SPEC R49)" }
elseif ($vampCtl[0].GetAttribute("name") -ne 'tabsVamp') { Fail "V188 the Vampire tabControl is named '$($vampCtl[0].GetAttribute('name'))', not tabsVamp" }
else {
    $vampTabs = @($vampCtl[0].ChildNodes | Where-Object { $_.NodeType -eq 'Element' -and $_.LocalName -eq 'tab' })
    $vampBad = @()
    if ($vampTabs.Count -ne $wantVamp.Count) { $vampBad += "tabsVamp holds $($vampTabs.Count) tabs, not $($wantVamp.Count)" }
    else {
        $i = 0
        foreach ($nm in $wantVamp.Keys) {
            $t   = $vampTabs[$i]
            $imp = @($t.SelectNodes("import") | ForEach-Object { $_.GetAttribute("file") })
            if ($t.GetAttribute("name") -ne $nm) { $vampBad += "tab $($i + 1) is '$($t.GetAttribute('name'))', expected $nm - the first tab is the one that opens" }
            elseif ($t.GetAttribute("title") -ne $wantVamp[$nm][0]) { $vampBad += "$nm reads '$($t.GetAttribute('title'))', expected '$($wantVamp[$nm][0])' - the title is what groups the blood sorcery pair" }
            elseif ($imp.Count -ne 1 -or $imp[0] -ne $wantVamp[$nm][1]) { $vampBad += "$nm imports '$($imp -join ', ')', expected $($wantVamp[$nm][1])" }
            $i++
        }
    }
    if ($vampBad) { foreach ($v in $vampBad) { Fail "V188 $v" } }
    else { Pass "V188 the Vampire tab is one tabControl over three sibling tabs, opening on Disciplines" }
}

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
if ($nestedCtl) { foreach ($n in $nestedCtl) { Fail "V188 $n - R49 says the inner one loses its tab labels" } }
elseif ($allCtl.Count -ne 2) { Fail "V188 the sheet carries $($allCtl.Count) tabControls ($($allCtl -join ', ')) - it has room for two, the root's and the Vampire tab's" }
else { Pass "V188 two tabControls in the sheet ($($allCtl -join ', ')), neither inside the other" }

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
$reqRx = [regex]'require\s*\(\s*["''](desc[A-Za-z0-9_]*\.lua)["'']\s*\)'
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
$descRx = [regex]'(?ms)^\s*\["([^"]+)"\]\s*=\s*\{\s*en\s*=\s*\[==\[(.*?)\]==\]\s*,\s*pt\s*=\s*\[==\[(.*?)\]==\]\s*,?\s*(.*?)\},'
$srcRx  = [regex]'^.+,\s+(p\.|p(\xE1|a)g\.)\s*\d+$'
# T470: an entry may carry a SECOND body under daEn/daPt, written from the Dark Ages book.
# It is optional, but when it is there it is the SAME three blocks (SPEC I21) - a medieval
# body with no source line would open a description the reader cannot trace back to a page.
$eraRx  = [regex]'(?ms)\b(daEn|daPt)\s*=\s*\[==\[(.*?)\]==\]'
# T479-T481 moved the three tables out of the .lfm files and into one module per area
# (SPEC I24 / V189). The markers migrated verbatim, so the region and this parser are both
# unchanged - only the file each region is read from moved.
foreach ($area in @(
    @('descDisc.lua', 'DISC_DESC'),
    @('descPath.lua', 'PATH_DESC'),
    @('descRitual.lua', 'RITUAL_DESC'))) {
    $areaPath = Join-Path $plugin $area[0]
    if (-not (Test-Path $areaPath)) { $descForm += "$($area[0]) missing from the plugin root - the area has no text to render (SPEC I24)"; continue }
    $txt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($areaPath)) -replace "`r`n", "`n"
    $region = [regex]::Match($txt, "-- >>> $($area[1])_BEGIN[^\n]*\n(.*?)-- <<< $($area[1])_END", 'Singleline')
    if (-not $region.Success) { $descForm += "$($area[0]) has no $($area[1]) markers - the region the entries land in is gone"; continue }
    foreach ($m in $descRx.Matches($region.Groups[1].Value)) {
        $key = $m.Groups[1].Value
        foreach ($lang in @('en', 'pt')) {
            $descSeen++
            $blocks = @(($m.Groups[$(if ($lang -eq 'en') { 2 } else { 3 })].Value.Trim()) -split "`n`n`n")
            if ($blocks.Count -ne 3) { $descForm += "$($area[0]) '$key' [$lang] is $($blocks.Count) block(s), not source + name + text two blank lines apart"; continue }
            if (-not $srcRx.IsMatch($blocks[0].Trim())) { $descForm += "$($area[0]) '$key' [$lang] opens with '$($blocks[0].Trim())' - block one is '<book>, p. <page>'" }
            if ($blocks[1].Trim() -ne $key) { $descForm += "$($area[0]) '$key' [$lang] names itself '$($blocks[1].Trim())' - block two is the picker value the entry is keyed by" }
            if ($blocks[2].Trim().Length -lt 1) { $descForm += "$($area[0]) '$key' [$lang] has a header and no description under it" }
        }
        # The optional medieval body, same shape, checked only when the entry carries one.
        foreach ($e in $eraRx.Matches($m.Groups[4].Value)) {
            $tag = $e.Groups[1].Value
            $descSeen++
            $eb = @(($e.Groups[2].Value.Trim()) -split "`n`n`n")
            if ($eb.Count -ne 3) { $descForm += "$($area[0]) '$key' [$tag] is $($eb.Count) block(s), not source + name + text two blank lines apart"; continue }
            if (-not $srcRx.IsMatch($eb[0].Trim())) { $descForm += "$($area[0]) '$key' [$tag] opens with '$($eb[0].Trim())' - block one is '<book>, p. <page>'" }
            if ($eb[1].Trim() -ne $key) { $descForm += "$($area[0]) '$key' [$tag] names itself '$($eb[1].Trim())' - block two is the picker value the entry is keyed by" }
            if ($eb[2].Trim().Length -lt 1) { $descForm += "$($area[0]) '$key' [$tag] has a header and no description under it" }
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
elseif ($lockFn -notmatch '(?s)c\.enabled = open;\s*\r?\n\s*c\.opacity = open and 1 or 0\.55;') { Fail "V175 enabled and opacity are not written in the same breath - a combo could look open while it is locked (SPEC V162)" }
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
    $bright = @($roDots | Where-Object { $_.GetAttribute("opacity") -ne '0.55' })
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
elseif ($visFn -notmatch 'local kids = tab:getChildren\(\)') { Fail "V92 applyTabVisibility never reaches the tab's contents - a host that keeps the tab button would still show them (SPEC R31)" }
elseif ($visFn -notmatch 'kids\[j\]\.visible = want') { Fail "V92 the tab's contents do not follow the tab's own visibility" }
else { Pass "V92 hiding a tab hides what is inside it" }

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
$tabNodes = (Doc $rootPath).SelectNodes("//tab")
$tabNames = @($tabNodes | ForEach-Object { $_.GetAttribute("name") })
$unnamed = @($tabNames | Where-Object { -not $_ })
$wantTabs = @('tabNumina', 'tabDisciplines', 'tabStoryteller')
$missingTabs = @($wantTabs | Where-Object { $tabNames -notcontains $_ })
if ($tabNodes.Count -ne 11) { Fail "V89 expected 11 tabs (SPEC I1b/I1c), found $($tabNodes.Count)" }
elseif ($unnamed.Count) { Fail "V89 $($unnamed.Count) tab(s) carry no name - the renderer addresses them by name" }
elseif ($missingTabs) { foreach ($t in $missingTabs) { Fail "V89 no tab named $t - its flag would switch nothing" } }
else { Pass "V89 all 11 tabs named, including the three the renderer switches" }

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
    elseif ($stateFn -notmatch 'dynBaselineState') { Fail "V82 nothing on the tab says whether the character was saved (SPEC V33)" }
    else { Pass "V82 Save goes dead once the baseline exists, and the tab says so" }

    # No field of the ledger's own may be edited from here, and the flags must be real fields.
    $stFields = @((Doc $stDoc).SelectNodes("//*[@field]") | ForEach-Object { $_.GetAttribute("field") })
    $wantFlags = @('stBackgroundsXP', 'stShowNumina', 'stShowDisciplines', 'stFreeBuy', 'stSpec3XP', 'stSpec4XP')
    $missFlags = @($wantFlags | Where-Object { $stFields -notcontains $_ })
    if ($missFlags) { foreach ($f in $missFlags) { Fail "V89 WoD20.10 has no widget for $f" } }
    else { Pass "V89 all $($wantFlags.Count) storyteller flags are owned by WoD20.10" }
}

# ---- V94: a switched tab is AUTHORED in the state its flag defaults to ------------
# The 27th round authored all of them visible and left the hiding to the renderer, so a fresh
# sheet with every checkbox unticked opened with three tabs the player was never meant to see
# (SPEC B26). The static state fails closed too now.
$hiddenByDefault = @('tabDisciplines', 'tabStoryteller')
$authoredOpen = @($tabNodes | Where-Object { $hiddenByDefault -contains $_.GetAttribute("name") -and $_.GetAttribute("visible") -ne 'false' })
$numinaTab = @($tabNodes | Where-Object { $_.GetAttribute("name") -eq 'tabNumina' })
if ($authoredOpen) { foreach ($t in $authoredOpen) { Fail "V94 tab $($t.GetAttribute('name')) is authored visible - a sheet whose Lua never ran would show it (SPEC B26)" } }
elseif ($numinaTab.Count -ne 1) { Fail "V94 expected exactly one tabNumina, found $($numinaTab.Count)" }
elseif ($numinaTab[0].GetAttribute("visible") -eq 'false') { Fail "V94 tabNumina is authored hidden - its flag defaults ON (SPEC V89)" }
else { Pass "V94 two tabs authored hidden, Numina authored visible" }

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
elseif ($ledFn -notmatch '#rows == 0[^\r\n]*translateSheetText') { Fail "V98 the empty-log text is not translated (SPEC V70)" }
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
$dots = @()
$dotsUnguarded = @()
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//imageCheckBox")) {
        if (-not $n.GetAttribute("field")) { continue }   # display-only mirror (V51): owns nothing, buys nothing
        if ($n.GetAttribute("field") -match '^bloodPool_\d+$') { continue }   # free resource, not a rating (V219)
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
        'Background' = 'return from \* 3'
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
    if ($costFn -notmatch 'if not ctx\.backgroundsXP then return 0; end;') { $costBad += "backgrounds are priced even with the storyteller's box unticked" }
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
elseif ($numTxt -notmatch 'text="\* The first path is the Affinity Path"') { Fail "V88 the note explaining the affinity path is missing (SPEC C, after True Faith)" }
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
# field wearing 0.55 lies in the other direction and would teach the player to ignore it.
# The theme never writes opacity (V57/V66 family), so what the XML says is what renders in
# all four eras.
$DIM     = '0.55'
$dimSeen = 0
$dimBefore = $fail
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//edit | //textEditor | //comboBox | //checkBox | //imageCheckBox")) {
        $ro = ($n.GetAttribute("readOnly") -eq 'true') -or
              ($n.GetAttribute("enabled")  -eq 'false') -or
              ($n.LocalName -eq 'imageCheckBox' -and $n.GetAttribute("autoChange") -eq 'false' -and -not $n.GetAttribute("onClick"))
        $op = $n.GetAttribute("opacity")
        $id = $n.GetAttribute("name"); if (-not $id) { $id = $n.GetAttribute("field") }; if (-not $id) { $id = $n.LocalName }

        if ($ro) {
            $dimSeen++
            if ($op -ne $DIM) { Fail "V111 $($f.Name) $id is read-only but reads live (opacity '$op', expected $DIM)" }
        } elseif ($op -ne '') {
            Fail "V111 $($f.Name) $id is editable but reads locked (opacity '$op')"
        }
    }
}
if ($fail -eq $dimBefore) { Pass "V111 $dimSeen read-only widgets dimmed at $DIM, every editable one left bright" }

# The fixed first dot of a virtue is an <image>, not an input, so the sweep above cannot see
# it - and a bright dot beside four dimmed ones is exactly the row reading half-locked (SPEC C).
# Only the Combat mirror has one; the same art on Main belongs to an editable row.
$imgBefore = $fail
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//image[@src]")) {
        $op   = $n.GetAttribute("opacity")
        $want = ($f.Name -eq 'WoD20.3.lfm')
        if ($want -and $op -ne $DIM) { Fail "V111 $($f.Name) mirror dot1 reads live (opacity '$op', expected $DIM)" }
        elseif (-not $want -and $op -ne '') { Fail "V111 $($f.Name) a dot on an editable row is dimmed (opacity '$op')" }
    }
}
if ($fail -eq $imgBefore) { Pass "V111 the fixed dot1 art is dimmed on the mirror tab and bright everywhere else" }

# ---- V112: a control that locks at runtime dims in the same breath ----------------
# btnSaveBaseline is the only one. Writing `enabled` without writing `opacity` leaves a dead
# button with a live button's face, which is the same lie V111 refuses in the XML.
$stTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.10.lfm")))
if ($stTxt -notmatch 'btnSaveBaseline\.enabled\s*=\s*not saved;') { Fail "V112 the Save button is not disabled once the baseline is saved (SPEC V82)" }
elseif ($stTxt -notmatch 'btnSaveBaseline\.opacity\s*=\s*saved and 0\.55 or 1;') { Fail "V112 the Save button locks without dimming - dead control, live face" }
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

function CodeOf($path) {
    $t = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($path))
    $t = [regex]::Replace($t, '(?s)<!--.*?-->', '')
    $t = [regex]::Replace($t, '(?m)^\s*--.*$', '')
    $t
}
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
elseif ((CodeOf (Join-Path $dir "WoD20.9.lfm")) -match 'function renderXPLedger\(node, rows\)[\s\S]{0,400}?form\.dynXpType\.width' -and (CodeOf (Join-Path $dir "WoD20.9.lfm")) -notmatch 'local form = xpFind') { Fail "V143 WoD20.9 still addresses its columns off a form handed to it" }
else { Pass "V143 one walker finds every control by name, for both the boxes and the log" }

# ---- V144: the storyteller's notes are the storyteller's ------------------------------
# Three boxes that look exactly like the player's, on fields of their own. Pointing one of
# them at anotacoes* would put what the storyteller wrote inside the player's Notes tab -
# two owners of one text (V1), and the tab being hidden would stop hiding anything.
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
if ($stNoteFields.Count -ne 3) { Fail "V144 WoD20.10 carries $($stNoteFields.Count) note box(es) - the storyteller was given three" }
elseif (@($stNoteFields | Sort-Object -Unique).Count -ne 3) { Fail "V144 two of the storyteller's note boxes share a field - one of them would never be read back" }
elseif ($crossed) { foreach ($c in $crossed) { Fail "V144 WoD20.10 note box owns '$c', which is the player's on WoD20.5 - the storyteller's text would show up in the player's Notes tab (SPEC V1)" } }
elseif (@($stNoteFields | Where-Object { $_ -notmatch '^stNotes\d$' })) { Fail "V144 a storyteller note box is on a field outside stNotes1..3 - the contract in I3 names those three" }
elseif ($stElsewhere) { foreach ($s in $stElsewhere) { Fail "V144 $s - a storyteller field is owned outside WoD20.10, where a player can reach it" } }
else { Pass "V144 the storyteller's three notes own their own fields, and no tab shares them ($($stNoteFields -join ', '))" }

# ---- V145: one place says how many backgrounds there are -------------------------------
# The XML draws the rows, two loops on the root form walk them - one to let experience buy a
# background, one to price it for the log. The count was a literal `9` in both until the 46th
# round doubled it. A row added to the XML and to neither loop is a background nothing
# charges for and nothing shows in the log: free, and invisible.
$bgLoops   = @([regex]::Matches($rootTxt, 'for i = 1, BACKGROUND_ROWS, 1 do'))
$bgLiteral = @([regex]::Matches($rootTxt, 'for i = 1, \d+, 1 do[^\r\n]*background'))
$bgXml     = @()
foreach ($bf in $files) {
    foreach ($n in (Doc $bf.FullName).SelectNodes("//OpenAbility[@field]")) {
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
    $iPr   = $c.IndexOf('xpLedgerRows(field, want, key)')
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
elseif ($rowsSim -notmatch 'function xpLedgerRows\(clickField, clickValue, clickFree\)') { Fail "V136 xpLedgerRows cannot be handed a pending click" }
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
function BoxOf($doc, $title) { @($doc.SelectNodes("//layout[label/@text='$title']"))[0] }
$mainDoc = Doc (Join-Path $dir "WoD20.1.lfm")
$sb = BoxOf $mainDoc "SPECIALTIES"
$specTpl = @($mainDoc.SelectNodes("//template[@name='SpecialityRow']"))[0]
if (-not $sb) { Fail "V146 WoD20.1 declares no SPECIALTIES box - the tab's map says exactly one" }
elseif (-not $specTpl) { Fail "V146 SpecialityRow is not declared on WoD20.1" }
else {
    $sbW = [int]$sb.GetAttribute("width"); $sbH = [int]$sb.GetAttribute("height")
    $sRows = @($sb.SelectNodes("layout[SpecialityRow]"))
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
    elseif ($sTops[0] -ne 25) { Fail "V146 the first speciality row starts at $($sTops[0]), not under the title at 25" }
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
    foreach ($n in (Doc $f.FullName).SelectNodes("//SpecialityRow[@num]")) { $specXmlRows += [int]$n.GetAttribute("num") }
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
elseif ($specLoops.Count -lt 3) { Fail "V147 only $($specLoops.Count) loop(s) read SPECIALITY_ROWS - the three that walk the rows are declareTrait, the ledger and the grant looking for a free slot" }
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
# Two boxes, one choice, neither on by default. Four is read first so a sheet carrying both -
# which the interface cannot produce (V155) - still has one price. Free dots does not open the
# door: one flag says WHETHER, the other says HOW MUCH.
$costSpecFn = LuaFn $rootTxt 'specCost'
$xpCostFn   = LuaFn $rootTxt 'xpCost'
$specGuard  = [regex]::Match($cc, 'if trait ~= nil and string\.match\(trait, "\^speciality_%d\+\$"\) ~= nil then(.*?)\n\t\t\t\tend;', 'Singleline')
if (-not $costSpecFn) { Fail "V154 specCost not found on the root form" }
elseif ($costSpecFn.IndexOf('stSpec4XP') -gt $costSpecFn.IndexOf('stSpec3XP')) { Fail "V154 specCost reads the 3-point box first - a sheet with both set would answer differently depending on who asked" }
elseif ($costSpecFn -notmatch 'return 4;' -or $costSpecFn -notmatch 'return 3;') { Fail "V154 specCost does not price the two boxes at 4 and 3" }
elseif ($costSpecFn -notmatch 'return 0;') { Fail "V154 specCost has no answer for both boxes off - that is the default state" }
elseif ($xpCostFn -notmatch 'if kind == "Specialty" then return specCost\(\); end;') { Fail "V154 xpCost does not price a specialty through specCost - the log would show it free" }
elseif (-not $specGuard.Success) { Fail "V154 xpClick has no speciality branch - a row could be bought with both boxes off" }
elseif ($specGuard.Groups[1].Value -notmatch 'if want and base ~= nil and specCost\(\) == 0 then') { Fail "V154 the closed door is not asked about, or is asked before the character is frozen (SPEC V101)" }
elseif ($specGuard.Groups[1].Value -notmatch 'xpWarn\("Specialties cannot be bought"\);') { Fail "V154 a closed door refuses in silence" }
elseif ($specGuard.Groups[1].Value -notmatch 'xpWarn\("Choose a trait first"\);') { Fail "V156 a row with no trait refuses in silence" }
elseif ($specGuard.Groups[1].Value -match 'markDot\(|setField\(') { Fail "V154/V156 the speciality branch writes before it has decided (SPEC V135)" }
elseif ($cc.IndexOf('if trait ~= nil and string.match(trait, "^speciality_%d+$")') -gt $cc.LastIndexOf('markDot(form, field, want)')) { Fail "V154/V156 the speciality refusals come after the mark - there would be nothing to refuse" }
else { Pass "V154/V156 a specialty is bought only where the storyteller allowed it, and every refusal says why" }

# ---- V155: two prices are one choice ---------------------------------------------------
# Ticking either clears the other, written from a dataLink and NOT from the checkbox's own
# onChange: a write made inside a control's own dispatch does not survive it (SPEC B36/B38).
# Both off is legal - it is the default, and it means specialities are not for sale.
$stDoc     = Doc (Join-Path $dir "WoD20.10.lfm")
$specBoxes = @($stDoc.SelectNodes("//checkBox[@field='stSpec3XP' or @field='stSpec4XP']"))
$specLinks = @($stDoc.SelectNodes("//dataLink[@field='stSpec3XP' or @field='stSpec4XP']"))
$specOnChg = @($specBoxes | Where-Object { $_.GetAttribute("onChange") -ne "" })
if ($specBoxes.Count -ne 2) { Fail "V155 WoD20.10 carries $($specBoxes.Count) speciality price box(es) - the storyteller is given two" }
elseif ($specOnChg.Count -gt 0) { Fail "V155 a speciality box clears its sibling from its own onChange - that write does not survive the dispatch (SPEC B36/B38)" }
elseif ($specLinks.Count -ne 2) { Fail "V155 $($specLinks.Count) of the two flags are watched - the unwatched one could never clear the other" }
elseif ($stTxt -notmatch 'if sheet ~= nil and sheet\.stSpec3XP == true then setField\("stSpec4XP", false\); end;') { Fail "V155 ticking the 3-point box does not clear the 4-point one" }
elseif ($stTxt -notmatch 'if sheet ~= nil and sheet\.stSpec4XP == true then setField\("stSpec3XP", false\); end;') { Fail "V155 ticking the 4-point box does not clear the 3-point one" }
else { Pass "V155 the two speciality prices clear each other, from a dataLink, and both off stays legal" }

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
elseif ($renderSpecFn -notmatch '(?s)c\.enabled = not locked;\s*\r?\n\s*c\.opacity = locked and 0\.55 or 1;') { Fail "V162 enabled and opacity are not written in the same breath - a row could look open while it is locked (SPEC V112)" }
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
$tcTag = [regex]::Match($rootLfm, '<tabControl\b[^>]*>')
$revealFn = [regex]::Match($rootLfm, '(?s)function sheetReveal\(from\)(.*?)\r?\n\t{3}end;')
$revealBody = if ($revealFn.Success) { $revealFn.Groups[1].Value } else { '' }
$tabsHHTotal = 0
foreach ($f in $files) {
    $raw = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    $tabsHHTotal += ([regex]::Matches($raw, 'tabsHH')).Count
}
$tabsHHInReveal = ([regex]::Matches($revealBody, 'tabsHH')).Count
$tabsHHInTag = ([regex]::Matches($tcTag.Value, 'tabsHH')).Count
$revealLights = ([regex]::Matches($revealBody, '\.visible\s*=\s*true')).Count
$tabsHHLoose = $tabsHHTotal - $tabsHHInReveal - $tabsHHInTag
if (-not $tcTag.Success) { Fail "V166 no <tabControl> on the root form" }
elseif ($tcTag.Value -notmatch 'name="tabsHH"') { Fail "V166 the tabControl carries no name - sheetReveal finds it by name from the root (SPEC V143)" }
elseif ($tcTag.Value -notmatch 'visible="false"') { Fail "V166 the tabControl is authored visible - the raw sheet is on screen before anything paints it (SPEC B40)" }
elseif (-not $revealFn.Success) { Fail "V166 sheetReveal not found on the root form - nothing would ever show the sheet" }
elseif ($revealLights -ne 1) { Fail "V166 sheetReveal writes visible=true $revealLights time(s) - it is the one place that lights the sheet" }
elseif ($tabsHHLoose -ne 0) { Fail "V166 tabsHH is named $tabsHHLoose time(s) outside sheetReveal and its own declaration - a second place could show the sheet early" }
else { Pass "V166 the tabControl is authored hidden and sheetReveal is the only thing that lights it" }

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
    @{ col = "SKILLS";     under = @("HEALTH") },
    @{ col = "KNOWLEDGES"; under = @("SPECIALTIES") }
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
$managedTab = $rootXdoc.SelectSingleNode("//tab[@name='tabDisciplines']")
if ($null -eq $managedTab) { Fail "V172 the root form has no tab named tabDisciplines - the control name was renamed with the title (SPEC V2)" }
elseif ($managedTab.GetAttribute("title") -ne 'Vampire') { Fail "V172 tabDisciplines is titled '$($managedTab.GetAttribute("title"))' - the 51st round renamed it to Vampire" }
elseif ($rootTxt -notmatch 'sheet\.stShowDisciplines') { Fail "V172 stShowDisciplines is no longer read - the field was renamed with the tab (SPEC V2)" }
elseif ($rootTxt -match '(?m)kind\s*==\s*"Vampire"') { Fail "V172 'Vampire' is a ledger category - the rename reached the experience log (SPEC I10)" }
elseif ($rootTxt -notmatch '(?m)kind\s*==\s*"Discipline"') { Fail "V172 the ledger no longer prices 'Discipline' - the category was renamed with the tab" }
else { Pass "V172 the rename is title and visible text; the field, the control name and the ledger category all kept their old spelling" }

# ---- V173/V174: `clan` is authored asleep, and CLANS has no reader while it sleeps -----
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
if ($clansReaders) { Fail "V174 CLANS is read in $(($clansReaders | Sort-Object -Unique) -join ', ') - a dormant table with a live caller can change behaviour, and its research was never checked against play" }
elseif ($rootTxt -notmatch '(?m)^\s*local CLANS\s*=\s*\{') { Fail "V174 CLANS is not declared on the root form - the check reads nothing (SPEC V20)" }
else { Pass "V174 CLANS is declared and read by nothing, exactly as a dormant table must be" }

# ---- V176: three radio groups, one per DESCRIPTION block ------------------------------
# Same shape V30 measures on the numina tab, now that the Vampire tab has three of them.
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
        if ($gn -in @('numinaSel','discSel','pathSel','ritualSel')) { continue }
        $strayGroups += "$($f.Name): '$gn'"
    }
}
if ($strayGroups) { $rgBad += "a fifth radio group exists - $(($strayGroups | Sort-Object -Unique) -join '; ') - there is one per DESCRIPTION block and no more" }
if ($rgBad) { foreach ($r in $rgBad) { Fail "V176 $r" } }
else { Pass "V176 the three Vampire selectors bind one field each, with $((@($radioGroups.Values) | ForEach-Object { $_.Count } | Measure-Object -Sum).Sum) distinct row values between them" }

# ---- V177/V178/V184: the picker lists, the tables behind them, and the level prefix ----
# V177 is V32 for the Vampire tab: every item a picker offers must open text in BOTH
# languages, or its radio opens an empty box. V178 measures the OTHER direction plus the
# sibling rule: the two path templates offer the same list, and a key may not be written
# twice in one module. V184 measures the ritual prefix the level is read off (SPEC I19).
$areaSpec = @(
    @{ File = 'WoD20.12.lfm'; Module = 'descDisc.lua';   Marker = 'DISC_DESC';   Templates = @('DiscRow');                   Name = 'discipline' },
    @{ File = 'WoD20.13.lfm'; Module = 'descPath.lua';   Marker = 'PATH_DESC';   Templates = @('MainPathRow','SecPathRow');  Name = 'path' },
    @{ File = 'WoD20.14.lfm'; Module = 'descRitual.lua'; Marker = 'RITUAL_DESC'; Templates = @('RitualRow');                 Name = 'ritual' })
$entryRx2 = [regex]'(?ms)^\s*\["([^"]+)"\]\s*=\s*\{\s*en\s*=\s*\[==\[(.*?)\]==\]\s*,\s*pt\s*=\s*\[==\[(.*?)\]==\]'
$keyRx2   = [regex]'(?m)^\s*\["([^"]+)"\]\s*=\s*\{'
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
    # V177: every item has text on file, in both languages.
    $modPath = Join-Path $plugin $a.Module
    if (-not (Test-Path $modPath)) { $areaBad += "V177 $($a.Module) missing - every $($a.Name) item would open an empty box"; continue }
    $modTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($modPath)) -replace "`r`n", "`n"
    $region = [regex]::Match($modTxt, "-- >>> $($a.Marker)_BEGIN[^\n]*\n(.*?)-- <<< $($a.Marker)_END", 'Singleline')
    if (-not $region.Success) { $areaBad += "V177 $($a.Module) has no $($a.Marker) markers - the region the entries live in is gone"; continue }
    $keys = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
    $thin2 = @()
    foreach ($m in $entryRx2.Matches($region.Groups[1].Value)) {
        $k = $m.Groups[1].Value
        [void]$keys.Add($k)
        if ($m.Groups[2].Value.Trim().Length -lt 1) { $thin2 += "V177 $($a.Module) '$k' has an empty [en] body" }
        if ($m.Groups[3].Value.Trim().Length -lt 1) { $thin2 += "V177 $($a.Module) '$k' has an empty [pt] body" }
    }
    foreach ($t in $thin2) { $areaBad += $t }
    # V178, table half: a book that repeats an item must not become two entries.
    $allKeys = @($keyRx2.Matches($region.Groups[1].Value) | ForEach-Object { $_.Groups[1].Value })
    foreach ($d in @($allKeys | Group-Object | Where-Object { $_.Count -gt 1 })) {
        $areaBad += "V178 $($a.Module) declares '$($d.Name)' $($d.Count) times - the second copy is unreachable and free to drift"
    }
    if ($keys.Count -eq 0) { $areaBad += "V177 $($a.Module) parsed to zero entries - the parser or the generated shape drifted"; continue }
    $miss = @($items | Where-Object { -not $keys.Contains($_) })
    foreach ($m in $miss) { $areaBad += "V177 the $($a.Name) picker offers '$m' and $($a.Module) has no entry - its radio would open an empty block" }
    $orph = @($allKeys | Where-Object { $items -notcontains $_ })
    foreach ($o in ($orph | Sort-Object -Unique)) { $areaBad += "V177 $($a.Module) carries '$o' and no picker offers it - dead text or a spelling drift" }
    if (-not ($areaBad | Where-Object { $_ -like "*$($a.Module)*" -or $_ -like "*$($a.File)*" })) {
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
$rowSpec = @(
    @{ Const = 'CLAN_DISC_ROWS'; File = 'WoD20.12.lfm'; Row = 'DiscRow';     Field = 'clanDisc' },
    @{ Const = 'DISC_ROWS';      File = 'WoD20.12.lfm'; Row = 'DiscRow';     Field = 'disc' },
    @{ Const = 'MAIN_PATH_ROWS'; File = 'WoD20.13.lfm'; Row = 'MainPathRow'; Field = 'mainPath' },
    @{ Const = 'SEC_PATH_ROWS';  File = 'WoD20.13.lfm'; Row = 'SecPathRow';  Field = 'secPath' },
    @{ Const = 'RITUAL_ROWS';    File = 'WoD20.14.lfm'; Row = 'RitualRow';   Field = 'ritual' }
)
foreach ($rs in $rowSpec) {
    $m = [regex]::Match($rootTxt, "(?m)^\s*$($rs.Const)\s*=\s*(\d+);")
    if (-not $m.Success) { $filterBad += "V204 $($rs.Const) is not declared on the root form - the count would live in the XML alone"; continue }
    $declared = [int]$m.Groups[1].Value
    $txt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir $rs.File)))
    $drawn = ([regex]::Matches($txt, "<$($rs.Row)\s+field=`"$($rs.Field)_\d+`"")).Count
    if ($declared -ne $drawn) {
        $filterBad += "V204 $($rs.Const) says $declared and $($rs.File) draws $drawn - every loop that reads it stops short, in silence (SPEC B46)"
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

# ---- V213: the Ambesek credit is an OBLIGATION, not a tolerance -----------------------
# The user asked for the thank-you to stay when the plugin stopped being Ambesek's. The
# rename swept every other mention of that name, so this check is the only thing left
# holding the one mention that was asked for.
$creditTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.6.lfm")))
$creditBad = @()
foreach ($needle in @('text="Programmer: Vinny (Ambesek)"',
                      'text="Based on the RPGmeister sheet plugin, by:"',
                      '["Programmer: Vinny (Ambesek)"] = "Programador: Vinny (Ambesek)"')) {
    if ($creditTxt.IndexOf($needle) -lt 0) { $creditBad += "missing: $needle" }
}
if ($creditBad) { foreach ($b in $creditBad) { Fail "V213 credit $b" } }
else { Pass "V213 the Ambesek credit stands on the Settings tab (label + pt entry)" }

# ---- V213: the Game roster keeps its "Hunters Hunted" item ----------------------------
# It reads like the old sheet name but it is content - the name of the game in the book -
# so a rename that swallowed it would delete an option from a roster SPEC C locks.
$rosterHits = ([regex]::Matches($creditTxt, 'Hunters Hunted')).Count
if ($rosterHits -ge 3) { Pass "V213 the Game roster still offers 'Hunters Hunted' ($rosterHits mentions in WoD20.6)" }
else { Fail "V213 'Hunters Hunted' appears $rosterHits times in WoD20.6 - the Game roster item is content, not branding (SPEC C)" }

# ---- V214: the old plugin no longer declares the sheet --------------------------------
# V4 hunts the NEW dataType, so a forgotten copy under the old plugin is invisible to it
# and alive for the Firecast: two sheets in the list, the old one requiring desc*.lua that
# no longer sit beside it.
$oldPlugin = Join-Path $PSScriptRoot "Plugins\Sheets\World of Darkness 20th"
$v214Bad = @()
if (-not (Test-Path -LiteralPath $oldPlugin)) { $v214Bad += "the old plugin folder is gone - V214 measured nothing (SPEC V209)" }
if (Test-Path -LiteralPath (Join-Path $oldPlugin "HuntersHunted")) { $v214Bad += "HuntersHunted/ is still under the old plugin" }
foreach ($m in @('descDisc.lua', 'descNumina.lua', 'descPath.lua', 'descRitual.lua')) {
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
$tabsVamp = $vampDoc.SelectSingleNode("//tabControl[@name='tabsVamp']")
if ($null -eq $tabsVamp) { Fail "V221 tabsVamp is gone from WoD20.11" }
elseif ($tabsVamp.GetAttribute("align")) { Fail "V221 tabsVamp claims align='$($tabsVamp.GetAttribute('align'))' again - whatever is authored above it would be drawn under it (SPEC B41)" }
else {
    $lowest = 0
    foreach ($l in $vampDoc.SelectNodes("//scrollBox/layout")) {
        $b = [int]$l.GetAttribute("top") + [int]$l.GetAttribute("height")
        if ($b -gt $lowest) { $lowest = $b }
    }
    $tabTop = [int]$tabsVamp.GetAttribute("top")
    if ($lowest -eq 0) { Fail "V221 no box was found above the sub-tabs - this check measured nothing (SPEC V209)" }
    elseif ($tabTop -lt $lowest) { Fail "V221 tabsVamp starts at $tabTop, inside the boxes that end at $lowest" }
    else { Pass "V221 the sub-tabs start at $tabTop, clear of the boxes ending at $lowest" }
}
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
