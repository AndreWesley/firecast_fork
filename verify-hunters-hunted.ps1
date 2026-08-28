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

# clanFamily stopped being an alias in the 107th round. Clan and family are two authored
# lists now and the ghoul dropdown offers their UNION, built once in the constructor
# (SPEC I29b, T510). Mirror it here exactly the way the aliases are mirrored above, so every
# check downstream measures the list the dropdown really shows and not the clan list alone.
$UNION_REGION = [regex]::Match($rootLfmTxt, '(?s)>>> CLANFAMILY_UNION_BEGIN(.*?)<<< CLANFAMILY_UNION_END')
if ($UNION_REGION.Success -and $PICKER.ContainsKey('clan') -and $PICKER.ContainsKey('family')) {
    $PICKER['clanFamily'] = @(@($PICKER['clan']) + @($PICKER['family']))
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
    # runtime strings built in Lua go through the t() helper. The lookbehind is the whole
    # point (SPEC V222, B60): without it the pattern matches the trailing `t` of any other
    # call - string.format("%.1f") read as t("%.1f") - and a format verb is demanded of the
    # .lang file as if it were prose. One-argument calls only were affected, because the
    # closing quote has to touch the paren; format("#%08X", v) escaped on its comma alone,
    # which is luck and not a rule.
    [regex]::Matches($raw, '(?<!\w)t\("([^"]+)"\)') | ForEach-Object { [void]$visible.Add($_.Groups[1].Value) }
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
# The ruler knows the FONT SIZE since the 114th round (SPEC I86f, V312, R116). It is one
# constant per size and not one per control: a ruler picked by NAME would be a nominal
# exception, which is B38 arriving through the width door, while the physics is the same for
# every control that authors the same size.
#
# 6.0 for fontSize="12", and it is still a CEILING. R116 is what earned it: on the running
# sheet the [pt] item `Sociedade de Ideologias Altruistas Esclarecidas (SEAI)` leaves over a
# centimetre of slack inside a 362px interior, so 55 characters render at 5.89px or less. 6.0
# stays above that. Dropping it further without a NEW measurement trades a ceiling for a guess,
# and what waits on the other side is a comboBox that CLIPS rather than wraps (SPEC V196, B43).
$PX_PER_CHAR    = 6.5
$PX_PER_CHAR_12 = 6.0
function NeededPx($txt, $fontSize) {
    $longest = $txt.Length
    if ($ptVal.ContainsKey($txt) -and $ptVal[$txt].Length -gt $longest) { $longest = $ptVal[$txt].Length }
    # Callers that measure a plain label pass nothing and get the default body ruler, which is
    # the calibration this check has always run on (SPEC V312a).
    $ruler = if ("$fontSize" -eq '12') { $PX_PER_CHAR_12 } else { $PX_PER_CHAR }
    [math]::Ceiling($longest * $ruler)
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
#
# The ruler is SYMMETRY, not left=0 (103rd round, SPEC T618). Until I73 the title spanned the
# whole box, so "left=0 and width=box" was the cheapest way to say centred - but with a 20px
# margin on all four sides the title CANNOT start at 0 without breaking V280a, and left=20 in
# a 340px box with width=300 is dead centre. Measuring the two margins against each other says
# what the check was always for and stops being a literal the next margin change has to edit -
# the same move T618 made on the 1270 ruler of V262c/V267a.
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
            $rt = $bw - $lf - $w
            if ($lf -ne $rt) { $offCentre += "$($f.Name): '$($lb.GetAttribute('text'))' leaves $lf on the left and $rt on the right in a ${bw}px box - a centred title has to sit on equal margins (SPEC V27, I73)" }
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
#
# EMENDED in the 117th round and NOT renumbered (SPEC I89e): what this measures is the AUTHORED
# corner - the floor every era without a `boxCorner` falls back to - and no longer what is on
# SCREEN, because Modern Nights rewrites the corner at runtime (SPEC I89a). What it buys is
# still real: a box copied from an older file lands among its siblings with a different corner
# and reddens here. What it no longer promises is ONE corner across the four eras.
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
    Pass "V68 all $boxSeen section boxes AUTHOR cornerType='$($p[0])' radius $($p[1])/$($p[2]) - the floor every era without a boxCorner falls back to - and the one strip floor is cut out by construction"
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
# shrinks it to the chosen track (V49), so it does not close on the line - a corner taken in
# the 11th round, and measured here rather than skipped.
#
# The exception changed SIDES in the 112th round and the sign is the whole record of it: it
# hung BELOW the line from the 11th round until then, and the 30px the tail lost (SPEC I82b,
# HEALTH_BOX_PAD 79 -> 49) put it ABOVE. Two rounds move this literal for two different
# reasons - T682 raised the line to 852 and T683 shortened the box to 823 - so a pass that
# leaves it stale fails here rather than somewhere quieter (SPEC V69, V49).
$HEALTH_TEN_ROW_OVERHANG = -29
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
    elseif (($mainBottom["HEALTH"] - $line) -ne $HEALTH_TEN_ROW_OVERHANG) { Fail "V69 HEALTH sits $($mainBottom['HEALTH'] - $line)px off the line, not the $HEALTH_TEN_ROW_OVERHANG px the ten-row case is allowed (SPEC V49)" }
    else { Pass "V69 HUMANITY, SPECIALTIES and the avatar all close on y=$line; HEALTH sits the declared $HEALTH_TEN_ROW_OVERHANG px off it at ten rows" }
}

# ---- V309: the avatar FRAME tracks the avatar IMAGE (SPEC I82d, V309, B71) ------------
# Four numbers, both sides read from the XML - a RELATION, so there is no literal here to go
# stale at the next tightening of the gap.
#
# B71 is why it exists. The frame is a loose <rectangle>, not a section box: V280/V298 collect
# layout[rectangle[@color='black'][@xradius]] and this one is DimGray with no parent layout, so
# the collector never saw it; V69 measures the IMAGE's bottom; V48 names it as a deliberate
# non-black rectangle and stops there. Three families of check walked past the same control,
# and three rounds of reflow (T647, T668, T675) moved the image from 471 down to 441 while the
# frame stayed put - thirty pixels of grey hanging below the photo, on screen, green in the gate
# the whole time. Zero owners for one relation: nothing would ever have reddened on its own.
# THREE controls since the 113th round (SPEC I84d): the DimGray frame underneath, the picture,
# and the transparent carrier above that the filigree hangs on. All three share the picture's
# four numbers - the carrier has to sit exactly over the photo or the ornament draws off it.
$frameV309 = @($mainDocV69.SelectNodes("//scrollBox/rectangle[@color='DimGray']"))[0]
$ornCarrier = @($mainDocV69.SelectNodes("//scrollBox/rectangle[@name='ornAvatar']"))[0]
if ($null -eq $avatarImg)    { Fail "V309 the avatar image is gone from WoD20.1 - there is nothing to track the frame against (SPEC V209)" }
elseif ($null -eq $frameV309) { Fail "V309 the avatar frame is gone from WoD20.1 - a check that goes quiet when its only target disappears is B7 waiting (SPEC V209, B71)" }
elseif ($null -eq $ornCarrier) { Fail "V309 the avatar ornament carrier (ornAvatar) is gone from WoD20.1 - the filigree would fall back behind the picture, which is B71's symptom by another door (SPEC V209, I84d)" }
else {
    $offV309 = @()
    foreach ($pair in @(@($frameV309, 'frame'), @($ornCarrier, 'carrier'))) {
        foreach ($a in @("left", "top", "width", "height")) {
            $fv = $pair[0].GetAttribute($a); $iv = $avatarImg.GetAttribute($a)
            if ($fv -ne $iv) { $offV309 += "$a is $fv on the $($pair[1]) and $iv on the image" }
        }
    }
    # The carrier must be declared AFTER the image, or its path draws underneath and the whole
    # point of I84d is lost - silently, because the filigree still exists and still paints.
    $kidsV309 = @($ornCarrier.ParentNode.ChildNodes | Where-Object { $_.NodeType -eq 'Element' })
    $iImg = [array]::IndexOf($kidsV309, $avatarImg)
    $iOrn = [array]::IndexOf($kidsV309, $ornCarrier)
    if ($iOrn -lt $iImg) { $offV309 += "the carrier is declared before the image, so its filigree draws behind the photo (SPEC I84d)" }
    if ($offV309.Count -gt 0) { Fail "V309 the avatar frame/carrier has drifted off the picture - $($offV309 -join '; ') (SPEC I82d, I84d, B71)" }
    else { Pass "V309 the avatar frame and the ornament carrier both carry the picture's own left/top/width/height, and the carrier is declared above it" }
}

# ---- V311: the health box's tail equals the title's margin (SPEC I84c, V311) ----------
# The user's rule, not a number: the gap under the last VISIBLE health row reads the same as the
# gap from the top edge down to the word HEALTH. Three values, all from the XML - box height, the
# bottom of the last row, and the title's top - so HEALTH_BOX_PAD is a CONSEQUENCE and no id here
# writes 57 down. V49 chains it to the Lua (height = 10*pitch + pad), so the two together pin the
# constant without either of them owning a literal.
#
# That is the difference from B72, which cost a build: there the number was asserted without being
# measured. Here there is no number to assert.
#
# V280a survives and is not duplicated - it demands >= 20 on all four sides of every box; this
# demands EQUALITY between two sides of one box. The probe separates them: move the title to
# top=30 and V280a stays green while this reddens.
$v311Bad = @()
$v311Seen = 0
foreach ($pair in @(@("WoD20.1.lfm", "dynHealth_"), @("WoD20.3.lfm", "dynHealth3_"))) {
    $d311 = Doc (Join-Path $dir $pair[0])
    $box311 = $d311.SelectSingleNode("//layout[@name='$($pair[1])box']")
    if ($null -eq $box311) { $v311Bad += "$($pair[0]) has no <layout name='$($pair[1])box'> - there is no box to measure (SPEC V209)"; continue }
    $rows311 = @($box311.SelectNodes("layout[starts-with(@name,'$($pair[1])row')]"))
    $ttl311  = $box311.SelectSingleNode("label[@horzTextAlign='center']")
    if ($rows311.Count -eq 0) { $v311Bad += "$($pair[0]) health box holds no row - a box with nothing in it has no tail to read (SPEC V209)"; continue }
    if ($null -eq $ttl311)    { $v311Bad += "$($pair[0]) health box has no centred title - the ruler this leg measures against is gone (SPEC V209)"; continue }
    $v311Seen++
    $last311 = ($rows311 | Sort-Object { [int]$_.GetAttribute("top") })[-1]
    $tail311 = [int]$box311.GetAttribute("height") - ([int]$last311.GetAttribute("top") + [int]$last311.GetAttribute("height"))
    $head311 = [int]$ttl311.GetAttribute("top")
    if ($tail311 -ne $head311) {
        $v311Bad += "$($pair[0]) leaves $tail311 under the last health row but $head311 above the title - the two margins are one rule (SPEC I84c)"
    }
}
if ($v311Seen -ne 2) { Fail "V311 measured $v311Seen health box(es), expected 2 - both tabs carry one and a check that reads half the sheet is B7 waiting (SPEC V209)" }
elseif ($v311Bad) { foreach ($b in $v311Bad) { Fail "V311 $b" } }
else { Pass "V311 both health boxes close the same distance under the last row as they open above the title - HEALTH_BOX_PAD follows from it" }
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

    # The height has to DERIVE from the pitch, and that is not the same as being written on one
    # line with it. B62's fix hands the measurement to the filigree as well as to the box, so it
    # is computed into a local first - one source of truth for two readers. Anchoring on the
    # one-liner would have forced the expression to be written twice, which is the second truth
    # this check exists to prevent. So: find what is assigned to `.height`, and accept it if the
    # RHS carries the pitch itself OR names a local that was assigned from it (SPEC V222).
    $hAsg = [regex]::Match($rendFn, '(?m)\.height\s*=\s*([^;\r\n]+);')
    $pitchOk = $false
    if ($hAsg.Success) {
        $rhs = $hAsg.Groups[1].Value
        if ($rhs -match 'HEALTH_ROW_PITCH') { $pitchOk = $true }
        elseif ($rhs -match '^\s*(\w+)\s*$') {
            $ln = [regex]::Escape($Matches[1])
            if ($rendFn -match ('(?m)^\s*local\s+' + $ln + '\s*=[^;\r\n]*HEALTH_ROW_PITCH')) { $pitchOk = $true }
        }
    }

    if (-not $hAsg.Success) { Fail "V49 renderHealthTrack never writes the box height - the box would stay ten rows tall" }
    elseif (-not $pitchOk) { Fail "V49 renderHealthTrack sets the box height from something other than HEALTH_ROW_PITCH - the box would not end under the last row" }
    elseif ($rendFn -notmatch 'healthLevels') { Fail "V49 renderHealthTrack does not read healthLevels for the height" }
    else { Pass "V49 the renderer sizes the box from the chosen track length" }
}

# ---- V12: combo items are values - items must agree with the Lua comparison ---
# The theme combo was removed on 2026-08-17. Absent is fine; present-but-inconsistent is not.
$hh6 = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "WoD20.6.lfm")))

# The radii and corner types a PALETTE can put on a section box at RUNTIME (SPEC I89a, V316).
# Read ONCE, here, because three checks downstream need the same fact: V258 measures the corner
# bite against the LARGEST radius any era can render, V66 fences the write that produces it, and
# V316 owns the key itself. Anchored at line start so a comment mentioning boxCorner never
# counts as a declaration.
$boxCornerDecl  = @([regex]::Matches($hh6, '(?m)^\s*boxCorner\s*=\s*\{\s*type\s*=\s*"([^"]*)"\s*,\s*radius\s*=\s*([0-9.]+)\s*\}\s*,'))
$boxCornerRadii = @($boxCornerDecl | ForEach-Object { [double]$_.Groups[2].Value })
$boxCornerTypes = @($boxCornerDecl | ForEach-Object { $_.Groups[1].Value })
$boxCornerAny   = @([regex]::Matches($hh6, '(?m)^\s*boxCorner\s*=')).Count
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
        # The control's OWN fontSize picks the ruler (SPEC V312a): fourteen of the sheet's
        # twenty-one pickers author 12, and measuring them against the body ruler was charging
        # them for glyphs they do not draw (SPEC R116).
        $cbSize = $cb.GetAttribute("fontSize")
        foreach ($it in $shown) { $n = NeededPx $it $cbSize; if ($n -gt $need) { $need = $n; $worst = $it } }
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

    # V66: REVOKED in the letter by the 117th round (SPEC I89d, V316). applyTheme DOES write the
    # corner now - that is the whole of the coffin bevel - but only where sectionBox says yes.
    # What this invariant was BUYING is still bought and merely changed owner: a theme-wide
    # radius must never reach the three rectangles that carry a radius of their own (the health
    # mark box at 2, the avatar frame at 5), and a palette key `corner` = 0 flattening the lot is
    # still forbidden outright. The guard stops being "the write does not exist" and becomes "the
    # write is FENCED", which is a thing this gate can still count.
    #
    # The fence is measured by SUBTRACTION: cut the sectionBox block out of applyTheme and demand
    # that nothing left over mentions a corner property. Asking only that the fence EXISTS would
    # pass a version that also wrote the radius on the way past every pill.
    #
    # The comment strip is inline because NoComments is declared further down this file than this
    # check runs.
    $body66  = [regex]::Replace($body, '(?m)^\s*--.*$', '')
    $fence66 = '(?ms)^(\t+)if sectionBox\(c, fill\) then\r?\n.*?^\1end;'
    if ($themesBlock -match '(?m)^\s+corner\s*=') { Fail "V66 a palette declares ``corner`` again - a theme-wide radius flattens the boxes that set their own" }
    elseif ($body66 -notmatch '"(xradius|yradius|cornerType)"') { Fail "V66 applyTheme writes no corner at all - the bevel of I89 reaches not one box, and every leg of V316 below is measuring a feature that is not there (SPEC V209)" }
    elseif ($body66 -notmatch $fence66) { Fail "V66 the corner write is not fenced by sectionBox - unfenced this branch runs on EVERY rectangle the sheet has and bevels the 19 tab pills, whose width is priced for the concave arc (SPEC V228, V316d)" }
    else {
        $outside66 = [regex]::Replace($body66, $fence66, '')
        if ($outside66 -match '"(xradius|yradius|cornerType)"') { Fail "V66 applyTheme touches a corner property OUTSIDE the sectionBox fence - that reaches the pills, the mark boxes and the avatar frame, which is exactly what this invariant has bought since the 16th round" }
        else { Pass "V66 no palette declares ``corner``, and every corner write applyTheme makes is fenced inside sectionBox" }
    }

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
    # V57 AMENDED in the 123rd round (SPEC B79, I98a, V327b). Geometry stays FORBIDDEN and the
    # reason is unchanged - V37/V40/V49 measure the static XML, so anything the theme resizes is
    # invisible to them. What changed is that there is now ONE declared exception: the height of
    # the eleven tabStrip labels, which the Classical palette writes through tabLabelHeight so the
    # word can sit in the middle of its button (SPEC I98).
    #
    # The exception is CUT OUT of the body before the count and then measured on its own terms
    # below. Cutting rather than loosening the pattern is the point: a second `height` write
    # anywhere else in applyTheme still turns this red, which is exactly what V57 was buying.
    $tabHRe = 'local lp = c\.parent;[\s\S]*?paint\(c, "height", t\.tabLabelHeight or ah, ah\);'
    $tabH   = [regex]::Match($body, $tabHRe)
    $bodyGeo = if ($tabH.Success) { $body.Remove($tabH.Index, $tabH.Length) } else { $body }

    $geo = [regex]::Matches($bodyGeo, '"(left|top|width|height)"|\.(left|top|width|height)\s*=')
    if ($geo.Count -gt 0) { Fail "V57 applyTheme writes geometry ($($geo.Count) hit(s)) outside the one declared exception - V37/V40/V49 only measure the static XML (SPEC V57, B79)" }
    else { Pass "V57 applyTheme writes no geometry beyond the declared tabStrip label height" }

    # ---- V327: the era writes the top bar's label height, and the column lets go of the word --
    # SPEC I98, V327. Four legs, and the first one is the WAY BACK OUT - the same shape V316c
    # cobbled for the corner, on a second target.
    if (-not $tabH.Success) {
        Fail "V327b the tabStrip label-height write is missing or not in the declared shape - without `t.tabLabelHeight or ah` the eleven labels stay at 30 forever once the Classical era has been on, with rdk -l exiting 0 and this gate green (SPEC V327b, B58, B62)"
    } else {
        Pass "V327b the label-height write carries the authored value as its way back out"
    }

    # (a) exactly ONE palette declares the key. A second is a shape nobody asked for in an era
    # nobody asked, and the symptom shows up one era away from whoever caused it (family B6).
    $tlh = [regex]::Matches($hh6, 'tabLabelHeight\s*=\s*\d+')
    if ($tlh.Count -ne 1) { Fail "V327a $($tlh.Count) palette(s) declare tabLabelHeight, expected exactly 1 (SPEC V327a)" }
    else { Pass "V327a exactly 1 palette declares tabLabelHeight" }

    # (c) the selector is the GRANDPARENT and it reaches the eleven - not ten, not twelve - and
    # reaches none of the eight sub-bar labels, which are authored 30 already (V122).
    # Read OUTSIDE the branch: leg (d) measures against the same strip, and a $stripDoc that only
    # exists on the happy path made the (c) mutation throw instead of failing - a check that dies
    # is not a check that says no (SPEC V20, V209).
    $stripDoc = (Doc (Join-Path $dir "WoD20th.lfm")).SelectSingleNode("//layout[@name='tabStrip']")
    $topLbl   = if ($null -eq $stripDoc) { 0 } else { $stripDoc.SelectNodes("rectangle[@onClick]/label").Count }

    if ($body -notmatch 'lp\.parent\.name == "tabStrip"') {
        Fail "V327c the label-height write is not fenced by the tabStrip grandparent - unfenced it would resize labels that are not the top bar's (SPEC V327c)"
    } elseif ($topLbl -ne 11) {
        Fail "V327c the tabStrip carries $topLbl label(s) under a clickable button, expected 11 - the selector is covering less than the bar has (SPEC V209)"
    } else {
        Pass "V327c the grandparent selector reaches the 11 top-bar labels and none of the 8 sub-tab ones"
    }

    # (d) ORN_COL_EDGE exists inside markCoronaMuralis, and the GAP it buys on the NARROWEST
    # button is measured with the gate's own estimator - a floor with two owners is B69.
    $edgeM = [regex]::Match($hh6, 'local ORN_COL_EDGE\s*=\s*([\d.]+)')
    $wM    = [regex]::Match($hh6, 'local ORN_COL_W\s*=\s*([\d.]+)')
    if (-not $edgeM.Success -or -not $wM.Success -or $null -eq $stripDoc) {
        Fail "V327d ORN_COL_EDGE, ORN_COL_W or the tabStrip itself is missing - there is no column position left to measure (SPEC V209, V327d)"
    } else {
        $edge = [double]$edgeM.Groups[1].Value
        $colW = [double]$wM.Groups[1].Value
        $capEnd = $edge + $colW                      # where the capital closes, in from the rim
        $worst = $null
        foreach ($n in $stripDoc.SelectNodes("rectangle[@onClick]")) {
            $l = $n.SelectSingleNode("label[@text]"); if ($null -eq $l) { continue }
            $bw = 0; [void][int]::TryParse($n.GetAttribute("width"), [ref]$bw)
            $gap = ($bw - (NeededPx $l.GetAttribute("text"))) / 2 - $capEnd
            if ($null -eq $worst -or $gap -lt $worst) { $worst = $gap }
        }
        $GAP_FLOOR = 4
        if ($worst -lt $GAP_FLOOR) { Fail "V327d the narrowest tab leaves ${worst}px between the column and the word, under the $GAP_FLOOR floor - that is the crowding the user named (SPEC I98b, V327d)" }
        else { Pass "V327d the column clears the word on every tab - worst gap $worst px (capital closes at $capEnd) against a floor of $GAP_FLOOR" }
    }

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
    elseif (([int]$edit.GetAttribute("top") + [int]$edit.GetAttribute("height")) -ne ($dEnd - $dTop - 20)) {
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
    # Where the first row opens is DERIVED from the title, not typed (103rd round, SPEC T618):
    # the hairline under the title band. It read 31 while the margin was 10 and reads 41 under
    # I73, and a literal here is the third one this check has had to hand-edit.
    $sTtl  = $sb.SelectSingleNode("label[@text='SPECIALTIES']")
    $sBody = if ($null -ne $sTtl) { [int]$sTtl.GetAttribute("top") + [int]$sTtl.GetAttribute("height") + 1 } else { -1 }
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
    elseif ($sBody -lt 0) { Fail "V146 the SPECIALTIES box carries no title - the row that opens under it would be measured against nothing (SPEC V209)" }
    elseif ($sTops[0] -ne $sBody) { Fail "V146 the first speciality row starts at $($sTops[0]), not on the hairline under the title at $sBody - the row opens where the title band ends, whatever margin I73 gives it (SPEC I40, I73, V240)" }
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
    # The row spans what the 20px margin I73 gives every box leaves - it read colW - 30 while
    # the inset was 15 (103rd round, SPEC T618). The leg itself is unchanged: the width a column
    # gains has to arrive as NAME, and a row that stands still while its box grows turns it into
    # air between the last dot and the border, which is what V170 was written to stop.
    $colInner = $colW[0] - 40
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

    # The FOURTH argument is the hedge path map and it is named here on purpose (SPEC I83f,
    # V310e): dropping it costs nothing a reader would notice - the ritual filter simply stops
    # pruning, rdk exits 0 and every other check stays green.
    if ($pk -notmatch 'pickAllowed\(field, raw, levels, memo\.hedge\)') {
        $filterBad += "V199 pickerItems does not ask pickAllowed with the level map AND the hedge path map - whatever drops an item now, it is not the one rule (SPEC V199, I83f)"
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
        if ($w.Groups[2].Value -match '^PICKER_LIST\["\w+"\];') { continue }
        # One write is not an alias and is still legal: the clan+family union, assembled into
        # a LOCAL inside its marked region and handed over whole (SPEC I29b, V294). It is as
        # constant as the two lists behind it - born in the constructor, never written again -
        # and it is accepted only from INSIDE the markers, so a stray assignment anywhere else
        # still fails right here.
        if ($w.Groups[1].Value -eq 'clanFamily' -and $UNION_REGION.Success -and
            $UNION_REGION.Groups[1].Value -match [regex]::Escape($w.Value.Trim())) { continue }
        $filterBad += "V201 PICKER_LIST[$($w.Groups[1].Value)] is assigned something that is not an alias - the map is authored once and never written (SPEC V201)"
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
    # `hedgeRitual` joined the three in the 112th round (SPEC I83g, V310f). It belongs HERE and
    # not in FILTER_NAME: all twelve picked ritual rows answer to one question, unlike the numina
    # box where only the first row is the Affinity Path. The list stays closed either way - the
    # extra-name arm below is what stops a Discipline picker being filtered by what the player
    # already owns, which would leave a new sheet with nineteen empty combos.
    $wantFilter = @('mainPath', 'secPath', 'ritual', 'hedgeRitual')
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
    # Anchored on the CONSTRUCTION and never on the identifiers (SPEC V222, B60), the same
    # cure V275 already carries: whatever indexes memo.lists IS the key, and whatever the read
    # assigns IS the hit, under any name. Renaming either local is invisible here - that is the
    # neighbour probe - while dropping the read, the store, or the miss gate still goes red.
    # The old form spelled `key` and `hit` into the pattern, so a rename that changed no
    # behaviour at all turned this check red (found by the T611 probe, 96th round).
    $idx205 = [regex]::Match($pkm, 'memo\.lists\[\s*(\w+)\s*\]')
    $rd205 = [regex]::Match($pkm, '(?m)^\s*local\s+(\w+)\s*=\s*memo\.lists\[\s*\w+\s*\];')
    $read205 = $idx205.Success -and $rd205.Success
    $store205 = $false
    if ($read205) {
        $k205 = [regex]::Escape($idx205.Groups[1].Value)
        $h205 = [regex]::Escape($rd205.Groups[1].Value)
        $store205 = ($pkm -match "memo\.lists\[\s*$k205\s*\]\s*=\s*\{ kept = kept, shown = shown \};") -and ($pkm -match "if\s+$h205\s+== nil then")
    }
    if (-not $read205) {
        $filterBad += "V205 pickerItems never READS the memo - the same list is rebuilt once per control, and the ritual rows alone pay that 25 times a pass (SPEC T491, B48)"
    }
    elseif (-not $store205) {
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
    elseif ($pkm -notmatch 'not pickAllowed\(field, current, levels, memo\.hedge\)' -or $pkm -notmatch '\.\. "\|" \.\. odd') {
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
    # Since T510 the field holds a clan OR a revenant family, so the set CLANS has to answer
    # is BOTH lists, never the clan list alone (SPEC I29b, V294).
    $clanPick = @(@($PICKER['clan']) + @($PICKER['family']) | Where-Object { $_ -ne '' })
    if ($clanKeys.Count -eq 0) { $v212Bad += "CLANS parsed to zero clans - the check verifies nothing (SPEC V20, B7)" }
    elseif ($clanPick.Count -eq 0) { $v212Bad += "PICKER_LIST['clan'] is empty - there is nothing to compare CLANS against" }
    else {
        foreach ($c in $clanPick) { if ($clanKeys -notcontains $c) { $v212Bad += "'$c' is offered by the picker and absent from CLANS" } }
        foreach ($c in $clanKeys) { if ($clanPick -notcontains $c) { $v212Bad += "'$c' is keyed in CLANS and the picker does not offer it" } }
    }
}
if ($v212Bad) { foreach ($b in $v212Bad) { Fail "V212 $b" } }
else { Pass "V212 the picker and CLANS name the same $(@(@($PICKER['clan']) + @($PICKER['family']) | Where-Object { $_ -ne '' }).Count) clans and families" }

# ---- V294: the family dropdown is an exact UNION, not a third authored list ------------
# clanFamily stopped being an alias when clan and family became two lists (SPEC I29b): the
# clan picker is going to be shown somewhere else without the families, and only this
# dropdown wants both. A union is the kind of thing that rots quietly - a name reaching the
# dropdown without standing in either source has no CLANS entry, is invisible to V212, and
# lights up nothing at all when the player picks it.
$v294Bad = @()
$famList = @()
if ($PICKER.ContainsKey('family')) { $famList = @($PICKER['family']) }
if (-not $UNION_REGION.Success) {
    $v294Bad += "the CLANFAMILY_UNION markers are gone from the root form - the union is unreadable and every leg below verifies nothing (SPEC V20, B7)"
} elseif ($famList.Count -eq 0) {
    $v294Bad += "PICKER_LIST['family'] is not declared - the ghoul dropdown would offer the clan list alone (SPEC I29b)"
} else {
    $uClan = @($PICKER['clan'])
    # (a) the union really walks BOTH lists. This has to read the SOURCE, not the mirror the
    # parser builds: the mirror is clan+family by construction, so comparing it against
    # clan+family would be a check that cannot fail - B7 in a new costume. What can rot is the
    # code, so the code is what gets measured: one loop per authored list, both copying into
    # the same local, and that local handed to the map.
    $uSrc = $UNION_REGION.Groups[1].Value
    $uLocal = ''
    if ($uSrc -match 'PICKER_LIST\["clanFamily"\]\s*=\s*(\w+);') { $uLocal = $Matches[1] }
    if (-not $uLocal) {
        $v294Bad += "nothing inside the markers is handed to PICKER_LIST['clanFamily'] - the dropdown would resolve to nothing at all (SPEC V294a, B6)"
    } else {
        foreach ($src in @('clan', 'family')) {
            if ($uSrc -notmatch ('#PICKER_LIST\["' + $src + '"\]')) {
                $v294Bad += "the union never walks PICKER_LIST['$src'] - the dropdown would offer only what the other loop copies (SPEC V294a)"
            }
            if ($uSrc -notmatch ([regex]::Escape($uLocal) + '\[[^\]\r\n]*\]\s*=\s*PICKER_LIST\["' + $src + '"\]')) {
                $v294Bad += "PICKER_LIST['$src'] is walked but never copied into $uLocal - the entries counted are not the entries offered (SPEC V294a)"
            }
        }
    }
    # (b) the two lists are disjoint
    $clanSet = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
    foreach ($x in $uClan) { if ($x -ne '') { [void]$clanSet.Add($x) } }
    foreach ($x in $famList) {
        if ($clanSet.Contains($x)) { $v294Bad += "'$x' is authored by BOTH clan and family - the dropdown shows it twice and CLANS[sheet.clanFamily] cannot say which one was picked (SPEC V294b)" }
        if ($x -eq '') { $v294Bad += "PICKER_LIST['family'] carries an empty item - the empty one comes from clan, which leads the union (SPEC I29b)" }
    }
    # (c) neither authored list is grown, anywhere
    $rootNoC294 = NoComments $rootLfmTxt
    foreach ($k in @('clan', 'family', 'clanFamily')) {
        # WRITING is the verb, so the pattern demands the assignment: the union READS
        # PICKER_LIST["clan"][i] in its loop, and a check that could not tell the two apart
        # would fail on the very code it exists to protect.
        if ($rootNoC294 -match ('PICKER_LIST\["' + $k + '"\]\s*\[[^\]\r\n]*\]\s*=[^=]')) {
            $v294Bad += "PICKER_LIST['$k'] is indexed for writing - the authored lists are constants and the union is built into a local, which is what keeps an append off the Main tab's clan picker (SPEC V294c, V201, V211c)"
        }
    }
    # (d) every family name is translated in both languages
    foreach ($x in $famList) {
        if (-not $ptK.Contains($x)) { $v294Bad += "'$x' has no [pt] entry - the dropdown shows the raw key, and the list lives in Lua where V16 does not reach it (SPEC V294d)" }
        if (-not $enK.Contains($x)) { $v294Bad += "'$x' has no [en] entry - the dropdown shows the raw key, and the list lives in Lua where V16 does not reach it (SPEC V294d)" }
    }
}
if ($famList.Count -lt 22) { Fail "V294 PICKER_LIST['family'] parsed to $($famList.Count) entries, expected at least the 22 SPEC R93 froze - this check is covering less than the sheet has (SPEC V209)" }
elseif ($v294Bad) { foreach ($b in ($v294Bad | Select-Object -First 12)) { Fail "V294 $b" } }
else { Pass "V294 the ghoul dropdown is clan + family exactly - $($PICKER['clanFamily'].Count) entries, no overlap, no growth, all $($famList.Count) families translated in both languages" }

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
        # The caption, told the way V27 and V240 tell a title since I73 (103rd round, SPEC T618):
        # it is the CENTRED label taking most of the width, not one that spans the box edge to
        # edge. With a 20px margin on all four sides "width == box" matches nothing, and the
        # caption would be counted as a ninth cell of a grid that has eight.
        $capW = 0
        if ($c.LocalName -eq 'label' -and $c.GetAttribute("horzTextAlign") -eq 'center' -and
            [int]::TryParse($c.GetAttribute("width"), [ref]$capW) -and $capW -ge ($boxW * 0.8)) { continue }
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
        # ONE label on the top bar, TWO on a sub-tab since the 109th round: the sub-tab says its
        # state in colour as well as weight, and one label cannot carry two colours without a Lua
        # write applyTheme undoes (SPEC I78c, V57, V305). What this leg measures is that the word
        # is a <label> the theme reaches - never how many the pair needs (SPEC B67).
        $lbl = @($b.SelectNodes("label"))
        $lblWant = if ($pair[1] -eq 'tabStrip') { 1 } else { 2 }
        if ($lbl.Count -ne $lblWant) { $stripBad += "$($b.GetAttribute('name')) carries $($lbl.Count) label(s), expected $lblWant - the word is a label the theme paints on both ends, and on a sub-tab it is the pair V305 measures" }
        else {
            foreach ($l226 in $lbl) {
                if ($l226.GetAttribute("hitTest") -ne 'false') { $stripBad += "$($b.GetAttribute('name'))'s label '$($l226.GetAttribute('name'))' is hit-testable - it would eat the click meant for the rectangle" }
            }
        }
    }
}
if ($btnSeen -lt 19) { Fail "V226 only $btnSeen strip button(s) were read, expected 19 - this check is covering less than the sheet has (SPEC V209)" }
elseif ($stripBad) { foreach ($b in $stripBad) { Fail "V226 $b" } }
else { Pass "V226 all $btnSeen tab buttons are a rectangle over a label - one on the top bar, the pair of V305 on a sub-tab - the one pair the theme reaches on both ends" }

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
# The pills' half of this moved out in the 108th round. The open tab is no longer a DimGray
# lozenge - it is a foot rule the marker draws itself (SPEC I77b) - so what used to be measured
# here is measured by V301b, in the shape the marker has now. The FLOOR stays: it is the same
# rectangle, black and square, and V68 still steps aside for it. Two owners for one fact is the
# no-op V20 forbids, which is why this half left rather than being rewritten in both places.
if ($stripSkin) { foreach ($t in $stripSkin) { Fail "V229 $t" } }
else { Pass "V229 the strip floor is black and square - V301b carries the other half now, that the open tab cannot wear the floor's own colour" }
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

# ---- V231: what is LEFT - the strip band is symmetric by construction ------------
# Legs (a) and (c) were REVOKED in the 106th round (SPEC I74a, V286). The content gap the
# 82nd round asked for is now ZERO on the eleven top-level tabs, so "the strip breathes LESS
# than the content it heads" reads 15 < 0 and cannot hold; and the gap itself is no longer
# one number for fourteen forms, so it moved to V286, which measures it BY SCOPE.
#
# The band stays, and it is the half that never depended on the content: 2*gap + pill, so the
# space above the pill equals the space below by construction and neither can slide without
# the other lighting up (SPEC I73, V281). The floor rectangle is skipped for free - it carries
# no name, while all 22 pills and buttons do.
$gapBad = @()
$stripGap = -1
$pillH = -1
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
        [void][int]::TryParse($rects231[0].GetAttribute("height"), [ref]$pillH)
        if ($bandH -ne (2 * $stripGap + $pillH)) { $gapBad += "the strip band is $($bandH)px for a gap of $stripGap over a $($pillH)px pill - it must be $(2 * $stripGap + $pillH), so the space above equals the space below" }
    }
}
if ($gapBad) { foreach ($b in $gapBad) { Fail "V231 $b" } }
else { Pass "V231 the strip band is $(2 * $stripGap + $pillH)px - $stripGap above and below a $($pillH)px pill, symmetric by construction" }

# ---- V286: the top gap, BY SCOPE (SPEC I74a, user 2026-08-25) ---------------------
# Two numbers now, not one. The eleven tabs that hang off the top menu open at ZERO - the box
# meets the black band and there is no seam. The three SUB-tab forms hang off vampStrip
# instead, and they keep the 20 they had: zeroing them too would glue a sub-tab to its own
# sub-bar, which nobody asked for.
#
# The two groups are DERIVED from the root form - a tab layout is one that imports a file -
# so a tab added later falls into the right group without anyone editing a list here. Naming
# the eleven would go stale exactly once, silently, and the zero-guard is what says so.
$v286Bad = @()
$v286Top = @($(Doc $rootPath).SelectNodes("//layout[@name][import/@file]") | ForEach-Object { $_.SelectSingleNode("import").GetAttribute("file") })
if ($v286Top.Count -ne 11) {
    Fail "V286 the root form imports $($v286Top.Count) tab form(s), expected 11 - the two groups below would be split by a ruler that stopped matching (SPEC V209, I32)"
} else {
    $v286Seen = 0
    $v286Sub = 0
    foreach ($f in $files) {
        $sb = (Doc $f.FullName).SelectSingleNode("//scrollBox")
        if ($null -eq $sb) { continue }
        $tops = @()
        foreach ($c in $sb.ChildNodes) {
            if ($c.NodeType -ne 'Element') { continue }
            $tv = 0
            if ([int]::TryParse($c.GetAttribute("top"), [ref]$tv)) { $tops += $tv }
        }
        if (-not $tops.Count) { continue }
        $v286Seen++
        $min = ($tops | Measure-Object -Minimum).Minimum
        if ($v286Top -contains $f.Name) {
            # (a) top-level: EXACTLY 0, and something has to sit on the ruler. ">= 0" is true
            # of every sheet ever authored and would pass a tab that opened at 200.
            if ($min -ne 0) { $v286Bad += "$($f.Name) hangs off the top menu and opens its first box at top=$min, not 0 (SPEC I74a, V286a)" }
        } else {
            # (b) sub-tab: still 20. Their content answers to vampStrip, not to the top menu.
            $v286Sub++
            if ($min -ne 20) { $v286Bad += "$($f.Name) is a sub-tab form and opens at top=$min, not the 20 it keeps - only the eleven that hang off the top menu went to zero (SPEC I74a, V286b)" }
        }
    }
    if ($v286Seen -ne 14) { $v286Bad += "only $v286Seen content form(s) were measured, expected 14 - this leg is covering less than the sheet has (SPEC V209)" }
    if ($v286Sub -ne 3) { $v286Bad += "$v286Sub form(s) fell into the sub-tab group, expected 3 - with none there, leg (b) is a rule with nothing under it (SPEC V209)" }
    if ($v286Bad) { foreach ($b in $v286Bad) { Fail "V286 $b" } }
    else { Pass "V286 all 11 top-level forms open at top=0 and the 3 sub-tab forms keep 20" }
}

