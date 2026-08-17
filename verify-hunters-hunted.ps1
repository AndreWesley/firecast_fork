# Build gate for the HuntersHunted sheet. Checks SPEC.md §V1, §V3, §V4, §V5, §V8.
# With -Build it also runs the real compile and checks §V6 + §V7.
#
# Lives at repo root, NOT inside the plugin dir: rdk packs every file under the
# plugin folder into the .rpk, so a .ps1 there would ship to users.
#
#   .\verify-hunters-hunted.ps1            # static checks only
#   .\verify-hunters-hunted.ps1 -Build     # + rdk -l, asserts the .rpk actually changed

param([switch]$Build)

$ErrorActionPreference = 'Stop'
$plugin = Join-Path $PSScriptRoot "Plugins\Sheets\World of Darkness 20th"
$dir    = Join-Path $plugin "HuntersHunted"
$rpk    = Join-Path $plugin "output\World of Darkness 20th.rpk"
$fail   = 0

function Fail($msg) { Write-Host "FAIL  $msg"; $script:fail++ }
function Pass($msg) { Write-Host "ok    $msg" }

$files = Get-ChildItem -LiteralPath $dir -Filter *.lfm | Sort-Object Name

# ---- XML well-formedness -----------------------------------------------------
foreach ($f in $files) {
    try { [xml](Get-Content -Raw -LiteralPath $f.FullName) | Out-Null; Pass "XML $($f.Name)" }
    catch { Fail "XML $($f.Name): $($_.Exception.Message)" }
}

# ---- collect fields, expanding templates ------------------------------------
$allFields  = @{}   # expanded field name -> list of "file:tag"  (input widgets only)
$linkFields = @()   # <dataLink field="x"> - observes an existing field, never owns it (§V1, §B.3)
$allImages  = @()

foreach ($f in $files) {
    $xml = [xml](Get-Content -Raw -LiteralPath $f.FullName)

    $tpl = @{}
    foreach ($t in $xml.SelectNodes("//template")) {
        $pats = @()
        foreach ($n in $t.SelectNodes(".//*[@field]")) { $pats += $n.GetAttribute("field") }
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
                $expanded = $pat
                foreach ($a in $n.Attributes) { $expanded = $expanded.Replace("`$($($a.Name))", $a.Value) }
                if ($expanded -match '\$\(') { Fail "unresolved placeholder '$expanded' in $($f.Name) <$($n.LocalName)>"; continue }
                if (-not $allFields.ContainsKey($expanded)) { $allFields[$expanded] = @() }
                $allFields[$expanded] += "$($f.Name):<$($n.LocalName)>"
            }
        }
        elseif ($n.HasAttribute("field")) {
            $v = $n.GetAttribute("field")
            if ($v -match '\$\(') { continue }
            if ($n.LocalName -eq 'dataLink') { $linkFields += [pscustomobject]@{ File=$f.Name; Field=$v }; continue }
            if (-not $allFields.ContainsKey($v)) { $allFields[$v] = @() }
            $allFields[$v] += "$($f.Name):<$($n.LocalName)>"
        }
    }
}

# ---- V1: no duplicate field among input widgets ------------------------------
$dupes = $allFields.GetEnumerator() | Where-Object { $_.Value.Count -gt 1 }
if ($dupes) { foreach ($d in $dupes) { Fail "V1 duplicate field '$($d.Key)' -> $($d.Value -join ', ')" } }
else { Pass "V1 no duplicate field ($($allFields.Count) unique input widgets)" }

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
'alertness','athletics','awareness','brawl','empathy','expression','intimidation','leadership','streetwise','subterfuge',
'animalKen','crafts','etiquette','firearms','larceny','melee','performance','ride','stealth','survival',
'academics','enigmas','finance','investigation','law','medicine','occult','politics','science','technology',
'faith'                                                                                                   | % { $expect[$_] = 5 }
$expect['humanity'] = 10
$expect['willpower'] = 10

foreach ($k in ($expect.Keys | Sort-Object)) {
    $got = DotCount $k
    if ($got -eq $expect[$k]) { Pass "V5 $k = $got dots" } else { Fail "V5 $k = $got dots, expected $($expect[$k])" }
}
$wb = BoxCount 'willpower'
if ($wb -eq 10) { Pass "V5 willpower = 10 boxes" } else { Fail "V5 willpower = $wb boxes, expected 10" }

foreach ($grp in @(@('numina',11), @('background',5))) {
    $n = ($allFields.Keys | Where-Object { $_ -match "^$($grp[0])_\d+$" }).Count
    if ($n -eq $grp[1]) { Pass "V5 $($grp[0]) = $n rows" } else { Fail "V5 $($grp[0]) = $n rows, expected $($grp[1])" }
}

$health = @('bruised','hurt','injured','wounded','mauled','crippled','incapacitated') | Where-Object { $allFields.ContainsKey($_) }
if ($health.Count -eq 7) { Pass "V5 health = 7 levels" } else { Fail "V5 health = $($health.Count) levels, expected 7" }

