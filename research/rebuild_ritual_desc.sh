#!/bin/bash
# Rebuild the RITUAL_DESC table of HH.14.lfm from per-entry block files (§T446).
#
# Why this exists: unlike HH.12/HH.13, the 284 ritual keys are NOT written in
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
# the file names. --split writes what HH.14.lfm already has into <blockdir> as
# existing.lua first, so a rebuild never loses entries written in an earlier
# session.
#
# Fails loudly on an unknown key or a duplicate key — both mean the .lfm would
# come out wrong, and a silent wrong splice is what §B says to prevent.
set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LFM="$ROOT/Plugins/Sheets/World of Darkness 20th/HuntersHunted/HH.14.lfm"
MAP="$ROOT/research/ritual_pages.tsv"
DIR="$1"
[ -d "$DIR" ] || { echo "usage: $0 <blockdir> [--split]" >&2; exit 2; }

IDX="$DIR/.index"
awk -F'\t' 'NR>1{printf "%04d\t%s. %s\n", NR-1, $1, $2}' "$MAP" > "$IDX"

START=$(grep -n $'^\t\t\t\t\\["' "$LFM" | head -1 | cut -d: -f1)
END=$(grep -n -- '-- <<< RITUAL_DESC_END' "$LFM" | cut -d: -f1)
[ -n "$START" ] && [ -n "$END" ] || { echo "FATAL: markers not found in HH.14.lfm" >&2; exit 1; }

if [ "$2" = "--split" ]; then
	head -n $((END-1)) "$LFM" | tail -n +"$START" > "$DIR/existing.lua"
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

head -n $((START-1)) "$LFM"  > "$DIR/.new"
cat "$DIR/.region"          >> "$DIR/.new"
tail -n +"$END" "$LFM"      >> "$DIR/.new"
cp "$DIR/.new" "$LFM"

# proofs (§B1: exit 0 alone proves nothing)
o=$(grep -c '\[==\[' "$LFM"); c=$(grep -c '\]==\]' "$LFM")
[ "$o" = "$c" ] || { echo "FATAL: long-bracket mismatch open=$o close=$c" >&2; exit 1; }
[ "$(grep -c ']]>' "$LFM")" = "1" ] || { echo "FATAL: CDATA count != 1" >&2; exit 1; }
grep -o $'^\t\t\t\t\\["[^"]*"' "$LFM" | sed 's/.*\["//;s/"$//' > "$DIR/.keys"
awk -F'\t' 'NR>1{print $1". "$2}' "$MAP" > "$DIR/.order"
awk 'NR==FNR{ord[$0]=FNR;next}
     { if(!($0 in ord)){print "FATAL: orphan key " $0 > "/dev/stderr"; exit 1}
       if(ord[$0]<=last){print "FATAL: out of order " $0 > "/dev/stderr"; exit 1}
       last=ord[$0] }
     END{ printf "ok  %d entries, in picker order\n", FNR }' "$DIR/.order" "$DIR/.keys"
