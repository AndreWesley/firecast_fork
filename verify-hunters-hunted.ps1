# Build gate for the HuntersHunted sheet. Checks SPEC.md V1, V3, V4, V5, V8-V40.
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
$plugin = Join-Path $PSScriptRoot "Plugins\Sheets\World of Darkness 20th"
$dir    = Join-Path $plugin "HuntersHunted"
$rpk    = Join-Path $plugin "output\World of Darkness 20th.rpk"
$langFile = Join-Path $plugin "localization.lang"
$fail   = 0

function Fail($msg) { Write-Host "FAIL  $msg"; $script:fail++ }
function Pass($msg) { Write-Host "ok    $msg" }
function Doc($path) { $x = New-Object System.Xml.XmlDocument; $x.LoadXml([System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($path))); $x }

$files = Get-ChildItem -LiteralPath $dir -Filter *.lfm | Sort-Object Name

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
        -Pattern 'Ambesek\.HuntersHunted\.20th' -ErrorAction SilentlyContinue
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
$bgRootTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "HuntersHunted.lfm")))
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
# combat gear. Its old home is therefore HH.8 and its new one HH.3 - the reverse of the
# other rows here. `transportation` and `other` are no longer listed: they own no widget
# at all now and are checked as declared orphans below instead.
$movedTo  = @{
    'HH.7.lfm' = @('faith_1','faith_2','faith_3','faith_4','faith_5')
    'HH.8.lfm' = @('items','gear','equipment')
    'HH.3.lfm' = @('armorClass','armorRating','armorPenalty','armorDescription')
}
$movedFrom = @{ 'HH.7.lfm' = 'HH.1.lfm'; 'HH.8.lfm' = 'HH.3.lfm'; 'HH.3.lfm' = 'HH.8.lfm' }
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
        if ($own.Count -eq 1 -and $wh[0] -eq 'HH.8.lfm') { Pass "V1 '$fld' owned once, in HH.8.lfm" }
        else { Fail "V1 '$fld' owned by $($own -join ', ') - expected exactly one widget in HH.8.lfm" }
    }
}

# ---- collect every user-visible string ---------------------------------------
# label/checkBox/button text, template `nome=` args, tab titles, Lua t("..."), picker items.
$visible = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
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
    # Tab titles are translated too (HH.6 handles cls == "tab"), so they are visible strings.
    foreach ($n in $xml.SelectNodes("//tab[@title]")) { [void]$visible.Add($n.GetAttribute("title").Trim()) }
    # runtime strings built in Lua go through the t() helper
    [regex]::Matches($raw, 't\("([^"]+)"\)') | ForEach-Object { [void]$visible.Add($_.Groups[1].Value) }
    # Picker items are user-visible too (SPEC V17). Read them off the XML `items=` attribute,
    # NOT out of a Lua table: the lists live inline in the templates now, and a checker that
    # greps for the old Lua form would pass silently while verifying nothing.
    # Only `cbo*` pickers count - the colour and theme combos are values, not prose.
    foreach ($cb in $xml.SelectNodes("//comboBox[@name][@items]")) {
        if ($cb.GetAttribute("name") -notlike 'cbo*') { continue }
        # [^']* not [^']+ - with + the leading empty entry ('') fails to match and the engine
        # slides forward, capturing the separator ', ' as if it were a list item.
        [regex]::Matches($cb.GetAttribute("items"), "'([^']*)'") |
            ForEach-Object { $it = $_.Groups[1].Value; if ($it -ne '') { [void]$visible.Add($it) } }
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
    foreach ($cb in $xml.SelectNodes("//comboBox[@name][@items]")) {
        $nm = $cb.GetAttribute("name")
        if ($nm -notlike 'cbo*') { continue }
        $items = @([regex]::Matches($cb.GetAttribute("items"), "'([^']*)'") | ForEach-Object { $_.Groups[1].Value })
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
foreach ($must in @('HH.6.lfm/cboGame','HH.7.lfm/cboFaith','HH.6.lfm/cboSheetTheme')) {
    if ($listReport | Where-Object { $_.Name -eq $must }) { Pass "V14/V15/V17 $must reaches the list checks" }
    else { Fail "V14/V15/V17 $must was never collected - its list is unchecked" }
}

# cboGame is a closed roster, not an open vocabulary: assert the names themselves, so a
# dropped, renamed or added entry fails instead of passing as "no duplicates" (SPEC V109).
# Three since the 32nd round, and no leading empty one to discount.
$gameList = @($listReport | Where-Object { $_.Name -eq 'HH.6.lfm/cboGame' })
if ($gameList.Count -eq 1) {
    $wantGames = @('Vampire', 'Hunters Hunted', 'Mage')
    $gotGames = @($gameList[0].Items)
    if (($gotGames -join '|') -eq ($wantGames -join '|')) { Pass "V109 cboGame offers exactly $($wantGames -join ', ')" }
    else { Fail "V109 cboGame offers '$($gotGames -join ', ')', expected '$($wantGames -join ', ')'" }
}

# ---- V9: source language is English - no non-ASCII in authored strings -------
# Deliberately a codepoint range, not a list of accented letters: this file is read
# as ANSI by PowerShell 5.1 when it has no BOM, so non-ASCII literals here would rot.
$ptChars = $visible | Where-Object { $_ -match '[^\x00-\x7F]' }
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
$rootPath = Join-Path $dir "HuntersHunted.lfm"
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
    # them - the HH.6 map never sees them. Same check V22 runs on that map.
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

    # Read HH.6 here rather than using $hh6: that variable is not assigned until the V12 block
    # further down, so referencing it at this point would silently test an empty string.
    $hh6Early = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "HH.6.lfm")))
    if ($hh6Early -match 'string\.sub\(dynName, 1, 3\) == "dyn"') { Pass "V31/V39 the traversal skips Lua-owned (dyn*) text" }
    else { Fail "V31/V39 HH.6 traversal has no dyn* guard - it would restore stale health labels" }
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
$strayMarks = @($files | Where-Object { $_.Name -ne 'HuntersHunted.lfm' } |
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
    if ($f.Name -eq 'HH.9.lfm') { continue }
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


# ---- V69: the Main bottom row closes on the line the tab declares (SPEC V69, T193) ----
# V40 only asks that two boxes never overlap, so growing VIRTUES and shrinking the
# HUMANITY/WILLPOWER box under it by the wrong amount would leave the middle column ending
# short and still pass green - the 18th round moves both, and this is what keeps it honest.
#
# The ruler used to be the BACKGROUNDS box beside it. That box moved to the Traits tab in
# the 46th round, so the ruler is now the y=810 the tab's own grid comment declares.
# HEALTH is out of it on purpose: its declared height is the ten-row case (816) and the
# renderer shrinks it to the chosen track (V49), an exception taken in the 11th round.
$MAIN_BOTTOM_Y = 810
$mainBottom = @{}
foreach ($bx in (Doc (Join-Path $dir "HH.1.lfm")).SelectNodes("//scrollBox/layout")) {
    $bt = 0; $bh = 0
    if (-not ([int]::TryParse($bx.GetAttribute("top"), [ref]$bt) -and
              [int]::TryParse($bx.GetAttribute("height"), [ref]$bh))) { continue }
    foreach ($lb in $bx.SelectNodes("label")) {
        $t = $lb.GetAttribute("text")
        if ($t) { $mainBottom[$t] = $bt + $bh }
    }
}
if (-not $mainBottom.ContainsKey("HUMANITY")) {
    Fail "V69 HUMANITY not found on HH.1 - the check measured nothing (SPEC V20)"
} elseif ($mainBottom["HUMANITY"] -ne $MAIN_BOTTOM_Y) {
    Fail "V69 the HUMANITY/WILLPOWER box ends at y=$($mainBottom['HUMANITY']), not the y=$MAIN_BOTTOM_Y the tab's grid closes on - the Main bottom row must close on one line"
} else {
    Pass "V69 Main bottom row closes on y=$MAIN_BOTTOM_Y"
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
$hh3x = Doc (($files | Where-Object { $_.Name -eq 'HH.3.lfm' }).FullName)
$hh3t = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "HH.3.lfm")))
$wpTpl = $hh3x.SelectSingleNode("//template[@name='WillpowerMirror']")
if ($null -eq $wpTpl) { Fail "V51 HH.3 has no WillpowerMirror template" }
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

    if ($hh3t -notmatch 'paintWillpower') { Fail "V51 HH.3 never paints the willpower dots - they would stay empty" }
    elseif ($hh3t -notmatch "'willpower_1'") { Fail "V51 the HH.3 dataLink does not observe willpower_* - the dots would not follow the Main tab" }
    else { Pass "V51 the dots are painted and follow the Main tab" }
}

