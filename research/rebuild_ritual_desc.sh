#!/bin/bash
# Rebuild the RITUAL_DESC region of descRitual_en.lua and descRitual_pt.lua from per-entry
# block files (§T446, split per language by §T495).
#
# Why this exists: unlike WoD20.12/WoD20.13, the 284 ritual keys are NOT written in
# book order — the picker sorts them by "<level>. <name>", so a new entry almost
# never belongs at the end. Appending before the END marker (the §T444/§T445
# recipe) puts it in the wrong place. This script sort-merges instead.
#
# Usage:
#   bash research/rebuild_ritual_desc.sh <blockdir>          # rebuild
#   bash research/rebuild_ritual_desc.sh <blockdir> --split  # dump current
#                                                            # entries first
#
# <blockdir> holds *.lua files; each may contain any number of complete
#   ["<key>"] = { en = [==[...]==], pt = [==[...]==], },
# entries, in any order. Order comes from research/ritual_pages.tsv, never from
# the file names. --split writes what the module already has into <blockdir> as
# existing.lua first, so a rebuild never loses entries written in an earlier
# session.
#
# §T495 put the two languages in two FILES (§V210). The block files still hold PAIRED
# entries — a ritual is written and proofread with its translation beside it — so the join
# happens on the way in (--split) and the split on the way out, and the sort-merge in the
# middle is the one it always was.
#
# Fails loudly on an unknown key or a duplicate key — both mean the module would
# come out wrong, and a silent wrong splice is what §B says to prevent.
set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PLUG="$ROOT/Plugins/Sheets/World of Darkness 20th Anniversary Edition"
MOD_EN="$PLUG/descRitual_en.lua"
MOD_PT="$PLUG/descRitual_pt.lua"
MAP="$ROOT/research/ritual_pages.tsv"
DIR="$1"
[ -d "$DIR" ] || { echo "usage: $0 <blockdir> [--split]" >&2; exit 2; }

IDX="$DIR/.index"
awk -F'\t' 'NR>1{printf "%04d\t%s. %s\n", NR-1, $1, $2}' "$MAP" > "$IDX"

region_of() { # $1=module -> START and END line numbers on stdout
	local s e
	s=$(grep -n $'^\t\t\t\t\\["' "$1" | head -1 | cut -d: -f1)
	e=$(grep -n -- '-- <<< RITUAL_DESC_END' "$1" | cut -d: -f1)
	[ -n "$s" ] && [ -n "$e" ] || { echo "FATAL: markers not found in $1" >&2; exit 1; }
	echo "$s $e"
}
read START_EN END_EN <<< "$(region_of "$MOD_EN")"
read START_PT END_PT <<< "$(region_of "$MOD_PT")"
[ -n "$START_EN" ] && [ -n "$END_EN" ] && [ -n "$START_PT" ] && [ -n "$END_PT" ] || { echo "FATAL: could not locate the RITUAL_DESC region in both halves" >&2; exit 1; }

head -n $((END_EN-1)) "$MOD_EN" | tail -n +"$START_EN" > "$DIR/.cur_en"
head -n $((END_PT-1)) "$MOD_PT" | tail -n +"$START_PT" > "$DIR/.cur_pt"

# The two halves back into one paired entry: key line, the en body, the pt body, close.
awk -v PTF="$DIR/.cur_pt" '
BEGIN {
	while ((getline line < PTF) > 0) {
		if (line ~ /^\t\t\t\t\["/) { k = line; sub(/^\t\t\t\t\["/, "", k); sub(/"\].*$/, "", k); key = k }
		else if (line ~ /^\t\t\t\t\},$/) { key = "" }
		else if (key != "") pt[key] = pt[key] line "\n"
	}
}
/^\t\t\t\t\["/ { k = $0; sub(/^\t\t\t\t\["/, "", k); sub(/"\].*$/, "", k); cur = k
	if (!(cur in pt)) { print "FATAL: key in [en] and not in [pt]: " cur > "/dev/stderr"; exit 1 }
	print; next }
/^\t\t\t\t\},$/ { if (cur != "") { printf "%s", pt[cur]; cur = "" } print; next }
{ print }
' "$DIR/.cur_en" > "$DIR/.cur"

if [ "$2" = "--split" ]; then
	cp "$DIR/.cur" "$DIR/existing.lua"
	echo "split: $(grep -c $'^\t\t\t\t\\["' "$DIR/existing.lua") entries -> $DIR/existing.lua"
fi