# ---- collect every user-visible string (label/checkBox/button + Lua t("...")) --
$visible = New-Object 'System.Collections.Generic.HashSet[string]'
$padded  = @()
foreach ($f in $files) {
    $raw = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    $xml = New-Object System.Xml.XmlDocument; $xml.LoadXml($raw)
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
    # runtime strings built in Lua go through the t() helper
    [regex]::Matches($raw, 't\("([^"]+)"\)') | ForEach-Object { [void]$visible.Add($_.Groups[1].Value) }
    # picker items are user-visible too (SPEC V17)
    # Picker items are user-visible too (SPEC V17). Read them off the XML `items=` attribute,
    # NOT out of a Lua table: the lists live inline in the templates now, and a checker that
    # greps for the old Lua form would pass silently while verifying nothing.
    # Only `cbo*` pickers count — the colour and theme combos are values, not prose.
    foreach ($cb in $xml.SelectNodes("//comboBox[@name][@items]")) {
        if ($cb.GetAttribute("name") -notlike 'cbo*') { continue }
        # [^']* not [^']+ — with + the leading empty entry ('') fails to match and the engine
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
    $raw = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName))
    $xml = New-Object System.Xml.XmlDocument; $xml.LoadXml($raw)
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
    else { Pass "V14 $($l.Name) has $($l.Items.Count - 1) unique entries" }
    if ($l.Items[0] -eq '') { Pass "V15 $($l.Name) starts empty" } else { Fail "V15 $($l.Name) first entry is '$($l.Items[0])', expected empty" }
}

# ---- V9: source language is English - no non-ASCII in authored strings -------
# Deliberately a codepoint range, not a list of accented letters: this file is read
# as ANSI by PowerShell 5.1 when it has no BOM, so non-ASCII literals here would rot.
$ptChars = $visible | Where-Object { $_ -match '[^\x00-\x7F]' }
if ($ptChars) { foreach ($s in $ptChars) { Fail "V9 non-English string '$s' - source must be English" } }
else { Pass "V9 all $($visible.Count) visible strings authored in English" }

# ---- V11: no label aligns columns with padding runs (§B.5) -------------------
if ($padded) { foreach ($s in $padded) { Fail "V11 padding run used for alignment -> $s" } }
else { Pass "V11 no label uses padding runs" }

# ---- V10: every visible string has a key in BOTH [pt] and [en] ---------------
# Ordinal comparison on purpose: the native tryLang's case behaviour is unknown (§R.1).
$langFile = Join-Path $plugin "localization.lang"
$cur = ''
$ptK = New-Object 'System.Collections.Generic.HashSet[string]'
$enK = New-Object 'System.Collections.Generic.HashSet[string]'
foreach ($l in ([System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($langFile)) -split "`r?`n")) {
    if ($l -match '^\[(\w+)\]') { $cur = $Matches[1]; continue }
    if ($l -match '^wod\.(.+?)=') {
        if ($cur -eq 'pt') { [void]$ptK.Add($Matches[1]) } elseif ($cur -eq 'en') { [void]$enK.Add($Matches[1]) }
    }
}
$noPt = @($visible | Where-Object { -not $ptK.Contains($_) })
$noEn = @($visible | Where-Object { -not $enK.Contains($_) })
if ($noPt) { foreach ($s in $noPt) { Fail "V10 no [pt] key for '$s'" } } else { Pass "V10 all visible strings have a [pt] key" }
if ($noEn) { foreach ($s in $noEn) { Fail "V10 no [en] key for '$s'" } } else { Pass "V10 all visible strings have an [en] key" }

# ---- V16: a label must be wide enough for the LONGER of its EN and PT text ----
# Crude on purpose: no font metrics available offline, so estimate at ~6.5px/char for the
# default proportional font. Only flags clear overflow, not tight fits.
$PX_PER_CHAR = 6.5
$tooNarrow = @()
foreach ($f in $files) {
    $xml = New-Object System.Xml.XmlDocument
    $xml.LoadXml([System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($f.FullName)))
    foreach ($n in $xml.SelectNodes("//label[@text][@width]")) {
        $txt = $n.GetAttribute("text").Trim()
        if (-not $txt -or $txt -match '\$\(') { continue }
        $w = 0; if (-not [int]::TryParse($n.GetAttribute("width"), [ref]$w)) { continue }
        $pt = $null
        foreach ($l in ([System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes($langFile)) -split "`r?`n")) {
            if ($l -match "^wod\.$([regex]::Escape($txt))=(.*)$") { $pt = $Matches[1]; break }
        }
        $longest = $txt.Length
        if ($pt -and $pt.Length -gt $longest) { $longest = $pt.Length }
        $need = [math]::Ceiling($longest * $PX_PER_CHAR)
        if ($need -gt $w) { $tooNarrow += "$($f.Name): '$txt' (pt '$pt') needs ~${need}px, width=${w}px" }
    }
}
if ($tooNarrow) { foreach ($t in $tooNarrow) { Fail "V16 $t" } } else { Pass "V16 every label fits its longest translation" }

# ---- V12: combo items are values - items must agree with the Lua comparison ---
$hh6 = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes((Join-Path $dir "HH.6.lfm")))
if ($hh6 -match 'field="theme"[^>]*items="\{([^}]*)\}"') {
    $items = ([regex]::Matches($Matches[1], "'([^']*)'") | ForEach-Object { $_.Groups[1].Value })
    if ($hh6 -match 'theme\s*==\s*"([^"]+)"') {
        $cmp = $Matches[1]
        if ($items -contains $cmp) { Pass "V12 theme comparison '$cmp' is one of {$($items -join ', ')}" }
        else { Fail "V12 Lua compares theme == '$cmp' but items are {$($items -join ', ')} - theme switching is broken" }
    } else { Fail "V12 no theme comparison found in HH.6.lfm" }
} else { Fail "V12 theme comboBox items not found in HH.6.lfm" }

# ---- V6 + V7: real build, and proof the artifact actually changed -------------
# §B.1: `rdk p` is PREPARE, not pack. It exits 0 without touching the .rpk.
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
        } else { Fail "V7 .rpk unchanged after build - exit 0 was not proof (see SPEC §B.1)" }
    }
}

Write-Host ""
if ($fail -eq 0) { Write-Host "ALL CHECKS PASSED"; exit 0 } else { Write-Host "$fail CHECK(S) FAILED"; exit 1 }