# Virtues joined the display-only side in the 12th round: same rule, same two ways to break it.
$vTpl = $hh3x.SelectSingleNode("//template[@name='VirtueMirror']")
if ($null -eq $vTpl) { Fail "V51 HH.3 has no VirtueMirror template" }
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
    if ($hh3t -notmatch 'paint\(form,\s*RO_VIRTUES\[') { Fail "V51 HH.3 never paints the virtue dots - they would stay empty" }
    elseif ($hh3t -notmatch 'RO_VIRTUES\s*=\s*\{\s*"conscience"') { Fail "V51 RO_VIRTUES does not list the three virtues" }
    elseif ($hh3t -notmatch "'conscience_2'") { Fail "V51 the HH.3 dataLink does not observe the virtue fields - the dots would not follow the Main tab" }
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
    foreach ($pair in @(@('HH.1.lfm','dynHealth_'), @('HH.3.lfm','dynHealth3_'))) {
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
$hh6 = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "HH.6.lfm")))
if ($hh6 -match 'field="theme"[^>]*items="\{([^}]*)\}"') {
    $items = ([regex]::Matches($Matches[1], "'([^']*)'") | ForEach-Object { $_.Groups[1].Value })
    if ($hh6 -match 'theme\s*==\s*"([^"]+)"') {
        $cmp = $Matches[1]
        if ($items -contains $cmp) { Pass "V12 theme comparison '$cmp' is one of {$($items -join ', ')}" }
        else { Fail "V12 Lua compares theme == '$cmp' but items are {$($items -join ', ')} - theme switching is broken" }
    } else { Fail "V12 theme combo present but no comparison found in HH.6.lfm" }
} else { Pass "V12 n/a - no theme combo (removed)" }

# ---- V21: language traversal starts at the ROOT, not at this form (SPEC B.9) --
if ($hh6 -match 'recursiveFindControls\s*\(\s*self') { Fail "V21 traversal still starts at self - sibling tabs unreachable" }
elseif ($hh6 -notmatch 'getParent\(\)') { Fail "V21 no getParent() walk found - traversal cannot reach the sheet root" }
else { Pass "V21 traversal walks up to the sheet root" }

