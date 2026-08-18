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
foreach ($m in @('healthLevels','experience')) { [void]$mirrors.Add($m) }
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
foreach ($l in $linkFields) {
    if ($allFields.ContainsKey($l.Field)) { Pass "V8 dataLink '$($l.Field)' observes a real field" }
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
1..9 | ForEach-Object { $expect["background_$_"] = 5 }
# Powers tab: 10 hedge rows + 10 psychic rows, 5 dots each (SPEC V5 after T56/T57)
1..10 | ForEach-Object { $expect["numina_$_"] = 5; $expect["psychic_$_"] = 5 }

foreach ($k in ($expect.Keys | Sort-Object)) {
    $got = DotCount $k
    if ($got -eq $expect[$k]) { Pass "V5 $k = $got dots" } else { Fail "V5 $k = $got dots, expected $($expect[$k])" }
}
$wb = BoxCount 'willpower'
if ($wb -eq 10) { Pass "V5 willpower = 10 boxes" } else { Fail "V5 willpower = $wb boxes, expected 10" }

# Each numina table is 8 pickers + 2 free rows (SPEC T56/T57); backgrounds are 9 (T78, then
# the 7th, then _8 and _9 in the 4th round).
foreach ($grp in @(@('numina',10), @('psychic',10), @('background',9), @('health',10))) {
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
foreach ($orphan in @('transportation','other','bruised','hurt','injured','wounded','mauled','crippled','incapacitated','personalidade','natureza')) {
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
    if ($l.Name -like '*cboSheetTheme*') { Pass "V15 $($l.Name) n/a - state combo with a default (declared exception)" }
    elseif ($l.Items[0] -eq '') { Pass "V15 $($l.Name) starts empty" } else { Fail "V15 $($l.Name) first entry is '$($l.Items[0])', expected empty" }
}

# The three checks above are only worth as much as what the collector saw: a picker named
# without the `cbo` prefix, or one that lost its inline `items=`, drops out of $listReport
# and every check on it becomes a silent no-op (SPEC V20 / B.7). Name the new ones.
foreach ($must in @('HH.6.lfm/cboGame','HH.7.lfm/cboFaith','HH.6.lfm/cboSheetTheme')) {
    if ($listReport | Where-Object { $_.Name -eq $must }) { Pass "V14/V15/V17 $must reaches the list checks" }
    else { Fail "V14/V15/V17 $must was never collected - its list is unchecked" }
}

# cboGame is a closed roster, not an open vocabulary: assert the count so a dropped or
# duplicated entry fails instead of passing as "no duplicates, starts empty" (SPEC T90).
$gameList = @($listReport | Where-Object { $_.Name -eq 'HH.6.lfm/cboGame' })
if ($gameList.Count -eq 1) {
    $nGames = $gameList[0].Items.Count - 1      # minus the leading empty entry
    if ($nGames -eq 5) { Pass "V14 cboGame offers 5 games" }
    else { Fail "V14 cboGame offers $nGames games, expected 5" }
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
if ($root -match 'markIndex\(mark\)\s*==\s*1' -and $root -match 'sheet\["health_"\s*\.\.\s*i\]\s*=\s*HEALTH_MARKS\[1\]') {
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


# ---- V69: the Main bottom row closes on one line (SPEC V69, T193) -----------------
# V40 only asks that two boxes never overlap, so growing VIRTUES and shrinking the
# HUMANITY/WILLPOWER box under it by the wrong amount would leave the middle column
# ending short of BACKGROUNDS and still pass green - the 18th round moves both, and this
# is what keeps the two columns closing together.
# HEALTH is out of it on purpose: its declared height is the ten-row case (816) and the
# renderer shrinks it to the chosen track (V49), an exception taken in the 11th round.
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
if (-not ($mainBottom.ContainsKey("HUMANITY") -and $mainBottom.ContainsKey("BACKGROUNDS"))) {
    Fail "V69 HUMANITY or BACKGROUNDS not found on HH.1 - the check measured nothing (SPEC V20)"
} elseif ($mainBottom["HUMANITY"] -ne $mainBottom["BACKGROUNDS"]) {
    Fail "V69 the HUMANITY/WILLPOWER box ends at y=$($mainBottom['HUMANITY']) but BACKGROUNDS ends at y=$($mainBottom['BACKGROUNDS']) - the Main bottom row must close on one line"
} else {
    Pass "V69 Main bottom row closes together on y=$($mainBottom['BACKGROUNDS'])"
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
if ($paperTabs -contains 'HH.6.lfm') { Fail "V56 the Settings tab has a backdrop - a covered theme combo cannot be switched back" }
elseif ($paperTabs.Count -ne 8) { Fail "V56 found $($paperTabs.Count) backdrops, expected 8 (every tab but Settings)" }
else { Pass "V56 all 8 content tabs carry a hidden, click-through backdrop; Settings has none" }

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
if ($hh6 -notmatch 'c\.field = full;') { Fail "V76 the renderer never rebinds a dot - the slots would keep the authored field" }
elseif ($hh6 -notmatch 'c\.checked = sheet\[full\] == true;') { Fail "V76 the renderer rebinds without reloading checked - the dot would show the old field's state" }
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