# ---- V287: the strip floor has no contour, in any era (SPEC I74b) ----------------
# applyTheme paints strokeColor and a 3px strokeSize onto every THEME_SHAPES rectangle whose
# authored colour the palette knows, and all four stroke maps key "black" - so the band was
# getting the same 3px rule the 73 section boxes wear (SPEC I5). The user asked for that rule
# gone and the fill kept.
#
# The cure is authored rather than special-cased in the Lua, and it is proof against the
# getter: what a rectangle with no authored stroke hands back cannot be settled from disk
# (SPEC R25), but with #00000000 authored, `authored()` returns THAT in either case - and it
# then either paints transparent (the key is there) or falls out of paint's no-mapped-target
# guard (SPEC V61). Invisible down both paths.
#
# The palette side is NOT re-checked here: V53 already demands every authored strokeColor be
# a key in all four stroke maps, and a second owner for one fact is the no-op V20 forbids.
# BOTH directions, though: the floor has it, and nothing else does. Without the second the
# idiom leaks onto a section box and silently kills its gold fillet.
$v287Bad = @()
$strip287 = (Doc $rootPath).SelectSingleNode("//layout[@name='tabStrip']")
if ($null -eq $strip287) { $v287Bad += "tabStrip is gone from the root form (SPEC I32)" }
else {
    $floor287 = $strip287.SelectSingleNode("rectangle[@align='client']")
    if ($null -eq $floor287) { $v287Bad += "tabStrip has no align='client' floor to measure (SPEC I33, V229)" }
    elseif ($floor287.GetAttribute("strokeColor") -ne '#00000000') {
        $v287Bad += "the strip floor authors strokeColor='$($floor287.GetAttribute('strokeColor'))' - it must author #00000000, or applyTheme hands it the 3px rule every black rectangle gets (SPEC I74b, V53)"
    }
}
$v287Others = @()
foreach ($f in $files) {
    foreach ($n287 in (Doc $f.FullName).SelectNodes("//*[@strokeColor='#00000000']")) {
        if ($f.Name -eq 'WoD20th.lfm' -and $n287.LocalName -eq 'rectangle' -and $n287.GetAttribute("align") -eq 'client' -and $n287.ParentNode.GetAttribute("name") -eq 'tabStrip') { continue }
        # 108th round: the 19 tab buttons lost their box and author the same transparent contour
        # (SPEC I77a, V301a). They are admitted by NAME, so the idiom still cannot spread to a
        # section box - which is the direction this leg exists to guard.
        if ($n287.LocalName -eq 'rectangle' -and $n287.GetAttribute("name") -like 'btnTab*') { continue }
        # 109th round: the 19 markers and the 5 separators carry a path and paint nothing of their
        # own, so they author the same transparent contour (SPEC I78a, I78d). Admitted by NAME, so
        # the second direction below still catches the idiom leaking onto a section box.
        if ($n287.LocalName -eq 'rectangle' -and ($n287.GetAttribute("name") -like 'tabOn*' -or $n287.GetAttribute("name") -like 'sep*')) { continue }
        # 113th round: the avatar's ornament carrier (SPEC I84d, V309). It is transparent in BOTH
        # senses because the photo has to show through it - it holds no content, it only gives the
        # filigree somewhere to hang above the picture. Admitted by its exact NAME, not a wildcard:
        # it is one control, and the second direction below - a section box authoring a transparent
        # contour - stays exactly as strict as it was.
        if ($n287.LocalName -eq 'rectangle' -and $n287.GetAttribute("name") -eq 'ornAvatar') { continue }
        $v287Others += "$($f.Name) <$($n287.LocalName) name='$($n287.GetAttribute('name'))'>"
    }
}
if ($v287Others.Count) {
    $v287Bad += "a transparent contour is authored outside the strip floor, the 19 buttons, the 19 markers, the 5 separators and the avatar carrier, on $($v287Others -join ', ') - the era paints a rule on every black rectangle and this idiom silently erases it (SPEC I74b, I5)"
}
if ($v287Bad) { foreach ($b in $v287Bad) { Fail "V287 $b" } }
else { Pass "V287 the strip floor, the 19 buttons, the 19 markers, the 5 separators and the avatar carrier are the only controls authoring a transparent contour, and the floor does author it" }

# ---- V288..V292: the five alignments the 106th round was asked for -----------------
# Every one of them is a RELATION between two things in the sheet, never a literal here: the
# 103rd round moved BACKGROUNDS and RESOURCES apart and no check noticed, because the only
# place that alignment was written down was a comment (SPEC V289). A literal would have gone
# stale the same way - and a relation is what makes the mutation bite from BOTH sides.
function BoxByTitle($doc, $title) {
    foreach ($b in $doc.SelectNodes("//scrollBox/layout")) {
        foreach ($lb in $b.SelectNodes("label")) {
            if ($lb.GetAttribute("text") -eq $title) { return $b }
        }
    }
    return $null
}
function BoxRect($b) {
    $l = 0; $t = 0; $w = 0; $h = 0
    [void][int]::TryParse($b.GetAttribute("left"), [ref]$l)
    [void][int]::TryParse($b.GetAttribute("top"), [ref]$t)
    [void][int]::TryParse($b.GetAttribute("width"), [ref]$w)
    [void][int]::TryParse($b.GetAttribute("height"), [ref]$h)
    return [pscustomobject]@{ L = $l; T = $t; W = $w; H = $h; R = $l + $w; B = $t + $h }
}

# ---- V288: the three ATTRIBUTES headings centre on the group they name -------------
# They were 7.5px low - all three by the same amount, since the 41st round. Nothing could see
# it: V27, V239, V240 and V280c all CUT a child carrying rotationAngle, because its authored
# box is the pre-rotation one and reading it as a margin reddens code that is right (SPEC B61).
# That cut is correct for margins and wrong to inherit here - what is useless as an edge is
# exactly what gives the CENTRE, because rotation is about the box's own middle.
$v288Bad = @()
$doc288 = Doc (Join-Path $dir "WoD20.1.lfm")
$box288 = BoxByTitle $doc288 "ATTRIBUTES"
if ($null -eq $box288) { Fail "V288 the ATTRIBUTES box was not found on WoD20.1 - this check measured nothing (SPEC V209)" }
else {
    $rot288 = @($box288.SelectNodes("label[@rotationAngle]") | ForEach-Object {
        $t = 0; $h = 0
        [void][int]::TryParse($_.GetAttribute("top"), [ref]$t)
        [void][int]::TryParse($_.GetAttribute("height"), [ref]$h)
        [pscustomobject]@{ Text = $_.GetAttribute("text"); T = $t; H = $h }
    } | Sort-Object T)
    $rows288 = @($box288.SelectNodes("layout") | ForEach-Object {
        $t = 0; $h = 0
        if ([int]::TryParse($_.GetAttribute("top"), [ref]$t) -and [int]::TryParse($_.GetAttribute("height"), [ref]$h)) {
            [pscustomobject]@{ T = $t; H = $h }
        }
    } | Sort-Object T)
    if ($rot288.Count -ne 3) { $v288Bad += "the box holds $($rot288.Count) rotated heading(s), expected 3 (SPEC V209)" }
    elseif ($rows288.Count -ne 9) { $v288Bad += "the box holds $($rows288.Count) attribute row(s), expected 9 - three groups of three (SPEC V209)" }
    else {
        for ($g = 0; $g -lt 3; $g++) {
            $first = $rows288[$g * 3]
            $last = $rows288[$g * 3 + 2]
            $groupMid = ($first.T + $last.T + $last.H) / 2
            # The extent alone is blind to the MIDDLE row: 41/70/91 centres exactly where
            # 41/66/91 does. One pitch per group is what makes that mutation bite.
            $mid = $rows288[$g * 3 + 1]
            if (($mid.T - $first.T) -ne ($last.T - $mid.T)) {
                $v288Bad += "the group under '$($rot288[$g].Text)' runs $($first.T)/$($mid.T)/$($last.T) - three rows on one pitch, or the centre it is measured against means nothing (SPEC V288)"
            }
            $labelMid = $rot288[$g].T + $rot288[$g].H / 2
            $off = [Math]::Abs($labelMid - $groupMid)
            if ($off -gt 0.5) {
                $v288Bad += "'$($rot288[$g].Text)' centres on y=$labelMid while its three rows centre on y=$groupMid - $($off)px out (SPEC V288)"
            }
        }
    }
    if ($v288Bad) { foreach ($b in $v288Bad) { Fail "V288 $b" } }
    else { Pass "V288 Physical, Social and Mental each centre on the three rows they name, within half a pixel" }
}

# ---- V289: BACKGROUNDS closes where RESOURCES closes -------------------------------
# The comment on WoD20.2 has claimed this since the 46th round and nothing enforced it, so
# the 103rd round moved both boxes and left them 67px apart with a green gate (SPEC B7).
$v289Bad = @()
$doc289 = Doc (Join-Path $dir "WoD20.2.lfm")
$bg289 = BoxByTitle $doc289 "BACKGROUNDS"
$rs289 = BoxByTitle $doc289 "RESOURCES"
if ($null -eq $bg289 -or $null -eq $rs289) { Fail "V289 BACKGROUNDS or RESOURCES was not found on WoD20.2 - this check measured nothing (SPEC V209)" }
else {
    $a = BoxRect $bg289; $b = BoxRect $rs289
    if ($a.B -ne $b.B) { Fail "V289 BACKGROUNDS closes at y=$($a.B) and RESOURCES at y=$($b.B) - the two columns of the Traits tab end on one line" }
    else { Pass "V289 BACKGROUNDS and RESOURCES both close on y=$($a.B)" }
}

# ---- V290: the Merit/Flaw tables - four columns, and the row they sit on -----------
# (a) one template serves both tables, so the column ORDER is asked of it once. Heading and
# field are checked as a PAIR: a heading that keeps its old x while the field moves is the
# failure that looks right in the XML and lies on screen.
# (b) the top row of the tab lands on the grid the bottom row already keeps.
$v290Bad = @()
$doc290 = Doc (Join-Path $dir "WoD20.2.lfm")
$tpl290 = $doc290.SelectSingleNode("//template[@name='Merit']")
if ($null -eq $tpl290) { $v290Bad += "the Merit template is gone - the two tables have no shared column order left to check (SPEC V209)" }
else {
    $cols290 = @($tpl290.SelectNodes("edit") | ForEach-Object {
        $l = 0; $w = 0
        [void][int]::TryParse($_.GetAttribute("left"), [ref]$l)
        [void][int]::TryParse($_.GetAttribute("width"), [ref]$w)
        [pscustomobject]@{ L = $l; W = $w; Root = ($_.GetAttribute("field") -replace '\$\(num\)$', '') }
    } | Sort-Object L)
    $want290 = @('merit_', 'book_', 'type_', 'costy_')
    if ($cols290.Count -ne 4) { $v290Bad += "the Merit template draws $($cols290.Count) column(s), expected 4 (SPEC V209)" }
    elseif ((($cols290 | ForEach-Object { $_.Root }) -join ',') -ne ($want290 -join ',')) {
        $v290Bad += "the columns run $((($cols290 | ForEach-Object { $_.Root }) -join ' ')) - Book goes between the name and Page (SPEC I74, V290a)"
    } else {
        for ($i = 0; $i -lt 3; $i++) {
            if (($cols290[$i].L + $cols290[$i].W) -ne $cols290[$i + 1].L) {
                $v290Bad += "column '$($cols290[$i].Root)' closes at $($cols290[$i].L + $cols290[$i].W) and '$($cols290[$i + 1].Root)' opens at $($cols290[$i + 1].L) - the four columns tile with no seam (SPEC V290a)"
            }
        }
        foreach ($tbl in @('Merit', 'Flaw')) {
            $box = BoxByTitle $doc290 $tbl
            if ($null -eq $box) { $v290Bad += "the $tbl table was not found (SPEC V209)"; continue }
            $row = @($box.SelectNodes("layout"))[0]
            if ($null -eq $row) { $v290Bad += "the $tbl table draws no rows (SPEC V209)"; continue }
            $rowL = 0; [void][int]::TryParse($row.GetAttribute("left"), [ref]$rowL)
            $heads = @($box.SelectNodes("label") | ForEach-Object {
                $l = 0; $w = 0
                [void][int]::TryParse($_.GetAttribute("left"), [ref]$l)
                [void][int]::TryParse($_.GetAttribute("width"), [ref]$w)
                [pscustomobject]@{ Text = $_.GetAttribute("text"); L = $l; W = $w }
            })
            if ($heads.Count -ne 4) { $v290Bad += "the $tbl table carries $($heads.Count) heading(s) for 4 columns (SPEC V290a)"; continue }
            foreach ($c in $cols290) {
                $over = @($heads | Where-Object { $_.L -eq ($rowL + $c.L) -and $_.W -eq $c.W })
                if ($over.Count -ne 1) {
                    $v290Bad += "in $tbl no single heading stands over column '$($c.Root)' (x=$($rowL + $c.L), $($c.W) wide) - heading and field must move together (SPEC V290a)"
                }
            }
        }
    }
}
foreach ($pair in @(@('Merit', 'MENTOR', 'R'), @('Flaw', 'FAME', 'R'), @('DERANGEMENTS', 'BASE OF OPERATIONS', 'LR'))) {
    $top = BoxByTitle $doc290 $pair[0]
    $bot = BoxByTitle $doc290 $pair[1]
    if ($null -eq $top -or $null -eq $bot) { $v290Bad += "$($pair[0]) or $($pair[1]) was not found on WoD20.2 (SPEC V209)"; continue }
    $a = BoxRect $top; $b = BoxRect $bot
    if ($pair[2].Contains('L') -and $a.L -ne $b.L) { $v290Bad += "$($pair[0]) opens at x=$($a.L) and $($pair[1]) at x=$($b.L) (SPEC V290b)" }
    if ($a.R -ne $b.R) { $v290Bad += "$($pair[0]) closes at x=$($a.R) and $($pair[1]) at x=$($b.R) (SPEC V290b)" }
}
if ($v290Bad) { foreach ($b in $v290Bad) { Fail "V290 $b" } }
else { Pass "V290 Merit|Book|Page|Cost tile in that order under their own headings, and the top row lands on the grid the bottom row keeps" }

# ---- V291: the Background tab closes on two rulers, one per axis -------------------
$v291Bad = @()
$doc291 = Doc (Join-Path $dir "WoD20.4.lfm")
$pre291 = BoxByTitle $doc291 "Prelude"
$goal291 = BoxByTitle $doc291 "Goals"
$head291 = @($doc291.SelectNodes("//scrollBox/layout"))[0]
if ($null -eq $pre291 -or $null -eq $goal291) { $v291Bad += "Prelude or Goals was not found on WoD20.4 (SPEC V209)" }
elseif ($null -eq $head291) { $v291Bad += "the identity header was not found on WoD20.4 (SPEC V209)" }
else {
    $p = BoxRect $pre291; $g = BoxRect $goal291; $h = BoxRect $head291
    if ($p.B -ne $g.B) { $v291Bad += "Prelude closes at y=$($p.B) and Goals at y=$($g.B) - the two columns end on one line (SPEC V291a)" }
    if ($h.R -ne $p.R) { $v291Bad += "the header closes at x=$($h.R) and Prelude at x=$($p.R) - the tab has one right edge (SPEC V291b)" }
    # and the width the header holds is spent on its columns, not on air at the end
    $cols291 = @($head291.SelectNodes("layout") | ForEach-Object {
        $l = 0; $w = 0
        [void][int]::TryParse($_.GetAttribute("left"), [ref]$l)
        [void][int]::TryParse($_.GetAttribute("width"), [ref]$w)
        [pscustomobject]@{ L = $l; W = $w }
    })
    $lefts291 = @($cols291 | ForEach-Object { $_.L } | Sort-Object -Unique)
    $widths291 = @($cols291 | ForEach-Object { $_.W } | Sort-Object -Unique)
    if ($lefts291.Count -ne 3) { $v291Bad += "the header holds $($lefts291.Count) column(s), expected 3 (SPEC V209)" }
    elseif ($widths291.Count -ne 1) { $v291Bad += "the header columns are $($widths291 -join '/') wide - the three share one width (SPEC V291b)" }
    else {
        $gut1 = $lefts291[1] - ($lefts291[0] + $widths291[0])
        $gut2 = $lefts291[2] - ($lefts291[1] + $widths291[0])
        $mL = $lefts291[0]
        $mR = $h.W - ($lefts291[2] + $widths291[0])
        if ($gut1 -ne $gut2) { $v291Bad += "the header gutters are $gut1 and $gut2 - the three columns are evenly spread or they are not (SPEC V291b)" }
        if ($mL -ne $mR) { $v291Bad += "the header leaves $mL on the left and $mR on the right - width the box gains goes to the columns, never to air at the end (SPEC V170, V291b)" }
    }
}
if ($v291Bad) { foreach ($b in $v291Bad) { Fail "V291 $b" } }
else { Pass "V291 Prelude closes with Goals on Y, the header closes with Prelude on X, and the 130px it gained went to its three columns" }

# ---- V292: the two Settings boxes close on one edge --------------------------------
$v292Bad = @()
$doc292 = Doc (Join-Path $dir "WoD20.6.lfm")
$boxes292 = @($doc292.SelectNodes("//scrollBox/layout"))
if ($boxes292.Count -ne 2) { $v292Bad += "the Settings tab holds $($boxes292.Count) section box(es), expected 2 - the ruler is one against the other and there is no literal to fall back on (SPEC V209)" }
else {
    $a = BoxRect $boxes292[0]; $b = BoxRect $boxes292[1]
    if ($a.R -ne $b.R) { $v292Bad += "the boxes close at x=$($a.R) and x=$($b.R) - the tab has one right edge (SPEC V292)" }
    foreach ($bx in $boxes292) {
        $r = BoxRect $bx
        $ends = @($bx.ChildNodes | Where-Object { $_.NodeType -eq 'Element' -and $_.LocalName -ne 'rectangle' -and $_.LocalName -ne 'dataLink' } | ForEach-Object {
            $l = 0; $w = 0
            if ([int]::TryParse($_.GetAttribute("left"), [ref]$l) -and [int]::TryParse($_.GetAttribute("width"), [ref]$w)) { $l + $w }
        })
        if (-not $ends.Count) { $v292Bad += "a Settings box holds nothing measurable (SPEC V209)"; continue }
        $far = ($ends | Measure-Object -Maximum).Maximum
        if (($r.W - $far) -ne 20) { $v292Bad += "a Settings box is $($r.W) wide and its widest child closes $($r.W - $far) short of the edge, not 20 - the width goes to the field, not to margin (SPEC V170, V292)" }
    }
}
if ($v292Bad) { foreach ($b in $v292Bad) { Fail "V292 $b" } }
else { Pass "V292 both Settings boxes close on one edge and each spends its width on its widest child" }

# ---- V293: hedgeStrip breathes the same on both sides (SPEC B64) -------------------
# V268 guards this strip from BELOW only - "an absolute sibling does not collide, it simply
# covers" - and that asymmetry is what B64 walked through: the 106th round's spec text ordered
# hedgeStrip to top=170, eight pixels INSIDE the row of boxes that ends at 178, and nothing
# here would have reddened. V280b cannot help (its scope is box-to-box and a strip is not a
# section box) and V281 is about buttons.
#
# Measured as a RELATION, never as the literal 12: I73 already owns that number for the gap
# below, and writing it again here would be two owners for one fact (SPEC V20).
$v293Bad = @()
$doc293 = Doc (Join-Path $dir "WoD20.7.lfm")
$hedge293 = $doc293.SelectSingleNode("//layout[@name='tabHedge']")
if ($null -eq $hedge293) { Fail "V293 tabHedge is gone from WoD20.7 - there is no pane to measure inside (SPEC I64, V209)" }
else {
    $strip293 = $hedge293.SelectSingleNode("layout[@name='hedgeStrip']")
    $panes293 = @($hedge293.SelectNodes("layout[@name='tabHedgePaths'] | layout[@name='tabHedgeRituals']"))
    if ($null -eq $strip293) { Fail "V293 hedgeStrip is not a child of tabHedge - the whole shape B64 got wrong has changed again (SPEC V209, B64)" }
    elseif ($panes293.Count -ne 2) { Fail "V293 tabHedge holds $($panes293.Count) sub-pane(s) under its strip, expected 2 (SPEC V209)" }
    else {
        $sT = 0; $sH = 0
        [void][int]::TryParse($strip293.GetAttribute("top"), [ref]$sT)
        [void][int]::TryParse($strip293.GetAttribute("height"), [ref]$sH)
        $skip293 = @('hedgeStrip', 'tabHedgePaths', 'tabHedgeRituals')
        $above293 = -1
        foreach ($k in $hedge293.ChildNodes) {
            if ($k.NodeType -ne 'Element') { continue }
            if ($skip293 -contains $k.GetAttribute("name")) { continue }
            $kt = 0; $kh = 0
            if (-not ([int]::TryParse($k.GetAttribute("top"), [ref]$kt) -and [int]::TryParse($k.GetAttribute("height"), [ref]$kh))) { continue }
            if (($kt + $kh) -gt $above293) { $above293 = $kt + $kh }
        }
        $pT = 0; [void][int]::TryParse($panes293[0].GetAttribute("top"), [ref]$pT)
        if ($above293 -lt 0) { $v293Bad += "nothing sits above hedgeStrip that this check can measure - the gap it guards has no upper side left (SPEC V209)" }
        else {
            $gapUp = $sT - $above293
            $gapDown = $pT - ($sT + $sH)
            if ($gapUp -le 0) { $v293Bad += "the row above hedgeStrip closes at y=$above293 and the strip opens at y=$sT - $([Math]::Abs($gapUp))px INSIDE it (SPEC B64, V293)" }
            elseif ($gapDown -le 0) { $v293Bad += "hedgeStrip closes at y=$($sT + $sH) and its sub-panes open at y=$pT - the strip has no room under it (SPEC V268, V293)" }
            elseif ($gapUp -ne $gapDown) { $v293Bad += "hedgeStrip leaves $gapUp above and $gapDown below - the sub-bar breathes the same on both sides, and the number itself belongs to I73 (SPEC V293)" }
        }
        if ($v293Bad) { foreach ($b in $v293Bad) { Fail "V293 $b" } }
        else { Pass "V293 hedgeStrip leaves the same gap above and below inside tabHedge" }
    }
}

# ---- V296: the two rows of the Numina tab are ONE grid --------------------------------
# The list boxes open and close where HEDGE MAGIC does, and the two DESCRIPTIONs span from
# where QUINTESSENCE opens to where WILLPOWER closes (SPEC I75, user 2026-08-25). Until T642
# that was a COINCIDENCE - 450/470/1410 happened to line up and nothing measured it - so
# widening one box on its own would have left the gate green over a crooked screen, which is
# B52 on the other axis.
#
# Found by TITLE, never by coordinate: a coordinate is what T490 already proved fragile
# (SPEC V18), and the ruler here IS a coordinate. The XPaths are scoped to the pane that owns
# each box because tabPsychic carries a DESCRIPTION of its own, on its own ruler (SPEC I75).
$doc296 = Doc (Join-Path $dir "WoD20.7.lfm")
$xp296 = [ordered]@{
    magic = "//layout[@name='tabHedge']/layout[label/@text='HEDGE MAGIC']"
    quint = "//layout[@name='tabHedge']/layout[label/@text='QUINTESSENCE']"
    will  = "//layout[@name='tabHedge']/layout[label/@text='WILLPOWER']"
    pathL = "//layout[@name='tabHedgePaths']/layout[label/@text='HEDGE MAGIC PATHS']"
    pathD = "//layout[@name='tabHedgePaths']/layout[label/@text='DESCRIPTION']"
    ritL  = "//layout[@name='tabHedgeRituals']/layout[label/@text='HEDGE MAGIC RITUALS']"
    ritD  = "//layout[@name='tabHedgeRituals']/layout[label/@text='DESCRIPTION']"
}
$v296Bad = @()
$b296 = @{}
foreach ($k in $xp296.Keys) {
    $node = @($doc296.SelectNodes($xp296[$k]))[0]
    if ($null -ne $node) {
        $l = 0; $w = 0
        if ([int]::TryParse($node.GetAttribute("left"), [ref]$l) -and [int]::TryParse($node.GetAttribute("width"), [ref]$w)) {
            $b296[$k] = @{ L = $l; R = $l + $w }
        }
    }
}
if ($b296.Count -lt 7) {
    Fail "V296 only $($b296.Count) of the 7 boxes of the Numina tab were found by title (the ruler plus the 6 that follow it) - this check measured nothing (SPEC V209, B7)"
} else {
    # (a) both lists sit exactly under HEDGE MAGIC
    foreach ($k in @('pathL', 'ritL')) {
        if ($b296[$k].L -ne $b296['magic'].L -or $b296[$k].R -ne $b296['magic'].R) {
            $v296Bad += "the list box of $k spans $($b296[$k].L)..$($b296[$k].R) and HEDGE MAGIC spans $($b296['magic'].L)..$($b296['magic'].R) - one number has to move all of them or none (SPEC V296a)"
        }
    }
    # (b) both DESCRIPTIONs open at QUINTESSENCE and close at WILLPOWER
    foreach ($k in @('pathD', 'ritD')) {
        if ($b296[$k].L -ne $b296['quint'].L) {
            $v296Bad += "the DESCRIPTION of $k opens at $($b296[$k].L) and QUINTESSENCE opens at $($b296['quint'].L) (SPEC V296b)"
        }
        if ($b296[$k].R -ne $b296['will'].R) {
            $v296Bad += "the DESCRIPTION of $k closes at $($b296[$k].R) and WILLPOWER closes at $($b296['will'].R) (SPEC V296b)"
        }
    }
    if ($v296Bad) { foreach ($b in $v296Bad) { Fail "V296 $b" } }
    else { Pass "V296 the two rows of the Numina tab tile as one grid - lists on $($b296['magic'].L)..$($b296['magic'].R), descriptions on $($b296['quint'].L)..$($b296['will'].R)" }
}

# ---- V297: HEDGE MAGIC is a GRID, not three rows that happen to line up ----------------
# Same shape V224 measures on the DOMINATOR box, and for the same reason it exists there
# (SPEC B12, B13): three labels on one x, three entries on another, and the three entries
# CLOSING on one x. Until T645 the entries were 386/220/220, which read as a staircase -
# the user asked for that to go, and without a check the next round quietly brings it back.
#
# The mirror edtHedgeAffiliation is left OUT of the column count on purpose: it is the SAME
# rectangle as the combo it hides behind (SPEC I71, V274), so counting it would put two
# controls in one cell and make the grid look broken while it is right.
$box297 = @($doc296.SelectNodes("//layout[@name='tabHedge']/layout[label/@text='HEDGE MAGIC']"))[0]
$v297Bad = @()
if ($null -eq $box297) {
    Fail "V297 the HEDGE MAGIC box was not found by title on WoD20.7 - this check measured nothing (SPEC V209, B7)"
} else {
    $lab297 = @()
    foreach ($nm in @('Affiliation', 'Essence', 'Casting Attribute')) {
        $n = @($box297.SelectNodes("label[@text='$nm']"))[0]
        if ($null -ne $n) { $lab297 += ,@($nm, [int]$n.GetAttribute("left"), [int]$n.GetAttribute("width")) }
    }
    $ent297 = @()
    foreach ($xp in @("comboBox[@name='cboHedgeAffiliation']", "edit[@field='hedgeEssence']", "comboBox[@name='cboHedgeAttr']")) {
        $n = @($box297.SelectNodes($xp))[0]
        if ($null -ne $n) { $ent297 += ,@($xp, [int]$n.GetAttribute("left"), [int]$n.GetAttribute("width")) }
    }
    if (($lab297.Count + $ent297.Count) -lt 6) {
        Fail "V297 only $($lab297.Count) label(s) and $($ent297.Count) entr(y/ies) of the six the grid needs were found - this check is covering less than the box has (SPEC V209)"
    } else {
        # (a) two shared columns
        $lx = @($lab297 | ForEach-Object { $_[1] } | Sort-Object -Unique)
        $ex = @($ent297 | ForEach-Object { $_[1] } | Sort-Object -Unique)
        if ($lx.Count -ne 1) { $v297Bad += "the three labels sit on $($lx.Count) different x ($($lx -join ', ')) - a grid shares one label column (SPEC V297a)" }
        if ($ex.Count -ne 1) { $v297Bad += "the three entries sit on $($ex.Count) different x ($($ex -join ', ')) - a grid shares one entry column (SPEC V297a)" }
        # (b) the three entries close on one x
        $er = @($ent297 | ForEach-Object { $_[1] + $_[2] } | Sort-Object -Unique)
        if ($er.Count -ne 1) {
            $v297Bad += "the three entries close on $($er.Count) different x ($($er -join ', ')) - shrinking one on its own reopens the staircase the user asked to remove (SPEC V297b)"
        }
        if ($v297Bad) { foreach ($b in $v297Bad) { Fail "V297 $b" } }
        else { Pass "V297 HEDGE MAGIC is a grid - labels on x=$($lx[0]), entries on x=$($ex[0]), all three closing on $($er[0])" }
    }
}

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

foreach ($pair in @(@("WoD20.1.lfm", "dynHealth_box", 330), @("WoD20.3.lfm", "dynHealth3_box", 320))) {
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
    # SYMMETRY, not left=0 (103rd round, SPEC T618): since I73 the title spans what the 20px
    # margin leaves, so "left=0 and width=box" is no longer how this sheet says centred - it is
    # how it says wrong. What the leg is really for survives the change: a title narrowed back
    # to the 215 the combo left it with reads 20 on the left and 95 on the right and reddens
    # here, which is the silence item 13 was about.
    if ($tl -ne ($hbw - $tl - $tw)) { $hlBad += "$($pair[1])'s HEALTH title leaves $tl on the left and $($hbw - $tl - $tw) on the right in a $($hbw)px box - with the combo gone it has to sit on equal margins, or centring centres it on nothing (SPEC V27, I73)" }
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
        # How many slots come OUT of `choice`, absent meaning one (SPEC I17, B65). The
        # `choice\s*=\s*\{` pattern above cannot see this one: choiceN takes a number, not a
        # table, so the two never read each other's value.
        $choiceN = 0
        if ($body -match 'choiceN\s*=\s*(\d+)') { $choiceN = [int]$Matches[1] }
        if ($clanEntries.ContainsKey($key)) { $clanBad += "CLANS names '$key' twice - the second entry is the one Lua keeps, silently" }
        $clanEntries[$key] = @{ fixed = $fixed; choice = $choice; open = $open; choiceN = $choiceN }
    }
} else { $clanBad += "the root form declares no CLANS between its markers - Clan/Family would fill nothing (SPEC I17, I37)" }

$clanList = @()
if ($PICKER.ContainsKey('clan')) { $clanList = @(@($PICKER['clan']) + @($PICKER['family']) | Where-Object { $_ }) }
$discSet = @{}
if ($PICKER.ContainsKey('disc')) { foreach ($d in $PICKER['disc']) { if ($d) { $discSet[$d] = $true } } }
$discRows = 0
if ($rootTxt -match 'CLAN_DISC_ROWS\s*=\s*(\d+)') { $discRows = [int]$Matches[1] }
$released = 0

if ($clanList.Count -lt 83) { $clanBad += "the clan picker offers $($clanList.Count) entries, expected at least the 83 it carries (61 clans + 22 revenant families) - this check would be reading less than the sheet has (SPEC V209)" }
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
if ($clanSeen -lt 83) { Fail "V236 only $clanSeen clan(s) were measured, expected 83 - this check is covering less than the picker offers (SPEC V209)" }
elseif ($clanBad) { foreach ($b in ($clanBad | Select-Object -First 12)) { Fail "V236 $b" } }
else { Pass "V236 CLANS answers all 83 clans and families in the picker's own spelling, $released of them released by choice or open" }

# ---- V295: an entry PROMISES a number of slots, and that number has to fit ------------
# B65: `choice` never said how MANY slots it opens, so renderClanDisc treated every slot
# without a `fixed` name as a slot to pick in - and Ventrue Antitribu, Wu Zao and Angellis
# Ater handed out four clan Disciplines where the book gives three. The fourth slot exists
# for the Gargoyles, who fix four; the other three inherited it for free. V236 could not
# see it: it measures coverage, spelling, and the `fixed` ceiling ON ITS OWN - never the
# total an entry delivers. Prose in I17 said "one slot to choose" and prose is not a
# contract, so the number now lives in the table as `choiceN` and gets measured here.
$v295Bad = @()
$v295Choice = 0
foreach ($k in ($clanEntries.Keys | Sort-Object)) {
    $en = $clanEntries[$k]
    $picks = 0
    if ($en.choice.Count -gt 0) {
        $v295Choice++
        $picks = 1
        if ($en.choiceN -gt 0) { $picks = $en.choiceN }
        # (b) more picks than options is impossible to satisfy, and the slot sticks empty
        if ($picks -gt $en.choice.Count) {
            $v295Bad += "'$k' asks for $picks pick(s) out of a list of $($en.choice.Count) - a slot nobody can ever fill (SPEC V295b)"
        }
    } elseif ($en.choiceN -gt 0) {
        # (c) a count with no list to count is dead data, and the ABSENCE of the number is
        # what made B65 in the first place
        $v295Bad += "'$k' declares choiceN=$($en.choiceN) with no choice list to pick from (SPEC V295c)"
    }
    # (a) fixed + picked + open has to fit the slots that actually exist
    $total = $en.fixed.Count + $picks + $en.open
    if ($discRows -gt 0 -and $total -gt $discRows) {
        $v295Bad += "'$k' promises $total Disciplines ($($en.fixed.Count) fixed + $picks picked + $($en.open) open) for $discRows slots - the extra name falls on the floor with nothing raised (SPEC V295a)"
    }
}
if ($clanEntries.Count -eq 0) { Fail "V295 CLANS parsed to zero entries - there is no slot count to measure here (SPEC V209, B7)" }
elseif ($v295Choice -lt 4) { Fail "V295 only $v295Choice entr(y/ies) carrying a choice list were read, expected at least the 4 CLANS holds - the collector is missing the very shape this check exists for (SPEC V209)" }
elseif ($v295Bad) { foreach ($b in ($v295Bad | Select-Object -First 12)) { Fail "V295 $b" } }
else { Pass "V295 all $($clanEntries.Count) CLANS entries fit inside $discRows slots, $v295Choice of them handing out picks" }

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
                if ($k.NodeType -eq 'Element' -and $k.LocalName -eq 'label' -and $k.GetAttribute("horzTextAlign") -eq 'center' -and $k.GetAttribute("text") -and -not $k.HasAttribute("rotationAngle")) { $tw = 0; if ([int]::TryParse($k.GetAttribute("width"), [ref]$tw) -and $tw -ge ($bw * 0.8)) { $ttl = $k.GetAttribute("text"); break } }
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
# The two numbers are a FLOOR of 20 since the 104th round, and they were an equality of 10
# before it (user decision, SPEC T618). What forced the change is B63: HEALTH on the Main tab,
# HEALTH on Combat and SPECIALTIES are welded to the line V69 draws, and the 22px that line
# owes them was put INSIDE the box rather than in a gap above it, so all three close 42 under
# their last row on purpose. A floor is V280a's own wording - "no child closing less than 20
# from the border" - and it keeps the mutations that matter: a title back at top=4 and a box
# shrunk by 5px both still redden. What it gives up is the box that grows a hole under its
# last row and calls it a design, which is B38 by the other axis - V69, V49 and V193 are what
# hold those three heights now, and a box that answers to none of them has no reason to grow.
# They are NOT V231's numbers: that one guards the gap between the tab's CONTENT and the tab
# STRIP, is 12 against 8, and lives one level further out.
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

        # The title is told the way V27 tells it, and for V27's reason (103rd round, SPEC T618):
        # since I73 gave every box 20 on all four sides the title CANNOT start at 0, so
        # "left=0 and width=box" now finds no title in any of the 73 boxes. It would not have
        # reddened anything here - the name would just read '(untitled)' - but the stretched-band
        # exception below is keyed on that name, so it would stop reaching its two boxes and go
        # on passing, which is the shape of B7 (SPEC V209).
        $ttl = '(untitled)'
        $ttlNode = $null
        foreach ($k in $box.ChildNodes) {
            if ($k.NodeType -ne 'Element' -or $k.LocalName -ne 'label' -or -not $k.GetAttribute("text")) { continue }
            if ($k.GetAttribute("horzTextAlign") -ne 'center' -or $k.HasAttribute("rotationAngle")) { continue }
            $tw = 0; if (-not [int]::TryParse($k.GetAttribute("width"), [ref]$tw)) { continue }
            if ($tw -lt ($bw * 0.8)) { continue }
            $ttl = $k.GetAttribute("text"); $ttlNode = $k; break
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

            # Where the body opens, and the 114th round MOVED it (SPEC I86b, V267b, user
            # 2026-08-26). It used to be the hairline under the title band plus the margin I73
            # asks under it - title.bottom + 1 + 20, which read 41 while that margin was 10 and
            # 61 after. That charges the title's margin TWICE: it is a FLOOR for content stacked
            # under a title, not a band reserved from the box, and counting it as both pushed a
            # single centred row 21px low. The eye caught it on the Numina tab before any check
            # did, because both boxes were passing this arm the whole time.
            #
            # It opens on the BOX's own margin now - the same 20 V280a charges on four sides -
            # so the title takes no band of its own. Still DERIVED, not typed: 20 is read from
            # the one margin the sheet uses everywhere, and the title node is still what proves
            # this is the titled arm.
            $bodyTop = 20
            if ($hiC -eq [int]::MaxValue) { $vpadBad += "$($f.Name) '$ttl' is stretched and holds nothing under its title - the exception is for a box that pays centring, not for an empty one (SPEC V267b)" }
            elseif ($hi -lt 20) { $vpadBad += "$($f.Name) '$ttl' opens with $hi above its title - stretched or not, the title still clears 20 (SPEC I40, V267b)" }
            # The content still clears the title band by the sheet's own margin (SPEC I86c). This
            # leg is what makes the 114th round's move a CEILING and not a direction: WILLPOWER,
            # the taller of the two, lands at exactly 20 under its title, so one more pixel up
            # reddens here. Without it the centring formula alone would happily walk the content
            # into the title as the box shrank.
            elseif (($hiC - ([int]$ttlNode.GetAttribute("top") + [int]$ttlNode.GetAttribute("height"))) -lt 20) { $vpadBad += "$($f.Name) '$ttl' leaves $($hiC - ([int]$ttlNode.GetAttribute('top') + [int]$ttlNode.GetAttribute('height')))px between the title and the content, under the 20 every box on this sheet keeps (SPEC I86c, V280a)" }
            # Centring is DERIVED and not a tolerance: the top gap is the floor of the halved
            # remainder, so the odd pixel always falls BELOW (SPEC I86c, V267b). Written as one
            # expected `top` rather than as two gaps compared loosely - a `-le 1` slack would
            # accept the odd pixel on either side and stop measuring which.
            elseif ($hiC -ne ($bodyTop + [math]::Floor(($bh - $bodyTop - ($loC - $hiC)) / 2))) { $vpadBad += "$($f.Name) '$ttl' ($($bh)px tall) opens its content at $hiC, not the $($bodyTop + [math]::Floor(($bh - $bodyTop - ($loC - $hiC)) / 2)) that centres it in the body with the odd pixel below - a stretched box pays CENTRING in place of the 20 (SPEC V267b, I73)" }
        }
        elseif ($hi -lt 20 -or $gapB -lt 20) {
            $vpadBad += "$($f.Name) '$ttl' ($($bh)px tall) opens with $hi above its first child and leaves $gapB under its last - neither may drop under 20 (SPEC I40, I73, V280a)"
        }
    }
}
if ($vpadSeen -lt 71) { Fail "V240 only $vpadSeen box(es) were measured, expected the 71 the sheet draws - this check is covering less than the sheet has (SPEC V209)" }
elseif ($stretchSeen -ne 2) { Fail "V240 $stretchSeen stretched box(es) took the centring rule, expected the 2 of the tabHedge band - an exception nothing reaches is an exception that stopped measuring (SPEC V209, V267b)" }
elseif ($vpadBad) { foreach ($b in $vpadBad) { Fail "V240 $b" } }
else { Pass "V240 all $vpadSeen boxes breathe at least 20 above their title and 20 under their last row, and the $stretchSeen stretched ones centre their content instead" }

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
# The columns are read INSIDE the box that scrolls them, not against the frame (103rd round,
# SPEC T618): until I73 the scrollBox sat at left=0 and was as wide as the frame, so the two
# rulers were the same number and the check could use either. With a 20px margin they are 40
# apart, and the chain the invariant is about - column -> scrolling box -> frame - has to be
# said in two steps or the 16px bar reserve reads as 56.
$logScroll = $xp9Doc.SelectSingleNode("//scrollBox[@name='xpLogScroll']")