# ---- V109 + V110: the Game box is locked, defaulted, and kept inside its roster ---
# Information, not a choice. Which makes what it holds the sheet's problem: a value outside
# the three - one of the four longer names this sheet used to offer, or nothing at all - would
# sit in a box nobody can open, so the load puts it back inside the roster.
$gameNode = @((Doc (Join-Path $dir "HH.6.lfm")).SelectNodes("//comboBox[@name='cboGame']"))
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
if (-not $mapBlock.Success) { Fail "V22 PT map not found in HH.6.lfm" }
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
$notEn = @()
foreach ($f in $files) {
    $xml = Doc $f.FullName
    foreach ($cb in $xml.SelectNodes("//comboBox[@name][@values]")) {
        if ($cb.GetAttribute("name") -notlike 'cbo*') { continue }
        foreach ($m in [regex]::Matches($cb.GetAttribute("values"), "'([^']*)'")) {
            $v = $m.Groups[1].Value
            if ($v -ne '' -and $v -match '[^\x00-\x7F]') { $notEn += "$($f.Name): stored value '$v' is not English" }
        }
    }
}
if ($notEn) { foreach ($n in $notEn) { Fail "V24 $n" } } else { Pass "V24 all picker values are canonical English" }

# ---- V29 - V33: the Powers tab description block ------------------------------
# The block shows book text: read-only, no field, fed from the DESC table by the renderer.
$hh7Path = Join-Path $dir "HH.7.lfm"
if (-not (Test-Path $hh7Path)) { Fail "V29 HH.7.lfm missing - the Powers tab is gone" }
else {
    $hh7 = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($hh7Path))
    $hh7x = Doc $hh7Path

    # V29: read-only, and no `field=` - a field here would write book text into the character
    $desc = $hh7x.SelectSingleNode("//textEditor[@name='edtNuminaDesc']")
    if ($null -eq $desc) { Fail "V29 no <textEditor name='edtNuminaDesc'> - the renderer has nothing to write to" }
    else {
        if ($desc.GetAttribute("readOnly") -eq 'true') { Pass "V29 description block is readOnly" }
        else { Fail "V29 description block is not readOnly - the reader could type over the book text" }
        if ($desc.HasAttribute("field")) { Fail "V29 description block owns field '$($desc.GetAttribute('field'))' - it would be saved on the sheet" }
        else { Pass "V29 description block owns no field (nothing saved)" }
    }

    # V30: one group, one field, distinct fieldValues, each pointing at a real row
    $numinaRadios = @($radios | Where-Object { $_.File -eq 'HH.7.lfm' })
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
    if ($hh6 -match "cls\s*==\s*`"textEditor`"") { Fail "V31 HH.6 translates textEditor in place - it would overwrite the rendered description" }
    else { Pass "V31 HH.6 traversal leaves textEditor alone" }

    # V32: every picker item must have a description in both languages.
    # Read the region between the generator markers, not `local DESC = {...};`: the entries are
    # generated one per line and close with `]==] },`, so a regex expecting a newline before the
    # brace matches nothing and reports 43 phantom failures (this check was wrong once already).
    $descBlock = [regex]::Match($hh7, '-- >>> DESC_BEGIN[^\n]*\n(.*?)-- <<< DESC_END', 'Singleline')
    if (-not $descBlock.Success) { Fail "V32 DESC markers not found in HH.7.lfm" }
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
        foreach ($cb in $hh7x.SelectNodes("//comboBox[@name][@items]")) {
            if ($cb.GetAttribute("name") -notlike 'cbo*') { continue }
            # The TRUE FAITH row picks a religion and always shows the True Faith text, so its
            # items are deliberately outside this check (SPEC V50, checked on its own below).
            if ($cb.GetAttribute("name") -eq 'cboFaith') { continue }
            foreach ($m in [regex]::Matches($cb.GetAttribute("items"), "'([^']*)'")) {
                $it = $m.Groups[1].Value
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
        if ($hh7 -notmatch 'selected\s*==\s*"faith"') { Fail "V50 HH.7 does not special-case the faith row - a religion would open the NO_ENTRY message" }
        elseif ($hh7 -notmatch 'value\s*=\s*"True Faith"') { Fail "V50 the faith row does not resolve to the True Faith entry" }
        elseif (-not $descKeys.Contains('True Faith')) { Fail "V50 DESC has no 'True Faith' entry - the row would open empty" }
        else { Pass "V50 every religion on the faith row opens the True Faith description" }

        $faithCb = $hh7x.SelectSingleNode("//comboBox[@name='cboFaith']")
        if ($null -eq $faithCb) { Fail "V50 cboFaith not found" }
        else {
            $faithItems = @([regex]::Matches($faithCb.GetAttribute("items"), "'([^']*)'") | ForEach-Object { $_.Groups[1].Value } | Where-Object { $_ -ne '' })
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
        $cb = $hh7x.SelectSingleNode("//template[@name='$tpl']//comboBox[@items]")
        if ($null -eq $cb) { Fail "V78 template '$tpl' carries no picker - its list is unchecked (SPEC V20)"; continue }
        $got = @([regex]::Matches($cb.GetAttribute("items"), "'([^']*)'") | ForEach-Object { $_.Groups[1].Value } | Where-Object { $_ -ne '' })
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
        $vals = @([regex]::Matches($cb.GetAttribute("values"), "'([^']*)'") | ForEach-Object { $_.Groups[1].Value } | Where-Object { $_ -ne '' })
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
    if ($hh7 -match 'renderNuminaDesc\(self\)') { Pass "V33 renderer is wired (dataLink + onNodeReady)" }
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
foreach ($p in (@($files | ForEach-Object { $_.FullName }) + @($langFile))) {
    $txt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($p))
    foreach ($m in $banned.Matches($txt)) {
        $ln = ($txt.Substring(0, $m.Index) -split "`n").Count
        Fail "V34 $(Split-Path $p -Leaf):$ln '$($m.Value)' - hedge magic is 'magia estatica', hedge magician/wizard is 'mago estatico' (SPEC B.15)"
        $bannedHits++
    }
}
if ($bannedHits -eq 0) { Pass "V34 no banned hedge-magic wording in the .lfm files or the .lang" }

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
if (-not $themeFn.Success) { Fail "V52..V58 applyTheme not found in HH.6.lfm - every theme check below is a no-op" }
else {
    $body = $themeFn.Groups[1].Value

    # V52: the three values, the table that answers them, and the fallback.
    $themeCb = @($listReport | Where-Object { $_.Name -eq 'HH.6.lfm/cboSheetTheme' })
    $wantThemes = @('Modern Nights', 'Victorian Era', 'Dark Ages', 'Classical Age')
    if ($themeCb.Count -ne 1) { Fail "V52 cboSheetTheme was never collected - its value list is unchecked" }
    elseif (Compare-Object $themeCb[0].Items $wantThemes) {
        Fail "V52 cboSheetTheme offers {$($themeCb[0].Items -join ', ')}, expected {$($wantThemes -join ', ')}"
    } else { Pass "V52 cboSheetTheme offers the $($wantThemes.Count) declared themes" }

    # The combo saves what it shows, so items and values must not drift apart (SPEC V24).
    $themeNode = (Doc (Join-Path $dir "HH.6.lfm")).SelectSingleNode("//comboBox[@name='cboSheetTheme']")
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
    if ($hh6 -match 'findClass\s*\(') { Fail "V55 HH.6 calls findClass - it stops at this tab (SPEC R21/B.9)" }
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
# time - the generated Lua carries "/HuntersHunted/images/prime_on.png" - so a relative path
# handed to a setter at runtime resolves to nothing and the art quietly fails to load. This
# check measures the FORM of the path; V58 below measures the file. B20 passed V58 green while
# every dot in both Victorian themes was broken, because only the file was ever checked.
$artPrefix = '/HuntersHunted/images/'
$themeArt = @([regex]::Matches($hh6, '(?:dotOn|dotOff|paper)\s*=\s*"([^"]+)"') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
if ($themeArt.Count -eq 0) { Fail "V58/V60 no theme art referenced - the palettes point at nothing" }
else {
    foreach ($img in $themeArt) {
        if (-not $img.StartsWith($artPrefix)) {
            Fail "V60 palette path '$img' is not plugin-absolute - the rdk only resolves the relative form at compile time (SPEC B20)"
            continue
        }
        # Strip only the sheet folder: what is left ("images/x.png") is the path on disk.
        $onDisk = Join-Path $dir ($img.Substring('/HuntersHunted/'.Length))
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
# Counted off the tabs rather than hard-coded: the 27th round took the sheet from 9 tabs to 12
# and a fixed 8 here would have to be edited by hand every time a tab is added, which is how a
# check quietly stops matching the sheet it guards.
$paperWant = ((Doc $rootPath).SelectNodes("//tab")).Count - 1
if ($paperTabs -contains 'HH.6.lfm') { Fail "V56 the Settings tab has a backdrop - a covered theme combo cannot be switched back" }
elseif ($paperTabs.Count -ne $paperWant) { Fail "V56 found $($paperTabs.Count) backdrops, expected $paperWant (every tab but Settings)" }
else { Pass "V56 all $paperWant content tabs carry a hidden, click-through backdrop; Settings has none" }

# ---- V70/V74/V75/V76: the era ability lists (SPEC I7, 21st round) ----------------
# A row on the Main tab is a slot: the era decides which ability sits there and the renderer
# rebinds the dots to that ability's field. Two bugs came out of getting this wrong - B23 (a
# name changing field between eras) and B24 (one field carrying several names) - so what is
# checked here is the shape that makes both impossible: one name, one field, both ways.
#
# None of these strings live in the XML, which is why the width and translation checks further
# up cannot see them - the same blind spot as B11 and B17, one family further out.
$rootLfm = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "HuntersHunted.lfm")))

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
$mainDoc = Doc (Join-Path $dir "HH.1.lfm")
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
                if ($null -eq $row) { $authBad += "$col slot $i is not authored on HH.1"; continue }
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
$hh3Text = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "HH.3.lfm")))
if ($rootLfm -notmatch 'function eraRangedName\(') { Fail "V74 eraRangedName is missing - the Combat mirror cannot follow the era" }
elseif ($hh3Text -notmatch 'ReadOnlyTrait field="ranged"') { Fail "V74 the Combat ranged row is not a slot - Archery has its own field now" }
elseif ($hh3Text -notmatch 'paintAs\(form, "ranged", ABILITY_FIELD\[eraRangedName\(\)\], 1\)') { Fail "V74 the ranged row is not painted from the era's own ranged skill" }
elseif ($hh3Text -notmatch "'archery_1'" -or $hh3Text -notmatch "'sheetTheme'") { Fail "V74 the HH.3 dataLink does not observe archery_* and sheetTheme - the mirror would go stale" }
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
$roLbl = (Doc (Join-Path $dir "HH.3.lfm")).SelectSingleNode("//template[@name='ReadOnlyTrait']/label")
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