awk -v idx="$IDX" '
BEGIN{ FS="\t"; while((getline line < idx)>0){ split(line,a,"\t"); num[a[2]]=a[1] } }
/^\t\t\t\t\["/ {
	k=$0; sub(/^\t\t\t\t\["/,"",k); sub(/"\].*$/,"",k)
	if(!(k in num)){ print "FATAL: key not in ritual_pages.tsv: " k > "/dev/stderr"; exit 1 }
	if(num[k] in blk){ print "FATAL: duplicate key: " k > "/dev/stderr"; exit 1 }
	cur=num[k]; blk[cur]=$0 "\n"; next
}
cur!="" { blk[cur]=blk[cur] $0 "\n" }
/^\t\t\t\t\},$/ { cur="" }
END{ n=asorti(blk, ord); for(i=1;i<=n;i++) printf "%s", blk[ord[i]] }
' $(ls "$DIR"/*.lua) > "$DIR/.region"

# One paired region out, two single-language ones in: `en` to the [en] half, `pt` to the [pt]
# one, and the key line and the closing brace to both (§T495, §V210a).
rm -f "$DIR/.region_en" "$DIR/.region_pt"
awk -v EN="$DIR/.region_en" -v PT="$DIR/.region_pt" '
BEGIN { cur = "" }
{
	if (cur == "en") { print >> EN; if ($0 ~ /\]==\],$/) cur = ""; next }
	if (cur == "pt") { print >> PT; if ($0 ~ /\]==\],$/) cur = ""; next }
	if ($0 ~ /^\t\t\t\t\ten = \[==\[/) { print >> EN; cur = ($0 ~ /\]==\],$/) ? "" : "en"; next }
	if ($0 ~ /^\t\t\t\t\tpt = \[==\[/) { print >> PT; cur = ($0 ~ /\]==\],$/) ? "" : "pt"; next }
	print >> EN; print >> PT
}
' "$DIR/.region"

splice() { # $1=module $2=start $3=end $4=region
	head -n $(($2-1)) "$1"  > "$DIR/.new"
	cat "$4"               >> "$DIR/.new"
	tail -n +"$3" "$1"     >> "$DIR/.new"
	cp "$DIR/.new" "$1"
}
splice "$MOD_EN" "$START_EN" "$END_EN" "$DIR/.region_en"
splice "$MOD_PT" "$START_PT" "$END_PT" "$DIR/.region_pt"

# proofs (§B1: exit 0 alone proves nothing)
for MOD in "$MOD_EN" "$MOD_PT"; do
	o=$(grep -c '\[==\[' "$MOD"); c=$(grep -c '\]==\]' "$MOD")
	[ "$o" = "$c" ] || { echo "FATAL: long-bracket mismatch in $MOD open=$o close=$c" >&2; exit 1; }
	# The target used to be a <script> CDATA, so this guarded ']]>' - the one sequence that
	# would close the block early. It is a plain .lua module since SPEC T481, so what has to
	# survive a rebuild is the module shape: exactly one `return {` and a `};` on the last line.
	[ "$(grep -c '^return {' "$MOD")" = "1" ] || { echo "FATAL: $MOD does not open with exactly one 'return {'" >&2; exit 1; }
	[ "$(tail -n 1 "$MOD")" = "};" ] || { echo "FATAL: $MOD does not close with '};'" >&2; exit 1; }
done
# §V210a: nothing may be dropped on the way through, and the halves are useless apart.
grep -o $'^\t\t\t\t\\["[^"]*"' "$MOD_EN" | sed 's/.*\["//;s/"$//' > "$DIR/.keys"
grep -o $'^\t\t\t\t\\["[^"]*"' "$MOD_PT" | sed 's/.*\["//;s/"$//' > "$DIR/.keys_pt"
cmp -s "$DIR/.keys" "$DIR/.keys_pt" || { echo "FATAL: the two halves do not carry the same keys in the same order (SPEC V210a)" >&2; exit 1; }
awk -F'\t' 'NR>1{print $1". "$2}' "$MAP" > "$DIR/.order"
awk 'NR==FNR{ord[$0]=FNR;next}
     { if(!($0 in ord)){print "FATAL: orphan key " $0 > "/dev/stderr"; exit 1}
       if(ord[$0]<=last){print "FATAL: out of order " $0 > "/dev/stderr"; exit 1}
       last=ord[$0] }
     END{ printf "ok  %d entries in both halves, in picker order\n", FNR }' "$DIR/.order" "$DIR/.keys"