if ($null -eq $logBox -or $null -eq $costCol -or $null -eq $lvlCol) { Fail "V247 the log box or one of its columns is missing from WoD20.9 (SPEC V20 - this check would be reading nothing)" }
elseif ($null -eq $expBox) { Fail "V247 the EXPERIENCE box was not found on WoD20.9 - the width relation has only one side" }
elseif ($null -eq $logScroll) { Fail "V247 xpLogScroll is gone from WoD20.9 - the columns would be measured against the frame they no longer share an edge with (SPEC V209, I57)" }
else {
    $costEnd = [int]$costCol.GetAttribute("left") + [int]$costCol.GetAttribute("width")
    $logW    = [int]$logBox.GetAttribute("width")
    $expW    = [int]$expBox.GetAttribute("width")
    $scrL    = [int]$logScroll.GetAttribute("left")
    $scrW    = [int]$logScroll.GetAttribute("width")
    $needLvl = NeededPx 'MANUAL'

    if ($logW -ne $expW) { Fail "V247 the log box is $logW wide and the EXPERIENCE box $expW - the two boxes of this tab close on the same x or the tab reads crooked" }
    elseif ($scrW -ne ($costEnd + 16)) { Fail "V247 the scrolling box is $scrW wide and its last column ends at $costEnd - the columns are the Cost column plus the 16px the vertical bar comes out of, or a column grew and the box did not (SPEC I44, I57)" }
    elseif ($logW -ne (2 * $scrL + $scrW)) { Fail "V247 the log box is $logW wide around a scrolling box $scrW wide at left=$scrL - the frame is the columns plus the margin on both sides, or a column grew and the frame did not (SPEC I44, I73)" }
    elseif ([int]$lvlCol.GetAttribute("width") -lt $needLvl) { Fail "V247 the Level column is $($lvlCol.GetAttribute('width'))px and MANUAL needs about $needLvl - the one row whose Level is a word would come up cut (SPEC V16)" }
    else { Pass "V247 both Experience boxes are $logW wide, the last column closes 16 short of the box that scrolls it, and Level holds MANUAL" }
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
        # The ruler is the LARGEST radius this box can WEAR, not the one the XML spells (SPEC
        # I89g, V316f). Since the 117th round a palette writes the corner at runtime, so Modern
        # Nights renders 18 on a rectangle whose XML still says 14 - reading the attribute alone
        # would quietly measure the SMALLER bite and this check would cover less than the sheet
        # draws, which is B7 arriving by radius. Both sides are READ: the attribute here, the
        # palette radii at the top of this file.
        #
        # The XML gate stays FIRST and is not folded into the max: a rectangle that authors no
        # radius has no bite to clear, and sectionBox refuses it too, so no palette can ever put
        # a corner on it. Folding it in would start measuring the square strip floor.
        $rXml = 0
        [void][int]::TryParse($back.GetAttribute("xradius"), [ref]$rXml)
        if ($rXml -le 0) { continue }   # a square box has no bite to clear
        $r = $rXml
        foreach ($pr258 in $boxCornerRadii) { if ($pr258 -gt $r) { $r = [int][Math]::Ceiling($pr258) } }

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

# ---- V259: REVOKED - absorbed by V298 (SPEC B70, user 2026-08-25) --------------------
# It measured DOMINATOR -> BLOOD POOL, and that pair is box-to-box under one parent, so V298
# already walks it among the 73 boxes it collects - with a zero-guard of its own. V259 had ONE
# leg and that leg WAS the gap, so nothing is left standing once the gap has an owner.
#
# It is deleted rather than pointed at the new number, because carrying the literal here is
# what B70 IS: the gap was spelled in THREE checks - this one, V298, and an undeclared leg
# inside V262 - and two rounds of amendment moved only one of them. This copy also drifted
# from its own SPEC line, which still read 10 while the check read 15. V298 owns the number;
# anything measuring a box gap delegates to it instead of writing the number down again.

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
        # row of boxes has to TILE - open at 0 and close on the ruler the widest row sets. The gutter
        # between neighbours is NOT read here any more (SPEC B70); V298 owns that number. Shrinking one
        # box of a pair passes the old leg (the sibling still closes the line) and fails V298 on the gap.
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
            # The ruler is the WIDEST row of the three sub-tabs, not a number written here
            # (103rd round, SPEC V262c, T618). 1270 was the literal that kept this invariant and
            # V267a red for four rounds: T615 moved the panes and every row with them, so the
            # check reddened code that was right, which is B7 arriving through the ruler. What
            # the leg is for is unchanged and still bites - shrink ONE box and its row stops
            # closing where its neighbours do.
            $numRuler = 0
            foreach ($k in $numRows.Keys) {
                $r = (@($numRows[$k] | Sort-Object L))[-1].R
                if ($r -gt $numRuler) { $numRuler = $r }
            }
            foreach ($k in $numRows.Keys) {
                $row = @($numRows[$k] | Sort-Object L)
                $shape = ($row | ForEach-Object { "$($_.N) $($_.L)..$($_.R)" }) -join ' | '
                if ($row[0].L -ne 0) { $v262Bad += "row $k opens at x=$($row[0].L), not at 0 - a row that starts short leaves dead space no other check reads: $shape" }
                if ($row[$row.Count - 1].R -ne $numRuler) { $v262Bad += "row $k closes at x=$($row[$row.Count - 1].R), not on the $numRuler the widest row of the three panes sets: $shape" }
                # The gutter between two boxes of a row is NOT measured here. It used to be,
                # spelled 15, and SPEC V262 never declared that leg - a live check the spec did
                # not know about, the inverse of B7. The four rows it walked are box-to-box, so
                # V298 already measures every one of them against the one number that owns the
                # gap (SPEC B70). What (c) keeps is what (c) always said: opens at 0, closes on
                # the ruler.
            }
        }
    }

    # (d) The pane exemption V40 leans on. Zero here means the leg is not wired and V40 is
    # exempting by <import> alone again - which is the shape of B7, a check that stopped
    # measuring what its message claims.
    if ($paneByRect -lt 3) { $v262Bad += "V40 exempted $paneByRect pane(s) by shared rect, expected at least the 3 the Numina tab draws - the exemption is back to trusting <import> (SPEC V209, V262d)" }

    if ($v262Bad) { foreach ($b in $v262Bad) { Fail "V262 $b" } }
    else { Pass "V262 the strip clears the panes, all three fit on both axes, $($numRows.Count) rows of boxes tile from 0 to $numRuler, and $paneByRect panes are exempt by rect" }
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
        # The same ruler V262c just measured, taken from it rather than typed again (103rd
        # round, SPEC V267a, T618): 1270 was a literal in two checks, and T615 moved both. If
        # V262c never got as far as setting one, saying so is the answer - a band measured
        # against nothing would pass while measuring nothing (SPEC V209, B7).
        $right267 = ($band267 | Measure-Object -Property R -Maximum).Maximum
        if (-not $numRuler) { $v267Bad += "V262c set no ruler for the panes - the band has nothing to close on and this leg would pass on an empty comparison (SPEC V209, V262c)" }
        elseif ($right267 -ne $numRuler) { $v267Bad += "the band closes at x=$right267, not on the $numRuler ruler the panes below it use (SPEC V262c, V267a)" }
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
    if ($h274 -ne 419) { $v274Bad += "the box is $h274 tall, expected 419 - two flags of 25 at a pitch of 30 moved everything under them by 60, and I73 added the 20 (SPEC V274e, I71, I73)" }
    $kids274 = @($stBox274.ChildNodes | Where-Object { $_.NodeType -eq "Element" -and $_.LocalName -ne "rectangle" -and $_.HasAttribute("top") })
    if ($kids274.Count -eq 0) { $v274Bad += "the box holds no placed control - the two gaps below would be measured against nothing (SPEC V209)" }
    else {
        $minTop274 = ($kids274 | ForEach-Object { [int]$_.GetAttribute("top") } | Measure-Object -Minimum).Minimum
        $maxBot274 = ($kids274 | ForEach-Object { [int]$_.GetAttribute("top") + [int]$_.GetAttribute("height") } | Measure-Object -Maximum).Maximum
        if ($minTop274 -ne 20) { $v274Bad += "the box breathes $minTop274 above its title, expected 20 (SPEC V240, V274e)" }
        if (($h274 - $maxBot274) -ne 20) { $v274Bad += "the box breathes $($h274 - $maxBot274) under its last row, expected 20 (SPEC V240, V274e)" }
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

# ---- V276..V279: the Victorian filigree ---------------------------------------------
# SPEC I72, the 98th round. The ornament is built by Lua into one <path> per section box, so
# NOTHING above sees it: without this block the palette key, the generator and the call could
# all be deleted and every other check would stay green - which is exactly the state the
# feature shipped in, and the reason item (1) of the request was to spec it at all.
$ornBad = @()
$ornMake = LuaFn $hh6 'ornament'
$ornGeo = LuaFn $hh6 'ornPath'
$ornArmFn = LuaFn $hh6 'ornArm'
$ornFiligFn = LuaFn $hh6 'ornFiligree'
$ornFileteFn = LuaFn $hh6 'ornFilete'

if (-not $ornMake) { $ornBad += "ornament() is gone from WoD20.6 - the filigree has no painter (SPEC I72c)" }
elseif (-not $ornGeo) { $ornBad += "ornPath() is gone from WoD20.6 - there is no geometry to paint (SPEC I72)" }
elseif (-not $ornArmFn) { $ornBad += "ornArm() is gone - the corner cannot shrink to fit and a short box goes back to being skipped (SPEC V279, B59)" }
elseif (-not $ornFiligFn) { $ornBad += "ornFiligree() is gone from WoD20.6 - the DEFAULT drawing is missing, so three eras of four would have no frame to fall back to (SPEC I87b, V313b)" }
else {
    $ornBody = NoComments $ornMake

    # V276: the path is made at RUNTIME and placed by align, never by geometry. A left/top/
    # width/height written here would put a theme back in the business V57 took it out of.
    #
    # What the path is parented TO is no longer asked here (103rd round, SPEC T621, T623). The
    # leg that used to sit on this line demanded `setParent(c)` and cited I72c, and I72c is
    # REVOKED: the user asked for the filigree on TOP of the labels and fields, so the argument
    # is now the <layout> the rectangle lives in. Two checks cannot both be the truth about one
    # argument, and V276's own sentence never mentioned parenting - it is about a path made at
    # runtime and placed by align. V283a owns the question now, in the opposite direction.
    if ($ornBody -notmatch 'gui\.newPath\(\)') { $ornBad += "V276 nothing creates a <path> - the filigree is declared and never drawn (SPEC I72)" }
    elseif ($ornBody -notmatch '(?m)^\s*\w+\.align\s*=\s*"client";') { $ornBad += "V276 the path is not align=client - it would need a left and a size, which is the geometry V57 forbids" }
    elseif ($ornBody -notmatch '(?m)^\s*\w+\.hitTest\s*=\s*false;') { $ornBad += "V276 the path is hit-testable - it would eat every click meant for the box under it" }
    elseif ([regex]::Matches($ornBody, '"(left|top|width|height)"|\.(left|top|width|height)\s*=').Count -gt 0) {
        $ornBad += "V276 the painter WRITES geometry - V37/V40/V49 only ever measure the static XML, so a size written here is a collision nothing can see (SPEC V57)"
    }

    # V277: a plainer era hides the filigree and never destroys it - the V56 promise, for the
    # frame instead of the backdrop. Destroying would also strand the handle in the ledger.
    if ($ornBody -notmatch 'visible\s*=\s*false;') { $ornBad += "V277 the filigree is never hidden - Modern would ship with a gold frame on every box (SPEC V56)" }
    if ($ornBody -match 'destroy') { $ornBad += "V277 the filigree is DESTROYED rather than hidden - the ledger would keep a dead handle and switching back would redraw 73 paths (SPEC V277)" }

    # V278: who gets one is decided by CONSTRUCTION - authored black plus a radius of its own.
    # Anchored on what the code READS, not on a roster of names spelled here (SPEC V222).
    #
    # RE-POINTED in the 117th round and NOT renumbered (SPEC V316d): the test moved out of
    # ornament() into sectionBox, so the frame and the CORNER of I89 ask it in ONE place. Left
    # grepping ornament() this check would find nothing, report nothing and pass by vacancy -
    # the no-op V20 refuses, and B7 in the letter.
    $sbFn278 = LuaFn $hh6 'sectionBox'
    $sbBody278 = NoComments $sbFn278
    if (-not $sbFn278) { $ornBad += "V278 sectionBox is gone - the one place that says which rectangles ARE section boxes does not exist, so neither caller is filtered (SPEC V209, V316d)" }
    elseif ($ornBody -notmatch 'sectionBox\(\s*c\s*,\s*fill\s*\)') { $ornBad += "V278 ornament() no longer asks sectionBox - a second copy of the filter is exactly what V67 pays not to have (SPEC V316d)" }
    elseif ($sbBody278 -notmatch 'normColor\(\s*fill\s*\)') { $ornBad += "V278 the filter does not read the AUTHORED fill - by the time this runs the box is mahogany, so reading the current colour matches nothing (SPEC V62)" }
    else {
        # The radius has to REFUSE, not merely be read. Anchored on the construction (SPEC
        # V222): find the local assigned from c.xradius, then demand a return guarded by it.
        # Asking only that the word appears passes a version that reads the radius and then
        # frames the box anyway - which is how the tab-strip floor would get a gold frame.
        $radL = [regex]::Match($sbBody278, '(?m)^\s*local\s+(\w+)\s*=\s*c\.xradius;')
        if (-not $radL.Success) { $ornBad += "V278 nothing reads the box own corner radius - the tab-strip floor is black and square and would be framed like a section box (SPEC V229, V68)" }
        else {
            $rn278 = [regex]::Escape($radL.Groups[1].Value)
            if ($sbBody278 -notmatch "(?m)^\s*if\s+[^\r\n]*\b$rn278\b[^\r\n]*then return;") {
                $ornBad += "V278 the corner radius is read and never REFUSES - a black square would be framed exactly like a section box (SPEC V229, V68)"
            }
        }
    }

    # V279: the corner SHRINKS to fit; no box is silently skipped. The floor is read out of the
    # Lua and measured against the smallest box the XML actually authors, so the two can never
    # drift: a shorter box added tomorrow reddens this instead of quietly coming out plain.
    # This is the backprop of B59 - TRUE FAITH, 1270 wide and 76 tall, fell through the old
    # fixed guard and nothing said so.
    # $ornBody and not $ornMake: the comment above explains the OLD guard in prose, and a
    # check that reddens on prose is the false positive V222 exists for.
    if ($ornBody -match '2\s*\*\s*ORN_ARM') {
        $ornBad += "V279 the painter still refuses a box by size - that is the guard that skipped TRUE FAITH in silence (SPEC B59)"
    }
    $armCap = [regex]::Match($hh6, '(?m)^\s*local ORN_ARM\s*=\s*(\d+);')
    $armSlack = [regex]::Match($ornArmFn, 'math\.floor\(math\.min\(w, h\) / 2\) - (\d+)')
    # 115th round: the floor is read PER STYLE (SPEC I87b, T706). ornPath is a dispatcher now
    # and carries no geometry of its own, so the filigree floor comes out of ornFiligree -
    # pointing this at the dispatcher would match nothing and turn the leg into the no-op V20
    # exists to refuse. The filete's own floor is measured below, and it floors the CROSS.
    $armFloor = [regex]::Match($ornFiligFn, '(?m)^\s*if a < (\d+) then return "";')
    if (-not $armCap.Success -or -not $armSlack.Success -or -not $armFloor.Success) {
        $ornBad += "V279 ORN_ARM, the shrink or the floor could not be read - the guard this measures is unreadable, so the check is a no-op (SPEC V20)"
    } else {
        $slack = [int]$armSlack.Groups[1].Value
        $floor = [int]$armFloor.Groups[1].Value
        $tiny = 0
        $tinyName = ''
        foreach ($f in $files) {
            foreach ($r in (Doc $f.FullName).SelectNodes("//rectangle[@color='black'][@xradius]")) {
                $p = $r.ParentNode
                $bw = 0; $bh = 0
                if (-not [int]::TryParse($r.GetAttribute("width"), [ref]$bw)) { [void][int]::TryParse($p.GetAttribute("width"), [ref]$bw) }
                if (-not [int]::TryParse($r.GetAttribute("height"), [ref]$bh)) { [void][int]::TryParse($p.GetAttribute("height"), [ref]$bh) }
                if ($bw -le 0 -or $bh -le 0) { continue }
                $side = [Math]::Min($bw, $bh)
                if ($tiny -eq 0 -or $side -lt $tiny) { $tiny = $side; $tinyName = "$($f.Name) $($bw)x$($bh)" }
            }
        }
        if ($tiny -eq 0) { $ornBad += "V279 no section box was found - this check measured nothing (SPEC V209)" }
        else {
            $arm = [Math]::Min([int]$armCap.Groups[1].Value, [Math]::Floor($tiny / 2) - $slack)
            if ($arm -lt $floor) { $ornBad += "V279 the smallest section box ($tinyName) resolves to an arm of $arm, under the floor of $floor - it would come out with NO filigree while its neighbours carry it (SPEC B59)" }
            else { Pass "V279 the shortest section box ($tinyName) resolves to an arm of $arm, clear of the floor of $floor - no box is skipped" }
        }
    }

    # V283: the filigree draws OVER the content of the box (item 1 of the 2026-08-24 request,
    # SPEC I72c REVOKED, V283). Four legs, and each is about a line of Lua this gate cannot RUN
    # (SPEC B30, B34) - so what it cannot count, it FORBIDS, the way V198 and V275 already do.
    #
    # (a) the argument handed to setParent is the <layout>, not the <rectangle>. A child draws
    # above its parent and below the parent's LATER siblings, so setParent(c) - what shipped
    # until this round - put the path under every label and field the box carries. That is the
    # report that opened the round: the boxes you type in were covering the detail.
    $sp283 = @([regex]::Matches($ornBody, 'setParent\(\s*([^()]*(?:\([^()]*\))?[^()]*?)\s*\)') | ForEach-Object { $_.Groups[1].Value.Trim() })
    if ($sp283.Count -eq 0) { $ornBad += "V283 ornament() never parents the path it creates - a path on no parent is on no form, and where it sits is the whole of this round (SPEC V209, V283a)" }
    else {
        foreach ($a283 in $sp283) {
            # (b) getParent() as the argument is the trap, not a style. setParent returns early
            # when the parent is unchanged (rrpgObjs.lua:637, SPEC R112): it compiles, runs, exits
            # 0 and moves NOTHING. No error to grep for, no symptom but the effect that never
            # arrives - B6 through a new door. Detaching with nil first is the one legal path.
            if ($a283 -match 'getParent\s*\(') {
                $ornBad += "V283 setParent is handed '$a283' - handing back the parent it already has returns early and does nothing at all (rrpgObjs.lua:637, SPEC R112, V283b)"
            }
            elseif ($a283 -eq 'nil') { continue }
            elseif ($a283 -notmatch '^\w+\.parent$') {
                $ornBad += "V283 the path is parented to '$a283' - it has to take the <layout> that holds the box (c.parent), or it draws UNDER the labels and fields, which is the bug the user reported (SPEC V283a, I72c REVOKED)"
            }
        }
    }

    # (c) hitTest false is the ONLY thing between "ornament on top" and "ornament that eats every
    # click on the box". V276 asks for it on its own account; here it is a DECLARED dependency of
    # (a) - the moment the path went over the fields, that line stopped being hygiene.
    if ($ornBody -notmatch '(?m)^\s*\w+\.hitTest\s*=\s*false;') {
        $ornBad += "V283 the path now draws OVER the content and is still hit-testable - it would swallow every click meant for the dots, combos and fields under it (SPEC V283c, V276)"
    }

    # (d) V280 is a PREREQUISITE of this, and it is measured rather than only written down: the
    # inner rule sits ORN_IN in from the border, so a box whose children start closer than that
    # gets its own content struck through. With I73's 20 there is room; at the 10 this sheet had
    # before T615 the 9px rule crossed the full-width children of 68 of the 73 boxes, which is
    # why raising the path before the margin lands is a visible regression and not a fix.
    $ornIn283 = [regex]::Match($hh6, '(?m)^\s*local ORN_IN\s*=\s*(\d+);')
    if (-not $ornIn283.Success) { $ornBad += "V283 ORN_IN could not be read out of WoD20.6 - the rule this leg measures against the margin is unreadable, so the leg is a no-op (SPEC V209, V20)" }
    elseif ([int]$ornIn283.Groups[1].Value -ge 20) {
        $ornBad += "V283 the inner rule sits $($ornIn283.Groups[1].Value)px in, at or past the 20px margin I73 gives every box - a path drawn on TOP at that width strikes through the children that fill the box (SPEC V283d, V280a, I73)"
    }
}
if ($ornBad) { foreach ($b in $ornBad) { Fail $b } }
else { Pass "V276/V277/V278/V283 the filigree is a runtime path, placed by align, hidden and never destroyed, filtered by construction, and it draws OVER the content without taking a click" }

# ---- V313: the DRAWING comes out of the PALETTE, and the memo stamps all three axes ----
# SPEC I87, the 115th round. Until now there was one frame and one era wearing it, so `which
# drawing` was not a question anybody could get wrong. With two, it is - and the way to get it
# wrong is silent in both directions: a dispatch that defaults to the new drawing repaints 73
# boxes in an era nobody asked, and a memo that does not stamp the STYLE hands back the frame
# it built for the era before. Neither raises anything: rdk -l exits 0 and the sheet is wrong
# on screen only. This block is the only thing above either.
$v313Bad = @()
$ornMake313 = LuaFn $hh6 'ornament'
$styleVar313 = [regex]::Match($hh6, '(?m)^\s*local (ornStyle\w+) = nil;')

# (a) a style with no colour beside it is a DEAD key: what hides the path is the colour (V277),
# so the style would never be reached and nothing would say so. Read out of the THEMES block at
# its own indent, the same way V63 reads the eight required keys - not from a roster here.
if (-not $themesBlock) { $v313Bad += "V313 the THEMES block could not be read - leg (a) measured nothing (SPEC V209, V20)" }
else {
    $styled313 = 0
    foreach ($k in $themeKeys) {
        $pal313 = [regex]::Match($themesBlock, "(?ms)^\t{4}\[""$([regex]::Escape($k))""\] = \{(.*?)^\t{4}\},")
        if (-not $pal313.Success) { $v313Bad += "V313 palette '$k' could not be read - its ornament keys are unchecked (SPEC V209)"; continue }
        $hasStyle313 = $pal313.Groups[1].Value -match "(?m)^\t{5}ornStyle\s*="
        $hasCol313 = $pal313.Groups[1].Value -match "(?m)^\t{5}ornament\s*="
        if ($hasStyle313) {
            $styled313++
            if (-not $hasCol313) {
                $v313Bad += "V313 palette '$k' declares ornStyle and no ornament - the colour is what hides the path (V277), so the style is a key that can never draw and never complain (SPEC V313a, I87a)"
            }
        }
    }
    if ($styled313 -eq 0) { $v313Bad += "V313 no palette declares ornStyle - leg (a) matched nothing, which is B7 waiting (SPEC V209, V20)" }
    else { Pass "V313 $styled313 palette(s) declare ornStyle and every one of them declares an ornament colour too" }
}

# (b) the DEFAULT is the filigree. An era that declares no style has to fall to the drawing
# that was here first - a dispatch whose fallthrough is the filete changes 73 boxes in three
# eras that never asked, and the symptom lands an era away from the line that caused it.
if (-not $ornGeo) { $v313Bad += "V313 ornPath is gone from WoD20.6 - there is no dispatch to measure (SPEC V209)" }
else {
    $disp313 = NoComments $ornGeo
    if ($disp313 -notmatch 'if\s+style\s*==\s*"filete"') {
        $v313Bad += "V313 ornPath does not branch on the style it is handed - the palette cannot pick a drawing, and the key T703 added would do nothing at all (SPEC I87b)"
    }
    if ($disp313 -notmatch 'ornFilete\s*\(') { $v313Bad += "V313 ornPath never reaches ornFilete - the Dark Ages frame is written and never called (SPEC I87b, V209)" }
    $tail313 = [regex]::Match($disp313, '(?m)^\s*return\s+(\w+)\(w, h\);\s*$')
    if (-not $tail313.Success) { $v313Bad += "V313 ornPath has no unguarded final return - there is no default drawing, so an era with no style gets NO frame instead of the filigree (SPEC V313b)" }
    elseif ($tail313.Groups[1].Value -ne 'ornFiligree') {
        $v313Bad += "V313 ornPath falls through to $($tail313.Groups[1].Value) - the default has to be the filigree, or three eras of four silently change drawing (SPEC V313b, I87b)"
    }
    else { Pass "V313 ornPath dispatches on the palette's style and falls through to the filigree" }
}

# (c) the memo stamps the STYLE. Switching era on an open sheet moves no box, so the size
# comparison V284 already owns answers `same` and the entry is handed straight back - wearing
# the drawing of the era before, repainted in the new era's colour. B58 and B62 on a third
# axis, and the only one of the three with no measurement to notice it.
if (-not $ornMake313) { $v313Bad += "V313 ornament() is gone from WoD20.6 - there is no memo to measure (SPEC V209)" }
elseif (-not $styleVar313.Success) {
    $v313Bad += "V313 no module-level style is kept beside ornColour - refreshOrnament runs outside the theme walk with no palette in hand, so it would have nothing to redraw FROM (SPEC I87e)"
}
else {
    $sv313 = [regex]::Escape($styleVar313.Groups[1].Value)
    $ornB313 = NoComments $ornMake313

    if ($hh6 -notmatch "(?m)^\s*$sv313 = t\.ornStyle;") {
        $v313Bad += "V313 the style global is never written from the palette - it would stay nil forever and every era would draw the filigree (SPEC I87e)"
    }

    $carries313 = $false
    foreach ($t313 in [regex]::Matches($ornB313, '\{[^{}]*\}')) {
        if ($t313.Value -match ('\b' + $sv313 + '\b')) { $carries313 = $true; break }
    }

    if (-not $carries313) {
        $v313Bad += "V313 the memo entry does not carry the style - it can tell 'already drawn' and 'drawn at THIS size' and not 'drawn in THIS drawing', so changing era keeps the old frame (SPEC I87d, V313c, B58)"
    }
    elseif ($ornB313 -notmatch ("~=\s*" + $sv313 + '|' + $sv313 + "\s*~=")) {
        $v313Bad += "V313 the stored style is written and never COMPARED - the third door never opens for a change of era, and the sheet keeps the frame it had (SPEC V313c)"
    }
    else {
        $calls313 = [regex]::Matches($ornB313, 'ornPath\s*\(([^)]*)\)')
        $bare313 = @($calls313 | Where-Object { $_.Groups[1].Value -notmatch ('\b' + $sv313 + '\b') })

        if ($calls313.Count -eq 0) { $v313Bad += "V313 ornament() never calls ornPath - there is no drawing to hand a style to (SPEC V209)" }
        elseif ($bare313.Count -gt 0) {
            $v313Bad += "V313 $($bare313.Count) of $($calls313.Count) ornPath call(s) in ornament() carry no style - every one has to, or the one that does not rebuilds the box in the default drawing with nothing to say so (SPEC I87b, V313c)"
        }
        else { Pass "V313 the memo stamps size AND style, and all $($calls313.Count) ornPath calls carry it" }
    }
}

# (d) one painter, one generator. Two copies is what V67 pays not to have with THEME_STROKE and
# V308 with the marker's three motifs; here the cost of the second copy is 73 boxes wearing two
# frames at once, with nothing in rdk -l or above to say which one is stale.
$nOrn313 = [regex]::Matches($hh6, '(?m)^\s*local function ornament\s*\(').Count
$nPath313 = [regex]::Matches($hh6, '(?m)^\s*local function ornPath\s*\(').Count
if ($nOrn313 -ne 1) { $v313Bad += "V313 WoD20.6 declares $nOrn313 ornament() - one painter per style is two memos and two creation paths for one <path> (SPEC V313d, V67)" }
elseif ($nPath313 -ne 1) { $v313Bad += "V313 WoD20.6 declares $nPath313 ornPath() - the dispatch is the single door, and a second one is a second answer to which drawing is in force (SPEC V313d)" }
else { Pass "V313 one painter and one generator serve both drawings" }

if ($v313Bad) { foreach ($b in $v313Bad) { Fail $b } }

# ---- V314: the filete's geometry is a RELATION, not five literals -----------------------
# SPEC I87c, the 115th round. Every number in this drawing has the other side of a relation
# sitting in the same file, so the gate reads BOTH and never spells one here: a literal spelled
# on this side is the second truth V49 pays not to have, and the failure it hides is visual -
# a cross sitting on the corner curve, or touching the 3px outline, exits 0 and merely looks wrong.
$v314Bad = @()
$c314 = @{}
foreach ($n314 in @('ORN_BOXR', 'ORN_IN', 'ORN_CROSS', 'ORN_CROSS2', 'ORN_CROSS_AT', 'THEME_STROKE')) {
    $m314 = [regex]::Match($hh6, "(?m)^\s*local $n314\s*=\s*([0-9.]+);")
    if ($m314.Success) { $c314[$n314] = [double]$m314.Groups[1].Value }
}

if ($c314.Count -ne 6) {
    $v314Bad += "V314 only $($c314.Count) of the 6 constants this measures could be read out of WoD20.6 - the relations are unreadable, so every leg below is a no-op (SPEC V209, V20)"
} else {
    $rIn314 = $c314['ORN_BOXR'] + $c314['ORN_IN']
    $straight314 = [Math]::Sqrt(($rIn314 * $rIn314) - ($c314['ORN_IN'] * $c314['ORN_IN']))

    # (a) the cross lands on the STRAIGHT run. The corner arc gives out where the rule leaves
    # the box's own concave radius; inside that the cross sits on the curve and comes out
    # crooked. Both sides read from the Lua: move ORN_BOXR and the floor moves with it.
    if ($c314['ORN_CROSS_AT'] -le $straight314) {
        $v314Bad += "V314 the corner cross sits at $($c314['ORN_CROSS_AT']) and the rule is still on its arc until $([Math]::Round($straight314, 2)) - it would be drawn on the CURVE, crooked, with nothing to say so (SPEC V314a, I87c)"
    } else { Pass "V314 the corner cross at $($c314['ORN_CROSS_AT']) clears the corner arc, which gives out at $([Math]::Round($straight314, 2))" }

    # (b) the centre cross does not touch the frame. Centred on a rule ORN_IN in, a half-arm of
    # h reaches ORN_IN - h outward against the box's own outline, which applyTheme writes at
    # THEME_STROKE on every rectangle it repaints (V67). This is a CEILING, not a taste.
    $cap314 = $c314['ORN_IN'] - $c314['THEME_STROKE']
    if ($c314['ORN_CROSS2'] -ge $cap314) {
        $v314Bad += "V314 the centre cross has a half-arm of $($c314['ORN_CROSS2']) and reaches $($c314['ORN_IN'] - $c314['ORN_CROSS2']) out, into the $($c314['THEME_STROKE'])px outline the theme paints on every box - the ceiling is $cap314 (SPEC V314b, V67)"
    } else { Pass "V314 the centre cross half-arm of $($c314['ORN_CROSS2']) clears the $($c314['THEME_STROKE'])px outline, under the ceiling of $cap314" }

    # (c) and it does not reach the CONTENT. The filete draws on TOP of everything the box
    # carries (I72c), so what keeps it off the children is the 20px margin every box has - the
    # same number V283d measures the rule itself against, one motif further in.
    $reach314 = $c314['ORN_IN'] + $c314['ORN_CROSS2']
    if ($reach314 -gt 20) {
        $v314Bad += "V314 the centre cross reaches ${reach314}px into the box, at or past the 20px margin I73 gives every one - drawn on TOP it would strike through the children that fill the box (SPEC V314c, V280a, V283d)"
    } else { Pass "V314 the deepest the filete reaches is ${reach314}px, clear of the 20px content margin" }

    # (d) the hierarchy IS the drawing. "One slightly larger in the middle" is what the plate
    # says; equal arms lose the centre and no check above this one would notice.
    if ($c314['ORN_CROSS'] -ge $c314['ORN_CROSS2']) {
        $v314Bad += "V314 the corner cross ($($c314['ORN_CROSS'])) is not smaller than the centre one ($($c314['ORN_CROSS2'])) - the plate's whole hierarchy is that one of them is larger (SPEC V314d)"
    } else { Pass "V314 the corner cross ($($c314['ORN_CROSS'])) stays under the centre one ($($c314['ORN_CROSS2']))" }

    # (e) what a small box drops is the CROSS, never the rule - V279's doctrine in the letter
    # T613 wrote it for the filigree's arm. The floor is READ out of the Lua and measured
    # against the smallest box the XML actually authors, so neither can drift from the other.
    $roomM314 = [regex]::Match($hh6, '(?m)^\s*local ORN_CROSS_ROOM\s*=\s*2 \* \(ORN_CROSS_AT \+ ORN_CROSS \+ ORN_CROSS2\);')
    $fileteFam314 = ''
    foreach ($fn314 in @('ornFilete', 'ornFileteCorner', 'ornFileteEdge')) { $fileteFam314 += (LuaFn $hh6 $fn314) }
    $famNC314 = NoComments $fileteFam314
    $emitted314 = [regex]::Matches($famNC314, 'ornCross\s*\(').Count
    $floored314 = [regex]::Matches($famNC314, 'ORN_CROSS_ROOM').Count

    if (-not $fileteFam314) { $v314Bad += "V314 the filete family is gone from WoD20.6 - leg (e) measured nothing (SPEC V209)" }
    elseif (-not $roomM314.Success) { $v314Bad += "V314 ORN_CROSS_ROOM is not the sum of the three constants it floors - the floor and the motif could drift apart with nothing between them (SPEC V314e, V49)" }
    elseif ($famNC314 -match 'return "";') {
        $v314Bad += "V314 the filete refuses a box by size - what a small box drops is the CROSS, never the rule, and a box skipped in silence between ornamented neighbours is exactly B59 (SPEC V314e, T613)"
    }
    elseif ($emitted314 -eq 0) {
        $v314Bad += "V314 the filete emits no cross at all - the motif this leg floors does not exist (SPEC V209)"
    }
    elseif ($floored314 -lt $emitted314) {
        $v314Bad += "V314 the filete emits $emitted314 cross(es) and consults ORN_CROSS_ROOM $floored314 time(s) - a cross drawn without the test overlaps its neighbour on a short run, and counting the family ONCE passed while two of three drew unguarded (SPEC V314e)"
    }
    else {
        $room314 = 2 * ($c314['ORN_CROSS_AT'] + $c314['ORN_CROSS'] + $c314['ORN_CROSS2'])
        $tiny314 = 0
        $tinyN314 = ''
        foreach ($f in $files) {
            foreach ($r in (Doc $f.FullName).SelectNodes("//rectangle[@color='black'][@xradius]")) {
                $p314 = $r.ParentNode
                $bw314 = 0; $bh314 = 0
                if (-not [int]::TryParse($r.GetAttribute("width"), [ref]$bw314)) { [void][int]::TryParse($p314.GetAttribute("width"), [ref]$bw314) }
                if (-not [int]::TryParse($r.GetAttribute("height"), [ref]$bh314)) { [void][int]::TryParse($p314.GetAttribute("height"), [ref]$bh314) }
                if ($bw314 -le 0 -or $bh314 -le 0) { continue }
                $side314 = [Math]::Min($bw314, $bh314)
                if ($tiny314 -eq 0 -or $side314 -lt $tiny314) { $tiny314 = $side314; $tinyN314 = "$($f.Name) $($bw314)x$($bh314)" }
            }
        }
        if ($tiny314 -eq 0) { $v314Bad += "V314 no section box was found - leg (e) measured nothing (SPEC V209)" }
        elseif ($tiny314 -lt $room314) {
            $v314Bad += "V314 the smallest section box ($tinyN314) is under the ${room314}px a run needs to hold its crosses - it would come out with the bare rule while its neighbours carry the motif (SPEC V314e, B59)"
        }
        else { Pass "V314 the smallest section box ($tinyN314) clears the ${room314}px the crosses need - no box loses the motif in silence" }
    }
}

if ($v314Bad) { foreach ($b in $v314Bad) { Fail $b } }

# ---- V315: the BAR's drawing comes out of the same palette the BOX's does (SPEC I88) -----
# The 116th round. I87 gave the era its own BOX frame; this gives it the BAR, through the SAME
# palette key and the SAME module global, so no era can wear one drawing on its boxes and
# another on its tabs. Six legs, and (c) is the one that keeps the new drawing off the words.
$v315Bad = @()
$fil315  = LuaFn $hh6 'markFilete'
$path315 = LuaFn $hh6 'markPath'
$rule315 = LuaFn $hh6 'markRule'
$mkC315 = [regex]::Match($hh6, '(?m)^\s*local ORN_FIL_MARK\s*=\s*([\d.]+);')
$crC315 = [regex]::Match($hh6, '(?m)^\s*local ORN_FIL_CROSS\s*=\s*([\d.]+);')
$spC315 = [regex]::Match($hh6, '(?m)^\s*local ORN_FIL_SEP\s*=\s*([\d.]+);')
$m2C315 = [regex]::Match($hh6, '(?m)^\s*local ORN_MARK2\s*=\s*([\d.]+);')
$plC315 = [regex]::Match($hh6, '(?m)^\s*local ORN_PILLR\s*=\s*([\d.]+);')
if (-not ($fil315 -and $path315 -and $rule315)) {
    Fail "V315 markFilete / markPath / markRule could not all be read out of WoD20.6 - every leg below measures one of them, so all six would be no-ops (SPEC V209, V20)"
}
elseif (-not ($mkC315.Success -and $crC315.Success -and $spC315.Success -and $m2C315.Success -and $plC315.Success)) {
    Fail "V315 ORN_FIL_MARK / ORN_FIL_CROSS / ORN_FIL_SEP / ORN_MARK2 / ORN_PILLR are not all readable in WoD20.6 - the Lua side of these relations is gone, and a relation with one side is a no-op (SPEC V209, V20)"
}
else {
    $filBody315  = NoComments $fil315
    $pathBody315 = NoComments $path315
    $ruleBody315 = NoComments $rule315
    $filMark315  = [double]$mkC315.Groups[1].Value
    $filCross315 = [double]$crC315.Groups[1].Value
    $filSep315   = [double]$spC315.Groups[1].Value
    $mark2_315   = [double]$m2C315.Groups[1].Value
    $pillr315    = [double]$plC315.Groups[1].Value

    # (a) the style is DISPATCHED and it arrives as an ARGUMENT. markPath is declared ABOVE the
    # local that holds the era's style, so reading it there compiles to a GETGLOBAL and finds
    # nil - rdk -l exits 0 and there is no symptom to grep, which is B51 (SPEC I88a, V223).
    if ($pathBody315 -notmatch 'function markPath\(w, h, kind, style\)') { $v315Bad += "markPath does not take the style as a fourth argument - the palette has no way to reach the bar (SPEC I88a)" }
    if ($pathBody315 -notmatch 'if style == "filete" then') { $v315Bad += "markPath does not dispatch on the filete style - every era falls to the default drawing and the palette key is dead (SPEC I88a)" }
    if ($pathBody315 -match '\bornStyleNow\b') { $v315Bad += "markPath reads ornStyleNow directly, and that local is declared BELOW it - the read compiles to a GETGLOBAL and calls nil, with exit 0 and nothing to grep (SPEC I88a, V223, B51)" }
    if ($ruleBody315 -notmatch 'markPath\(bw, bh, kind, ornStyleNow\)') { $v315Bad += "markRule does not pass ornStyleNow into markPath - the style arrives nil and the era's own drawing is never reached (SPEC I88a)" }
    # EMENDED by the 118th round and NOT renumbered (SPEC I90h). The count was "exactly 1
    # palette declares ornStyle", which the chain makes false: two eras carry a style now. It
    # becomes a RELATION with both sides READ - as many palettes declaring a style as ornPath has
    # branches to answer them - so a fifth era with a sixth drawing cannot slip past a number
    # spelled here.
    #
    # And the TYPO test changes painter. It used to demand markPath dispatch on the declared
    # value, which was right while ornStyle meant one thing; `corrente` changes the BOX and
    # deliberately leaves the bar alone, so that demand would redden a product decision. What
    # still has to hold is that the BOX painter answers every style a palette declares - it is
    # the painter the key exists for, and a style ornPath does not know falls to the filigree
    # with exit 0, the gate green and only the screen left to tell. A style the BAR does not
    # dispatch is a declared subset and stays GREEN.
    $decl315 = [regex]::Matches($hh6, '(?m)^\s*ornStyle\s*=\s*"([^"]+)"')
    $pathFn315 = NoComments (LuaFn $hh6 'ornPath')
    $branch315 = @([regex]::Matches($pathFn315, 'if style == "([^"]+)" then') | ForEach-Object { $_.Groups[1].Value })
    if ($decl315.Count -eq 0) { $v315Bad += "no palette declares ornStyle - leg (a) matched nothing, which is B7 waiting (SPEC V209, V20)" }
    elseif ($branch315.Count -ne $decl315.Count) {
        $v315Bad += "$($decl315.Count) palette(s) declare a style and ornPath branches on $($branch315.Count) - a style with no branch draws the filigree instead, and a branch with no palette is a drawing nobody can reach (SPEC I90h, V315a)"
    }
    else {
        foreach ($d315 in $decl315) {
            $val315 = $d315.Groups[1].Value
            if ($branch315 -notcontains $val315) { $v315Bad += "the palette declares ornStyle = $val315 and ornPath dispatches on no such style - a mistyped style falls to the default drawing with exit 0, gate green, and only the screen left to tell (SPEC I90h, V285)" }
        }
    }

    # (b) a STYLE's constant does not cross into ANOTHER style's drawing, the way V308 keeps a
    # MOTIF's constant out of another motif (B69). EMENDED by the 119th round and NOT
    # renumbered (SPEC I91i): it enumerated the two styles that existed, and a third drawing
    # arrived - so it is a table now, and a fourth style is one row rather than a rewrite.
    #
    # THREE exceptions, and they are DECLARED rather than accidental: ORN_PILLR, the arc V228
    # authors on all nineteen buttons; ORN_SUB_MARK, the sub-tab height the user approved in
    # the 109th round, which is one fact in any style; and ORN_KAPPA, which is not a drawing
    # choice at all but the constant of the arc, so it carries none of B69's risk.
    $cor315 = LuaFn $hh6 'markCorrente'
    if (-not $cor315) { $v315Bad += "markCorrente is gone from WoD20.6 - the corrente style's drawing cannot be read, so the row this leg holds for it would measure nothing (SPEC I91a, V209, V20)" }
    else {
        $corBody315 = NoComments $cor315
        $defOwn315 = @('ORN_MARK', 'ORN_MARK2', 'ORN_MARK_RX', 'ORN_MARK_RY', 'ORN_MARK_GAP', 'ORN_SUB', 'ORN_SEP_RX', 'ORN_SEP_RY')
        $filOwn315 = @('ORN_FIL_MARK', 'ORN_FIL_CROSS', 'ORN_FIL_SEP')
        $corOwn315 = @('ORN_COR_MARK', 'ORN_COR_MARK2', 'ORN_COR_IN', 'ORN_COR_SPAN', 'ORN_COR_SUB2', 'ORN_COR_SUB_SPAN', 'ORN_COR_DOT')
        $fam315 = @(
            @{ fn = 'markPath (the default drawing)'; body = $pathBody315; forbid = ($filOwn315 + $corOwn315); sub = $false },
            @{ fn = 'markFilete';                     body = $filBody315;  forbid = ($defOwn315 + $corOwn315); sub = $true  },
            @{ fn = 'markCorrente';                   body = $corBody315;  forbid = ($defOwn315 + $filOwn315); sub = $true  }
        )
        foreach ($f315 in $fam315) {
            foreach ($bad315 in $f315.forbid) {
                if ($f315.body -match ("\b" + [regex]::Escape($bad315) + "\b(?!_|\d)")) { $v315Bad += "$($f315.fn) reads $bad315, which belongs to ANOTHER style - one constant serving two drawings is how the 110th round moved three levels when it was asked to move one (SPEC I88e, I91i, V308, B69)" }
            }
            if ($f315.sub -and $f315.body -notmatch '\bORN_SUB_MARK\b') { $v315Bad += "$($f315.fn) has no ORN_SUB_MARK - its sub-tab rule has come off the height the user saw and approved in the 109th round (SPEC I88e, I91c)" }
        }
    }

    # (c) THE relation, and the one that keeps the cross off the words. In the default style the
    # topmost ink is the upper rule, at h - ORN_MARK2 = 21, which is the state the user approved
    # on screen in the 112th round. In filete the topmost ink is the cross's UPPER ARM, so the
    # two constants have to add to the same number or the drawing climbs into the label box,
    # which closes at 20 (SPEC I88d, B68). Both sides read from Lua, neither spelled here.
    if (($filMark315 + $filCross315) -ne $mark2_315) { $v315Bad += "ORN_FIL_MARK ($filMark315) + ORN_FIL_CROSS ($filCross315) is $($filMark315 + $filCross315) against ORN_MARK2 = $mark2_315 - the two styles no longer put their topmost ink on the same line, so one of them is nearer the words than was ever approved (SPEC I88d, V307a, B68)" }

    # (d) the tab's cross is BIGGER than the separator's: the level that says least says it in
    # less, and equal arms lose the hierarchy with nothing anywhere to say so (SPEC I88f).
    if ($filCross315 -le $filSep315) { $v315Bad += "ORN_FIL_CROSS ($filCross315) is not greater than ORN_FIL_SEP ($filSep315) - the separator stops being the smaller mark and the three levels stop being told apart by quantity (SPEC I88f)" }

    # (e) the floor is READ, never spelled. What falls out for want of room is the CROSS, never
    # the rule (V279) - and a guard that CANNOT fire is B59's hole, so the narrowest of the
    # nineteen is measured against a floor built from the Lua's own numbers (SPEC I88h).
    $wid315 = @()
    $sep315 = 0
    foreach ($pr315 in @(@("WoD20th.lfm", "tabStrip"), @("WoD20.11.lfm", "vampStrip"), @("WoD20.7.lfm", "numStrip"), @("WoD20.7.lfm", "hedgeStrip"))) {
        $st315 = (Doc (Join-Path $dir $pr315[0])).SelectSingleNode("//layout[@name='$($pr315[1])']")
        if ($null -eq $st315) { $v315Bad += "$($pr315[1]) is gone from $($pr315[0]) - the bar this invariant measures does not exist (SPEC I32, I58, V209)"; continue }
        foreach ($r315 in $st315.SelectNodes("rectangle[starts-with(@name,'tabOn')]")) { $wid315 += [double]$r315.GetAttribute("width") }
        $sep315 += @($st315.SelectNodes("rectangle[starts-with(@name,'sep')]")).Count
    }
    $foot315  = [Math]::Sqrt(($pillr315 + $filMark315) * ($pillr315 + $filMark315) - $filMark315 * $filMark315)
    $floor315 = 2 * $foot315 + 2 * $filCross315
    if ($wid315.Count -ne 19) { $v315Bad += "read $($wid315.Count) marker(s) across the four bars, expected 19 - this check is covering less than the bars hold (SPEC V209)" }
    elseif ((($wid315 | Measure-Object -Minimum).Minimum) -le $floor315) { $v315Bad += "the narrowest marker is $(($wid315 | Measure-Object -Minimum).Minimum) against a floor of $([Math]::Round($floor315, 2)) - at that width the tab drops its crosses, and a drawing that quietly loses half its motif is not the one anybody chose (SPEC I88h, V279, B59)" }
    if ($sep315 -ne 5) { $v315Bad += "read $sep315 separator carrier(s) across the bars, expected 5 - the fleuron that became a cross has lost a carrier to stand in (SPEC I78d, V209)" }

    # (f) the marker memo stamps the DRAWING. The nineteen never resize, so measure is not what
    # this memo has to tell apart - and without the stamp, swapping era on an OPEN sheet leaves
    # the bar wearing the previous era's drawing repainted in the new colour (SPEC I88g, B62).
    # The closing brace is what makes this the CREATION stamp and not the rewrite below: the
    # first draft of this leg matched a bare "s = ornStyleNow", which the restyle branch also
    # contains, so deleting the stamp left the check green - caught by the mutation V20 asks
    # for, which is the whole reason it is run before the check is believed (SPEC V20, B7).
    if ($ruleBody315 -notmatch 's = ornStyleNow\s*\}') { $v315Bad += "markRule never stamps the style into the marker memo at CREATION - swapping era on an OPEN sheet leaves the bar in the previous era's drawing repainted in the new colour, with exit 0 and the gate green (SPEC I88g, B58, B62)" }
    if ($ruleBody315 -notmatch 'e\.s = ornStyleNow') { $v315Bad += "markRule never writes the new style back into the memo after redrawing - the entry would say the OLD style for ever and every later repaint would rebuild the same path (SPEC I88g, V284)" }
    if ($ruleBody315 -notmatch 'e\.s ~= ornStyleNow') { $v315Bad += "markRule never compares the stamped style against the era in force - the memo answers already-drawn to a question about a DIFFERENT drawing (SPEC I88g, V284)" }

    if ($v315Bad) { foreach ($b in $v315Bad) { Fail "V315 $b" } }
    else { Pass "V315 the bar's drawing comes out of the palette that draws the boxes, each style keeps its own constants, and both styles put their topmost ink at $mark2_315 from the marker's foot" }
}

# ---- V316: the PALETTE may write the CORNER, and ONE selector says in whom ----------------
# SPEC I89, the 117th round. The coffin bevel is the first thing a palette writes that is
# GEOMETRY and not colour, so it is the first that can deform a rectangle rather than recolour
# it. Every leg below has its other side read out of the Lua: a number spelled on this side is
# the second truth V49 pays not to have, and the failure each one hides is visual - exit 0,
# rdk -l 0, gate green, wrong on screen.
$v316Bad = @()

$sbFn316   = LuaFn $hh6 'sectionBox'
$ornFn316  = LuaFn $hh6 'ornament'
$themeM316 = [regex]::Match($hh6, 'local function applyTheme\(v, from\)(.*?)\n\t\t\tend;', 'Singleline')
$body316   = if ($themeM316.Success) { NoComments $themeM316.Groups[1].Value } else { '' }
$boxr316   = [regex]::Match($hh6, '(?m)^\s*local ORN_BOXR\s*=\s*([0-9.]+);')
$props316  = @('cornerType', 'xradius', 'yradius')

# Zero-guard FIRST: a leg that reads nothing passes for the wrong reason, and the whole point of
# this block is that nothing above it sees the feature at all (SPEC V209, V20).
if (-not $sbFn316)              { $v316Bad += "sectionBox is not in WoD20.6 - every leg below measures a selector that does not exist (SPEC V209)" }
if (-not $themeM316.Success)    { $v316Bad += "applyTheme could not be read - the corner write is unmeasurable, so legs (c) and (d) are no-ops (SPEC V209, V20)" }
if (-not $boxr316.Success)      { $v316Bad += "ORN_BOXR could not be read out of the Lua - leg (b) has no other side and states an opinion instead of a relation (SPEC V209)" }
if ($boxCornerAny -eq 0)        { $v316Bad += "no palette declares boxCorner - the coffin bevel of I89 is not in the sheet and this whole block is measuring nothing (SPEC V209)" }

# (a) the key is a TABLE with BOTH fields, and it cannot exist by halves. `type` has to be a
# value the SDK's enum actually answers to (SPEC R117) - anything else is a write the SDK
# ignores in silence - and `radius` has to be POSITIVE. A radius of 0 is not "a square corner":
# it UNMAKES the selector, because sectionBox reads c.xradius LIVE and a 0 refuses the box, so
# one number in Modern Nights would wipe the filigree off the other three eras on an OPEN sheet.
$enum316 = @('round', 'bevel', 'innerRound', 'innerLine')
if ($boxCornerAny -ne $boxCornerDecl.Count) {
    $v316Bad += "$boxCornerAny palette key(s) named boxCorner but only $($boxCornerDecl.Count) is the { type = ..., radius = ... } table this reads - a half-declared key is a corner nobody can measure (SPEC V316a, I89a)"
}
foreach ($ty316 in $boxCornerTypes) {
    if ($enum316 -notcontains $ty316) { $v316Bad += "a palette asks for cornerType '$ty316', which is not one of the $($enum316.Count) the SDK enum answers to ($($enum316 -join ', ')) - the setter would ignore it in silence and the box would keep the concave bite (SPEC V316a, R117)" }
}
foreach ($rd316 in $boxCornerRadii) {
    if ($rd316 -le 0) { $v316Bad += "a palette asks for radius $rd316 - a radius at or under 0 makes sectionBox REFUSE the box, which strips the filigree off every OTHER era rather than squaring one corner (SPEC V316a, V278)" }
}

# (b) REVOKED by the 118th round and moved to V317a (SPEC I90d). What this leg forbade was the
# PAIRING - boxCorner beside ornament - on the grounds that the filigree and the filete arc
# CONCAVE at ORN_BOXR + ORN_IN and would cross a cut corner. That reasoning is intact; the ban
# built on it is not, because `corrente` is a drawing made FOR the bevel. The rule became "the
# style and the corner AGREE", which is strictly larger: it still refuses a concave drawing on a
# cut corner AND it refuses the direction this ban let straight through - a bevelled era asking
# for `filete`. Deleting the leg without V317a landing in the same commit would leave that whole
# axis unmeasured, which is why T715 and T716 ship together.
#
# (e) stays here and rides the same walk: exactly ONE palette declares the corner and the other
# three fall to the XML. A second one is a new shape in an era nobody asked for, and the symptom
# shows up one era away from whoever caused it - the family of B6.
$declCorner316 = @()
foreach ($k316 in $themeKeys) {
    $pal316 = [regex]::Match($themesBlock, "(?ms)^\t{4}\[""$([regex]::Escape($k316))""\] = \{(.*?)^\t{4}\},")
    if (-not $pal316.Success) { $v316Bad += "palette '$k316' could not be read - leg (e) cannot see what it declares (SPEC V209)"; continue }
    $pb316 = [regex]::Replace($pal316.Groups[1].Value, '(?m)^\s*--.*$', '')
    if ($pb316 -match '(?m)^\s*boxCorner\s*=') { $declCorner316 += $k316 }
}
if ($declCorner316.Count -ne 2) {
    $v316Bad += "$($declCorner316.Count) palette(s) declare boxCorner ($($declCorner316 -join ', ')), expected exactly 2 since the 123rd round - Modern Nights cuts and Classical Age steps; the other two fall to the corner the XML authored, and a third changes the shape of an era nobody asked about (SPEC V316e, V324a, B6)"
}

# (c) the WAY BACK OUT is written down. paint() returns early on a nil value (V61), so a write
# of t.boxCorner ALONE would leave all 73 boxes beveled FOR EVER once Modern Nights had been on:
# rdk -l exits 0, this gate stays green, and the defect exists only on screen - B58 and B62 on a
# fourth axis. The value handed to paint has to mention the palette AND the authored value, and
# the authored one has to be the SAME expression paint records as the original: an `or` onto
# some other local would restore a corner the box never had.
#
# Anchored on the CONSTRUCTION and not on the spelling (SPEC V222): find the local the palette's
# table is read INTO, then demand each painted value mention that local. Grepping for the literal
# `t.boxCorner` at the three paint sites would redden the version that reads the table once - the
# one the code is written in - and green-light the one that reads it three times.
if ($body316) {
    $bcL316 = [regex]::Match($body316, '(?m)^\s*local\s+(\w+)\s*=\s*t\.boxCorner;')
    if (-not $bcL316.Success) { $v316Bad += "applyTheme never reads t.boxCorner - the palette cannot reach the corner it declares (SPEC I89c, V209)" }
    else {
        $bcN316 = [regex]::Escape($bcL316.Groups[1].Value)
        foreach ($pr316 in $props316) {
            $pm316 = [regex]::Match($body316, "paint\(c, ""$pr316"",\s*(.+?),\s*([A-Za-z_]\w*)\);")
            if (-not $pm316.Success) { $v316Bad += "applyTheme never paints ``$pr316`` - one of the three properties the coffin bevel is made of is not written at all (SPEC V209, I89c)"; continue }
            $val316 = $pm316.Groups[1].Value
            $org316 = $pm316.Groups[2].Value
            if ($val316 -notmatch "\b$bcN316\b") { $v316Bad += "the value painted onto ``$pr316`` never reads the palette's corner - that property would keep the authored value in every era and the bevel would come out half drawn (SPEC I89c)" }
            elseif ($val316 -notmatch "\bor\s+$([regex]::Escape($org316))\b") { $v316Bad += "the value painted onto ``$pr316`` does not fall back to the AUTHORED ``$org316`` - paint() returns early on nil (V61), so leaving Modern Nights would leave all 73 boxes beveled for ever, with exit 0 and this gate green (SPEC V316c, B58, B62)" }
        }
    }
}

# (d) the selector is ONE. sectionBox exists, BOTH callers ask it, and the test itself is not
# copied anywhere else - a second copy of "which rectangles are the boxes" is what V67 pays not
# to have, and the cost of the two drifting apart here is the 19 pills beveled with a width
# priced for the concave arc (V228). Counted on the construction rather than on a roster: the
# authored-black test is the line that would have to be duplicated.
if ($sbFn316 -and $body316 -notmatch 'sectionBox\(\s*c\s*,\s*fill\s*\)') {
    $v316Bad += "applyTheme never asks sectionBox - the corner write would run on every rectangle the sheet has (SPEC V316d, V228)"
}
if ($sbFn316 -and (NoComments $ornFn316) -notmatch 'sectionBox\(\s*c\s*,\s*fill\s*\)') {
    $v316Bad += "ornament() never asks sectionBox - the two callers would each carry their own idea of which rectangles are boxes (SPEC V316d, V67)"
}
$dupe316 = [regex]::Matches((NoComments $hh6), 'normColor\(\s*fill\s*\)\s*~=\s*"#FF000000"').Count
if ($dupe316 -ne 1) {
    $v316Bad += "the authored-black test appears $dupe316 time(s) in WoD20.6, expected exactly 1 - two copies of the selector drift apart in silence and the pills are what pays (SPEC V316d, V67)"
}

# (f) and V258's ruler READS the palettes rather than the XML alone. This is the one leg whose
# other side is in THIS file, so it is read out of this file - the same trick V312 uses. Modern
# Nights renders 18 on a rectangle whose XML says 14: a ruler that consults only the attribute
# measures the SMALLER bite and quietly covers less than the sheet draws, which is B7 by radius.
$gateSrc316 = [System.IO.File]::ReadAllText($PSCommandPath)
$v258Blk316 = [regex]::Match($gateSrc316, '(?ms)^# ---- V258:.*?^if \(\$arcSeen')
if (-not $v258Blk316.Success) { $v316Bad += "the V258 block could not be read out of this gate - leg (f) is a no-op (SPEC V209, V20)" }
elseif ($v258Blk316.Value -notmatch '\$boxCornerRadii') { $v316Bad += "V258 measures the corner bite from the XML attribute alone - it would price the 14 the XML spells while Modern Nights draws 18, and cover less than the sheet has (SPEC V316f, I89g, B7)" }

if ($v316Bad) { foreach ($b in $v316Bad) { Fail "V316 $b" } }
else { Pass "V316 one palette ($($declCorner316 -join ', ')) writes the corner as $($boxCornerTypes -join ', ')/$($boxCornerRadii -join ', '), all $($props316.Count) properties fall back to the authored value, and one sectionBox answers for both callers" }

# ---- V317: the DRAWING and the CORNER agree, and the radius has ONE owner ------------------
# SPEC I90, the 118th round. This is the heir of V316b: that leg forbade boxCorner beside
# ornament, which was the only thing measurable while every drawing was built for the concave
# corner. `corrente` is built FOR the bevel, so the ban becomes an AGREEMENT - and the agreement
# catches both directions where the ban caught one.
$v317Bad = @()

$pathFn317 = LuaFn $hh6 'ornPath'
$pathNC317 = NoComments $pathFn317
$sig317    = [regex]::Match($pathNC317, 'function\s+ornPath\s*\(([^)]*)\)')
$boxr317   = [regex]::Match($hh6, '(?m)^\s*local ORN_BOXR\s*=\s*([0-9.]+);')
$in317     = [regex]::Match($hh6, '(?m)^\s*local ORN_IN\s*=\s*([0-9.]+);')
$link317   = [regex]::Match($hh6, '(?m)^\s*local ORN_LINK\s*=\s*([0-9.]+);')
$stroke317 = [regex]::Match($hh6, '(?m)^\s*local THEME_STROKE = ([0-9.]+);')

$fam317 = ''
foreach ($fn317 in @('ornCorrenteRun', 'ornCorrenteCorner', 'ornCorrenteEdge', 'ornCorrente')) { $fam317 += (LuaFn $hh6 $fn317) }
$famNC317 = NoComments $fam317

# Zero-guard FIRST - a leg that reads nothing passes for the wrong reason (SPEC V209, V20).
if (-not $pathFn317)        { $v317Bad += "ornPath is gone from WoD20.6 - there is no dispatch to measure and every leg below is a no-op (SPEC V209)" }
if (-not $famNC317)         { $v317Bad += "the corrente family is not in WoD20.6 - the drawing this whole block measures does not exist (SPEC V209)" }
if (-not $link317.Success)  { $v317Bad += "ORN_LINK could not be read out of the Lua - leg (f) has no other side and states an opinion instead of a relation (SPEC V209)" }
if (-not $boxr317.Success)  { $v317Bad += "ORN_BOXR could not be read out of the Lua - leg (b) is a no-op (SPEC V209)" }
if (-not $in317.Success)    { $v317Bad += "ORN_IN could not be read out of the Lua - legs (e) and (f) are no-ops (SPEC V209)" }
if ($boxCornerAny -eq 0)    { $v317Bad += "no palette declares boxCorner - leg (a) has nothing to pair a style with (SPEC V209)" }

# (a) the STYLE and the CORNER agree, and WHICH styles are corner-aware is READ rather than
# spelled: a branch of ornPath that forwards the radius parameter is drawn to the box's OWN
# corner, and a branch that does not is drawn to ORN_BOXR, the concave one. So the equivalence
# the gate measures is
#
#     palette declares boxCorner  <=>  its style's branch forwards the radius
#
# with both sides out of the Lua. That refuses a concave drawing on a cut corner - what V316b
# bought - AND the direction V316b let through, a bevelled era asking for `filete`. The default
# branch must NOT forward it: an era with no style has no corner either.
#
# `bevel` is the one value spelled here, and deliberately: the chain's arithmetic is a 45 degree
# CUT, and `round` or `innerRound` would keep every relation below arithmetically valid while
# drawing the links across a curve. The SDK enum is already spelled in V316a for the same
# reason - there is no Lua-side declaration of "which corners are cuts" to read instead.
if ($pathFn317 -and $sig317.Success) {
    $args317 = @($sig317.Groups[1].Value -split ',' | ForEach-Object { $_.Trim() })
    $rad317  = if ($args317.Count -ge 4) { $args317[3] } else { '' }
    if (-not $rad317) { $v317Bad += "ornPath takes $($args317.Count) parameter(s) and no radius - the chain would have to find the bevel in a constant of its own, which is a second owner for the 18 the palette declares (SPEC V317d, B69)" }
    else {
        $aware317 = @()
        foreach ($m317 in [regex]::Matches($pathNC317, 'if style == "([^"]+)" then return ([^;]+); end;')) {
            if ($m317.Groups[2].Value -match ('\b' + [regex]::Escape($rad317) + '\b')) { $aware317 += $m317.Groups[1].Value }
        }
        $tail317 = [regex]::Match($pathNC317, '(?m)^\s*return\s+(\w+)\(([^)]*)\);')
        if ($tail317.Success -and $tail317.Groups[2].Value -match ('\b' + [regex]::Escape($rad317) + '\b')) {
            $v317Bad += "the DEFAULT branch of ornPath forwards the radius - an era that declares no style has no boxCorner either, so it would be drawn to a corner it does not have (SPEC V317a)"
        }
        foreach ($k317 in $themeKeys) {
            $pal317 = [regex]::Match($themesBlock, "(?ms)^\t{4}\[""$([regex]::Escape($k317))""\] = \{(.*?)^\t{4}\},")
            if (-not $pal317.Success) { $v317Bad += "palette '$k317' could not be read - leg (a) cannot see what it declares (SPEC V209)"; continue }
            $pb317 = [regex]::Replace($pal317.Groups[1].Value, '(?m)^\s*--.*$', '')
            $st317 = [regex]::Match($pb317, '(?m)^\s*ornStyle\s*=\s*"([^"]+)"')
            $bc317 = [regex]::Match($pb317, '(?m)^\s*boxCorner\s*=\s*\{\s*type\s*=\s*"([^"]*)"')
            $wants317 = $st317.Success -and ($aware317 -contains $st317.Groups[1].Value)

            if ($wants317 -and -not $bc317.Success) {
                $v317Bad += "palette '$k317' draws '$($st317.Groups[1].Value)', whose branch is built from the box's OWN corner, and declares no boxCorner - it would be drawn to the corner the XML authored, which is not the one it was designed for (SPEC V317a, I90d)"
            }
            elseif (-not $wants317 -and $bc317.Success) {
                $v317Bad += "palette '$k317' cuts the corner and draws $(if ($st317.Success) { "'$($st317.Groups[1].Value)'" } else { 'the default filigree' }), which is built to the CONCAVE ORN_BOXR ($($boxr317.Groups[1].Value)) - the rule would arc across the very outline it decorates, with nothing to say so (SPEC V317a, I90d)"
            }
            elseif ($wants317) {
                # Which SHAPE each radius-taking style was drawn for. Two entries since the 123rd
                # round, and the pair is NAMED here rather than derived: the geometry that proves
                # each one is measured by its own invariant - V317e for the chain across a 45
                # degree cut, V324c and V324d for the step - and this leg only has to say which
                # corner the palette is then allowed to declare. A style absent from the map is a
                # style nobody wrote an agreement for, and that is the loudest failure of the two.
                $shape317 = @{ 'corrente' = 'bevel'; 'corona-muralis' = 'innerLine' }
                $st317v = $st317.Groups[1].Value
                $bc317v = $bc317.Groups[1].Value
                if (-not $shape317.ContainsKey($st317v)) {
                    $v317Bad += "palette '$k317' draws '$st317v', which takes the radius and so declares a corner, but no agreement is written for it - the pair style/corner is read from both sides and a style with no side to read is B7 waiting (SPEC V317a, V209)"
                }
                elseif ($bc317v -ne $shape317[$st317v]) {
                    $v317Bad += "palette '$k317' cuts its corner as '$bc317v' and draws '$st317v', which was built for '$($shape317[$st317v])' - every relation below stays arithmetically valid and the drawing comes out across a corner that is not its own, with rdk -l exiting 0 (SPEC V317a, I90d, I97a)"
                }
            }
        }
    }
}

# (b) ORN_BOXR is the Lua's COPY of the radius the XML authors, and until this round nothing
# soldered the two - the 117th round declared the hole and this closes it. Move the XML and
# leave the constant and the filigree arcs at the old radius over the new corner, with rdk -l
# exiting 0 and the gate green. Both sides read: the constant here, the attribute off the boxes
# V68 already counts.
if ($boxr317.Success) {
    $xr317 = @{}
    $seen317 = 0
    foreach ($f in $files) {
        foreach ($r317 in (Doc $f.FullName).SelectNodes("//rectangle[@color='black'][@xradius]")) {
            $seen317++
            $xr317[$r317.GetAttribute("xradius")] = $true
        }
    }
    if ($seen317 -lt 60) { $v317Bad += "only $seen317 section box(es) were read for leg (b), expected at least 60 - it is measuring less than the sheet has (SPEC V209)" }
    elseif ($xr317.Keys.Count -ne 1) { $v317Bad += "the boxes author $($xr317.Keys.Count) different radii ($($xr317.Keys -join ', ')) - V68 should already have caught that, and leg (b) has no single number to solder to" }
    elseif ([double]($xr317.Keys | Select-Object -First 1) -ne [double]$boxr317.Groups[1].Value) {
        $v317Bad += "ORN_BOXR is $($boxr317.Groups[1].Value) and the XML authors $($xr317.Keys | Select-Object -First 1) on all $seen317 boxes - the filigree would arc to a radius the boxes no longer have (SPEC V317b, I90i)"
    }
    else { Pass "V317 ORN_BOXR ($($boxr317.Groups[1].Value)) is soldered to the radius all $seen317 boxes author" }
}

# (c) one style, one palette. The memo stamps the STYLE (V313c) and the drawing now depends on
# the RADIUS too - two palettes sharing a style with different radii would make the memo answer
# "already drawn" about a different drawing, on an OPEN sheet, with nothing to grep. The fix is
# this rule rather than a fifth field in ornPainted: state nobody has to maintain (SPEC I90g).
$styleSeen317 = @{}
foreach ($d317 in [regex]::Matches($hh6, '(?m)^\s*ornStyle\s*=\s*"([^"]+)"')) {
    $sv317 = $d317.Groups[1].Value
    if ($styleSeen317.ContainsKey($sv317)) { $v317Bad += "'$sv317' is declared by more than one palette - the memo's style stamp would no longer identify the radius, and switching between those two eras on an OPEN sheet keeps the first one's drawing (SPEC V317c, B58, B62)" }
    $styleSeen317[$sv317] = $true
}

# (d) every call to ornPath carries all four arguments. A call that drops the radius reaches the
# chain with nil and every coordinate below becomes a Lua error inside a path nobody reads.
if ($pathFn317 -and $sig317.Success) {
    $want317 = @($sig317.Groups[1].Value -split ',').Count
    foreach ($c317 in [regex]::Matches((NoComments $hh6), '(?<!function )\bornPath\s*\(([^)]*)\)')) {
        $got317 = @($c317.Groups[1].Value -split ',').Count
        if ($got317 -ne $want317) { $v317Bad += "an ornPath call passes $got317 argument(s) against a signature of $want317 - the missing one is the radius and the chain would be drawn from nil (SPEC V317d)" }
    }
}

# (e) the chain is RELATION, not literals. R, the cut and the pitch all fall out of the box's
# radius and ORN_IN, so the gate computes what they come to and demands those numbers do NOT
# appear spelled in the family. A literal on one side is the second truth V49 pays not to have,
# and what it hides is a link sitting off the cut - exit 0 everywhere, only the screen to tell.
if ($famNC317 -and $in317.Success -and $boxCornerRadii.Count -ge 1) {
    # Distinct names on purpose: PowerShell is case-INSENSITIVE, so $r317v and $R317v are one
    # variable, and a scalar times an array is array REPETITION rather than arithmetic - the
    # first draft of this leg built an Object[] and died on the division.
    $insetV = [double]($in317.Groups[1].Value)
    $radV   = [double](@($boxCornerRadii)[0])
    foreach ($rr317 in @($boxCornerRadii)) { if ([double]$rr317 -gt $radV) { $radV = [double]$rr317 } }
    $k45317 = [Math]::Sqrt(2) - 1
    $runV   = $radV + ($insetV * $k45317)
    $cutV   = ([Math]::Sqrt(2) * $radV) - (2 * $insetV * $k45317)
    $pitchV = $cutV / 3
    foreach ($lit317 in @($runV, $cutV, $pitchV)) {
        $rx317 = '(?<![\w.])' + [regex]::Escape([Math]::Round($lit317, 1).ToString([Globalization.CultureInfo]::InvariantCulture)) + '(?![\w.])'
        $rx317b = '(?<![\w.])' + [regex]::Escape([Math]::Round($lit317).ToString()) + '(?![\w.])'
        if ($famNC317 -match $rx317 -or ($lit317 -eq [Math]::Round($lit317) -and $famNC317 -match $rx317b)) {
            $v317Bad += "the corrente family spells $([Math]::Round($lit317, 2)), which is what the radius and ORN_IN already come to - a literal on one side stops moving when the other does (SPEC V317e, V49)"
        }
    }
    $run317 = NoComments (LuaFn $hh6 'ornCorrenteRun')
    if ($run317 -notmatch 'math\.sqrt\s*\(\s*2\s*\)') { $v317Bad += "ornCorrenteRun does not compute the 45 degree offset from sqrt(2) - the inset of a CUT corner is not the inset of a curve (SPEC V317e)" }
    if ($run317 -notmatch '\bORN_IN\b') { $v317Bad += "ornCorrenteRun does not read ORN_IN - the run would sit at an inset of its own and drift from the one the user approved (SPEC V317e, V315b)" }
    if ($famNC317 -notmatch '/\s*3\b') { $v317Bad += "the corrente family never divides the cut in three - the three links are what the plate is, and a hard-coded pitch stops following the cut (SPEC V317e)" }
    if ($famNC317 -match 'return "";') { $v317Bad += "the corrente refuses a box by size - the cut is the same on every box (I90e), so a refusal here can only ever be the silent skip of B59 (SPEC V317e, V314e)" }
}

# (f) and it borrows V314's two ceilings rather than inventing clearances. Outward the link may
# not reach the 3px outline the theme paints on every box; inward it may not reach the 20px
# margin every box gives its children. Both are the numbers the CROSS already answers to.
if ($link317.Success -and $in317.Success -and $stroke317.Success) {
    $lk317 = [double]$link317.Groups[1].Value
    $dd317 = [double]$in317.Groups[1].Value
    $ss317 = [double]$stroke317.Groups[1].Value
    if ($lk317 -ge ($dd317 - $ss317)) { $v317Bad += "ORN_LINK is $lk317 and reaches $($dd317 - $lk317) out, into the $($ss317)px outline the theme paints on every box - the ceiling is $($dd317 - $ss317) (SPEC V317f, V314b, V67)" }
    if (($dd317 + $lk317) -gt 20) { $v317Bad += "the link reaches $($dd317 + $lk317)px into the box, at or past the 20px margin I73 gives every one - drawn on TOP it would strike through the children (SPEC V317f, V314c)" }
}

if ($v317Bad) { foreach ($b in $v317Bad) { Fail "V317 $b" } }
else { Pass "V317 the cut corner and the chain agree - the style whose branch reads the box's own radius is the one whose palette cuts it - the run stops $([Math]::Round($runV, 2)) in, the cut it leaves is $([Math]::Round($cutV, 2)) long and each of the three links spans $([Math]::Round($pitchV, 2)), none of them spelled in the Lua, and the link clears both of V314's ceilings" }
# ---- V304: the open tab is marked in all FOUR eras, and the line is thin (SPEC I78a, I78e)
# This replaces V282 whole. V282 tied the bar's line work to `ornament`, which only the Victorian
# palette declares - so the marker existed in ONE era of four and the sheet opened with no tab
# looking open in the other three. That is V229's failure shape, arriving through the door the
# check meant to guard it.
#
# The carrier is transparent BOTH ways and authors no sides: a rectangle that draws anything at
# all draws it 3px thick, because applyTheme writes THEME_STROKE onto every rectangle it repaints
# (SPEC V67), and the drawing the user picked is a hairline. So the rectangle carries and the
# path draws - and the path is fed the era's stroke accent, which all four palettes have.
$v304Bad = @()
$carriers304 = 0
foreach ($pr304 in @(@("WoD20th.lfm", "tabStrip"), @("WoD20.11.lfm", "vampStrip"), @("WoD20.7.lfm", "numStrip"), @("WoD20.7.lfm", "hedgeStrip"))) {
    $st304 = (Doc (Join-Path $dir $pr304[0])).SelectSingleNode("//layout[@name='$($pr304[1])']")
    if ($null -eq $st304) { $v304Bad += "$($pr304[1]) is gone from $($pr304[0]) (SPEC I32, I58, V209)"; continue }
    foreach ($on304 in $st304.SelectNodes("rectangle[starts-with(@name,'tabOn')]")) {
        $carriers304++
        $nm304 = $on304.GetAttribute("name")

        # (a) transparent both ways, and no sides - a CARRIER, not a drawing.
        if ($on304.GetAttribute("color") -ne '#00000000') {
            $v304Bad += "$nm304 is filled '$($on304.GetAttribute('color'))' - the marker carries a path now and paints nothing itself (SPEC I78a)"
        }
        if ($on304.GetAttribute("strokeColor") -ne '#00000000') {
            $v304Bad += "$nm304 authors strokeColor='$($on304.GetAttribute('strokeColor'))' - applyTheme would hand it the 3px rule of V67 and the drawing is a 1px hairline (SPEC I78a, V67)"
        }
        if ($on304.GetAttribute("sides")) {
            $v304Bad += "$nm304 authors sides='$($on304.GetAttribute('sides'))' - that was the 108th round's foot rule, and it comes back at 3px over the path that replaced it (SPEC I78a)"
        }

        # (c) authored hidden, because applyTabVisibility and renderSubTabs are what light it -
        # and the path rides that same visible, which is why it needs no state of its own.
        if ($on304.GetAttribute("visible") -ne 'false') {
            $v304Bad += "$nm304 is authored visible='$($on304.GetAttribute('visible'))' - the sheet would open with every tab marked at once, until the first render (SPEC V94, I78a)"
        }
    }
}

# (b) the colour the painter is handed comes from the STROKE map, which all four palettes key,
# and never from t.ornament, which one of them declares. This is the whole of why V282 died.
if ($hh6 -notmatch '(?m)^\s*local accent = t\.stroke\[normColor\("#FFFFFF"\)\];') {
    $v304Bad += "applyTheme does not read the era's accent out of t.stroke - without it the bar has no colour that exists in all four palettes (SPEC I78e, V304b)"
}
if ($hh6 -match '(?m)^\s*markRule\([^\r\n]*t\.ornament') {
    $v304Bad += "markRule is handed t.ornament - only the Victorian palette declares one, so the open tab would vanish in three eras of four with nothing red anywhere (SPEC I78e, V229, B66)"
}

if ($carriers304 -lt 19) { Fail "V304 only $carriers304 marker carrier(s) were read, expected 19 - this check is covering less than the four bars hold (SPEC V209)" }
elseif ($v304Bad) { foreach ($b in $v304Bad) { Fail "V304 $b" } }
else { Pass "V304 all $carriers304 markers are transparent carriers authored hidden, and the painter is handed the era's stroke accent - so the open tab shows in every era, at 1px" }


# ---- V306: one painter, three motifs, each picked by construction (SPEC I78b, I78d) -----
# The old filter - transparent fill plus the house radius - died when the button lost its box:
# since I77a both halves of every pair match it. What tells them apart now is the NAME, and the
# level comes from the bar the control sits in. That is one name read (tabStrip) and two family
# prefixes, which is the idiom note<X> and lbl<X> already established - not a roster of 24.
#
# (c) is why nothing here knows which tab is open: the path is a CHILD of the carrier, and the
# carrier's visible is already written by applyTabVisibility and renderSubTabs. A second opinion
# on that is exactly what V227 keeps off the sheet.
$v306Bad = @()
$markFn = LuaFn $hh6 'markRule'
$markKindFn = LuaFn $hh6 'markKind'
$markGeo = LuaFn $hh6 'markPath'
if (-not $markFn) { Fail "V306 markRule is gone from WoD20.6 - the bar has no painter to measure (SPEC I78e, V209)" }
elseif (-not $markKindFn) { Fail "V306 markKind is gone - nothing picks the motif and (b) has nothing to read (SPEC I78b, V209)" }
elseif (-not $markGeo) { Fail "V306 markPath is gone - the marker has no geometry of its own and only ornPath is left, which is the frame R111 refused (SPEC R111, V306)" }
else {
    $markBody = NoComments $markFn
    $kindBody = NoComments $markKindFn
    $geoBody = NoComments $markGeo

    # (a) it runs off the SAME traversal the boxes do, and it is handed the era's accent. A
    # painter nothing calls is the state I72 shipped in until the 98th round specced it.
    if ($hh6 -notmatch '(?m)^\s*markRule\(\s*c\s*,\s*nm\s*,\s*accent\s*\);') {
        $v306Bad += "nothing calls markRule with the name and the era's accent - the bar would never be drawn and no other check would notice (SPEC I78e, V306a)"
    }

    # (b) three motifs, and the two families are CLOSED - every control the painter accepts is
    # named tabOn* or sep*, and the level is read off the parent bar.
    foreach ($lit306 in @('"sep"', '"tabOn"', '"tabStrip"', '"sub"', '"tab"')) {
        if ($kindBody -notmatch [regex]::Escape($lit306)) {
            $v306Bad += "markKind never mentions $lit306 - one of the three motifs cannot be reached, and an unreachable branch is a drawing that silently never appears (SPEC I78b, V306b)"
        }
    }
    if ($kindBody -notmatch '\.parent') {
        $v306Bad += "markKind does not read the parent bar - without the level the top bar and a sub-bar get the same motif and the hierarchy the user asked for is gone (SPEC I78b, V306b)"
    }
    foreach ($k306 in @('"sep"', '"sub"')) {
        if ($geoBody -notmatch [regex]::Escape($k306)) {
            $v306Bad += "markPath has no branch for kind $k306 - markKind hands it a motif the geometry does not know and the path comes out empty (SPEC I78b, V306b)"
        }
    }

    # every sep<X> names a real sub-tab: an orphan separator raises nothing at runtime, it just
    # stands there forever between two names that are not there. Same shape as V300a.
    $subNames306 = @()
    foreach ($g306 in @($subTabRe.Matches($rootTxt))) {
        foreach ($m306 in [regex]::Matches($g306.Groups[1].Value, '"([^"]+)"')) { $subNames306 += $m306.Groups[1].Value }
    }
    $seps306 = 0
    $carr306 = 0
    foreach ($f in $files) {
        foreach ($s306 in (Doc $f.FullName).SelectNodes("//rectangle[starts-with(@name,'sep')]")) {
            $seps306++
            $sn306 = $s306.GetAttribute("name").Substring(3)
            if ($subNames306 -notcontains $sn306) { $v306Bad += "$($f.Name) 'sep$sn306' names no sub-tab in SUB_TABS - a separator between two names that do not exist (SPEC I78d, V306b)" }
            if ($s306.GetAttribute("hitTest") -ne 'false') { $v306Bad += "sep$sn306 authors hitTest='$($s306.GetAttribute('hitTest'))' - it sits over the gap between two buttons and would eat the click meant for one of them (SPEC I78d)" }
            if ($s306.GetAttribute("color") -ne '#00000000' -or $s306.GetAttribute("strokeColor") -ne '#00000000') { $v306Bad += "sep$sn306 is not transparent both ways - it carries a path and paints nothing itself, exactly like the markers (SPEC I78d, I78a)" }
        }
        foreach ($c306 in (Doc $f.FullName).SelectNodes("//rectangle[starts-with(@name,'tabOn')]")) { $carr306++ }
    }
    if ($seps306 -ne 5) { $v306Bad += "$seps306 separator(s) on the sheet, expected 5 - two on vampStrip, two on numStrip, one on hedgeStrip (SPEC I78d, V209)" }

    # (c) created once, parented to the carrier, hidden and never destroyed (SPEC V277).
    if ($markBody -notmatch 'setParent\(\s*c\s*\)') {
        $v306Bad += "the path is not parented to the control the painter picked - on the strip itself an align='client' child fills the whole band, and the carrier's visible would stop hiding it (SPEC I78b, V306c, V283a)"
    }
    if ($markBody -notmatch 'visible\s*=\s*false;') { $v306Bad += "the line work is never hidden - the painter must be able to take it back, the way V277 promises for the filigree (SPEC V277, V306c)" }
    if ($markBody -match 'destroy') { $v306Bad += "the line work is DESTROYED rather than hidden - the memo would keep a dead handle (SPEC V277, V306c)" }
    if ($markBody -notmatch '\bmarkPath\s*\(') { $v306Bad += "markRule does not build its path from markPath - the marker's motif is its own (SPEC R111)" }
    if ($markBody -match '\bornPath\s*\(') { $v306Bad += "markRule reaches for ornPath - 2*ORN_ARM is 80 and a marker is 30 tall, which is the frame R111 ruled out (SPEC R111)" }

    $targets306 = $carr306 + $seps306
    if ($targets306 -lt 24) { Fail "V306 the painter has $targets306 target(s) on the sheet, expected 24 - 19 markers and 5 separators; a painter with nothing to paint passes forever (SPEC V209, B7)" }
    elseif ($v306Bad) { foreach ($b in $v306Bad) { Fail "V306 $b" } }
    else { Pass "V306 one painter reaches $targets306 targets - 19 markers and 5 separators - picks its motif from the name and the bar, and hangs the path on the carrier that already knows which tab is open" }
}

# ---- V280: what a section box is spaced BY (SPEC I73, V280, user 2026-08-24) -----------
# TWO legs since the 107th round - (b), the gap between two boxes, left for V298 when the user
# took it from 20 to 15 to 10 to 5 (SPEC I76a). What is left here is the INTERNAL margin,
# still 20 - the two numbers diverge by 4x now, and V298 is the single owner of the gap (B70).
# What they replace is the thing that made I73 necessary in the first place: a
# mixture of 10, 15 and 20 measured across the sheet on 2026-08-24, every one of them derived
# box by box because nothing here held a single number for either question.
#
# The box is told by CONSTRUCTION, the sentence V278 already uses on the Lua side - a <layout>
# wearing a black rectangle with a corner radius of its own. Naming 73 boxes here instead
# would go stale the first time one is added, and the count below is what says so out loud.
#
# (c) is a rule about this CHECK, not about the sheet: no leg reads the left or top of a child
# carrying rotationAngle. For a rotated label those are the PRE-rotation box - the three
# ATTRIBUTES headings author left=-20 and render inside the box - so reading them as margin
# reddens code that is right. V27, V239 and V240 all cut the same way already, and this one
# INHERITS the cut rather than inventing another: reading their silence as a hole is B61.
$v280Bad = @()
$v280Boxes = @()
$v280Rot = 0
foreach ($f in $files) {
    foreach ($box in (Doc $f.FullName).SelectNodes("//layout[rectangle[@color='black'][@xradius]]")) {
        $bl = 0; $bt = 0; $bw = 0; $bh = 0
        if (-not ([int]::TryParse($box.GetAttribute("width"), [ref]$bw) -and [int]::TryParse($box.GetAttribute("height"), [ref]$bh))) { continue }
        [void][int]::TryParse($box.GetAttribute("left"), [ref]$bl)
        [void][int]::TryParse($box.GetAttribute("top"), [ref]$bt)
        $t280 = $box.SelectSingleNode("label[@horzTextAlign='center']")
        $v280Boxes += [pscustomobject]@{
            F = $f.Name; N = $(if ($t280) { $t280.GetAttribute("text") } else { '(untitled)' })
            L = $bl; T = $bt; W = $bw; H = $bh; Node = $box; P = $box.ParentNode }
    }
}
if ($v280Boxes.Count -ne 73) { Fail "V280 $($v280Boxes.Count) section box(es) were collected, expected the 73 I73 measures - the construction filter stopped matching and both legs below would be reading a fraction of the sheet (SPEC V209, I73)" }
else {
    # (a) 20 on all four sides. A FLOOR and not an equality, for V240's reason: HEALTH on Main,
    # HEALTH on Combat and SPECIALTIES are welded to the line V69 draws and carry the 22px it
    # owes them INSIDE the box, which the user chose over a 42px gap above it (SPEC B63).
    foreach ($b in $v280Boxes) {
        $ml = [int]::MaxValue; $mr = [int]::MaxValue; $mt = [int]::MaxValue; $mb = [int]::MaxValue
        foreach ($k in $b.Node.ChildNodes) {
            if ($k.NodeType -ne 'Element') { continue }
            if ($k.LocalName -in @('dataLink', 'script', 'event', 'template')) { continue }
            if ($k.GetAttribute("align") -eq 'client') { continue }              # the backdrop, and anything else filling the box
            if ($k.LocalName -eq 'rectangle' -and $k.GetAttribute("left") -eq '0' -and $k.GetAttribute("top") -eq '0') { continue }
            if ($k.HasAttribute("rotationAngle")) { $v280Rot++; continue }       # (c)
            $kl = 0; $kt = 0; $kw = 0; $kh = 0
            if (-not ([int]::TryParse($k.GetAttribute("left"), [ref]$kl) -and [int]::TryParse($k.GetAttribute("top"), [ref]$kt))) { continue }
            [void][int]::TryParse($k.GetAttribute("width"), [ref]$kw)
            [void][int]::TryParse($k.GetAttribute("height"), [ref]$kh)
            if ($kl -lt $ml) { $ml = $kl }
            if ($kt -lt $mt) { $mt = $kt }
            if (($b.W - $kl - $kw) -lt $mr) { $mr = $b.W - $kl - $kw }
            if (($b.H - $kt - $kh) -lt $mb) { $mb = $b.H - $kt - $kh }
        }
        if ($ml -eq [int]::MaxValue) { $v280Bad += "$($b.F) '$($b.N)' holds nothing this leg can measure - a box with no placed child is a box with no margin to read (SPEC V209)"; continue }
        if ($ml -lt 20 -or $mr -lt 20 -or $mt -lt 20 -or $mb -lt 20) {
            $v280Bad += "$($b.F) '$($b.N)' ($($b.W)x$($b.H)) leaves L=$ml R=$mr T=$mt B=$mb - every side of a section box clears 20 (SPEC I73, V280a)"
        }
    }
    # (c) zero-guard: the exclusion has to FIRE. If the three rotated headings ever stop being
    # matched - renamed attribute, a different way of turning them - this leg goes quiet and
    # (a) starts reading a pre-rotation box as a margin, which is B61 arriving a second time.
    if ($v280Rot -eq 0) { $v280Bad += "no rotated child was skipped by (a) - the cut V27/V239/V240 make is not firing here, and the next rotated label would be read as a margin it is not (SPEC V209, V280c, B61)" }

    if ($v280Bad) { foreach ($b in $v280Bad) { Fail "V280 $b" } }
    else { Pass "V280 all $($v280Boxes.Count) section boxes clear 20 on four sides, and $v280Rot rotated child(ren) were cut out of the margin" }
}

# ---- V298: the gap BETWEEN two section boxes (SPEC I76a, V298, user 2026-08-25) --------
# This IS V280b, moved out and re-numbered when it split off; the NUMBER since then is amended in
# place - 20 on the 98th, 15 on the 108th, 10 on the 110th, 5 here - only the literal moves, and a third
# name for one rule is what T664 chose against. The old value is gone rather than tolerated: two
# rules over one gap is the shape B7 warns about, and a check that accepts either number accepts
# the drift it exists to catch - so the mutation this check owes is 10, the value of the round
# just gone, not the 20 nobody would author by accident any more.
#
# 5 and the INTERNAL margin of 20 are DIFFERENT numbers, on purpose (SPEC I76a), and they now
# diverge by 2x: the margin pays for the ornament's palmette, which reaches 23 on the diagonal,
# and a gap pays for nothing at all - at 5 it no longer even parts the two 3px strokes it sits
# between, it BUTTS them (SPEC I76a: centred stroke leaves ~2px of air, inset leaves 5 - the
# screen answers that, T678 asks it). V280a keeps the 20, this keeps the 5, and they are 4x apart.
#
# BOTH axes, because B52 cost a whole round proving a mutation on X says nothing about Y
# (SPEC V222), and Y is the axis that carried the 5px of WoD20.4 when I73 first measured the
# sheet, while X had nothing below 10 even then.
#
# Neighbours, not every pair: two boxes under one parent that face each other with no third
# box standing between them. Scope is box-to-box ONLY - button-to-button (4) and bar-to-pane
# (12 and 4) belong to V281/V299 and V232, and I76a names them as staying out, so reddening
# on them would be a false alarm on numbers this round agreed not to touch.
if ($v280Boxes.Count -ne 73) { Fail "V298 $($v280Boxes.Count) section box(es) were collected, expected the 73 I73 measures - with the collector broken this leg reads a fraction of the sheet (SPEC V209, I73)" }
else {
    $v298Bad = @()
    $gapsX = 0; $gapsY = 0
    foreach ($grp in ($v280Boxes | Group-Object { $_.F + '|' + $_.P.GetHashCode() })) {
        $arr = @($grp.Group)
        foreach ($a in $arr) { foreach ($c in $arr) {
            if ([object]::ReferenceEquals($a, $c)) { continue }
            if (($a.T -lt ($c.T + $c.H)) -and ($c.T -lt ($a.T + $a.H)) -and ($c.L -ge ($a.L + $a.W))) {
                $between = $false
                foreach ($m in $arr) {
                    if ([object]::ReferenceEquals($m, $a) -or [object]::ReferenceEquals($m, $c)) { continue }
                    if (($m.T -lt ($c.T + $c.H)) -and ($c.T -lt ($m.T + $m.H)) -and ($m.L -ge ($a.L + $a.W)) -and (($m.L + $m.W) -le $c.L)) { $between = $true; break }
                }
                if (-not $between) {
                    $gapsX++
                    $g = $c.L - ($a.L + $a.W)
                    if ($g -ne 5) { $v298Bad += "$($a.F) '$($a.N)' closes at x=$($a.L + $a.W) and '$($c.N)' opens at x=$($c.L) - $($g)px between two section boxes where the house leaves 5 (SPEC I76a, V298)" }
                }
            }
            if (($a.L -lt ($c.L + $c.W)) -and ($c.L -lt ($a.L + $a.W)) -and ($c.T -ge ($a.T + $a.H))) {
                $between = $false
                foreach ($m in $arr) {
                    if ([object]::ReferenceEquals($m, $a) -or [object]::ReferenceEquals($m, $c)) { continue }
                    if (($m.L -lt ($c.L + $c.W)) -and ($c.L -lt ($m.L + $m.W)) -and ($m.T -ge ($a.T + $a.H)) -and (($m.T + $m.H) -le $c.T)) { $between = $true; break }
                }
                if (-not $between) {
                    $gapsY++
                    $g = $c.T - ($a.T + $a.H)
                    if ($g -ne 5) { $v298Bad += "$($a.F) '$($a.N)' closes at y=$($a.T + $a.H) and '$($c.N)' opens at y=$($c.T) - $($g)px between two section boxes where the house leaves 5 (SPEC I76a, V298)" }
                }
            }
        } }
    }
    if ($gapsX -eq 0 -or $gapsY -eq 0) { $v298Bad += "measured $gapsX gap(s) on X and $gapsY on Y - an axis with no gap read is an axis with no rule, which is exactly the half of B52 that shipped green (SPEC V209, V222)" }
    if ($v298Bad) { foreach ($b in $v298Bad) { Fail "V298 $b" } }
    else { Pass "V298 $gapsX gaps on X and $gapsY on Y between section boxes are all 5 apart" }
}

# ---- V281: what a tab BUTTON is spaced by, HORIZONTALLY (SPEC I73, V281, T616) ---------
# The same request as V280, one level out: 30 in from the end of the bar it opens, and the 4
# between two buttons left alone because it was the one number the four bars already agreed on.
#
# The VERTICAL half - 15 above and below each pill - left for V299 in the 107th round, when the
# user took it to 5 and the four bars went 60 -> 40 (SPEC I76b). Nothing here loosened: the leg
# moved whole, and what stayed is the axis the request did not touch.
#
# Leg (c) is NOT the sentence V281 was written with. "The last button closes 30 before the end"
# describes a bar whose buttons fill it edge to edge, and none of the four is: a pill is as wide
# as its own text (SPEC V228), so the last one closes wherever the words stop - measured on
# 2026-08-24, 450px short on vampStrip, 949 on numStrip, 1191 on hedgeStrip. Asking for slack of
# exactly 30 would redden three bars that are right. What it becomes instead (user decision, the
# 104th round) is the thing that sentence was protecting: the bar FITS its buttons - the last one
# closes inside it with the 30 margin still to spare, so adding a tab without widening the bar
# reddens here. tabStrip authors no width at all - it is align-driven and the XML reads 0 - so it
# is counted OUT of (c) and the count is printed, rather than skipped in a silence that would read
# as coverage (SPEC B7, V209).
$v281Bad = @()
$v281Pills = 0; $v281Bars = 0; $v281Fit = 0; $v281NoWidth = 0
foreach ($f in $files) {
    foreach ($bar in (Doc $f.FullName).SelectNodes("//layout[rectangle[starts-with(@name,'btnTab')]]")) {
        $barW = 0; $barH = 0
        if (-not [int]::TryParse($bar.GetAttribute("height"), [ref]$barH)) { continue }
        [void][int]::TryParse($bar.GetAttribute("width"), [ref]$barW)
        $pills = @($bar.SelectNodes("rectangle[starts-with(@name,'btnTab')]") | ForEach-Object {
            $pl = 0; $pt = 0; $pw = 0; $ph = 0
            [void][int]::TryParse($_.GetAttribute("left"), [ref]$pl); [void][int]::TryParse($_.GetAttribute("top"), [ref]$pt)
            [void][int]::TryParse($_.GetAttribute("width"), [ref]$pw); [void][int]::TryParse($_.GetAttribute("height"), [ref]$ph)
            [pscustomobject]@{ L = $pl; T = $pt; W = $pw; H = $ph; N = $_.GetAttribute("name") } } | Sort-Object L)
        if ($pills.Count -eq 0) { continue }
        $v281Bars++; $v281Pills += $pills.Count
        $bn = $bar.GetAttribute("name")

        # (b) the first button opens 30 in, the horizontal half of the same margin.
        if ($pills[0].L -ne 30) { $v281Bad += "$($f.Name) $bn opens its first button at left=$($pills[0].L) - the bar hands over 30 before the first pill (SPEC I73, V281b)" }
        # (c) the bar FITS: see the note above for why this is not "closes at exactly 30".
        if ($barW -le 0) { $v281NoWidth++ }
        else {
            $v281Fit++
            $end = $pills[-1].L + $pills[-1].W
            if (($end + 30) -gt $barW) { $v281Bad += "$($f.Name) $bn closes its last button at $end in a bar $($barW)px wide - the bar has to hold its buttons and the 30 margin after them, or a tab added tomorrow runs off the end (SPEC V281c, V228)" }
        }
        # (d) 4 between two buttons - frozen on purpose, and frozen is not unmeasured.
        for ($i = 1; $i -lt $pills.Count; $i++) {
            $pg = $pills[$i].L - ($pills[$i - 1].L + $pills[$i - 1].W)
            if ($pg -ne 4) { $v281Bad += "$($f.Name) $($pills[$i].N) sits $($pg)px from the button before it - the gap between two pills is 4 and T616 left it alone deliberately (SPEC I73, V281d)" }
        }
    }
}
if ($v281Bars -ne 4 -or $v281Pills -ne 19) { Fail "V281 $v281Pills button(s) were read across $v281Bars bar(s), expected the 19 across 4 that I73 measures - this check is covering less than the sheet has (SPEC V209, I73)" }
elseif ($v281Fit -eq 0) { Fail "V281 no bar was measured for fit by (c) - every one of the four came back without an authored width, so the leg is a no-op (SPEC V209, V20)" }
elseif ($v281Bad) { foreach ($b in $v281Bad) { Fail "V281 $b" } }
else { Pass "V281 all $v281Pills tab buttons open 30 in and sit 4 apart; $v281Fit of $v281Bars bars hold their buttons plus the margin ($v281NoWidth author no width and is align-driven)" }

# ---- V299: the bar is 40 tall and its panes came down with it (SPEC I76b, V299) --------
# This is V281a, moved out and re-numbered because the number changed: 15 above and below a
# 30px pill became 5, so the four bars went 60 -> 40 (user 2026-08-25, "diminuir bastante a
# altura"). The old leg is gone rather than loosened, for V298's reason: two rules over one
# gap is B7. The HORIZONTAL half of I73 - 30 in from the end, 4 between two pills - did not
# move and stays in V281, which is why that check keeps three legs and loses one.
#
# (a) is a RELATION, not a literal: the bar measures twice the pill's top plus the pill. A
# bar shrunk with one pill left behind reddens, and so does a pill moved inside a bar that
# stayed - both sides of one equation, which is what V222 asks of a relation.
#
# (b) is LITERAL and says so. The three ABSOLUTE bars carry their panes; tabStrip is
# align="top" and the scrollBox under it reflows on its own, which is what I74a bought when
# it zeroed the top gap. Nothing else would catch a bar that shrank while its panes stayed:
# V262a asks only that a pane open at or below the end of the bar, so a 20px hole reads
# GREEN there. The two numbers are I73's, frozen on purpose, and this is their only reader
# in the gate. V293 could measure hedgeStrip as a relation because that bar has content on
# both sides of it; numStrip and vampStrip have one side, and inventing a relation where the
# second side does not exist is how B64 was born.
$v299Bad = @()
$v299Bars = 0; $v299Pills = 0
$v299Panes = @{
    'numStrip'   = @{ File = 'WoD20.7.lfm';  Gap = 12; Panes = @('tabHedge', 'tabPsychic', 'tabFaith') }
    'hedgeStrip' = @{ File = 'WoD20.7.lfm';  Gap = 12; Panes = @('tabHedgePaths', 'tabHedgeRituals') }
    'vampStrip'  = @{ File = 'WoD20.11.lfm'; Gap = 4;  Panes = @('tabDisc', 'tabPaths', 'tabRituals') }
}
$v299Seen = @{}
foreach ($f in $files) {
    $doc299 = Doc $f.FullName
    foreach ($bar in $doc299.SelectNodes("//layout[rectangle[starts-with(@name,'btnTab')]]")) {
        $barH = 0
        if (-not [int]::TryParse($bar.GetAttribute("height"), [ref]$barH)) { continue }
        $pills = @($bar.SelectNodes("rectangle[starts-with(@name,'btnTab')]") | ForEach-Object {
            $pt = 0; $ph = 0
            [void][int]::TryParse($_.GetAttribute("top"), [ref]$pt); [void][int]::TryParse($_.GetAttribute("height"), [ref]$ph)
            [pscustomobject]@{ T = $pt; H = $ph; N = $_.GetAttribute("name") } })
        if ($pills.Count -eq 0) { continue }
        $v299Bars++; $v299Pills += $pills.Count
        $bn = $bar.GetAttribute("name")

        # (a) height = 2 * pill top + pill height, and every pill in the bar agrees on both.
        foreach ($p in $pills) {
            if ((2 * $p.T + $p.H) -ne $barH) {
                $v299Bad += "$($f.Name) $($p.N) sits $($p.T) from the top of a $($barH)px bar around a $($p.H)px pill - the bar is twice the pill's top plus the pill, which is 40 around the 30 the house draws (SPEC I76b, V299a)"
            }
            if (($barH - $p.T - $p.H) -ne $p.T) {
                $v299Bad += "$($f.Name) $($p.N) leaves $($barH - $p.T - $p.H) under it and $($p.T) over it - a tab button breathes the same on both (SPEC I76b, V299a)"
            }
        }

        # (b) the panes of an ABSOLUTE bar open the frozen gap under it.
        if ($v299Panes.ContainsKey($bn)) {
            $spec = $v299Panes[$bn]
            $v299Seen[$bn] = $true
            $barT = 0
            if (-not [int]::TryParse($bar.GetAttribute("top"), [ref]$barT)) {
                $v299Bad += "$($f.Name) $bn authors no top - an absolute bar whose own position cannot be read cannot be measured against the panes it carries (SPEC V209, V299b)"
            } else {
                foreach ($pn in $spec.Panes) {
                    $pane = $doc299.SelectSingleNode("//layout[@name='$pn']")
                    if ($pane -eq $null) { $v299Bad += "$($f.Name) pane '$pn' was not found under $bn - V299b is measuring nothing for it (SPEC V209)"; continue }
                    $paneT = 0
                    if (-not [int]::TryParse($pane.GetAttribute("top"), [ref]$paneT)) { $v299Bad += "$($f.Name) pane '$pn' authors no top (SPEC V209, V299b)"; continue }
                    $g299 = $paneT - ($barT + $barH)
                    if ($g299 -ne $spec.Gap) {
                        $v299Bad += "$($f.Name) '$pn' opens $($g299)px under $bn, which ends at $($barT + $barH) - I73 froze that gap at $($spec.Gap), and a bar that shrank without its panes leaves exactly this hole with V262a still green (SPEC I76b, V299b)"
                    }
                }
            }
        }
    }
}
if ($v299Bars -ne 4 -or $v299Pills -ne 19) { Fail "V299 $v299Pills button(s) were read across $v299Bars bar(s), expected the 19 across 4 that I73 measures - this check is covering less than the sheet has (SPEC V209, I73)" }
elseif ($v299Seen.Count -ne 3) { Fail "V299 (b) reached $($v299Seen.Count) of the 3 absolute bars - a bar that stopped being found takes its panes out of the check in silence, which is B7 (SPEC V209)" }
elseif ($v299Bad) { foreach ($b in $v299Bad) { Fail "V299 $b" } }
else { Pass "V299 all $v299Pills tab buttons breathe the same above and below across $v299Bars bars, and the 8 panes of the 3 absolute bars open the gap I73 froze" }


# ---- V300: the caption lives and dies with the pane it explains (SPEC I76c, V300) ------
# The affinity note is a caption for tabHedgePaths that cannot live inside it: the pane is 472
# tall, its seventeen rows measure 466, and the note plus its gap wants 30 more, which is why
# the 91st round parked it on hedgeStrip. Parked there it also stood over Rituals, explaining a
# list that was not on screen - the user's report of 2026-08-25.
#
# So nothing in the XML hides it and renderSubTabs does, by the SAME `live` that lights the
# pill, in the same loop. Three legs, and (b) is the one that matters: collecting a control and
# never writing to it is B6 exactly - guarded by `if ~= nil`, exit 0, gate green and dead.
#
# The zero-guard is not decoration here. There is ONE note on the sheet, so a check that goes
# quiet when it stops being found is a check that passes forever on nothing (SPEC B7).
$v300Bad = @()
$noteCtrls = @()
foreach ($f in $files) {
    foreach ($n300 in (Doc $f.FullName).SelectNodes("//*[starts-with(@name,'note')]")) {
        $noteCtrls += [pscustomobject]@{ F = $f.Name; N = $n300.GetAttribute("name"); V = $n300.GetAttribute("visible") }
    }
}
$subNames300 = @()
foreach ($g300 in @($subTabRe.Matches($rootTxt))) {
    foreach ($m300 in [regex]::Matches($g300.Groups[1].Value, '"([^"]+)"')) { $subNames300 += $m300.Groups[1].Value }
}
$subFn300 = LuaFn $rootTxt 'renderSubTabs'

if ($noteCtrls.Count -eq 0) { Fail "V300 no note<X> control was found on the sheet - the affinity note is the one there is, and a check that measures nothing passes forever (SPEC V209, B7)" }
elseif ($subNames300.Count -eq 0) { Fail "V300 SUB_TABS gave up no pane names - (a) has nothing to match a note against (SPEC V209)" }
elseif (-not $subFn300) { Fail "V300 renderSubTabs was not found on the root form - (b) cannot read what it does (SPEC V209)" }
else {
    # (a) a note belongs to a pane the strip actually knows. An orphan note raises nothing at
    # runtime: it simply never hides, which is the state the user reported.
    foreach ($nc in $noteCtrls) {
        $suffix300 = $nc.N.Substring(4)
        if ($subNames300 -notcontains $suffix300) {
            $v300Bad += "$($nc.F) '$($nc.N)' names no pane in SUB_TABS - a caption whose pane the strip does not know is a caption nothing ever hides (SPEC I76c, V300a)"
        }
    }

    # (b) renderSubTabs COLLECTS the name and WRITES visible on it. Both, or B6.
    if ($subFn300 -notmatch 'names\["note"\s*\.\.\s*list\[i\]\]') {
        $v300Bad += "renderSubTabs never asks xpFind for a note<X> - the caption is not in the map, so the write below it can only find nil (SPEC I76c, V300b)"
    }
    if ($subFn300 -notmatch 'note\.visible\s*=\s*live') {
        $v300Bad += "renderSubTabs collects the note and never writes its visibility - collected and unwritten, guarded by `if ~= nil`, is B6 with a new door (SPEC I76c, V300b)"
    }

    # (c) authored state = the pane's authored state, so the open does not flash the caption
    # over the wrong pane. This is V94 applied to one label.
    foreach ($nc in $noteCtrls) {
        $paneName300 = 'tab' + $nc.N.Substring(4)
        $paneVis300 = $null
        foreach ($f in $files) {
            $p300 = (Doc $f.FullName).SelectSingleNode("//layout[@name='$paneName300']")
            if ($p300 -ne $null) { $paneVis300 = $p300.GetAttribute("visible"); break }
        }
        if ($paneVis300 -eq $null) { $v300Bad += "'$($nc.N)' has no pane '$paneName300' anywhere on the sheet - (c) has nothing to compare against (SPEC V209, V300c)"; continue }
        if ($nc.V -ne $paneVis300) {
            $v300Bad += "$($nc.F) '$($nc.N)' is authored visible='$($nc.V)' and '$paneName300' is authored visible='$paneVis300' - the two disagree, so the open paints the caption over the wrong pane until renderSubTabs runs (SPEC I76c, V300c, V94)"
        }
    }

    if ($v300Bad) { foreach ($b in $v300Bad) { Fail "V300 $b" } }
    else { Pass "V300 the $($noteCtrls.Count) note caption(s) name a real pane, are hidden by renderSubTabs in the same line as the pill, and open in the state their pane opens in" }
}

# ---- V301: the bar wears no box, and the marker is a rule (SPEC I77a, I77b) -----------
# The 108th round took the pill away. Eleven gold outlines side by side divided the eye evenly
# and the OPEN tab was told apart by its fill alone - the weakest signal on the band. So the
# button keeps every number it had and loses its contour, and the marker keeps every number it
# had and becomes a foot rule: transparent fill, an authored contour, sides="bottom". The 3px
# THEME_STROKE applyTheme already writes lands as a 3px rule in the era's own accent, which is
# why no palette was touched for any of this (SPEC V53, V67).
#
# (b) is the leg with teeth. The three attributes are ONE state: a transparent fill with no
# sides draws NOTHING, in every era, and the sheet opens with no tab looking open. That is the
# silent and total failure V229 was written to stop, inherited here now that the pill it used
# to measure is gone.
$v301Bad = @()
$pairs301 = 0
foreach ($pr301 in @(@("WoD20th.lfm", "tabStrip"), @("WoD20.11.lfm", "vampStrip"), @("WoD20.7.lfm", "numStrip"), @("WoD20.7.lfm", "hedgeStrip"))) {
    $st301 = (Doc (Join-Path $dir $pr301[0])).SelectSingleNode("//layout[@name='$($pr301[1])']")
    if ($null -eq $st301) { $v301Bad += "$($pr301[1]) is gone from $($pr301[0]) - the bar it names has no buttons to measure (SPEC I32, I58, V209)"; continue }
    foreach ($on301 in $st301.SelectNodes("rectangle[starts-with(@name,'tabOn')]")) {
        $nm301 = $on301.GetAttribute("name")
        $sfx301 = $nm301.Substring(5)
        $btn301 = $st301.SelectSingleNode("rectangle[@name='btnTab$sfx301']")
        if ($null -eq $btn301) { $v301Bad += "'$nm301' has no 'btnTab$sfx301' beside it - the PAIR is what (c) measures (SPEC I32, V209)"; continue }
        $pairs301++

        # (a) the button is a click target and nothing else.
        if ($btn301.GetAttribute("color") -ne '#00000000') {
            $v301Bad += "btnTab$sfx301 is filled '$($btn301.GetAttribute('color'))' - the button is the target of a click and paints nothing (SPEC I77a)"
        }
        if ($btn301.GetAttribute("strokeColor") -ne '#00000000') {
            $v301Bad += "btnTab$sfx301 authors strokeColor='$($btn301.GetAttribute('strokeColor'))' - the box is what the 108th round removed, and applyTheme hands a 3px rule to every contour it knows (SPEC I77a, V67)"
        }

        # (b) LEFT for V304 in the 109th round. The marker stopped drawing anything of its own -
        # it carries a path now (SPEC I78a) - so what used to be measured here is measured there,
        # in the shape the marker has. What stays HERE is the button and the pair.

        # (c) the pair is one control drawn twice: same four numbers, so the rule is exactly as
        # wide as the word it underlines. V232a already welds the width on tabStrip; this is the
        # same weld on four bars and both axes - measuring one axis is how B52 cost a round.
        foreach ($a301 in @('left', 'top', 'width', 'height')) {
            $va301 = $on301.GetAttribute($a301)
            $vb301 = $btn301.GetAttribute($a301)
            if ($va301 -ne $vb301) {
                $v301Bad += "$nm301 has $a301='$va301' and btnTab$sfx301 has $a301='$vb301' - the rule and the word it marks have come apart (SPEC I77b, V301c)"
            }
        }
    }
}
if ($pairs301 -lt 19) { Fail "V301 only $pairs301 button/marker pair(s) were read, expected 19 - this check is covering less than the four bars hold (SPEC V209)" }
elseif ($v301Bad) { foreach ($b in $v301Bad) { Fail "V301 $b" } }
else { Pass "V301 all $pairs301 tab buttons author no contour and sit on the same four numbers as the marker they pair with - no box on the bar, and the rule is as wide as the word" }

# ---- V305: the sub-tab says its state in WEIGHT and in COLOUR (SPEC I78c) --------------
# The 108th round said the colour could not move, because fontColor belongs to applyTheme and a
# Lua write there is undone on the next repaint (SPEC V57). True - and the way around it was the
# one the sheet already uses everywhere else: author BOTH states and toggle `visible`. That is
# what tabOn<X> has always been for the pill. B66 is the record of choosing the first answer that
# respected the invariants over the one that delivered the drawing.
#
# So each sub-tab is two labels on the same four numbers with the same text: closed is italic in
# the theme's own text colour, open is roman in the era's accent. (d) is the leg that keeps the
# accent an ACCENT: four palettes, four different values, none of them equal to that palette's
# own text colour - a palette mapping the two together shows an open word no one can pick out.
$v305Bad = @()
$grp305 = @($subTabRe.Matches($rootTxt))
$subFn305 = LuaFn $rootTxt 'renderSubTabs'
$want305 = @{}
foreach ($g305 in $grp305) {
    $act305 = $g305.Groups[2].Value
    foreach ($m305 in [regex]::Matches($g305.Groups[1].Value, '"([^"]+)"')) {
        $want305[$m305.Groups[1].Value] = ($act305 -eq ("tab" + $m305.Groups[1].Value))
    }
}
if ($want305.Count -lt 8) { Fail "V305 only $($want305.Count) sub-tab name(s) were read from SUB_TABS, expected 8 across the three bars (SPEC V209)" }
elseif (-not $subFn305) { Fail "V305 renderSubTabs was not found on the root form - (c) cannot read what it does (SPEC V209)" }
else {
    foreach ($n305 in @($want305.Keys)) {
        $off305 = $null; $on305 = $null
        foreach ($f in $files) {
            $doc305 = Doc $f.FullName
            if ($null -eq $off305) { $off305 = $doc305.SelectSingleNode("//label[@name='lbl$n305']") }
            if ($null -eq $on305) { $on305 = $doc305.SelectSingleNode("//label[@name='lblOn$n305']") }
        }
        if ($null -eq $off305 -or $null -eq $on305) {
            $v305Bad += "sub-tab '$n305' is missing one of its two words (lbl$n305 / lblOn$n305) - one label cannot carry two colours without a Lua write the theme undoes (SPEC I78c, V57, V305a)"
            continue
        }

        # (a) closed is italic in the theme's colour; open is roman in the accent; and the two are
        # the same word in the same place, or it jumps as it opens.
        if ($off305.GetAttribute("fontStyle") -ne 'italic') { $v305Bad += "lbl$n305 authors fontStyle='$($off305.GetAttribute('fontStyle'))', expected italic - the closed word is the italic one (SPEC I78c, V305a)" }
        if ($off305.GetAttribute("fontColor") -ne 'white') { $v305Bad += "lbl$n305 authors fontColor='$($off305.GetAttribute('fontColor'))', expected white - the closed word wears the theme's own text colour (SPEC I78c, V53)" }
        if ($on305.GetAttribute("fontStyle")) { $v305Bad += "lblOn$n305 authors fontStyle='$($on305.GetAttribute('fontStyle'))' - the open word is the ROMAN one, which is how the pair reads as a state (SPEC I78c, V305a)" }
        if ($on305.GetAttribute("fontColor") -ne '#C2A14D') { $v305Bad += "lblOn$n305 authors fontColor='$($on305.GetAttribute('fontColor'))', expected #C2A14D - that is the accent key the four palettes map (SPEC I78c, V53)" }
        if ($off305.GetAttribute("text") -ne $on305.GetAttribute("text")) { $v305Bad += "lbl$n305 and lblOn$n305 carry different text - the sub-tab would rename itself as it opens (SPEC I78c, V305a)" }
        foreach ($a305 in @('left', 'top', 'width', 'height')) {
            if ($off305.GetAttribute($a305) -ne $on305.GetAttribute($a305)) {
                $v305Bad += "lbl$n305 has $a305='$($off305.GetAttribute($a305))' and lblOn$n305 has '$($on305.GetAttribute($a305))' - the word would jump as it opens (SPEC I78c, V305a)"
            }
        }

        # (b) authored OPPOSITE, and on the side its group opens on - V94 on a pair of labels.
        $vOff305 = $off305.GetAttribute("visible"); $vOn305 = $on305.GetAttribute("visible")
        if ($vOff305 -eq $vOn305) { $v305Bad += "lbl$n305 and lblOn$n305 are both authored visible='$vOff305' - roman stacked on italic until the first render (SPEC V94, V305b)" }
        elseif ($want305[$n305] -and $vOn305 -ne 'true') { $v305Bad += "the group opens on '$n305' but lblOn$n305 is authored visible='$vOn305' - the sheet opens italic and straightens a frame later (SPEC V94, V305b)" }
        elseif (-not $want305[$n305] -and $vOff305 -ne 'true') { $v305Bad += "the group does not open on '$n305' but lbl$n305 is authored visible='$vOff305' - the closed word is the one that shows (SPEC V94, V305b)" }
    }

    # (c) collected AND written, both of them - and no style or colour written anywhere.
    foreach ($fam305 in @('lbl', 'lblOn')) {
        if ($subFn305 -notmatch ('names\["' + $fam305 + '"\s*\.\.\s*list\[i\]\]')) {
            $v305Bad += "renderSubTabs never asks xpFind for a $fam305<X> - the word is not in the map and the write below it can only find nil (SPEC I78c, V305c)"
        }
    }
    if ($subFn305 -notmatch 'lbl\.visible\s*=\s*not live' -or $subFn305 -notmatch 'lblOn\.visible\s*=\s*live') {
        $v305Bad += "renderSubTabs does not write BOTH halves of the pair from the same live - one written and one collected is B6 with the door repainted (SPEC I78c, V305c)"
    }
    if ($rootTxt -match 'fontStyle\s*=' -or $rootTxt -match '\.fontColor\s*=') {
        $v305Bad += "the root form writes fontStyle or fontColor from Lua - applyTheme undoes a colour on the next repaint, and a write before it poisons the authored ledger (SPEC V57, V305c)"
    }

    # (d) the accent is an accent: four palettes, four values, none equal to that palette's text.
    # `local fill, stroke, font = {}, {}, {}` in the normaliser matches the naive pattern too, so
    # a map is a map only if it holds keys - five was the count before this line existed.
    $fonts305 = @([regex]::Matches($hh6, '(?s)font\s*=\s*\{(.*?)\}') | Where-Object { $_.Groups[1].Value -match '\["' })
    if ($fonts305.Count -ne 4) { $v305Bad += "read $($fonts305.Count) font map(s) out of THEMES, expected 4 - (d) cannot compare what it cannot find (SPEC V209)" }
    else {
        $seen305 = @{}
        foreach ($fm305 in $fonts305) {
            $body305 = $fm305.Groups[1].Value
            $acc305 = [regex]::Match($body305, '\["#C2A14D"\]\s*=\s*"(#[0-9A-Fa-f]{6})"')
            $whi305 = [regex]::Match($body305, '\["white"\]\s*=\s*"(#[0-9A-Fa-f]{6})"')
            if (-not $acc305.Success) { $v305Bad += "a palette does not map #C2A14D - the open word would keep the authored gold in an era that is not gold, or fall out of paint's guard entirely (SPEC V53, V61, V305d)"; continue }
            if ($whi305.Success -and $acc305.Groups[1].Value -eq $whi305.Groups[1].Value) {
                $v305Bad += "a palette maps #C2A14D and white to the same $($whi305.Groups[1].Value) - open and closed would differ by italic alone in that era (SPEC V305d)"
            }
            $seen305[$acc305.Groups[1].Value] = $true
        }
        if ($seen305.Count -lt 4) { $v305Bad += "the four palettes give the accent only $($seen305.Count) distinct value(s) - the accent is the era's own, not one gold everywhere (SPEC V305d)" }
    }

    if ($v305Bad) { foreach ($b in $v305Bad) { Fail "V305 $b" } }
    else { Pass "V305 all $($want305.Count) sub-tabs carry both words, authored opposite on the side their group opens, and the accent is four different colours across the four palettes" }
}


# ---- V307: the line work runs where the LEVEL says (SPEC I79, I80) --------------------
# Amended in the 111th round, not renumbered. It was born measuring the 19 buttons as ONE
# population, and the user treats the two levels as different things: the 110th round's drop was
# asked for the ELEVEN of the top bar, and it reached the eight sub-tabs too (B69). A single
# ruler over populations the user keeps apart is a product decision written as geometry.
#
# (a) is the relation the 110th round bought: the word ends, then 3px, then the drawing - with
# the three constants READ out of WoD20.6 and never spelled here, so moving either side reddens.
#
# (b) is the OPPOSITE, and deliberately so: on a sub-bar the label covers the whole button and
# the short rule runs inside it. That is the state the user saw on screen and approved in the
# 109th round. The leg measures no clearance - it exists so that undoing this takes a REQUEST,
# and so the next reader does not "fix" an approved drawing back into the shape B69 produced.
$v307Bad = @()
$top307 = 0
$sub307 = 0
$mk307 = [regex]::Match($hh6, '(?m)^\s*local ORN_MARK\s*=\s*([\d.]+);')
$mk2_307 = [regex]::Match($hh6, '(?m)^\s*local ORN_MARK2\s*=\s*([\d.]+);')
$ry307 = [regex]::Match($hh6, '(?m)^\s*local ORN_MARK_RY\s*=\s*([\d.]+);')
$sm307 = [regex]::Match($hh6, '(?m)^\s*local ORN_SUB_MARK\s*=\s*([\d.]+);')
if (-not ($mk307.Success -and $mk2_307.Success -and $ry307.Success -and $sm307.Success)) {
    Fail "V307 ORN_MARK / ORN_MARK2 / ORN_MARK_RY / ORN_SUB_MARK could not all be read out of WoD20.6 - the Lua side of these relations is unreadable, so the legs are no-ops (SPEC V209, V20)"
}
else {
    $artTop307 = [Math]::Max([double]$mk2_307.Groups[1].Value, [double]$mk307.Groups[1].Value + [double]$ry307.Groups[1].Value)
    # 3 until the 112th round, when the user asked the drawing closer to the word (SPEC I81). It
    # is measured on the label BOX, and the gate does not know the height of a GLYPH - PX_PER_CHAR
    # measures width and nothing measures height (SPEC R102) - so at 1 the four eras, on four
    # different fonts, are what decide whether it touches. That is a screen question, not a static
    # one, and Â§T681 is where it gets answered.
    $clear307 = 1
    foreach ($pr307 in @(@("WoD20th.lfm", "tabStrip"), @("WoD20.11.lfm", "vampStrip"), @("WoD20.7.lfm", "numStrip"), @("WoD20.7.lfm", "hedgeStrip"))) {
        $st307 = (Doc (Join-Path $dir $pr307[0])).SelectSingleNode("//layout[@name='$($pr307[1])']")
        if ($null -eq $st307) { $v307Bad += "$($pr307[1]) is gone from $($pr307[0]) (SPEC I32, I58, V209)"; continue }
        $isTop307 = ($pr307[1] -eq 'tabStrip')
        foreach ($b307 in $st307.SelectNodes("rectangle[starts-with(@name,'btnTab')]")) {
            $bn307 = $b307.GetAttribute("name")
            $bh307 = [double]$b307.GetAttribute("height")
            $seen307 = @()
            if ($isTop307) { $top307++ } else { $sub307++ }
            foreach ($l307 in $b307.SelectNodes("label")) {
                $lt307 = [double]$l307.GetAttribute("top")
                $lh307 = [double]$l307.GetAttribute("height")
                $seen307 += "$lt307/$lh307"
                if ($isTop307) {
                    # (a) the word ends, the clearance, then the drawing.
                    if (($lt307 + $lh307) -gt ($bh307 - $artTop307 - $clear307)) {
                        $v307Bad += "$bn307's word ends at $($lt307 + $lh307) and the line work starts at $($bh307 - $artTop307) - on the TOP bar the drawing runs below the word (SPEC I79, V307a, B68)"
                    }
                }
                else {
                    # (b) the approved state: the word covers the button, the short rule runs in it.
                    if ($lh307 -ne $bh307 -or $lt307 -ne 0) {
                        $v307Bad += "$bn307's word is $($lh307)px at top $lt307 inside a $($bh307)px button - on a SUB-bar the word covers the button, which is the state the user approved in the 109th round; shrinking it here is B69 coming back (SPEC I80b, V307b)"
                    }
                    if (($bh307 - [double]$sm307.Groups[1].Value) -ge ($lt307 + $lh307)) {
                        $v307Bad += "$bn307's short rule runs at $($bh307 - [double]$sm307.Groups[1].Value), at or below the word's box ending at $($lt307 + $lh307) - the sub-bar rule sits INSIDE the label box by decision, and moving it out is the top bar's ruler leaking down again (SPEC I80b, V307b, B69)"
                    }
                }
            }
            # (c) both words of a pair on the same vertical geometry, or the sub-tab jumps as it opens.
            if (($seen307 | Sort-Object -Unique).Count -gt 1) {
                $v307Bad += "$bn307 carries words on different vertical geometry ($($seen307 -join ', ')) - the pair would open at a different height than it closed (SPEC V307c, V305a)"
            }
        }
    }
    if ($top307 -ne 11 -or $sub307 -ne 8) { Fail "V307 read $top307 top-bar button(s) and $sub307 sub-bar button(s), expected 11 and 8 - this check is covering less than the four bars hold (SPEC V209)" }
    elseif ($v307Bad) { foreach ($b in $v307Bad) { Fail "V307 $b" } }
    else { Pass "V307 the $top307 top-bar words clear the line work by $clear307, and the $sub307 sub-bar words keep the 109th round's shape the user approved - two levels, two rulers" }
}

# ---- V308: a motif's constant does not cross into another motif (SPEC I80c) ------------
# This measures the CODE, not the drawing, and it is the invariant B69 asks for. markPath grew
# three motifs in the 109th round and the constants stayed in one heap, so ORN_MARK was read by
# `tab` AND `sub`, and ORN_MARK_RY by `tab` AND `sep`. The 110th round then moved the top bar
# and moved two other levels with it - rdk -l exit 0, gate green, and the damage one level away
# from the edit that caused it, which is the B6 family.
#
# ORN_PILLR is the declared exception: it is not a drawing choice but the arc V228 authors on
# every button, so it is one fact with one owner (SPEC V49) and every motif may read it.
$v308Bad = @()
$geo308 = LuaFn $hh6 'markPath'
if (-not $geo308) { Fail "V308 markPath is gone from WoD20.6 - there are no motifs to read (SPEC I78b, V209)" }
else {
    $body308 = NoComments $geo308
    $iSep308 = $body308.IndexOf('if kind == "sep" then')
    $iSub308 = $body308.IndexOf('if kind == "sub" then')
    if ($iSep308 -lt 0 -or $iSub308 -lt 0 -or $iSub308 -le $iSep308) {
        Fail "V308 markPath does not hold the sep and sub branches in that order - the slices this check reads cannot be cut (SPEC I78b, V209)"
    }
    else {
        # Three slices: sep, sub, and whatever follows them - which is the top bar's motif.
        $slices308 = @(
            @{ name = 'sep'; text = $body308.Substring($iSep308, $iSub308 - $iSep308); forbid = @('ORN_MARK', 'ORN_MARK2', 'ORN_MARK_RX', 'ORN_MARK_RY', 'ORN_MARK_GAP', 'ORN_SUB', 'ORN_SUB_MARK') },
            @{ name = 'sub'; text = $body308.Substring($iSub308, $body308.IndexOf('return table.concat', $iSub308) - $iSub308); forbid = @('ORN_MARK', 'ORN_MARK2', 'ORN_MARK_RX', 'ORN_MARK_RY', 'ORN_MARK_GAP', 'ORN_SEP_RX', 'ORN_SEP_RY') },
            @{ name = 'tab'; text = $body308.Substring($body308.IndexOf('return table.concat', $iSub308)); forbid = @('ORN_SUB', 'ORN_SUB_MARK', 'ORN_SEP_RX', 'ORN_SEP_RY') }
        )
        foreach ($sl308 in $slices308) {
            foreach ($bad308 in $sl308.forbid) {
                # ORN_MARK is a prefix of ORN_MARK2 and ORN_MARK_RX; ORN_SUB of ORN_SUB_MARK.
                if ($sl308.text -match ("\b" + [regex]::Escape($bad308) + "\b(?!_|\d)")) {
                    $v308Bad += "the `"$($sl308.name)`" motif reads $bad308, which belongs to another motif - that sharing is exactly how the 110th round moved three levels when it was asked to move one (SPEC I80c, B69)"
                }
            }
        }
        if ($body308 -notmatch '\bORN_SUB_MARK\b') { $v308Bad += "the sub motif has no ORN_SUB_MARK of its own - without it the short rule is back on the top bar's constant (SPEC I80b, I80c)" }
        if ($body308 -notmatch '\bORN_SEP_RY\b') { $v308Bad += "the sep motif has no ORN_SEP_RY of its own - the separator's fleuron is back on the top bar's constant (SPEC I80c)" }
        if ($v308Bad) { foreach ($b in $v308Bad) { Fail "V308 $b" } }
        else { Pass "V308 the three motifs of markPath each read their own family of constants - only ORN_PILLR, the arc V228 authors, is shared" }
    }
}

# ---- V284: the filigree of a box that RESIZES is redrawn, not inherited ---------------
# SPEC I72d, the 100th round, item 2 of the request. HEALTH is the one section box whose size
# moves at runtime - renderHealthTrack writes its height from the storyteller's track length
# (SPEC V49) - and the ornament data is built ONCE, from what the box measured at creation.
# Nothing above sees this: a frame drawn for ten rows sitting on a four-row box compiles,
# runs, exits 0 and merely looks wrong, which is the B6 shape on a new door.
$hbBad = @()
$ornMake2 = LuaFn $hh6 'ornament'
$refreshFn = LuaFn $hh6 'refreshOrnament'

if (-not $ornMake2) { $hbBad += "V284 ornament() is gone from WoD20.6 - there is no painter to refresh, so this check measured nothing (SPEC V209)" }
elseif (-not $rendFn) { $hbBad += "V284 renderHealthTrack() is gone from the root form - the box that resizes has no renderer, so this check measured nothing (SPEC V209)" }
else {
    $ornBody2 = NoComments $ornMake2
    $rendBody = NoComments $rendFn

    # (a) the memo carries the MEASUREMENTS, not just the path. Anchored on the CONSTRUCTION
    # and not on field names (SPEC V222): what has to hold is that the stored entry is a table
    # with the size beside the path, because a memo that only knows "already drawn" cannot
    # know "drawn at THIS size" - B58 one axis over, the carimbo instead of the key.
    $memoW = [regex]::Match($ornBody2, '(?m)^\s*local\s+(\w+)\s*=\s*ornPainted\[c\.handle\];')

    # The pair the box is measured into. Everything below is anchored on THESE names rather
    # than on the shape of the store, because "= {" is incidental: the entry may be built into
    # a local and handed over on the next line and still be the same construction (SPEC V222).
    $szL = [regex]::Match($ornBody2, '(?m)^\s*local\s+(\w+)\s*,\s*(\w+)\s*=\s*c\.width\s*,\s*c\.height;')
    $memoStored = $ornBody2 -match 'ornPainted\[c\.handle\]\s*='
    $carries = $false

    if ($szL.Success) {
        $wN = [regex]::Escape($szL.Groups[1].Value)
        $hN = [regex]::Escape($szL.Groups[2].Value)

        foreach ($t in [regex]::Matches($ornBody2, '\{[^{}]*\}')) {
            if ($t.Value -match ('\b' + $wN + '\b') -and $t.Value -match ('\b' + $hN + '\b')) { $carries = $true; break }
        }
    }

    if (-not $memoW.Success) { $hbBad += "V284 nothing reads ornPainted[c.handle] - the memo this check measures is gone (SPEC V209)" }
    elseif (-not $szL.Success) { $hbBad += "V284 the box is never measured into a pair - there is nothing for the memo to carry (SPEC I72d, V209)" }
    elseif (-not $memoStored) { $hbBad += "V284 nothing is stored in ornPainted[c.handle] - the memo is read and never written (SPEC V209)" }
    elseif (-not $carries) {
        $hbBad += "V284 the memo stores the path ALONE - with no measurement beside it the painter cannot tell 'already drawn' from 'drawn at this size', and a resized box keeps the frame it was born with (SPEC I72d, B58)"
    }
    else {
        $mn = [regex]::Escape($memoW.Groups[1].Value)

        # Storing the size and never reading it back is decoration. Demand the CURRENT size and
        # a comparison against what was stored - that pair IS the third door.
        if ($ornBody2 -notmatch 'c\.width' -or $ornBody2 -notmatch 'c\.height') {
            $hbBad += "V284 the painter never reads the box's current size - it has nothing to notice a resize with (SPEC I72d)"
        }

        $cmpPat = '(?m)~=\s*' + $mn + '\.\w+|' + $mn + '\.\w+\s*~='
        if ($ornBody2 -notmatch $cmpPat) {
            $hbBad += "V284 the stored measurement is written and never COMPARED - the third door never opens and the resize goes unnoticed (SPEC I72d)"
        }

        if ($ornBody2 -notmatch '\.data\s*=') {
            $hbBad += "V284 nothing rewrites the path data - the frame can only ever be built once (SPEC R113a)"
        }
    }

    # (b) ORDER, and it is the leg with no symptom: refreshing on the near side of the height
    # write rebuilds the frame to the measure the box is LEAVING, and exits 0 doing it.
    $hIdx = $rendBody.IndexOf('.height')
    $rIdx = $rendBody.IndexOf('refreshOrnament')

    if ($hIdx -lt 0) { $hbBad += "V284 renderHealthTrack no longer writes the box height - the resize this check guards is gone (SPEC V49, V209)" }
    elseif ($rIdx -lt 0) { $hbBad += "V284 renderHealthTrack never refreshes the filigree - the box resizes and the frame stays the size it was born (SPEC I72d)" }
    elseif ($rIdx -lt $hIdx) { $hbBad += "V284 the filigree is refreshed BEFORE the height is written - it would be rebuilt to the measure the box is leaving, with no error to show for it (SPEC V284b)" }

    # (c) BOTH health boxes, through the prefix the renderer already carries. A literal name
    # here fixes the Main tab and leaves the Combat twin crooked, in silence.
    if ($rendBody -match 'dynHealth3?_box') {
        $hbBad += "V284 the refresh names a health box LITERALLY - renderHealthTrack serves both of them through its prefix, so a literal repairs one and abandons the other (SPEC V284c)"
    }

    # (d) the NEGATIVE leg. `stretch` exists in the SDK and would do all of this with no code
    # at all, at the price of scaling the volutes and beads with the box - the very shearing
    # that made the ornament vector instead of a PNG. Spelled out so a later round cannot
    # "simplify" it back in and undo the reason the thing is drawn per box (SPEC R113b).
    if ($ornBody2 -match '\.mode\s*=\s*"(?!original")') {
        $hbBad += "V284 the path mode is no longer 'original' - stretch scales the volutes and beads with the box, which is the shearing the per-box vector exists to avoid (SPEC R113b)"
    }

    if (-not $refreshFn) {
        $hbBad += "V284 refreshOrnament() is gone from WoD20.6 - renderHealthTrack lives on the root form and has no other reach into the painter's chunk (SPEC I72d)"
    }
}

if ($hbBad) { foreach ($b in $hbBad) { Fail $b } }
else { Pass "V284 the filigree carries its measurements, notices a resize, is refreshed AFTER the height is written, and reaches both health boxes by prefix" }

# ---- V285: what the gate cannot RUN, the filigree may not DEPEND on ------------------
# SPEC B62, the 102nd round. V284 above proved the SHAPE of the refresh - the memo carries a
# measurement, the calls are in the right order, the mode is original - and the feature was
# broken anyway, because the two RUNTIME facts it rested on were never checkable here: the
# gate does not execute Lua (SPEC B30, B34). This block is V198/V275's own doctrine applied
# to the READS instead of to the memo: what cannot be counted gets PROHIBITED.
$v285Bad = @()
$refFn = LuaFn $hh6 'refreshOrnament'
$ornFn285 = LuaFn $hh6 'ornament'

if (-not $refFn) { $v285Bad += "V285 refreshOrnament() is gone from WoD20.6 - the refresh path this check measures does not exist (SPEC V209)" }
elseif (-not $ornFn285) { $v285Bad += "V285 ornament() is gone from WoD20.6 - there is no painter to measure (SPEC V209)" }
else {
    $refBody = NoComments $refFn
    $ornBody285 = NoComments $ornFn285

    # (a) the ornamented control is found by the MEMO. A finder that matches nothing returns
    # quietly and exits 0 - there is no error and no check to catch it, which is half of B62.
    if ($refBody -notmatch 'ornPainted\[') {
        $v285Bad += "V285 refreshOrnament does not find its target through ornPainted - a finder built on a property read returns empty in silence when the host answers in a shape nobody checked (SPEC V285a, B62)"
    }

    # (b) the NEGATIVE leg, and the one that keeps (a) from being undone. getClassName is proven
    # by the theme walk that repaints every round; `align` was proven by nothing, and the read
    # this replaces was the only one in the sheet.
    if ($refBody -match '\.align\s*==' -or $ornBody285 -match '\.align\s*==') {
        $v285Bad += "V285 the filigree READS .align - it has no precedent as a runtime read anywhere in the sheet, and if the host answers with an enum index instead of the string the branch silently never runs (SPEC V285b, B62)"
    }

    # (c) the redraw measurement is HANDED OVER, not read back. Anchored on the signature and on
    # the refresh branch actually naming those parameters - a fifth argument that is accepted and
    # then ignored is the same bug wearing the fix's clothes.
    $sig = [regex]::Match($ornBody285, 'function\s+ornament\s*\(([^)]*)\)')
    if (-not $sig.Success) { $v285Bad += "V285 ornament's signature could not be read - this check is a no-op (SPEC V209, V20)" }
    else {
        $prms = @($sig.Groups[1].Value -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ })
        if ($prms.Count -lt 5) {
            $v285Bad += "V285 ornament takes $($prms.Count) parameter(s) - it cannot be HANDED a measurement, so the redraw can only read one back off a control whose layout may not have resolved (SPEC V285c, B62)"
        } else {
            $reIdx = $ornBody285.IndexOf('if e ~= nil then')
            $crIdx = $ornBody285.IndexOf('if e == nil then')
            if ($reIdx -lt 0 -or $crIdx -le $reIdx) {
                $v285Bad += "V285 the refresh branch and the creation branch could not be told apart in ornament - this check is a no-op (SPEC V209, V20)"
            } else {
                $refBranch = $ornBody285.Substring($reIdx, $crIdx - $reIdx)
                foreach ($p in @($prms[3], $prms[4])) {
                    if ($refBranch -notmatch ('(?<![\w.])' + [regex]::Escape($p) + '(?![\w])')) {
                        $v285Bad += "V285 the refresh branch never uses the handed-over '$p' - the measurement is accepted and then thrown away, which redraws from the size the box is LEAVING (SPEC V285c, B62)"
                    }
                }
            }
        }
        # and the caller has to actually hand something over
        if ($refBody -notmatch 'ornament\s*\([^)]*,[^)]*,[^)]*,[^)]*,[^)]*\)') {
            $v285Bad += "V285 refreshOrnament calls the painter without a measurement - the parameters exist and nobody fills them (SPEC V285c)"
        }
    }

    # (d) the general rule (b) is one case of: nothing else is read off the child. `handle` is
    # the key of a table the sheet owns, not a measurement the host has to resolve.
    $loopVar = [regex]::Match($refBody, '(?m)^\s*local\s+(\w+)\s*=\s*\w+\[\s*i\s*\]\s*;')
    if ($loopVar.Success) {
        $lv = [regex]::Escape($loopVar.Groups[1].Value)
        foreach ($m in [regex]::Matches($refBody, '(?<![\w.])' + $lv + '\.(\w+)')) {
            if ($m.Groups[1].Value -ne 'handle') {
                $v285Bad += "V285 refreshOrnament reads .$($m.Groups[1].Value) off the child - every property beyond `handle` is a runtime answer this gate cannot verify, and B62 was two of them (SPEC V285d)"
            }
        }
    }
}

if ($v285Bad) { foreach ($b in ($v285Bad | Sort-Object -Unique)) { Fail $b } }
else { Pass "V285 the filigree finds its target by memo, reads no .align, and is redrawn from the measurement it is handed - not from one read back" }

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


# ---- V310: a hedge ritual is offered only while its PATH reaches its level ---------------
# SPEC I83, V310, user 2026-08-26. Six legs, and (e) and (f) are the two that give no symptom
# at all when they are wrong: the filter simply stops pruning, rdk exits 0 and every other
# check on this sheet stays green.
$v310Bad = @()

# The table maps ONE path per ritual - a string, not a list (SPEC I83b). It parses to zero rows
# today and that is legal while PICKER_LIST["hedgeRitual"] is empty too; leg (a) below is what
# ties the two together the moment either one fills.
$hrpDecl310 = [regex]::Match($rootTxt, '(?s)(?m)^\s*HEDGE_RITUAL_PATH = \{\r?\n(.*?)^\s*\};')
$hrp310 = [ordered]@{}
if ($hrpDecl310.Success) {
    foreach ($row in [regex]::Matches($hrpDecl310.Groups[1].Value, '\["([^"]+)"\]\s*=\s*"([^"]*)"')) {
        $hrp310[$row.Groups[1].Value] = $row.Groups[2].Value
    }
}

$numina310 = @()
$hritual310 = @()
if ($region270.Success) {
    $nl310 = [regex]::Match($region270.Groups[1].Value, '(?s)\["numina"\] = \{(.*?)\},\s*\n')
    if ($nl310.Success) { $numina310 = @([regex]::Matches($nl310.Groups[1].Value, '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value } | Where-Object { $_ -ne '' }) }
    $rl310 = [regex]::Match($region270.Groups[1].Value, '(?s)\["hedgeRitual"\] = \{(.*?)\},\s*\n')
    if ($rl310.Success) { $hritual310 = @([regex]::Matches($rl310.Groups[1].Value, '"([^"]*)"') | ForEach-Object { $_.Groups[1].Value } | Where-Object { $_ -ne '' }) }
}

$rootNoC310 = NoComments $rootTxt
$hh6NoC310  = NoComments $hh6

# Zero-guard: the three things this check reads have to BE there, or it measures nothing and
# passes green forever (SPEC V209, V20).
if (-not $hrpDecl310.Success) { $v310Bad += "HEDGE_RITUAL_PATH is not declared on the root form - the ritual filter has no table to read and this check measured nothing (SPEC I83b, V209)" }
elseif ($rootNoC310 -notmatch '(?m)^\s*function hedgePathLevels\(\)') { $v310Bad += "hedgePathLevels is gone from the root form - there is no map of path levels and this check measured nothing (SPEC I83d, V209)" }
elseif (-not $region270.Success) { $v310Bad += "the PICKER_LIST region could not be read - the two lists this check compares against are unreachable (SPEC V209)" }
else {
    # (a) both ends of the table stay inside the two lists, and the coverage rule switches on
    # the moment the ritual list fills. An empty table beside an empty list is the state the
    # 112th round ships; an empty table beside a FULL list is a filter that prunes nothing.
    foreach ($k in $hrp310.Keys) {
        if ($hritual310 -notcontains $k) { $v310Bad += "HEDGE_RITUAL_PATH is keyed on '$k', which PICKER_LIST['hedgeRitual'] does not carry - nobody can ever pick it, so the entry is dead (SPEC V310a, B55)" }
        if ($numina310 -notcontains $hrp310[$k]) { $v310Bad += "HEDGE_RITUAL_PATH['$k'] names the path '$($hrp310[$k])', which PICKER_LIST['numina'] does not carry - a path no row can hold answers zero, so the ritual is offered to nobody (SPEC V310a)" }
    }
    if ($hritual310.Count -gt 0) {
        $uncovered310 = @($hritual310 | Where-Object { -not $hrp310.Contains($_) })
        if ($uncovered310.Count -gt 0) { $v310Bad += "$($uncovered310.Count) ritual(s) are on the picker list with no path in HEDGE_RITUAL_PATH, e.g. '$($uncovered310[0])' - an unknown value prunes nothing, so those would be offered at every level of every path (SPEC V310a, I83b)" }
        $noPrefix310 = @($hritual310 | Where-Object { $_ -notmatch '^\d+\. ' })
        if ($noPrefix310.Count -gt 0) { $v310Bad += "$($noPrefix310.Count) ritual(s) carry no '<n>. ' prefix, e.g. '$($noPrefix310[0])' - the level is read off the item text and nowhere else, so a missing prefix reads as level 0 and passes for free (SPEC V310a, V310c, I83c)" }
    }

    # (b) the branch answers in pickAllowed, BEFORE pickRefusal, and an unknown value is left
    # alone. A `false` on the unknown key would open twelve blank dropdowns while the table is
    # still empty - V271d/V272e in a third place.
    # Anchored on the function's OWN indent, never on `^\s*end;`: pickAllowed's branches each
    # close with an `end;` of their own, so a loose anchor would cut the body off before the
    # pickRefusal call and the ordering leg below would quietly measure nothing (SPEC V20).
    $pa310 = [regex]::Match($rootNoC310, "(?s)\n\t\t\tfunction pickAllowed\(([^)]*)\)(.*?)\n\t\t\tend;")
    if (-not $pa310.Success) { $v310Bad += "pickAllowed could not be read off the root form - the one door to the rule is gone (SPEC V199, V209)" }
    else {
        if ($pa310.Groups[1].Value -notmatch 'hedge') { $v310Bad += "pickAllowed does not take the hedge path map - its fourth parameter is what the ritual branch measures against (SPEC I83f, V310e)" }
        $paBody310 = $pa310.Groups[2].Value
        $iRit310 = $paBody310.IndexOf('hedgeRitual_%d+$')
        $iRef310 = $paBody310.IndexOf('pickRefusal')
        if ($iRit310 -lt 0) { $v310Bad += "pickAllowed has no ritual-row branch - the twelve picked ritual rows would fall through to pickRefusal, which knows nothing about hedge magic (SPEC V310b)" }
        elseif ($iRef310 -ge 0 -and $iRit310 -gt $iRef310) { $v310Bad += "the ritual branch sits AFTER the pickRefusal call - pickRefusal answers nil for a field it does not know, so the branch would never be reached (SPEC V310b)" }
    }
    $hra310 = [regex]::Match($rootNoC310, "(?s)\n\t\t\tlocal function hedgeRitualAllows\(([^)]*)\)(.*?)\n\t\t\tend;")
    if (-not $hra310.Success) { $v310Bad += "hedgeRitualAllows is gone from the root form - the rule the branch delegates to is unreadable (SPEC V310b, V209)" }
    else {
        $hraBody310 = $hra310.Groups[2].Value
        if ($hraBody310 -notmatch 'if path == nil then return true') { $v310Bad += "hedgeRitualAllows does not answer TRUE for a value HEDGE_RITUAL_PATH has never heard of - while the table is empty that is every value, so the twelve dropdowns would open blank (SPEC V310b, V271d)" }
        # (c) the level comes off the item text and from nowhere else. A number in the table
        # would be the second source V269d already closed for the price.
        if ($hraBody310 -notmatch '\^\(%d\+\)%\. ') { $v310Bad += "hedgeRitualAllows does not read the level off the item-text prefix - a second source for one number is what lets the dots on screen say three while the filter measures four (SPEC V310c, V269d)" }
        if ($hraBody310 -match 'HEDGE_RITUAL_LEVEL') { $v310Bad += "hedgeRitualAllows reads a level from a table instead of the item text (SPEC V310c)" }
    }
    foreach ($v in $hrp310.Values) {
        if ($v -match '^\d+$') { $v310Bad += "HEDGE_RITUAL_PATH holds the number '$v' as a path - the level is the item's prefix and the table carries the PATH only (SPEC V310c)" }
    }

    # (d) the path map is its OWN, over all SEVENTEEN rows, and the ritual branch never reads
    # discLevels: `Necromancy` and `Weather Control` are a hedge path AND a vampire
    # Discipline/path, so one shared map lets the wrong one open the rituals (SPEC B15, V34).
    $hpl310 = [regex]::Match($rootNoC310, "(?s)\n\t\t\tfunction hedgePathLevels\(\)(.*?)\n\t\t\tend;")
    if (-not $hpl310.Success) { $v310Bad += "hedgePathLevels could not be read - this leg measured nothing (SPEC V209)" }
    else {
        $hplBody310 = $hpl310.Groups[1].Value
        if ($hplBody310 -notmatch 'NUMINA_ROWS') { $v310Bad += "hedgePathLevels does not walk NUMINA_ROWS - a literal count here goes stale the next time a row is added, and the five TYPED rows hold dots like any other (SPEC V310d, I83d)" }
        if ($hplBody310 -notmatch 'traitLevel') { $v310Bad += "hedgePathLevels never reads a dot - it would answer zero for every path and prune the whole list (SPEC V310d)" }
        if ($hplBody310 -notmatch '>') { $v310Bad += "hedgePathLevels does not keep the HIGHER of two rows naming one path - answering with the lower takes away a level the player owns (SPEC V310d)" }
    }
    if ($hra310.Success -and $hra310.Groups[2].Value -match 'discLevels') { $v310Bad += "the ritual rule reads discLevels - Necromancy the DISCIPLINE at five would open the rituals of Necromancy the hedge PATH (SPEC V310d, B15)" }

    # (e) the map rides the memo's own generation. Outside that block it is rebuilt once per
    # CONTROL; read from anywhere the reset cannot reach it serves last render's levels with
    # rdk exiting 0 and the gate green - B48 through a third door.
    $reset310 = [regex]::Match($hh6NoC310, '(?s)if memo\.stamp ~= stamp or memo\.levels ~= levels then(.*?)end;')
    if (-not $reset310.Success) { $v310Bad += "the picker memo no longer resets on a new generation - there is nothing for the hedge map to ride (SPEC V310e, V209)" }
    elseif ($reset310.Groups[1].Value -notmatch 'memo\.hedge\s*=\s*hedgePathLevels\(\)') { $v310Bad += "memo.hedge is not built INSIDE the memo reset - built outside it, the map is rebuilt once per control instead of once per render (SPEC V205, V310e)" }
    $hedgeBuilds310 = @([regex]::Matches($hh6NoC310, 'hedgePathLevels\(\)'))
    if ($hedgeBuilds310.Count -gt 1) { $v310Bad += "hedgePathLevels() is called $($hedgeBuilds310.Count) times in WoD20.6 - one build per render is the whole point, and a second caller is a second generation nothing invalidates (SPEC V205, V310e)" }

    # (f) reach and trigger, and the two halves fail for different reasons: a link without the
    # DOTS never wakes on a level, and a renderer without the twelve NAMES reaches no combo.
    $fr310 = [regex]::Match($hh6, '(?ms)local FILTER_ROW = \{(.*?)\}')
    if (-not $fr310.Success) { $v310Bad += "FILTER_ROW is not declared - the ritual rows would not be filtered at all (SPEC V310f, V209)" }
    elseif ($fr310.Groups[1].Value -notmatch 'hedgeRitual\s*=\s*true') { $v310Bad += "FILTER_ROW does not carry hedgeRitual - pickerItems asks isFilterRow first, so the twelve combos would be handed the whole list (SPEC V310f, I83g)" }
    $fn310 = [regex]::Match($hh6, '(?ms)local FILTER_NAME = \{(.*?)\}')
    if ($fn310.Success -and $fn310.Groups[1].Value -match 'hedgeRitual') { $v310Bad += "FILTER_NAME carries a hedgeRitual control - all twelve rows answer to the SAME question, so this scope holds by ROOT; by name only the one named row would filter (SPEC V310f, I83g, V203)" }

    $rhp310 = [regex]::Match($hh6NoC310, "(?s)\n\t\t\tfunction renderHedgePickers\(from\)(.*?)\n\t\t\tend;")
    if (-not $rhp310.Success) { $v310Bad += "renderHedgePickers is gone from WoD20.6 - nothing re-filters the hedge combos (SPEC V310f, V209)" }
    elseif ($rhp310.Groups[1].Value -notmatch 'cbohedgeRitual_') { $v310Bad += "renderHedgePickers names no cbohedgeRitual control - xpFind would come back with the two old combos and the twelve ritual ones would keep whatever list the last repaint left them (SPEC V310f, I83i)" }
    elseif ($rhp310.Groups[1].Value -notmatch 'HEDGE_RITUAL_ROWS - HEDGE_RITUAL_FREE_ROWS') { $v310Bad += "renderHedgePickers does not stop at total minus the typed rows - a typed row carries an edt and asking for its cbo is asking for a control that cannot exist (SPEC V248c, V310f)" }

    $doc310 = Doc (Join-Path $dir "WoD20.7.lfm")
    $link310 = $null
    foreach ($dl in $doc310.SelectNodes("//dataLink")) {
        if ($dl.GetAttribute("onChange") -match 'renderHedgePickers' -and $dl.GetAttribute("fields") -match "'numina_1'") { $link310 = $dl }
    }
    if ($null -eq $link310) { $v310Bad += "no dataLink on WoD20.7 watches the numina rows and calls renderHedgePickers - buying a level would open no ritual until something else repainted the tab (SPEC V310f, I83i, B48)" }
    else {
        $f310 = $link310.GetAttribute("fields")
        $namesSeen310 = @(1..17 | Where-Object { $f310 -notmatch "'numina_$_'" })
        if ($namesSeen310.Count -gt 0) { $v310Bad += "the numina dataLink misses row name(s) $($namesSeen310 -join ', ') - renaming the path on a row it does not watch leaves the ritual list built for the OLD path (SPEC V310f)" }
        $dotsMissing310 = @()
        foreach ($i in 1..17) { foreach ($d in 1..5) { if ($f310 -notmatch "'numina_${i}_${d}'") { $dotsMissing310 += "numina_${i}_${d}" } } }
        if ($dotsMissing310.Count -gt 0) { $v310Bad += "the numina dataLink misses $($dotsMissing310.Count) dot field(s), e.g. $($dotsMissing310[0]) - the filter would wake only when a path was RENAMED, so buying a level opens no ritual, with rdk exiting 0 and this gate green (SPEC V310f, B48)" }
    }
}

if ($v310Bad) { foreach ($b in $v310Bad) { Fail "V310 $b" } }
else { Pass "V310 the ritual filter reads one table of $($hrp310.Count) ritual(s) against a map of all 17 numina rows, answers inside pickAllowed before pickRefusal, rides the memo's own generation, and is woken by 17 names and 85 dots" }

# ---- V312: the width ruler knows the FONT SIZE, and is still a ceiling -------------------
# SPEC I86f, V312, R116, user 2026-08-26. Leg (c) is the one that gives B43 back if it falls:
# a ruler that loosens is not a licence to re-tighten, and a comboBox CLIPS rather than wraps.
$v312Bad = @()

$gateSrc312 = [System.IO.File]::ReadAllText($PSCommandPath)
$body312    = [regex]::Match($gateSrc312, '(?s)function NeededPx\(([^)]*)\)\s*\{(.*?)\n\}')

# (a) TWO constants, and the 12pt one is picked by the ATTRIBUTE. A ruler chosen by control
# NAME is a nominal exception wearing a formula's clothes (SPEC V312a).
$def312 = [regex]::Match($gateSrc312, '(?m)^\$PX_PER_CHAR\s*=\s*([\d.]+)\s*$')
$s12312 = [regex]::Match($gateSrc312, '(?m)^\$PX_PER_CHAR_12\s*=\s*([\d.]+)\s*$')

if (-not $def312.Success) { $v312Bad += "`$PX_PER_CHAR is gone - the body ruler every label is measured against no longer exists and this check measured nothing (SPEC V209, V16)" }
elseif (-not $s12312.Success) { $v312Bad += "`$PX_PER_CHAR_12 is gone - the fontSize axis collapsed back to one literal and the four fields of I86d are illegal again (SPEC V312a, V209)" }
elseif (-not $body312.Success) { $v312Bad += "NeededPx could not be read - the one place that turns characters into pixels is unreadable (SPEC V312d, V209)" }
else {
    $defV312 = [double]$def312.Groups[1].Value
    $s12V312 = [double]$s12312.Groups[1].Value

    if ($defV312 -ne 6.5) { $v312Bad += "the body ruler is $defV312, not the 6.5 it has been calibrated at since the first round - the 114th round added an axis, it did not move this one (SPEC V312a)" }
    # (b) the 12pt ruler stays ABOVE what the screen draws. R116 measured >1cm of slack beside
    # a 55-character item in a 362px interior, which puts the truth at 5.89 or less.
    if ($s12V312 -gt $defV312) { $v312Bad += "the 12pt ruler ($s12V312) is WIDER than the body ruler ($defV312) - smaller glyphs cannot need more pixels, so one of the two is upside down (SPEC V312b)" }
    if ($s12V312 -lt 5.9) { $v312Bad += "the 12pt ruler is $s12V312, under the 5.9 R116's measurement bounds it at - below that it stops being a CEILING and becomes a guess, and what waits there is a comboBox that clips (SPEC V312b, B43, R116)" }

    $nbody312 = $body312.Groups[2].Value
    if ($nbody312 -notmatch '\$PX_PER_CHAR_12' -or $nbody312 -notmatch '\$PX_PER_CHAR\b') { $v312Bad += "NeededPx does not read BOTH rulers - whichever it dropped is a constant nothing consults (SPEC V312d)" }
    if ($nbody312 -notmatch "12") { $v312Bad += "NeededPx never tests for the size 12 - the second ruler exists and no control can ever reach it (SPEC V312a)" }
    if ($body312.Groups[1].Value -notmatch 'fontSize') { $v312Bad += "NeededPx does not take a fontSize - the ruler cannot be chosen by the attribute, only by the caller's opinion (SPEC V312a)" }
    # The negative half of (a): the choice is made on the SIZE, never on who is asking.
    if ($nbody312 -match 'cbo[A-Z]|GetAttribute\("name"\)|hedgeAffiliation') { $v312Bad += "NeededPx picks its ruler from a control NAME - that is a nominal exception, which is B38 arriving through the width door (SPEC V312a)" }

    # (d) ONE place reads the rulers. Two owners for one sum is B70 on another axis - and the
    # test is where they are READ, not how they are multiplied: the product is written against
    # the chosen ruler, so counting `*` would measure the spelling of one line.
    #
    # Comment lines are cut first, or this check's own prose about $PX_PER_CHAR would count as
    # a second reader and the leg would redden on itself.
    $codeOnly312 = ($gateSrc312 -split "`n" | Where-Object { $_ -notmatch '^\s*#' }) -join "`n"
    $outside312 = 0
    foreach ($m312 in [regex]::Matches($codeOnly312, '\$PX_PER_CHAR(_12)?')) {
        $lineAt312 = $codeOnly312.Substring(0, $m312.Index)
        $lineAt312 = $lineAt312.Substring($lineAt312.LastIndexOf("`n") + 1)
        if ($lineAt312 -match '^\$PX_PER_CHAR') { continue }          # the two definitions
        if ($nbody312.Contains($m312.Value)) { continue }             # inside NeededPx
        $outside312++
    }
    if ($outside312 -gt 0) { $v312Bad += "a ruler is read outside NeededPx and outside its own declaration - two owners for one sum is what B70 cost a round to find (SPEC V312d)" }

    # (c) the ruler only LOOSENED. Every 12pt picker keeps the width it had, and the four of
    # I86d are the whole of this round's narrowing - named, so a fifth cannot slip in quietly.
    $WIDTH312 = @{
        'cboHedgeAffiliation' = 360
        'edtHedgeAffiliation' = 360
        'cboHedgeAttr'        = 360
    }
    $doc312 = Doc (Join-Path $dir "WoD20.7.lfm")
    $seen312 = 0
    foreach ($nm312 in $WIDTH312.Keys) {
        $node312 = @($doc312.SelectNodes("//*[@name='$nm312']"))[0]
        if ($null -eq $node312) { $v312Bad += "'$nm312' is not on WoD20.7 - one of the controls I86d narrows cannot be found, so this leg measured less than it claims (SPEC V209)"; continue }
        $seen312++
        $w312 = [int]$node312.GetAttribute("width")
        if ($w312 -ne $WIDTH312[$nm312]) { $v312Bad += "'$nm312' is ${w312}px, not the $($WIDTH312[$nm312]) I86d sets - the entry column is a GRID and one control leaving it reopens the ladder the user had removed (SPEC I86d, V297b)" }
    }
    if ($seen312 -ne 3) { $v312Bad += "only $seen312 of the 3 named entry controls were measured (SPEC V209)" }

    # The Essence edit carries no name, so it is reached by its field - and it has to land on
    # the same width as its two neighbours or V297b is the only thing left holding the grid.
    $ess312 = @($doc312.SelectNodes("//edit[@field='hedgeEssence']"))[0]
    if ($null -eq $ess312) { $v312Bad += "the hedgeEssence entry is gone from WoD20.7 - the middle row of the HEDGE MAGIC grid is unmeasured (SPEC V209, I86d)" }
    elseif ([int]$ess312.GetAttribute("width") -ne 360) { $v312Bad += "the hedgeEssence entry is $([int]$ess312.GetAttribute('width'))px, not 360 - it is a free-text field with no list to price it, so nothing but this leg keeps it on the grid (SPEC I86d)" }

    # No OTHER 12pt picker SPENT the slack, and the test says exactly that rather than guessing
    # at a width: every one of them still clears the OLD 6.5 ruler, which each of them cleared
    # before this round (the gate was green). The four of I86d are excluded because failing 6.5
    # is the whole point of them.
    #
    # A bare width threshold cannot express this - the sheet has 12pt pickers at 150px holding
    # three-word lists, and they are correct. The ruler gaining slack is not permission to spend
    # it: the vampire ritual and path rows carry the longest strings the sheet owns, and they are
    # exactly where B43 was found.
    foreach ($f312 in $files) {
        foreach ($cb312 in (Doc $f312.FullName).SelectNodes("//comboBox[@fontSize='12'][@width]")) {
            $cn312 = $cb312.GetAttribute("name")
            if ($WIDTH312.ContainsKey($cn312)) { continue }
            $cw312 = 0; if (-not [int]::TryParse($cb312.GetAttribute("width"), [ref]$cw312)) { continue }
            $tpl312 = TplOf $cb312
            $need312 = 0; $worst312 = ""
            foreach ($it312 in (ListOf $cb312 $tpl312)) {
                if ($it312 -eq '') { continue }
                $n312 = NeededPx $it312
                if ($n312 -gt $need312) { $need312 = $n312; $worst312 = $it312 }
            }
            if ($need312 -eq 0) { continue }
            if (($need312 + $ARROW) -gt $cw312) { $v312Bad += "$($f312.Name): the 12pt picker '$cn312' is ${cw312}px and would not clear the OLD 6.5 ruler ('$worst312' wants $($need312 + $ARROW)) - it spent slack the 114th round opened for four named controls and nobody else (SPEC V312c, R116)" }
        }
    }
}

if ($v312Bad) { foreach ($b in $v312Bad) { Fail "V312 $b" } }
else { Pass "V312 the ruler is a pair - 6.5 for the body and $($s12312.Groups[1].Value) for 12pt, chosen by the attribute in the one place that multiplies - and only the 3 named entries plus hedgeEssence spent the slack" }

# ---- V318: the line ending is CONTENT, and it is MEASURED --------------------------------
# SPEC B74, the 118th round. The Git Bash text tools rewrite a file WITHOUT its carriage
# returns - not on the line that matched, on the whole file - and four one-line edits turned a
# 3027-line CRLF SPEC.md into bare LF in silence. Three things hid it at once: git diff
# normalises under core.autocrlf=true and showed 11 changed lines rather than 3027, the Git Bash
# `cat -A` does not print ^M either, and rdk -l compiles LF without a word. There was no symptom
# at all, and the commit would have carried it.
#
# So the only signal that exists is the MEASUREMENT, and it is two counts per file. The 116th
# round already wrote this warning into HANDOFF.md for awk and for .lfm only; the real reach is
# every text tool in the shell and every CRLF file in the repo, which is why it is a check now
# and not a note.
$eolBad = @()
$eolSeen = 0
foreach ($f318 in @($files.FullName) + @((Join-Path $PSScriptRoot 'verify-hunters-hunted.ps1'), (Join-Path $PSScriptRoot 'SPEC.md'))) {
    if (-not (Test-Path $f318)) { $eolBad += "$(Split-Path $f318 -Leaf) is not where this check looks for it - it cannot be measured (SPEC V209)"; continue }
    $t318 = [IO.File]::ReadAllText($f318)
    $cr318 = ([regex]::Matches($t318, "`r")).Count
    $lf318 = ([regex]::Matches($t318, "`n")).Count
    $eolSeen++
    if ($lf318 -eq 0) { $eolBad += "$(Split-Path $f318 -Leaf) has no line break at all - it is not the file this check was written for" }
    elseif ($cr318 -ne $lf318) { $eolBad += "$(Split-Path $f318 -Leaf) carries $cr318 CR against $lf318 LF - a text tool rewrote it and ate the carriage returns, which git diff hides under autocrlf and rdk -l compiles without a word (SPEC B74)" }
}
if ($eolSeen -lt 17) { Fail "V318 only $eolSeen file(s) were measured, expected the 15 .lfm plus the gate and the spec - this check is covering less than the repo has (SPEC V209)" }
elseif ($eolBad) { foreach ($b in $eolBad) { Fail "V318 $b" } }
else { Pass "V318 all $eolSeen source files are CRLF end to end - no text tool has eaten a carriage return" }

# ---- V319: the corrente BAR is the THIRD drawing family, and each style pays its own -------
# The 119th round. I88 gave the Dark Ages its bar through the same palette key that already
# chose its box frame; this does it for Modern Nights, and REVOKES I90h, which one round ago
# left that era's bar on the default drawing BY DECISION. Six legs, and (e) and (f) are the two
# that keep the sheet's first FILLED ink from surviving into an era that never asked for it.
$v319Bad  = @()
$path319  = LuaFn $hh6 'markPath'
$cor319   = LuaFn $hh6 'markCorrente'
$fil319   = LuaFn $hh6 'markFilete'
$rule319  = LuaFn $hh6 'markRule'
$corOwn319 = @('ORN_COR_MARK', 'ORN_COR_IN', 'ORN_COR_MARK2', 'ORN_COR_SPAN', 'ORN_COR_SUB2', 'ORN_COR_SUB_SPAN', 'ORN_COR_DOT')
$num319 = @{}
foreach ($k319 in ($corOwn319 + @('ORN_MARK2', 'ORN_PILLR', 'ORN_SUB_MARK'))) {
    $m319 = [regex]::Match($hh6, '(?m)^\s*local ' + $k319 + '\s*=\s*([\d.]+);')
    if ($m319.Success) { $num319[$k319] = [double]$m319.Groups[1].Value }
}
if (-not ($path319 -and $cor319 -and $fil319 -and $rule319)) {
    Fail "V319 markPath / markCorrente / markFilete / markRule could not all be read out of WoD20.6 - every leg below measures one of them, so all six would be no-ops (SPEC V209, V20)"
}
elseif ($num319.Count -ne 10) {
    Fail "V319 read $($num319.Count) of the 10 constants this invariant relates, expected 10 - the Lua side of these relations is gone, and a relation with one side is a no-op (SPEC V209, V20)"
}
else {
    $pathBody319 = NoComments $path319
    $corBody319  = NoComments $cor319
    $filBody319  = NoComments $fil319
    $ruleBody319 = NoComments $rule319

    # (a) the style is DISPATCHED to a drawing of its own, and it arrives as an ARGUMENT.
    # markCorrente is declared ABOVE the local that holds the era's style, so reading it there
    # compiles to a GETGLOBAL and finds nil - exit 0 and nothing to grep, which is B51.
    if ($pathBody319 -notmatch 'if style == "corrente" then return markCorrente') { $v319Bad += "markPath does not dispatch corrente to a drawing of its own - the era falls back to the default bar, which is exactly what I90h said and the 119th round revoked (SPEC I91a)" }
    if ($corBody319 -match '\bornStyleNow\b') { $v319Bad += "markCorrente reads ornStyleNow directly, and that local is declared BELOW it - the read compiles to a GETGLOBAL and answers nil, with exit 0 and nothing to grep (SPEC I91a, V223, B51)" }

    # (b) the topmost ink does not RISE. In the default style it is the upper rule, at
    # h - ORN_MARK2 = 21, which is the state the user approved on screen in the 112th round.
    # Here the main rule IS the topmost ink, so one side is enough - and unlike V315c there is
    # no second owner of the 21 left to age (SPEC I91h, B70, B68).
    if ($num319['ORN_COR_MARK'] -gt $num319['ORN_MARK2']) { $v319Bad += "ORN_COR_MARK ($($num319['ORN_COR_MARK'])) is above ORN_MARK2 ($($num319['ORN_MARK2'])) - the corrente bar has climbed nearer the words than the drawing the user approved in the 112th round ever was (SPEC I91h, V307a, B68)" }

    # (c) the hierarchy holds on BOTH axes: the tab's main rule runs longer than the sub-tab's
    # and its second rule is wider. One axis alone leaves the two levels telling themselves
    # apart by a single number, which is I78b's hierarchy on one leg (SPEC I91b, I91c).
    $foot319 = [Math]::Sqrt(($num319['ORN_PILLR'] + $num319['ORN_SUB_MARK']) * ($num319['ORN_PILLR'] + $num319['ORN_SUB_MARK']) - $num319['ORN_SUB_MARK'] * $num319['ORN_SUB_MARK'])
    if ($num319['ORN_COR_IN'] -ge $foot319) { $v319Bad += "ORN_COR_IN ($($num319['ORN_COR_IN'])) is not inside the sub-tab's foot ($([Math]::Round($foot319, 2))) - the tab's main rule has stopped being the longer of the two and the levels read the same (SPEC I91b, V319c)" }
    if ($num319['ORN_COR_SPAN'] -ge $num319['ORN_COR_SUB_SPAN']) { $v319Bad += "ORN_COR_SPAN ($($num319['ORN_COR_SPAN'])) is not less than ORN_COR_SUB_SPAN ($($num319['ORN_COR_SUB_SPAN'])) - the tab's second rule has stopped being the wider one, and equal spans lose the hierarchy with nothing anywhere to say so (SPEC I91c, V315d)" }

    # (d) the floor is READ, never spelled, and there is ONE per motif - the main rule's. The
    # second rule is PROPORTIONAL, so it cannot run out of room and has no floor to write: a
    # guard that CANNOT fire is B59's hole (SPEC I91g, V314e, V315e).
    $wTop319 = @(); $wSub319 = @(); $sepN319 = 0
    foreach ($pr319 in @(@("WoD20th.lfm", "tabStrip", $true), @("WoD20.11.lfm", "vampStrip", $false), @("WoD20.7.lfm", "numStrip", $false), @("WoD20.7.lfm", "hedgeStrip", $false))) {
        $st319 = (Doc (Join-Path $dir $pr319[0])).SelectSingleNode("//layout[@name='$($pr319[1])']")
        if ($null -eq $st319) { $v319Bad += "$($pr319[1]) is gone from $($pr319[0]) - the bar this invariant measures does not exist (SPEC I32, I58, V209)"; continue }
        foreach ($r319 in $st319.SelectNodes("rectangle[starts-with(@name,'tabOn')]")) {
            if ($pr319[2]) { $wTop319 += [double]$r319.GetAttribute("width") } else { $wSub319 += [double]$r319.GetAttribute("width") }
        }
        $sepN319 += @($st319.SelectNodes("rectangle[starts-with(@name,'sep')]")).Count
    }
    if (($wTop319.Count + $wSub319.Count) -ne 19) { $v319Bad += "read $($wTop319.Count + $wSub319.Count) marker(s) across the four bars, expected 19 - this check is covering less than the bars hold (SPEC V209)" }
    else {
        $minAll319 = (($wTop319 + $wSub319) | Measure-Object -Minimum).Minimum
        $minSub319 = ($wSub319 | Measure-Object -Minimum).Minimum
        if ($minAll319 -le (2 * $num319['ORN_COR_IN'])) { $v319Bad += "the narrowest marker is $minAll319 against a floor of $(2 * $num319['ORN_COR_IN']) - at that width the corrente tab draws nothing at all, and a bar that quietly disappears is not the one anybody chose (SPEC I91g, V279, B59)" }
        if ($minSub319 -le (2 * $foot319)) { $v319Bad += "the narrowest sub-tab is $minSub319 against a floor of $([Math]::Round(2 * $foot319, 2)) - its main rule would be drawn end before start, so the marker refuses and the level loses its mark (SPEC I91g, V279, B59)" }
    }
    if ($sepN319 -ne 5) { $v319Bad += "read $sepN319 separator carrier(s) across the bars, expected 5 - the dot the user asked for has lost a carrier to stand in (SPEC I78d, I91d, V209)" }

    # (e) the FILL has ONE owner and it is the DRAWING. markPath and markFilete return the path
    # alone, markCorrente returns a second value in its `sep` branch and nowhere else, and
    # markRule spells neither a style nor a motif of its own - it only applies what it is
    # handed. Two owners of "who is filled" is B69 in a third place (SPEC I91e).
    if ($ruleBody319 -match '"corrente"') { $v319Bad += "markRule spells the corrente style - the painter has taken a second opinion on a question the drawing already answers, which is the sharing B69 is made of (SPEC I91e)" }
    if ($ruleBody319 -match '"sep"') { $v319Bad += "markRule spells the sep motif - it is markKind that resolves the level and the drawing that decides the fill, and a third reader of either is one that can disagree (SPEC I91e)" }
    if ($filBody319 -match ', true') { $v319Bad += "markFilete returns a second value - the filete style has taken up the fill flag, and the Dark Ages cross would be painted solid (SPEC I91e)" }
    if ($pathBody319 -match ', true') { $v319Bad += "markPath returns a second value of its own - the fill would arrive from the dispatcher instead of the drawing, and every era would carry it (SPEC I91e)" }
    $iSep319 = $corBody319.IndexOf('if kind == "sep" then')
    $iSub319 = $corBody319.IndexOf('if kind == "sub" then')
    $iTab319 = $corBody319.IndexOf('local s = w * ORN_COR_SPAN')
    if ($iSep319 -lt 0 -or $iSub319 -le $iSep319 -or $iTab319 -le $iSub319) {
        $v319Bad += "markCorrente does not hold the sep, sub and tab motifs in that order - the slices this leg reads cannot be cut, so the per-motif half of it would measure nothing (SPEC I91b, V209, V20)"
    }
    else {
        $sl319 = @(
            @{ name = 'sep'; text = $corBody319.Substring($iSep319, $iSub319 - $iSep319); forbid = @('ORN_COR_MARK', 'ORN_COR_MARK2', 'ORN_COR_IN', 'ORN_COR_SPAN', 'ORN_COR_SUB2', 'ORN_COR_SUB_SPAN', 'ORN_SUB_MARK') },
            @{ name = 'sub'; text = $corBody319.Substring($iSub319, $iTab319 - $iSub319); forbid = @('ORN_COR_MARK', 'ORN_COR_MARK2', 'ORN_COR_IN', 'ORN_COR_SPAN', 'ORN_COR_DOT') },
            @{ name = 'tab'; text = $corBody319.Substring($iTab319); forbid = @('ORN_COR_SUB2', 'ORN_COR_SUB_SPAN', 'ORN_COR_DOT', 'ORN_SUB_MARK') }
        )
        foreach ($s319 in $sl319) {
            foreach ($b319 in $s319.forbid) {
                if ($s319.text -match ("\b" + [regex]::Escape($b319) + "\b(?!_|\d)")) { $v319Bad += "the corrente $($s319.name) motif reads $b319, which belongs to another motif - that sharing is how the 110th round moved three levels when it was asked to move one (SPEC I91c, V308, B69)" }
            }
        }
        if ($sl319[0].text -notmatch ', true') { $v319Bad += "the corrente sep motif does not return the fill flag - the dot comes out as an outline and the user's choice of a SOLID one is undone with exit 0 and the gate green (SPEC I91d, I91e)" }
        if ($sl319[1].text -match ', true') { $v319Bad += "the corrente sub motif returns the fill flag - a sub-tab's rules would be filled, and filling an open run is ink nobody asked for (SPEC I91e)" }
        if ($sl319[2].text -match ', true') { $v319Bad += "the corrente tab motif returns the fill flag - the top bar's rules would be filled, and filling an open run is ink nobody asked for (SPEC I91e)" }
    }

    # (f) the memo CARRIES the fill and markRule writes the colour on every repaint. Nailed at
    # creation, `color` survives a swap of era on an OPEN sheet and leaves the next era's cross
    # filled - rdk -l exit 0, gate green, and only the screen left to tell (SPEC I91f, B58, B62).
    if ($ruleBody319 -notmatch 'local d, f = markPath\(bw, bh, kind, ornStyleNow\)') { $v319Bad += "markRule does not take the fill flag back from markPath at CREATION - the memo would carry nil and the dot would never be filled (SPEC I91e, I91f)" }
    if ($ruleBody319 -notmatch 'local d, f = markPath\(c\.width, c\.height, e\.k, ornStyleNow\)') { $v319Bad += "markRule does not take the fill flag back from markPath when the era CHANGES - the memo would keep the previous era's answer for ever (SPEC I91f)" }
    if ($ruleBody319 -notmatch 'f = f, s = ornStyleNow') { $v319Bad += "the creation entry does not stamp the fill flag with s still LAST - either the memo has lost the flag, or the stamp has moved off the brace V315f tells the creation by (SPEC I91f, V315f)" }
    if ($ruleBody319 -notmatch 'e\.f = f') { $v319Bad += "markRule never writes the new fill flag back into the memo after redrawing - the entry would answer for the PREVIOUS era's drawing (SPEC I91f, V284)" }
    if ($ruleBody319 -notmatch 'e\.p\.color = colour') { $v319Bad += "markRule never paints the fill - the dot is drawn and left hollow, which is the drawing the user did NOT pick (SPEC I91d, I91f)" }
    if ($ruleBody319 -match '(?<![\w.])p\.color') { $v319Bad += "markRule nails p.color shut at creation - swapping era on an OPEN sheet then leaves the next era's separator FILLED, with exit 0, the gate green and only the screen to tell (SPEC I91f, B58, B62)" }

    if ($v319Bad) { foreach ($b in $v319Bad) { Fail "V319 $b" } }
    else { Pass "V319 the corrente bar is a drawing of its own, its seven constants stay inside their motifs, its ink tops out no higher than $($num319['ORN_MARK2']) from the foot, and the fill comes from the drawing and is repainted every time" }
}
# ---- V320: the AVATAR wears the era's shape by a DECLARED roster, and ONE question says
# who DRAWS (SPEC I92, the 120th round) ------------------------------------------------------
# The avatar is the one thing on the sheet that is shaped like a section box and is not one:
# its frame is DimGray and its carrier is transparent, so the construction test of V278 refuses
# both and Modern Nights left it with the concave bite while the 73 wore the cut corner. The arm
# that lets it in cannot be a rule about SHAPE - by construction the carrier IS the nineteen
# tabOn<X> pills - so it is a roster of two names, and every leg below reads its other side out
# of the Lua or out of the XML rather than spelling it here.
$v320Bad = @()

$sbFn320    = LuaFn $hh6 'sectionBox'
$ornFn320   = LuaFn $hh6 'ornament'
$sbBody320  = if ($sbFn320)  { NoComments $sbFn320 }  else { '' }
$ornBody320 = if ($ornFn320) { NoComments $ornFn320 } else { '' }

$themeM320  = [regex]::Match($hh6, 'local function applyTheme\(v, from\)(.*?)\n\t\t\tend;', 'Singleline')
$themeB320  = if ($themeM320.Success) { NoComments $themeM320.Groups[1].Value } else { '' }

$roster320  = @('avatarFrame', 'ornAvatar')
$frame320   = $mainDocV69.SelectSingleNode("//rectangle[@name='avatarFrame']")
$carrier320 = $mainDocV69.SelectSingleNode("//rectangle[@name='ornAvatar']")
$img320     = $mainDocV69.SelectSingleNode("//image[@field='avatar']")

$allLfm320  = (Get-ChildItem (Join-Path $dir '*.lfm') | ForEach-Object { [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($_.FullName)) }) -join "`n"
$tabOn320   = ([regex]::Matches($allLfm320, 'name="tabOn')).Count

# Zero-guard FIRST: every leg under this reads the selector, the two rectangles or the pills,
# and a leg that reads nothing passes for the wrong reason (SPEC V209, V20).
if (-not $sbFn320)          { $v320Bad += "sectionBox is not in WoD20.6 - the selector this whole block measures does not exist (SPEC V209)" }
if (-not $ornFn320)         { $v320Bad += "ornament() could not be read - leg (c) cannot tell which answer it takes and is a no-op (SPEC V209, V20)" }
if (-not $themeM320.Success){ $v320Bad += "applyTheme could not be read - the corner write is unmeasurable and leg (c) is half blind (SPEC V209, V20)" }
if ($null -eq $frame320)    { $v320Bad += "no rectangle named avatarFrame in WoD20.1 - the roster points at a control that is gone, which is a check that goes quiet on the thing it guards (SPEC V209, V320a, B7)" }
if ($null -eq $carrier320)  { $v320Bad += "no rectangle named ornAvatar in WoD20.1 - same hole, and this is the one that DRAWS (SPEC V209, V320a, B7)" }
if ($null -eq $img320)      { $v320Bad += "the avatar image is gone from WoD20.1 - leg (d) has nothing to sit the two rectangles around (SPEC V209)" }
if ($tabOn320 -lt 19)       { $v320Bad += "only $tabOn320 tabOn<X> carriers were read and there are 19 - leg (b) measures the collision this roster exists to avoid, so reading fewer is measuring less than the sheet has (SPEC V209, V20)" }

# (a) the arm cites EXACTLY the two names, and both are in the XML above. A roster that names a
# control nobody authored is green over a hole; a roster that grew a third name quietly is a
# selector nobody declared.
$cited320 = @([regex]::Matches($sbBody320, 'nm\s*==\s*"([^"]+)"') | ForEach-Object { $_.Groups[1].Value })
if ((($cited320 | Sort-Object) -join ',') -ne (($roster320 | Sort-Object) -join ',')) {
    $v320Bad += "sectionBox's name arm cites [$($cited320 -join ', ')] and the declared roster is [$($roster320 -join ', ')] - the two sides have to be the same list, or the selector answers for a control the spec never let in (SPEC V320a, I92a)"
}

# (b) by NAME and never by CONSTRUCTION. The carrier is transparent both ways with its own
# radius and hitTest false - the four properties of every tabOn<X> - so a fill-based arm bevels
# the nineteen pills, whose width is priced for the concave arc (SPEC V228, V316d). This is the
# leg the "swap the roster for a shape test" mutation has to turn red.
if ($sbBody320 -match '#00000000') {
    $v320Bad += "sectionBox tests the TRANSPARENT fill - that is construction, not a roster, and it lets in all $tabOn320 tabOn<X> carriers along with the avatar's, bevelling pills whose width was priced for the arc (SPEC V320b, V228, V316d)"
}
if ($sbBody320 -match 'tabOn') {
    $v320Bad += "sectionBox mentions tabOn - the selector is reasoning about the tab pills, which means the roster stopped being about the avatar (SPEC V320b)"
}
if ($sbBody320 -notmatch 'getName\(\)') {
    $v320Bad += "sectionBox never asks the control its NAME, so whatever arm it grew is not the declared roster of I92a (SPEC V320b)"
}

# (c) ONE selector, TWO answers. The corner write takes the FIRST, ornament() takes the SECOND,
# and neither of them may reason about a name on its own - a second copy of "which rectangles
# are the boxes" is what V67 pays not to have (SPEC I89b, I92b).
if (([regex]::Matches($hh6, 'local function sectionBox')).Count -ne 1) {
    $v320Bad += "sectionBox is declared $((([regex]::Matches($hh6, 'local function sectionBox')).Count)) times - there is exactly one question about who the boxes are (SPEC V320c, V67, I89b)"
}
if ($sbBody320 -notmatch 'return true, true') {
    $v320Bad += "sectionBox has no `"return true, true`" - the pair of answers I92b is built on is not there, so nothing distinguishes wearing the shape from receiving the drawing (SPEC V320c)"
}
if ($sbBody320 -notmatch 'return true, false') {
    $v320Bad += "sectionBox never answers `"wears but does not draw`" - the frame would take a path of its own, and it sits UNDER the image, so that path lands behind the photo (SPEC V320c, I92c, B75)"
}
if ($ornBody320 -notmatch 'local _, draws = sectionBox\(c, fill\)') {
    $v320Bad += "ornament() does not take the SECOND answer from sectionBox - reading the first would hang a path on the avatar frame, behind the photo, which is B75 all over again (SPEC V320c, I92b)"
}
if ($ornBody320 -notmatch 'if not draws then return; end;') {
    $v320Bad += "ornament() does not refuse on the second answer - whatever it refuses on now, it is not the one that says who draws (SPEC V320c)"
}
if ($themeB320 -notmatch 'if sectionBox\(c, fill\) then') {
    $v320Bad += "the corner write no longer reads sectionBox's FIRST answer - either it stopped asking, or it started asking a second question of its own (SPEC V320c, V316d)"
}
foreach ($nm320 in $roster320) {
    if ($ornBody320 -match [regex]::Escape($nm320)) { $v320Bad += "ornament() names $nm320 itself - the roster has a second copy, and two lists of who the avatar is will drift (SPEC V320c, V67)" }
    if ($themeB320 -match [regex]::Escape($nm320)) { $v320Bad += "the theme walk names $nm320 itself - same second copy, on the corner side this time (SPEC V320c, V67)" }
}

# (d) the one that DRAWS is the one on TOP, and that is POSITION IN THE FILE rather than a name:
# the frame is declared BEFORE the image and the carrier AFTER it, so the path the carrier gets
# lands over the photo. Inverted, the drawing goes behind the picture with exit 0, a green gate
# and only the screen to tell - which is exactly B75.
$posFrame320 = $mainRawForMap.IndexOf('name="avatarFrame"')
$posImg320   = $mainRawForMap.IndexOf('field="avatar"')
$posCarr320  = $mainRawForMap.IndexOf('name="ornAvatar"')
if ($posFrame320 -lt 0 -or $posImg320 -lt 0 -or $posCarr320 -lt 0) {
    $v320Bad += "one of the avatar's three controls could not be found in the raw XML, so the stacking order is unmeasurable (SPEC V209, V320d)"
} else {
    if ($posFrame320 -gt $posImg320) { $v320Bad += "avatarFrame is declared AFTER the image - the grey letterbox would paint over the photo (SPEC V320d, I92c)" }
    if ($posCarr320 -lt $posImg320)  { $v320Bad += "ornAvatar is declared BEFORE the image - its path would land BEHIND the photo, drawn and invisible, which is B75 in one line (SPEC V320d, B75, I92c)" }
}

# (e) the frame keeps the shape V309 collects it by. The name is new; the DimGray fill is what
# V309's collector matches on, and losing it would take the avatar out of the check that exists
# because the frame spent three rounds thirty pixels behind the photo (SPEC B71).
if ($null -ne $frame320 -and $frame320.GetAttribute('color') -ne 'DimGray') {
    $v320Bad += "avatarFrame no longer authors color='DimGray' - V309 collects it by that fill, so renaming it out of the collector is B71 waiting to happen again (SPEC V320e, V309, V53)"
}

# (f) FOUR palettes declare ornament. AMENDED by the 122nd round (SPEC V322e): it read THREE,
# and the Classical Age was the one staying clean. It now declares an ornament of its own, so the
# count moves and the leg does NOT go away: what it measures is that the number of ornamented eras
# is DECLARED and never accidental, which is what stops a fifth from arriving unannounced. The
# avatar itself draws in NO era since V321 - this count is now about the 73 boxes.
# The original reason still stands: this leg exists so that "the era did not change" cannot
# Classical Age" cannot become a bug report in a later round - which is precisely what T695(4)
# became once Modern Nights grew an ornament of its own.
$ornDecl320 = ([regex]::Matches($hh6, '(?m)^\s*ornament\s*=\s*"#[0-9A-Fa-f]{6,8}"')).Count
if ($ornDecl320 -ne 4) {
    $v320Bad += "$ornDecl320 palette(s) declare ornament and the sheet is built around 4 - every era declares its own frame since the 122nd round, so a fifth is a drawing in an era nobody asked for and a third is one era losing it (SPEC V320f, V322e, V277)"
}

if ($v320Bad) { foreach ($b in $v320Bad) { Fail "V320 $b" } }
else { Pass "V320 the avatar wears the era's shape by a roster of $($roster320.Count) declared names, one selector answers both who wears and who draws, the carrier is the control on top, and $ornDecl320 palettes declare ornament" }

# ---- V321: NO avatar control receives a path, and the PAIR of answers survives (SPEC I93,
# the 121st round) ---------------------------------------------------------------------------
# The 120th round let the carrier draw, and the drawing came out over the whole tab: ornament()
# hangs its path on the control's PARENT with align="client" (SPEC I72c), so the geometry comes
# from the parent and not from the control. The 73 boxes fill their layout; the carrier is a
# loose rectangle in the tab's scrollBox and fills nothing. That is B76, and it is invisible to
# rdk -l and to every check above - the position only exists at runtime. What CAN be measured is
# the answer the selector gives, so that is what this pins.
$v321Bad = @()

$sbFn321    = LuaFn $hh6 'sectionBox'
$ornFn321   = LuaFn $hh6 'ornament'
$sbBody321  = if ($sbFn321)  { NoComments $sbFn321 }  else { '' }
$ornBody321 = if ($ornFn321) { NoComments $ornFn321 } else { '' }
$roster321  = @('avatarFrame', 'ornAvatar')

# Zero-guard FIRST (SPEC V209, V20).
if (-not $sbFn321)  { $v321Bad += "sectionBox is not in WoD20.6 - every leg here measures its answers and there are none (SPEC V209)" }
if (-not $ornFn321) { $v321Bad += "ornament() could not be read - leg (c) counts its parent writes and would count zero for the wrong reason (SPEC V209, V20)" }

# (a) each roster name is cited on a line that answers WEARS BUT DOES NOT DRAW. Both sides are
# read: the name has to be in the arm, and the arm it is in has to say `return true, false`.
foreach ($nm321 in $roster321) {
    $arm321 = [regex]::Match($sbBody321, '(?m)^.*nm\s*==\s*"' + [regex]::Escape($nm321) + '".*$')
    if (-not $arm321.Success) {
        $v321Bad += "the roster name $nm321 is not cited in sectionBox at all - the arm this leg measures is gone, and a check that goes quiet on a missing target is B7 waiting (SPEC V209, V321a)"
    } elseif ($arm321.Value -notmatch 'return true, false') {
        $v321Bad += "sectionBox answers DRAWS for $nm321 - ornament() would hang a path on it, and because the path takes its geometry from the PARENT that path covers the whole tab, not the control (SPEC V321a, I93b, B76)"
    }
}

# (b) the PAIR survives the removal. The question "who draws" still exists - today the 73 are
# the whole answer - and collapsing sectionBox back to one value leaves a selector that cannot
# say no the next time a loose control joins the roster.
if ($sbBody321 -notmatch 'return true, true') {
    $v321Bad += "sectionBox no longer answers `"wears and draws`" for anyone - the 73 boxes are that answer, so this is the section boxes losing their own frame (SPEC V321b, I93a)"
}
if ($ornBody321 -notmatch 'local _, draws = sectionBox\(c, fill\)') {
    $v321Bad += "ornament() stopped taking the SECOND answer - with the pair gone it would draw for whoever merely WEARS the shape, which is B76 by another door (SPEC V321b, V320c)"
}

# (c) ONE creation path in ornament(), and it is the parent. markRule has its own
# (p:setParent(c)) and is another painter; copying it in here is the second branch I93b refuses
# and the second creation path V67 pays not to have.
$setP321 = [regex]::Matches($ornBody321, 'p:setParent\(')
if ($setP321.Count -ne 1) {
    $v321Bad += "ornament() has $($setP321.Count) p:setParent( calls and there is exactly one - a second creation path is how the avatar gets its drawing back through the door I93b closed (SPEC V321c, V67)"
}
elseif ($ornBody321 -notmatch 'p:setParent\(c\.parent\)') {
    $v321Bad += "ornament() no longer parents the path to c.parent - the rule of I72c is what puts the drawing above the box's own fields, and changing it silently moves every one of the 73 frames (SPEC V321c, I72c)"
}

if ($v321Bad) { foreach ($b in $v321Bad) { Fail "V321 $b" } }
else { Pass "V321 neither of the $($roster321.Count) avatar controls receives a path, the pair of answers still separates wearing from drawing, and ornament() keeps its single parent write" }


# ---- V322: the CORONA MURALIS draws on the 73 and the Classical era stops being the empty
# one (SPEC I94, the 122nd round) -------------------------------------------------------------
# Of the four palettes the Classical was the ONLY one declaring no ornament, so V277 hid its
# path and its boxes were bare outline. Five legs: the palette declares both keys and the colour
# is one it already carried; the fourth branch exists and does NOT take the radius; the size
# guard drops the MERLON and never the rule; the constants stay inside their own family; and
# exactly four palettes now declare an ornament.
$v322Bad = @()

$muralFam322 = ""
foreach ($fn322 in @("ornCoronaMuralis", "ornMuralCorner", "ornMuralEdge", "ornMuralFoot")) { $muralFam322 += (LuaFn $hh6 $fn322) }
$famNC322  = NoComments $muralFam322
$pathNC322 = NoComments (LuaFn $hh6 "ornPath")

# zero-guard: a leg that reads nothing is a no-op that passes by vacancy (SPEC V20, V209, B7)
if (-not $muralFam322) { $v322Bad += "the corona muralis family is gone from WoD20.6 - there is no drawing left to measure (SPEC V209, V322)" }
if (-not $pathNC322)   { $v322Bad += "ornPath is gone from WoD20.6 - nothing dispatches a style at all (SPEC V209)" }

# (a) the palette declares BOTH keys, and the colour is one the palette ALREADY carried. A
# style with no colour is a key that can never draw and never complain (V313a, V277); a colour
# from outside the palette is the loose colour V53 exists to refuse, arriving by the one door
# nobody watches - the ornament.
$pal322 = [regex]::Match($themesBlock, "(?ms)^\t{4}\[""Classical Age""\] = \{(.*?)^\t{4}\},")
if (-not $pal322.Success) { $v322Bad += "the Classical Age palette could not be read - leg (a) measured nothing (SPEC V209, V322a)" }
else {
    $pb322 = NoComments $pal322.Groups[1].Value
    $st322 = [regex]::Match($pb322, "(?m)^\t{5}ornStyle\s*=\s*""([^""]+)""")
    $or322 = [regex]::Match($pb322, "(?m)^\t{5}ornament\s*=\s*""(#[0-9A-Fa-f]{6,8})""")
    $sb322 = [regex]::Match($pb322, "(?ms)^\t{5}stroke = \{(.*?)^\t{5}\},")
    $sw322 = [regex]::Match($sb322.Groups[1].Value, "\[""white""\]\s*=\s*""(#[0-9A-Fa-f]{6,8})""")

    if (-not $st322.Success) { $v322Bad += "the Classical Age palette declares no ornStyle - the era falls back to the default filigree and the round drew nothing (SPEC V322a, I94a)" }
    elseif ($st322.Groups[1].Value -ne "corona-muralis") { $v322Bad += "the Classical Age palette draws $($st322.Groups[1].Value) and the round is built on corona-muralis (SPEC V322a, I94a)" }
    if (-not $or322.Success) { $v322Bad += "the Classical Age palette declares ornStyle and no ornament - the colour is what hides the path (V277), so the style is a key that can never draw and never complain (SPEC V322a, V313a)" }
    elseif (-not $sw322.Success) { $v322Bad += "the Classical Age stroke has no white key - leg (a) has nothing to compare the ornament colour against (SPEC V209, V322a)" }
    elseif ($or322.Groups[1].Value -ne $sw322.Groups[1].Value) {
        $v322Bad += "the Classical ornament is $($or322.Groups[1].Value) and the palette outline is $($sw322.Groups[1].Value) - a colour the palette did not already carry is a loose colour arriving through the ornament, which is the door V53 exists to shut (SPEC V322a, V53)"
    }
}

# (b) the FOURTH branch, and it does NOT forward the radius. The V317a check derives from the
# CODE which style wants a cut corner, by reading which branch carries ornPath radius - hand it
# over here and the gate starts DEMANDING a boxCorner of the Classical palette, which by V317a
# it cannot have. The failure would land one level away from whoever caused it, which is B6.
$sig322 = [regex]::Match($hh6, "local function ornPath\(([^)]*)\)")
$rad322 = ""
if ($sig322.Success) { $sigA322 = $sig322.Groups[1].Value -split "\s*,\s*"; $rad322 = $sigA322[$sigA322.Count - 1] }
$br322 = [regex]::Match($pathNC322, "if style == ""corona-muralis"" then return (\w+)\(([^)]*)\); end;")

if (-not $br322.Success) { $v322Bad += "ornPath has no corona-muralis branch - the palette names a style the dispatcher never heard of, so the era silently draws the default filigree (SPEC V322b, I94b)" }
elseif ($br322.Groups[1].Value -ne "ornCoronaMuralis") { $v322Bad += "the corona-muralis branch calls $($br322.Groups[1].Value) and the drawing is ornCoronaMuralis (SPEC V322b)" }
elseif ($rad322 -and $br322.Groups[2].Value -notmatch ("\b" + [regex]::Escape($rad322) + "\b")) {
    # INVERTED by the 123rd round (SPEC V324b). It used to REFUSE the radius here, and that was
    # what held the Classical era without a corner of its own. Now the palette declares one, so
    # the branch has to carry the radius: drop it and the boxCorner above goes orphan, V317a own
    # derivation stops seeing this style as one that wants a corner, and the failure lands one
    # level away from whoever caused it - the B6 family.
    $v322Bad += "the corona-muralis branch does not forward $rad322 - the palette declares a boxCorner and the drawing would be built to the corner the XML authored instead of the one the era writes, with rdk -l exiting 0 (SPEC V324b, V322b, I96c)"
}

# (c) what a box without room drops is the MERLON, never the RULE. A box skipped in silence
# between ornamented neighbours is B59 in one line - that is how TRUE FAITH (1270x76) fell. The
# floor is READ out of the Lua and measured against the smallest box the XML actually authors,
# so neither can drift from the other (same shape as V314e and V315e).
$c322 = @{}
foreach ($k322 in @("ORN_MUR_OUT", "ORN_MUR_IN", "ORN_MUR_STEP", "ORN_MUR_RISE")) {
    $m322 = [regex]::Match($hh6, "(?m)^\s*local $k322\s*=\s*([\d.]+);")
    if ($m322.Success) { $c322[$k322] = [double]$m322.Groups[1].Value }
}
$boxrM322 = [regex]::Match($hh6, "(?m)^\s*local ORN_BOXR\s*=\s*(\d+);")

if ($c322.Count -ne 4) { $v322Bad += "only $($c322.Count) of the 4 ORN_MUR_* constants could be read - leg (c) has no floor to compute (SPEC V209, V322c)" }
elseif (-not $boxrM322.Success) { $v322Bad += "ORN_BOXR could not be read - the merlon foot cannot be computed (SPEC V209, V322c)" }
elseif ($famNC322 -match "return """";") {
    $v322Bad += "the corona muralis refuses a whole box by size - the RULE is what never drops, so a refusal at that level can only ever be the silent skip of B59 (SPEC V322c, V314e)"
}
elseif ($famNC322 -notmatch "if n < 1 then return; end;") {
    $v322Bad += "the merlon has no size refusal at all - a guard that CANNOT fire is the hole B59 came through, and the crenellation would be drawn end before start (SPEC V322c, V20, V279)"
}
else {
    $ftM322 = [Math]::Sqrt([Math]::Pow([double]$boxrM322.Groups[1].Value + $c322["ORN_MUR_OUT"], 2) - [Math]::Pow($c322["ORN_MUR_OUT"], 2))
    $flr322 = 2 * $ftM322 + $c322["ORN_MUR_STEP"]
    $dim322 = @()
    foreach ($f in $files) {
        foreach ($r322 in (Doc $f.FullName).SelectNodes("//rectangle[@color='black'][@xradius][@width][@height]")) {
            $dim322 += [double]$r322.GetAttribute("width")
            $dim322 += [double]$r322.GetAttribute("height")
        }
    }
    if ($dim322.Count -lt 10) { $v322Bad += "only $($dim322.Count) box dimension(s) were read for leg (c), expected at least 10 - it is measuring less than the sheet has (SPEC V209, V20)" }
    else {
        $minD322 = ($dim322 | Measure-Object -Minimum).Minimum
        if ($minD322 -le $flr322) {
            $v322Bad += "the smallest box side the XML authors is $minD322 against a merlon floor of $([Math]::Round($flr322, 2)) - at that size the crenellation drops and a box wearing only half the crown is not the one anybody chose (SPEC V322c, V279, B59)"
        }
    }
}

# (d) constants stay inside their own family (SPEC V308, B69): a number serving two drawings
# moves both when only one of them was asked for. ORN_OUT and ORN_IN (5 and 9) belong to the
# filigree and the filete, and the merlon has four of its own.
$oldFam322 = ""
foreach ($fn322 in @("ornFiligree", "ornFilete", "ornFileteCorner", "ornFileteEdge", "ornCorrente")) { $oldFam322 += (LuaFn $hh6 $fn322) }
$oldNC322 = NoComments $oldFam322

if ($famNC322 -match "\bORN_OUT\b|\bORN_IN\b") { $v322Bad += "the corona muralis reads ORN_OUT or ORN_IN - those are the filigree and filete rules, and one rule serving two drawings moves both when only one was asked for (SPEC V322d, V308, B69)" }
if ($oldNC322 -match "\bORN_MUR_") { $v322Bad += "the filigree or filete family reads an ORN_MUR_* constant - the merlon owns those four, and a shared owner is B69 in the other direction (SPEC V322d, V308)" }
if (-not $oldNC322) { $v322Bad += "the filigree and filete families could not be read - the second half of leg (d) measured nothing (SPEC V209, V20)" }

# (e) exactly FOUR palettes declare an ornament. This is the amended V320f seen from the other
# side: every era carries a frame now, and the count being DECLARED is what stops a fifth from
# arriving without a round behind it.
$ornDecl322 = ([regex]::Matches($hh6, "(?m)^\s*ornament\s*=\s*""#[0-9A-Fa-f]{6,8}""")).Count
$style322 = ([regex]::Matches($hh6, "(?m)^\t{5}ornStyle\s*=\s*""[^""]+""")).Count
if ($ornDecl322 -ne 4) { $v322Bad += "$ornDecl322 palette(s) declare ornament and every one of the 4 eras is meant to carry a frame since this round (SPEC V322e, V320f)" }
if ($style322 -lt 3) { $v322Bad += "only $style322 palette(s) declare an ornStyle - the corona muralis was the third, and fewer means an era quietly fell back to the default (SPEC V322e, V313a)" }

if ($v322Bad) { foreach ($b in $v322Bad) { Fail "V322 $b" } }
else { Pass "V322 the Classical Age draws corona-muralis in the gold it already carried, the fourth branch takes no radius, the merlon floor ($([Math]::Round($flr322, 2))) clears the smallest box side ($minD322), the four ORN_MUR_* stay in their own family, and $ornDecl322 palettes declare an ornament" }


# ---- V325: the CHUNK fits under the compiler ceiling for locals, and the ceiling is
# MEASURED (SPEC B77, the 122nd round) ---------------------------------------------------------
# What breaks does NOT announce itself: rdk -l exits 1, deletes the .rpk and names neither file
# nor line, so the round that overflows finds out by bisecting six builds unless the gate says it
# first. Three legs: the count, and where the two newest families live.
$v325Bad = @()

# (a) locals at CHUNK scope - three tabs, the level THEMES and the ORN_* families sit at.
# Ceiling measured at 105; the leg keeps 5 of margin.
$chunk325 = [regex]::Matches($hh6, "(?m)^\t{3}local ").Count
if ($chunk325 -eq 0) { $v325Bad += "counted 0 locals at chunk scope in WoD20.6 - the indentation this leg keys on moved, so it is measuring nothing (SPEC V209, V20, V325a)" }
elseif ($chunk325 -gt 100) {
    $v325Bad += "WoD20.6 declares $chunk325 locals at chunk scope against a ceiling of 100 (real limit 105, five kept as margin) - over it rdk -l exits 1, deletes the .rpk and names no file or line (SPEC V325a, B77, B19)"
}

# (c) POSITION, not count, and by PREFIX rather than by a list of names: what this leg measures
# is WHERE a family lives, never WHO is in it. A constant can be renamed inside its painter and
# stay correct; the moment one is hoisted to chunk scope the ceiling is back in play, and (a)
# alone would only catch that once the ceiling was touched - one round late. Same reasoning as
# V325b, which counts instead of naming owners.
$colFn325 = LuaFn $hh6 "markCoronaMuralis"
$murFn325 = LuaFn $hh6 "ornCoronaMuralis"

if (-not $colFn325) { $v325Bad += "markCoronaMuralis is gone from WoD20.6 - leg (c) has no painter to look inside (SPEC V209, V325c)" }
elseif (-not $murFn325) { $v325Bad += "ornCoronaMuralis is gone from WoD20.6 - leg (c) has no painter to look inside (SPEC V209, V325c)" }
else {
    foreach ($px325 in @("ORN_COL_", "ORN_GUT_", "ORN_MUR_")) {
        $hoist325 = [regex]::Matches($hh6, ("(?m)^\t{3}local " + $px325))
        if ($hoist325.Count -gt 0) {
            $v325Bad += "$($hoist325.Count) $px325* constant(s) sit at CHUNK scope - that family lives inside its own painter precisely so the chunk stays under the ceiling, and hoisting one is B77 repeating with a build that fails without naming a line (SPEC V325c, I95b, I94d)"
        }
    }
    foreach ($f325 in @("ornMuralFoot", "ornMuralCorner", "ornMuralEdge")) {
        if ($hh6 -match ("(?m)^\t{3}local function " + $f325 + "\b")) {
            $v325Bad += "$f325 is declared at CHUNK scope - the three mural helpers live inside ornCoronaMuralis, and each one hoisted out spends a chunk local the ceiling has no room for (SPEC V325c, B77)"
        }
    }

    # zero-guard for the leg itself: with the families gone from their painters there would be
    # nothing left to place and the loops above would pass by vacancy (SPEC V20, B7).
    $inCol325 = [regex]::Matches($colFn325, "ORN_COL_\w+|ORN_GUT_\w+").Count
    $inMur325 = [regex]::Matches($murFn325, "ORN_MUR_\w+").Count
    if ($inCol325 -lt 8) { $v325Bad += "markCoronaMuralis mentions $inCol325 column/gutta constant(s) and the family is 8 - leg (c) would be placing constants that are not there (SPEC V209, V20, V325c)" }
    if ($inMur325 -lt 4) { $v325Bad += "ornCoronaMuralis mentions $inMur325 mural constant(s) and the family is 4 - same vacancy on the box side (SPEC V209, V20, V325c)" }
}

if ($v325Bad) { foreach ($b in $v325Bad) { Fail "V325 $b" } }
else { Pass "V325 WoD20.6 declares $chunk325 local(s) at chunk scope against a ceiling of 100, and no ORN_COL_/ORN_GUT_/ORN_MUR_ constant and none of the three mural helpers has been hoisted out of its painter" }

# ---- V323: the COLUMN and the GUTTA draw on the Classical bar (SPEC I95, the 122nd round) -----
# The era stops wearing a new box with the default marker. Six legs.
$v323Bad = @()
$markPathNC323 = NoComments (LuaFn $hh6 "markPath")
$colNC323 = NoComments (LuaFn $hh6 "markCoronaMuralis")
$murNC323 = NoComments (LuaFn $hh6 "ornCoronaMuralis")

# zero-guard
if (-not $colNC323)      { $v323Bad += "markCoronaMuralis is gone from WoD20.6 - there is no bar drawing to measure (SPEC V209, V323)" }
if (-not $markPathNC323) { $v323Bad += "markPath is gone from WoD20.6 - nothing dispatches a marker style (SPEC V209)" }
else {
    $branch323 = [regex]::Matches($markPathNC323, "if style == ""[^""]+"" then return \w+\(").Count
    if ($branch323 -lt 3) { $v323Bad += "markPath has $branch323 style branch(es) and the sheet is built around 3 - the Classical era would fall back to the default marker with nothing to say so (SPEC V209, V323a)" }
}

# (a) the THIRD branch, and it forwards kind. A branch with no function is nil called on the
# theme switch; a function with no branch is code that never runs, with rdk -l 0 and the gate
# green - the B6 family, from both ends.
$br323 = [regex]::Match($markPathNC323, "if style == ""corona-muralis"" then return (\w+)\(([^)]*)\); end;")
$sig323 = [regex]::Match($hh6, "local function markCoronaMuralis\(([^)]*)\)")
if (-not $br323.Success) { $v323Bad += "markPath has no corona-muralis branch - the palette names a style the marker dispatcher never heard of (SPEC V323a, I95a)" }
elseif ($br323.Groups[1].Value -ne "markCoronaMuralis") { $v323Bad += "the corona-muralis marker branch calls $($br323.Groups[1].Value) (SPEC V323a)" }
elseif ($br323.Groups[2].Value -notmatch "\bkind\b") { $v323Bad += "the corona-muralis marker branch does not forward kind - all three levels would draw the same motif (SPEC V323a, I95a)" }
if ($sig323.Success) {
    $nArg323 = @($sig323.Groups[1].Value -split "\s*,\s*").Count
    if ($nArg323 -ne 3) { $v323Bad += "markCoronaMuralis takes $nArg323 parameter(s) and the contract is 3 (w, h, kind) - the level it is drawing for arrives nil (SPEC V323a)" }
} else { $v323Bad += "markCoronaMuralis has no readable signature - leg (a) measured nothing (SPEC V209)" }

# (b) THREE motifs, and three DIFFERENT drawings. A motif that returns "" for one kind is a level
# gone mute on the bar, and there is no rdk -l that says so - only the screen.
if ($colNC323) {
    if ($colNC323 -notmatch 'kind == "sep"') { $v323Bad += "markCoronaMuralis never tests kind == sep - the separator falls through to whatever the tab draws (SPEC V323b, I95d)" }
    if ($colNC323 -notmatch 'kind == "sub"') { $v323Bad += "markCoronaMuralis never tests kind == sub - the sub-tab and the tab become the same drawing, which is I78b hierarchy lost (SPEC V323b)" }
}

# (c) the FILL answers per MOTIF, never per style (SPEC I95e): two return values, true on sep and
# on sub, and NOT true on tab. Without this the column comes out FILLED - markRule writes
# color = colour when the second value is true - and the Tuscan pair becomes one block of gold.
if ($colNC323) {
    $sepRet323 = [regex]::Match($colNC323, '(?s)kind == "sep".{0,400}?return [^;]*?,\s*true')
    $subRet323 = [regex]::Match($colNC323, '(?s)kind == "sub".{0,1400}?return [^;]*?,\s*true')
    if (-not $sepRet323.Success) { $v323Bad += "the sep motif does not return a second value of true - the separator gutta would be traced instead of filled, and it is a peg, not an outline (SPEC V323c, I95e)" }
    if (-not $subRet323.Success) { $v323Bad += "the sub motif does not return a second value of true - its guttae would be traced (SPEC V323c, I95e)" }
    $tabTail323 = $colNC323.Substring([Math]::Max(0, $colNC323.Length - 700))
    if ($tabTail323 -match 'return [^;]*?,\s*true') { $v323Bad += "the tab motif returns true for the fill - the Tuscan column would be painted solid instead of traced, which is the one thing I95e exists to keep apart (SPEC V323c)" }
}

# (d) TWO guards, and what each drops is the SMALLEST thing: on tab the capital and base go and
# the shaft survives; on sub the gutta goes and the rule survives. Floors READ out of the Lua and
# measured against the narrowest button of each LEVEL - a floor with two owners is B69.
$c323 = @{}
foreach ($k323 in @("ORN_COL_W", "ORN_COL_SHAFT", "ORN_COL_ROOM", "ORN_GUT_STEP", "ORN_SUB_MARK", "ORN_PILLR")) {
    $m323 = [regex]::Match($hh6, "(?m)^\s*local $k323\s*=\s*([\d.]+);")
    if ($m323.Success) { $c323[$k323] = [double]$m323.Groups[1].Value }
}
if ($c323.Count -ne 6) { $v323Bad += "only $($c323.Count) of the 6 constants leg (d) needs could be read - it has no floor to compute (SPEC V209, V323d)" }
else {
    $wTop323 = @(); $wSub323 = @()
    foreach ($pr323 in @(@("WoD20th.lfm","tabStrip",$true), @("WoD20.11.lfm","vampStrip",$false), @("WoD20.7.lfm","numStrip",$false), @("WoD20.7.lfm","hedgeStrip",$false))) {
        $st323 = (Doc (Join-Path $dir $pr323[0])).SelectSingleNode("//layout[@name='$($pr323[1])']")
        if ($null -eq $st323) { continue }
        foreach ($r323 in $st323.SelectNodes("rectangle[starts-with(@name,'tabOn')]")) {
            if ($pr323[2]) { $wTop323 += [double]$r323.GetAttribute("width") } else { $wSub323 += [double]$r323.GetAttribute("width") }
        }
    }
    if (($wTop323.Count + $wSub323.Count) -ne 19) { $v323Bad += "read $($wTop323.Count + $wSub323.Count) marker(s) across the four bars, expected 19 - leg (d) is covering less than the bars hold (SPEC V209)" }
    else {
        $minTop323 = ($wTop323 | Measure-Object -Minimum).Minimum
        $minSub323 = ($wSub323 | Measure-Object -Minimum).Minimum
        $fCap323 = 2 * $c323["ORN_COL_W"] + $c323["ORN_COL_ROOM"]
        $fSha323 = 2 * $c323["ORN_COL_SHAFT"] + $c323["ORN_COL_ROOM"]
        $iSub323 = [Math]::Sqrt(($c323["ORN_PILLR"] + $c323["ORN_SUB_MARK"]) * ($c323["ORN_PILLR"] + $c323["ORN_SUB_MARK"]) - $c323["ORN_SUB_MARK"] * $c323["ORN_SUB_MARK"])
        $fGut323 = 2 * $iSub323 + $c323["ORN_GUT_STEP"]
        if ($fSha323 -ge $fCap323) { $v323Bad += "the shaft floor ($fSha323) is not below the capital floor ($fCap323) - the two levels of degradation collapse into one and the marker goes straight from full to gone (SPEC V323d, I95c)" }
        if ($minTop323 -le $fSha323) { $v323Bad += "the narrowest top marker is $minTop323 against a shaft floor of $fSha323 - at that width the tab draws NOTHING, and a marker that quietly disappears is not the one anybody chose (SPEC V323d, V279, B59)" }
        if ($minSub323 -le $fGut323) { $v323Bad += "the narrowest sub-tab is $minSub323 against a gutta floor of $([Math]::Round($fGut323, 2)) - at that width the pegs drop and the sub-tab keeps only its rule, which is the level losing half its mark (SPEC V323d, V279)" }
        if ($colNC323 -match 'return "";' -and $colNC323 -notmatch 'ORN_COL_SHAFT') { $v323Bad += "the bar refuses by size without reading the shaft constant - the refusal is not the one the two-step degradation describes (SPEC V323d)" }
    }
}

# (e) constants stay inside their own family (SPEC V308, B69). ORN_SUB_MARK is the DECLARED
# exception and is read by both markers - the sub-tab height the user approved is one fact.
if ($colNC323) {
    if ($colNC323 -match "\bORN_MUR_") { $v323Bad += "markCoronaMuralis reads an ORN_MUR_* constant - those belong to the BOX frame, and one number serving the box and the bar moves both when only one was asked for (SPEC V323e, V308, B69)" }
    if ($colNC323 -match "\bORN_FIL_|\bORN_COR_") { $v323Bad += "markCoronaMuralis reads a filete or corrente constant - it is drawing another era with this one numbers (SPEC V323e, V308)" }
}
if ($murNC323 -and $murNC323 -match "\bORN_COL_|\bORN_GUT_") { $v323Bad += "ornCoronaMuralis reads a column or gutta constant - the box frame is reading the bar family, which is B69 in the other direction (SPEC V323e, V308)" }

# (f) the palette keeps its TWO keys and gains no third: the marker reads ornStyle, which already
# exists, and its colour is t.stroke on #FFFFFF, as I78e set for all four eras. ornament belongs
# to the BOX. A new key here would be a loose colour arriving through the one door nobody watches.
$pal323 = [regex]::Match($themesBlock, "(?ms)^\t{4}\[""Classical Age""\] = \{(.*?)^\t{4}\},")
if (-not $pal323.Success) { $v323Bad += "the Classical Age palette could not be read - leg (f) measured nothing (SPEC V209, V323f)" }
else {
    $pb323 = NoComments $pal323.Groups[1].Value
    $nOrn323 = [regex]::Matches($pb323, "(?m)^\t{5}ornament\s*=").Count
    $nSty323 = [regex]::Matches($pb323, "(?m)^\t{5}ornStyle\s*=").Count
    if ($nOrn323 -ne 1) { $v323Bad += "the Classical Age palette declares $nOrn323 ornament key(s) and the contract is exactly 1 - a second is a loose colour entering through the ornament door (SPEC V323f, V53)" }
    if ($nSty323 -ne 1) { $v323Bad += "the Classical Age palette declares $nSty323 ornStyle key(s) and the contract is exactly 1 (SPEC V323f)" }
}

if ($v323Bad) { foreach ($b in $v323Bad) { Fail "V323 $b" } }
else { Pass "V323 the Classical bar draws the column and the gutta through markPath third branch, the three motifs are three drawings, only sep and sub fill, the narrowest marker ($minTop323) clears the shaft floor ($fSha323), the eight constants stay in their family, and the palette keeps its two keys" }


# ---- V324: the CLASSICAL corner holds on the 73 AND on the avatar, and the drawing was REMADE
# for it (SPEC I96, I97, the 122nd and 123rd rounds) -------------------------------------------
# Five legs. The era declares a step, the painter takes the radius, the foot stopped arcing, the
# corner stopped curving, and the avatar rides the FIRST answer of sectionBox.
$v324Bad = @()
$murNC324 = NoComments (LuaFn $hh6 "ornCoronaMuralis")
$secNC324 = NoComments (LuaFn $hh6 "sectionBox")
$ornNC324 = NoComments (LuaFn $hh6 "ornament")

if (-not $murNC324) { $v324Bad += "ornCoronaMuralis is gone from WoD20.6 - there is no drawing to measure (SPEC V209, V324)" }
if (-not $secNC324) { $v324Bad += "sectionBox is gone from WoD20.6 - leg (e) cannot ask who wears the shape (SPEC V209, V324e)" }

# (a) the palette declares BOTH fields, and the TYPE is read by VALUE. innerLine and bevel are
# the two members of the enum that do not arc, and swapping one for the other leaves the foot of
# I97a correct for the wrong shape, with rdk -l exiting 0.
$pal324 = [regex]::Match($themesBlock, "(?ms)^\t{4}\[""Classical Age""\] = \{(.*?)^\t{4}\},")
if (-not $pal324.Success) { $v324Bad += "the Classical Age palette could not be read - leg (a) measured nothing (SPEC V209, V324a)" }
else {
    $pb324 = NoComments $pal324.Groups[1].Value
    $bc324 = [regex]::Match($pb324, "(?m)^\s*boxCorner\s*=\s*\{\s*type\s*=\s*""([^""]*)""\s*,\s*radius\s*=\s*([\d.]+)\s*\}")
    if (-not $bc324.Success) { $v324Bad += "the Classical Age palette declares no complete boxCorner - half a table is a write the SDK ignores in silence, and the symptom would be a ROUND box under a merlon drawn for a step (SPEC V324a, V316a, I96d)" }
    else {
        if ($bc324.Groups[1].Value -ne "innerLine") { $v324Bad += "the Classical Age corner is '$($bc324.Groups[1].Value)' and the era was drawn for innerLine - the two non-arcing members of the enum are not interchangeable, and the foot of I97a would be right for the wrong shape (SPEC V324a, I96a)" }
        if ([double]$bc324.Groups[2].Value -le 0) { $v324Bad += "the Classical Age corner radius is $($bc324.Groups[2].Value) - a radius of zero or less UNDOES the selector of V278, because ornament() reads c.xradius live and a 0 refuses the box (SPEC V324a, V316a)" }
    }
}

# (b) THREE parameters and the branch forwards the radius. Both ends read: V322b now demands
# exactly what it used to refuse, and dropping either end orphans the boxCorner above.
$sig324 = [regex]::Match($hh6, "local function ornCoronaMuralis\(([^)]*)\)")
if (-not $sig324.Success) { $v324Bad += "ornCoronaMuralis has no readable signature (SPEC V209, V324b)" }
else {
    $n324 = @($sig324.Groups[1].Value -split "\s*,\s*").Count
    if ($n324 -ne 3) { $v324Bad += "ornCoronaMuralis takes $n324 parameter(s) and the contract is 3 (w, h, radius) - the era corner would arrive nil and the frame would be drawn to whatever the XML authored (SPEC V324b, I96c)" }
}

# (c) the FOOT steps: it reads neither ORN_BOXR, nor a root of a difference of squares, nor a
# sqrt(2) factor. Three refusals, one per shape the sheet carries - a rule of the wrong shape
# over this corner crosses the outline it decorates, and there is no rdk -l that sees it.
# Nested since B77: these live INSIDE ornCoronaMuralis at four tabs, so LuaFn - which is
# written for chunk-scope functions - hands back everything down to the next chunk-level end,
# and the run count below would add ornMuralEdge to ornMuralCorner. Cut at the OWN indentation.
function NestedFn($txt, $name) {
    $m = [regex]::Match($txt, "(?s)\t{4}local function " + [regex]::Escape($name) + "\(.*?\r?\n\t{4}end;")
    if ($m.Success) { return $m.Value }
    return ""
}
$footNC324 = NoComments (NestedFn $hh6 "ornMuralFoot")
if (-not $footNC324) { $v324Bad += "ornMuralFoot is gone from WoD20.6 - leg (c) measured nothing (SPEC V209, V324c)" }
else {
    if ($footNC324 -match "\bORN_BOXR\b") { $v324Bad += "ornMuralFoot reads ORN_BOXR - that constant is the Lua copy of the radius the XML authors, and this era writes its own through boxCorner, so the frame would be drawn to another era corner (SPEC V324c, V317d, B69)" }
    if ($footNC324 -match "math\.sqrt") { $v324Bad += "ornMuralFoot still takes a square root - that is what a CONCAVE ARC costs, and the era stopped arcing when it started stepping (SPEC V324c, I97a)" }
    if ($footNC324 -notmatch "radius") { $v324Bad += "ornMuralFoot does not read the radius - it would step by a number that is not the one the palette declares (SPEC V324c, I97a)" }
}

# (d) the CORNER stops curving AND emits TWO runs. Two legs and not one: the foot can be right
# while the curve stays in the corner, which is the PARTIAL defect - half the frame stepped and
# half arced on the same box - and it would pass (c) with only the screen to tell.
$cornNC324 = NoComments (NestedFn $hh6 "ornMuralCorner")
if (-not $cornNC324) { $v324Bad += "ornMuralCorner is gone from WoD20.6 - leg (d) measured nothing (SPEC V209, V324d)" }
else {
    if ($cornNC324 -match "\bornArc\b") { $v324Bad += "ornMuralCorner still calls ornArc - the corner would arc across a step, which is exactly the crossing V316b existed to forbid and V317a inherited (SPEC V324d, I96d)" }
    $runs324 = [regex]::Matches($cornNC324, "\bornLine\s*\(").Count
    if ($runs324 -ne 2) { $v324Bad += "ornMuralCorner emits $runs324 straight run(s) and a step closes with 2 - ONE is what a 45 degree CUT draws between the same two feet, so it passes every measurement of the pair and is wrong only on screen (SPEC V324d, I97b)" }
}

# (e) the AVATAR rides along, and it is MEASURED: the corner write sits under the FIRST value of
# sectionBox, the one that says WEARS, not the second, which says DRAWS. Move it to the second
# and the avatar loses the corner while the 73 keep it - the user request undone, rdk -l 0, gate
# green, and only the screen counting (SPEC I92a, I93a).
if ($secNC324) {
    foreach ($nm324 in @("avatarFrame", "ornAvatar")) {
        if ($secNC324 -notmatch [regex]::Escape($nm324)) { $v324Bad += "sectionBox no longer names $nm324 - the roster the avatar rides on is gone, so it stops wearing the era shape (SPEC V324e, V320a)" }
    }
}
$themeB324 = NoComments $themeFn.Groups[1].Value
if (-not $themeB324) { $v324Bad += "the theme walk could not be read - leg (e) cannot see which answer the corner write sits under (SPEC V209, V324e)" }
elseif ($themeB324 -notmatch "if sectionBox\(c, fill\) then") { $v324Bad += "the corner write no longer sits under sectionBox FIRST answer - whatever it asks now, it is not the question that puts the avatar and the 73 on the same branch (SPEC V324e, I96b)" }

if ($v324Bad) { foreach ($b in $v324Bad) { Fail "V324 $b" } }
else { Pass "V324 the Classical Age steps its corner at the radius it declares, the painter takes it as a parameter, the foot is a plain sum, the corner closes with two runs and no arc, and the avatar rides the same first answer the 73 boxes do" }

# ---- V326: the Classical corner goes PAST the ceiling, and the number is DECLARED rather than
# fallen out of some d (SPEC I97b, the 123rd round) ---------------------------------------------
# It exists because the step is the first drawing on the sheet to pass 23. The leg does NOT forbid
# the overshoot - it stops it from MOVING without a round behind it.
$v326Bad = @()
$murIn326 = [regex]::Match($hh6, "(?m)^\s*local ORN_MUR_IN\s*=\s*([\d.]+);")
$murOut326 = [regex]::Match($hh6, "(?m)^\s*local ORN_MUR_OUT\s*=\s*([\d.]+);")
$pal326 = [regex]::Match($themesBlock, "(?ms)^\t{4}\[""Classical Age""\] = \{(.*?)^\t{4}\},")

if (-not $murIn326.Success -or -not $murOut326.Success) { $v326Bad += "ORN_MUR_IN or ORN_MUR_OUT could not be read - there is no depth to compute (SPEC V209, V326a)" }
elseif (-not $pal326.Success) { $v326Bad += "the Classical Age palette could not be read (SPEC V209, V326a)" }
else {
    $r326 = [regex]::Match((NoComments $pal326.Groups[1].Value), "(?m)^\s*boxCorner\s*=\s*\{[^}]*radius\s*=\s*([\d.]+)")
    if (-not $r326.Success) { $v326Bad += "the Classical Age boxCorner declares no radius - leg (a) has nothing to add the rule inset to (SPEC V209, V326a)" }
    else {
        # (a) computed from BOTH sides - the radius off the palette, the inset off the Lua.
        $depth326 = [double]$r326.Groups[1].Value + [double]$murIn326.Groups[1].Value
        if ($depth326 -ne 16) {
            $v326Bad += "the Classical rule reaches $depth326 into the box and the round declared 16 - AMENDED by the 124th round, which shrank the step to 1 and with it the overshoot: the rule now sits INSIDE the 20px margin of I73 and under the 23 the filigree respects, and this leg keeps it there. At radius 14 it was 29 and at radius 20 it would be 35, with only the screen to warn (SPEC V326a, I97b, I73)"
        }
        # (c) the merlon stays INSIDE the rule that frames it.
        if ([double]$murOut326.Groups[1].Value -ge [double]$murIn326.Groups[1].Value) {
            $v326Bad += "ORN_MUR_OUT ($($murOut326.Groups[1].Value)) is not inside ORN_MUR_IN ($($murIn326.Groups[1].Value)) - the crenellation would be drawn on or past the rule it hangs under, and the frame would read as two rules instead of a wall (SPEC V326c)"
        }
    }
}

# (b) every OTHER era stays under 23: the two concave ones arc at ORN_BOXR + ORN_IN and Modern
# Nights cuts. Without this, "the Classical may pass 23" quietly becomes "anyone may", which is
# how a limit dies with nobody deciding it.
$deep326 = @()
foreach ($k326 in $themeKeys) {
    if ($k326 -eq "Classical Age") { continue }
    $p326 = [regex]::Match($themesBlock, "(?ms)^\t{4}\[""$([regex]::Escape($k326))""\] = \{(.*?)^\t{4}\},")
    if (-not $p326.Success) { continue }
    $b326 = [regex]::Match((NoComments $p326.Groups[1].Value), "(?m)^\s*boxCorner\s*=\s*\{\s*type\s*=\s*""([^""]*)""\s*,\s*radius\s*=\s*([\d.]+)")
    if ($b326.Success -and $b326.Groups[1].Value -eq "innerLine" -and ([double]$b326.Groups[2].Value + [double]$murIn326.Groups[1].Value) -gt 23) {
        $deep326 += $k326
    }
}
if ($deep326.Count -gt 0) { $v326Bad += "$($deep326 -join ', ') also step past the 23px ceiling - the overshoot was decided for ONE era at ONE corner, and a second one is the limit dying without anybody deciding it (SPEC V326b)" }

if ($v326Bad) { foreach ($b in $v326Bad) { Fail "V326 $b" } }
else { Pass "V326 the Classical rule reaches a declared $($depth326)px at the corner - inside the 20px margin since the 124th round - the merlon stays inside it, and no other era steps past the 23px ceiling" }

Write-Host ""
if ($fail -eq 0) { Write-Host "ALL CHECKS PASSED"; exit 0 } else { Write-Host "$fail CHECK(S) FAILED"; exit 1 }