# ---- V93: nobody is left standing on a tab that was just denied -------------------
# There is no event for the active tab and no trustworthy reading of tabIndex (SPEC R33), so
# the renderer watches for a tab going from shown to hidden and moves everyone to Main.
if (-not $visFn) { } # already reported above
elseif ($visFn -notmatch 'if tab\.visible and not want then') { Fail "V93 applyTabVisibility does not notice a tab going from shown to hidden - it cannot tell when to move the player" }
elseif ($visFn -notmatch 'tabMain:activate\(\)') { Fail "V93 nothing hands the player back to Main when a tab is denied" }
else { Pass "V93 a denied tab hands the player back to Main" }

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
$stDoc = Join-Path $dir "HH.10.lfm"
if (-not (Test-Path $stDoc)) { Fail "V81 HH.10.lfm (Storyteller tab) is missing" }
else {
    $stTxt  = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($stDoc))
    $saveFn = LuaFn $stTxt 'saveBaseline'
    $stateFn = LuaFn $stTxt 'renderBaselineState'

    if (-not $saveFn) { Fail "V81 saveBaseline not found on HH.10" }
    elseif ($saveFn -notmatch 'Dialogs\.confirmOkCancel') { Fail "V81 saveBaseline writes without asking (SPEC R30) - the action cannot be undone" }
    elseif (([regex]::Matches($saveFn, 'sheet\.baseline ~= nil and sheet\.baseline ~= ""')).Count -lt 2) { Fail "V81 saveBaseline does not re-check the baseline inside the callback - a second client could overwrite it" }
    elseif ($saveFn -notmatch 'setField\("baseline", ndb\.exportXML\(sheet\)\)') { Fail "V81 saveBaseline does not snapshot the sheet (SPEC R32)" }
    else { Pass "V81 baseline is written once, behind a confirmation" }

    if (-not $stateFn) { Fail "V82 renderBaselineState not found on HH.10" }
    elseif ($stateFn -notmatch 'btnSaveBaseline\.enabled = not saved') { Fail "V82 the Save button stays live after the baseline exists" }
    elseif ($stateFn -notmatch 'dynBaselineState') { Fail "V82 nothing on the tab says whether the character was saved (SPEC V33)" }
    else { Pass "V82 Save goes dead once the baseline exists, and the tab says so" }

    # No field of the ledger's own may be edited from here, and the flags must be real fields.
    $stFields = @((Doc $stDoc).SelectNodes("//*[@field]") | ForEach-Object { $_.GetAttribute("field") })
    $wantFlags = @('stBackgroundsXP', 'stShowNumina', 'stShowDisciplines', 'stFreeBuy', 'stSpec3XP', 'stSpec4XP')
    $missFlags = @($wantFlags | Where-Object { $stFields -notcontains $_ })
    if ($missFlags) { foreach ($f in $missFlags) { Fail "V89 HH.10 has no widget for $f" } }
    else { Pass "V89 all $($wantFlags.Count) storyteller flags are owned by HH.10" }
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
# HH.10 owns the checkboxes but is itself one of the four tabs being switched. A tab cannot be
# trusted to run the code that hides its neighbours - that is exactly how B26 happened.
$rootReady = [regex]::Match($root, '<event name="onNodeReady">(.*?)</event>', 'Singleline')
if ($root -notmatch "dataLink fields=""{'stShowNumina', 'stShowDisciplines'}""") { Fail "V95 the root form does not watch the two show-a-tab flags" }
elseif (-not $rootReady.Success) { Fail "V95 the root form has no onNodeReady - nothing would apply tab visibility on load" }
elseif ($rootReady.Groups[1].Value -notmatch 'applyTabVisibility\(') { Fail "V95 the root onNodeReady does not apply tab visibility" }
elseif ($stTxt -match 'applyTabVisibility') { Fail "V95 HH.10 still triggers the switch - it is one of the tabs being hidden (SPEC B26)" }
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
$progDoc = Join-Path $dir "HH.9.lfm"
$progTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($progDoc))
$ledFn   = LuaFn $progTxt 'renderXPLedger'
$rowsFn  = LuaFn $root 'xpLedgerRows'

$cols = @('dynXpType', 'dynXpTrait', 'dynXpLevel', 'dynXpCost')
$colNodes = @((Doc $progDoc).SelectNodes("//textEditor") | Where-Object { $cols -contains $_.GetAttribute("name") })
$colWithField = @($colNodes | Where-Object { $_.GetAttribute("field") })
if ($colNodes.Count -ne 4) { Fail "V84 expected 4 ledger columns on HH.9, found $($colNodes.Count)" }
elseif ($colWithField.Count) { Fail "V84 a ledger column owns a field - the derived log would be stored twice" }
elseif (@($colNodes | Where-Object { $_.GetAttribute("readOnly") -ne 'true' }).Count) { Fail "V84 a ledger column is editable - the log is derived, not typed" }
else { Pass "V84 four read-only ledger columns, none owning a field" }

if (-not $ledFn) { Fail "V83 renderXPLedger not found on HH.9" }
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
if (-not $progShow.Success) { Fail "V97 HH.9 has no onShow - the report would be built once and then frozen (SPEC B28)" }
elseif ($progShow.Groups[1].Value -notmatch 'renderXPLedger\(') { Fail "V97 HH.9's onShow does not rebuild the ledger" }
elseif ($progShow.Groups[1].Value -notmatch 'renderXPBoxes\(') { Fail "V97 HH.9's onShow does not rebuild the three numbers" }
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
# Every imageCheckBox on this sheet IS a rating dot - the willpower boxes are checkBoxes and
# the Combat mirror is images - so the rule is simply all of them.
$dots = @()
$dotsUnguarded = @()
foreach ($f in $files) {
    foreach ($n in (Doc $f.FullName).SelectNodes("//imageCheckBox")) {
        if (-not $n.GetAttribute("field")) { continue }   # display-only mirror (V51): owns nothing, buys nothing
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
elseif (-not $eraFn) { Fail "V107 renderAbilityLabels not found on HH.6" }
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
        'Numina'     = 'return from \* 7'
    }
    $costBad = @()
    foreach ($k in $costWant.Keys) { if ($costFn -notmatch $costWant[$k]) { $costBad += "$k is not priced as SPEC I9 states" } }
    # Read the CODE, not the prose: the comment above xpCost names the dormant rules on purpose,
    # so the check looks for a dormant kind being handled - a quoted kind string - rather than
    # for the word appearing anywhere in the file.
    foreach ($dead in @('Discipline', 'Path', 'Sphere', 'Arete')) {
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
$numDoc = Join-Path $dir "HH.7.lfm"
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
foreach ($empty in @('HH.11.lfm')) {
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
        $want = ($f.Name -eq 'HH.3.lfm')
        if ($want -and $op -ne $DIM) { Fail "V111 $($f.Name) mirror dot1 reads live (opacity '$op', expected $DIM)" }
        elseif (-not $want -and $op -ne '') { Fail "V111 $($f.Name) a dot on an editable row is dimmed (opacity '$op')" }
    }
}
if ($fail -eq $imgBefore) { Pass "V111 the fixed dot1 art is dimmed on the mirror tab and bright everywhere else" }

# ---- V112: a control that locks at runtime dims in the same breath ----------------
# btnSaveBaseline is the only one. Writing `enabled` without writing `opacity` leaves a dead
# button with a live button's face, which is the same lie V111 refuses in the XML.
$stTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "HH.10.lfm")))
if ($stTxt -notmatch 'btnSaveBaseline\.enabled\s*=\s*not saved;') { Fail "V112 the Save button is not disabled once the baseline is saved (SPEC V82)" }
elseif ($stTxt -notmatch 'btnSaveBaseline\.opacity\s*=\s*saved and 0\.55 or 1;') { Fail "V112 the Save button locks without dimming - dead control, live face" }
else { Pass "V112 the Save button dims in the same breath it locks" }


# ---- V121: nothing redraws off a whole-node observer -------------------------------
# B34: HH.9 registered ndb.newObserver(sheet) and redrew the whole experience log from its
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
$rootTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "HuntersHunted.lfm")))
$ledgerTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "HH.9.lfm")))
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
# HH.3 had one link over the health track AND the ~80 mirrored trait dots, so ticking any
# trait re-rendered the health track, and that render wrote all ten health rows back.
$combatTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "HH.3.lfm")))
$healthLinks = @([regex]::Matches($combatTxt, '<dataLink fields="\{([^}]*)\}"[^>]*renderHealthTrack'))
if ($healthLinks.Count -ne 1) { Fail "V123 expected exactly one dataLink driving renderHealthTrack on HH.3, found $($healthLinks.Count)" }
else {
    $watched = @($healthLinks[0].Groups[1].Value -split ',' | ForEach-Object { $_.Trim().Trim("'") })
    $strays  = @($watched | Where-Object { $_ -ne 'healthLevels' -and $_ -ne 'language' })
    if ($strays) { Fail "V123 the health link on HH.3 also watches $($strays -join ', ') - fields renderHealthTrack never reads (SPEC B34)" }
    else { Pass "V123 the health link on HH.3 watches only healthLevels and language" }
}
if ($combatTxt -notmatch '<dataLink fields="\{[^}]*\}"[^>]*renderCombatTraits\(self\);"\s*/>') { Fail "V123 the trait mirror on HH.3 has no link of its own" }
elseif ($combatTxt -match '<dataLink fields="\{[^}]*\}"[^>]*renderHealthTrack[^>]*renderCombatTraits') { Fail "V123 one link still drives both renderers on HH.3" }
else { Pass "V123 the trait mirror on HH.3 has its own link" }

# ---- V124: a whole-tree renderer runs once per open for the same state --------------
# language and sheetTheme both carry a defaultValue, so BOTH links fire when the sheet opens.
# renderAbilityLabels walked the whole control tree and rebound 150 dots each time.
$setTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "HH.6.lfm")))
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
if (Test-Path (Join-Path $dir "HH.12.lfm")) { Fail "V128 HH.12.lfm is still on disk - the Magika tab was removed" }
else { Pass "V128 HH.12.lfm is gone" }

$managed = @('tabNumina', 'tabDisciplines', 'tabStoryteller')
$magikaLeft = @($files | Where-Object { (CodeOf $_.FullName) -match '(tabMagika|stShowMagika|"Show Magika"|HH[.]12)' })
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
    # Three refusals speak, and each one says its own reason: want of experience (this check),
    # and the two a speciality row adds - no trait chosen, and the storyteller allowing none
    # (SPEC V154/V156). What may NOT happen is a second voice inside the balance branch, or
    # the sale refusal of V103 growing one.
    $buyWarns = @([regex]::Matches($buy.Groups[1].Value, 'xpWarn\("([^"]*)"\)'))
    if (-not $buy.Success) { Fail "V129 xpClick has no purchase branch" }
    elseif ($warns.Count -ne 4) { Fail "V129 xpClick raises $($warns.Count) pop-ups - four refusals speak: the balance, the empty trait, the closed door, and the gift that is not the player's to take off (SPEC V161)" }
    elseif ($buyWarns.Count -ne 1) { Fail "V129 the balance branch raises $($buyWarns.Count) pop-ups - only the refusal for want of experience may speak there" }
    elseif ($buy.Groups[1].Value -notmatch 'xpWarn\(') { Fail "V129 the refusal for want of experience says nothing" }
    elseif ($buy.Groups[1].Value -match 'markDot\(') { Fail "V129 the refused purchase marks the dot anyway (SPEC V135)" }
    else { Pass "V129 only the balance refusal speaks, and it speaks over a sheet nothing was written to" }
}

$warnFn   = LuaFn $rootTxt 'xpWarn'
$warnMsgs = @([regex]::Matches($rootTxt, 'xpWarn\("([^"]*)"\)') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
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
    if ($bf.Name -eq 'HuntersHunted.lfm') { continue }
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
$ledgerUsesFind = ((CodeOf (Join-Path $dir "HH.9.lfm")) -match 'xpFind\(node, XP_LOG')
if ($finders.Count -ne 1) { Fail "V143 xpFind is declared $($finders.Count) times on the root form - exactly one walker" }
elseif ($rootTxt -notmatch 'xpFind\(node, XP_BOXES, \{\}\)') { Fail "V143 the box painter does not find its controls through xpFind" }
elseif (-not $ledgerUsesFind) { Fail "V143 HH.9 does not find its columns through xpFind - a second way to reach a control by name" }
elseif ((CodeOf (Join-Path $dir "HH.9.lfm")) -match 'function renderXPLedger\(node, rows\)[\s\S]{0,400}?form\.dynXpType\.width' -and (CodeOf (Join-Path $dir "HH.9.lfm")) -notmatch 'local form = xpFind') { Fail "V143 HH.9 still addresses its columns off a form handed to it" }
else { Pass "V143 one walker finds every control by name, for both the boxes and the log" }

# ---- V144: the storyteller's notes are the storyteller's ------------------------------
# Three boxes that look exactly like the player's, on fields of their own. Pointing one of
# them at anotacoes* would put what the storyteller wrote inside the player's Notes tab -
# two owners of one text (V1), and the tab being hidden would stop hiding anything.
$stDocPath = Join-Path $dir "HH.10.lfm"
$hh5Path   = Join-Path $dir "HH.5.lfm"
$stNoteFields = @((Doc $stDocPath).SelectNodes("//textEditor[@field]") | ForEach-Object { $_.GetAttribute("field") })
$stElsewhere  = @()
foreach ($nf in $files) {
    if ($nf.Name -eq 'HH.10.lfm') { continue }
    foreach ($n in (Doc $nf.FullName).SelectNodes("//*[@field]")) {
        if ($n.GetAttribute("field") -match '^stNotes\d$') { $stElsewhere += "$($nf.Name)/$($n.GetAttribute('field'))" }
    }
}
$playerNotes = @((Doc $hh5Path).SelectNodes("//textEditor[@field]") | ForEach-Object { $_.GetAttribute("field") })
$crossed = @($stNoteFields | Where-Object { $playerNotes -contains $_ })
if ($stNoteFields.Count -ne 3) { Fail "V144 HH.10 carries $($stNoteFields.Count) note box(es) - the storyteller was given three" }
elseif (@($stNoteFields | Sort-Object -Unique).Count -ne 3) { Fail "V144 two of the storyteller's note boxes share a field - one of them would never be read back" }
elseif ($crossed) { foreach ($c in $crossed) { Fail "V144 HH.10 note box owns '$c', which is the player's on HH.5 - the storyteller's text would show up in the player's Notes tab (SPEC V1)" } }
elseif (@($stNoteFields | Where-Object { $_ -notmatch '^stNotes\d$' })) { Fail "V144 a storyteller note box is on a field outside stNotes1..3 - the contract in I3 names those three" }
elseif ($stElsewhere) { foreach ($s in $stElsewhere) { Fail "V144 $s - a storyteller field is owned outside HH.10, where a player can reach it" } }
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
elseif ($flagReads[0] -ne 'HuntersHunted.lfm') { Fail "V137 stFreeBuy is read from $($flagReads[0]) - the flag belongs to the click, not to a tab" }
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
# A tab may WATCH the stamps - HH.1 locks its rows off them (SPEC V164) - but naming the
# field in any other way outside the root form means a second owner of the gift.
#
# Only the `field=` attribute is dropped, not the whole tag: a handler written inside that
# same tag (onChange="setField('xpFree', ...)") is exactly the write this forbids, and
# stripping the element wholesale would have hidden it.
$freeElse   = @($files | Where-Object { $_.Name -ne 'HuntersHunted.lfm' -and ([regex]::Replace((CodeOf $_.FullName), '<dataLink field="xpFree"', '<dataLink')) -match 'xpFree' })
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
if (-not $riseFn) { Fail "V139 pushRise not found on the root form" }
elseif ($riseFn -notmatch 'function pushRise\(rows, kind, name, from, to, ctx, field\)') { Fail "V139 pushRise cannot tell which trait the row belongs to - it could not read a stamp" }
elseif ($riseFn -notmatch 'local cost = xpCost\(kind, lvl - 1, ctx\);') { Fail "V139 pushRise no longer prices the row through xpCost (SPEC V86)" }
elseif ($riseFn -notmatch 'string\.find\(ctx\.free, "\|" \.\. field \.\. "#" \.\. lvl \.\. "\|", 1, true\)') { Fail "V139 pushRise does not look the row's level up in the stamps" }
elseif ($riseFn.IndexOf('string.find(ctx.free') -lt $riseFn.IndexOf('local cost = xpCost(')) { Fail "V139 the discount lands before the price exists - it must zero a cost the table already worked out (SPEC V86)" }
elseif ($riseCalls.Count -ne 10) { Fail "V139 $($riseCalls.Count) of the ledger's ten row groups hand pushRise their field - one that does not could never go free" }
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

# ---- V146: the speciality box fills the corner the 46th round emptied ----------------
# 890..1210 x 510..810 is the slot BACKGROUNDS left when it moved to the Traits tab, and 810
# is the line every other box on this tab already closes on - which is what "line the bottom
# up with the others" meant. Nine rows at a pitch of 30 from 25: a tenth would want 295..320
# inside a box 300 tall, and a full table says so with a pop-up instead (V153).
$mainDoc = Doc (Join-Path $dir "HH.1.lfm")
$specBox = @($mainDoc.SelectNodes("//layout[label/@text='SPECIALTIES']"))
if ($specBox.Count -ne 1) { Fail "V146 HH.1 declares $($specBox.Count) SPECIALTIES boxes - the tab's map says exactly one" }
else {
    $sb = $specBox[0]
    $sbL = [int]$sb.GetAttribute("left"); $sbT = [int]$sb.GetAttribute("top")
    $sbW = [int]$sb.GetAttribute("width"); $sbH = [int]$sb.GetAttribute("height")
    $sRows = @($sb.SelectNodes("layout[SpecialityRow]"))
    $sTops = @($sRows | ForEach-Object { [int]$_.GetAttribute("top") } | Sort-Object)
    $sPitchBad = 0
    for ($i = 1; $i -lt $sTops.Count; $i++) { if (($sTops[$i] - $sTops[$i - 1]) -ne 30) { $sPitchBad++ } }
    if ($sbL -ne 890 -or $sbT -ne 510 -or $sbW -ne 320 -or $sbH -ne 300) { Fail "V146 SPECIALTIES sits at $sbL,$sbT ${sbW}x${sbH} - SPEC I14 puts it at 890,510 320x300" }
    elseif (($sbT + $sbH) -ne 810) { Fail "V146 SPECIALTIES closes at $($sbT + $sbH), not the 810 the rest of the tab lines up on" }
    elseif ($sRows.Count -ne $spRows) { Fail "V146 SPECIALTIES draws $($sRows.Count) row(s) with SPECIALITY_ROWS at $spRows" }
    elseif ($sTops[0] -ne 25) { Fail "V146 the first speciality row starts at $($sTops[0]), not under the title at 25" }
    elseif ($sPitchBad -gt 0) { Fail "V146 $sPitchBad speciality row(s) break the pitch of 30 - the box would not hold $spRows of them" }
    elseif (($sTops[-1] + 25) -gt $sbH) { Fail "V146 the last speciality row ends at $($sTops[-1] + 25), past a box $sbH tall" }
    else { Pass "V146 SPECIALTIES fills 890..1210 x 510..810 with $($sRows.Count) rows" }
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
$mainRaw =[System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "HH.1.lfm")))
$pickBlk = [regex]::Match($mainRaw, '<template name="SpecialityRow">(.*?)</template>', 'Singleline')
if (-not $attrBlk.Success) { Fail "V148 XP_ATTRS not found on the root form" }
elseif (-not $abilBlk.Success) { Fail "V148 ABILITY_FIELD not found on the root form" }
elseif (-not $pickBlk.Success) { Fail "V148 the SpecialityRow template is not in HH.1" }
else {
    $luaNames = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
    foreach ($m in [regex]::Matches($attrBlk.Groups[1].Value, '\{"([^"]+)", "[^"]+"\}')) { [void]$luaNames.Add($m.Groups[1].Value) }
    foreach ($m in [regex]::Matches($abilBlk.Groups[1].Value, '\["([^"]+)"\]\s*=\s*"[^"]+"')) { [void]$luaNames.Add($m.Groups[1].Value) }

    $itemsAttr = [regex]::Match($pickBlk.Groups[1].Value, 'items="\{([^}]*)\}"')
    $valsAttr  = [regex]::Match($pickBlk.Groups[1].Value, 'values="\{([^}]*)\}"')
    $pickItems = @([regex]::Matches($itemsAttr.Groups[1].Value, "'([^']*)'") | ForEach-Object { $_.Groups[1].Value })
    $pickVals  = @([regex]::Matches($valsAttr.Groups[1].Value, "'([^']*)'") | ForEach-Object { $_.Groups[1].Value })
    $pickSet   = @($pickItems | Where-Object { $_ -ne '' })

    $missPick = @($luaNames | Where-Object { $pickSet -notcontains $_ })
    $missLua  = @($pickSet | Where-Object { -not $luaNames.Contains($_) })
    if (-not $itemsAttr.Success -or -not $valsAttr.Success) { Fail "V148 the trait picker declares no inline items/values (SPEC V18)" }
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
    if ($f.Name -eq 'HuntersHunted.lfm') { continue }
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
    if ($f.Name -eq 'HuntersHunted.lfm') { continue }
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
$stDoc     = Doc (Join-Path $dir "HH.10.lfm")
$specBoxes = @($stDoc.SelectNodes("//checkBox[@field='stSpec3XP' or @field='stSpec4XP']"))
$specLinks = @($stDoc.SelectNodes("//dataLink[@field='stSpec3XP' or @field='stSpec4XP']"))
$specOnChg = @($specBoxes | Where-Object { $_.GetAttribute("onChange") -ne "" })
if ($specBoxes.Count -ne 2) { Fail "V155 HH.10 carries $($specBoxes.Count) speciality price box(es) - the storyteller is given two" }
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
$mainRawTxt = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "HH.1.lfm")))
$renderCalls = @([regex]::Matches($rootTxt, 'renderSpecialities\('))
$specLinks2  = @($mainDoc.SelectNodes("//dataLink[@field='xpFree']"))
if (-not $renderSpecFn) { Fail "V164 renderSpecialities not found on the root form" }
elseif ($renderSpecFn -notmatch 'xpFind\(tabRootOf\(from\), names, found\);') { Fail "V164 the renderer does not use the one control finder - form.<name> does not cross the import (SPEC V143, B9)" }
elseif ($renderCalls.Count -ne 3) { Fail "V164 renderSpecialities is called from $($renderCalls.Count - 1) place(s) on the root form - the two accepted click paths and no more" }
elseif ($specLinks2.Count -ne 1) { Fail "V164 HH.1 carries $($specLinks2.Count) xpFree links - one, so a grant made on another client locks the row here too" }
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

# ---- V6 + V7: real build, and proof the artifact actually changed -------------
# B.1: `rdk p` is PREPARE, not pack. It exits 0 without touching the .rpk.
# Exit 0 alone is not proof of a build - the artifact must change.
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
