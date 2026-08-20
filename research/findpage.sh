#!/bin/bash
# findpage.sh <idx-file> <offset> <name>
# Prints the printed page of the first line that IS a heading for <name>.
#
# A heading is the name alone, optionally preceded by a dot run (the books head
# their ritual entries "• Pierce the Veil") and optionally followed by a
# parenthetical ("Blood and Bane (Level 3 Dur-An-Ki Ritual)"). Anything else is
# the book mentioning its own ritual in running prose, which it does constantly
# - see trap 5 in research/README.md. Matching loosely is what put paths under
# the wrong owner twice.
idx="$1"; off="$2"; name="$3"
awk -F'\t' -v N="$name" -v OFF="$off" '
  {
    line = $2
    sub(/^[\xE2\x80\xA2 ]+/, "", line)      # leading bullet run, UTF-8 U+2022
    if (index(line, N) != 1) next
    rest = substr(line, length(N) + 1)
    if (rest == "" || rest ~ /^ *\(/) { last = $1 - OFF }
  }
  END { if (last != "") print last }
' "$idx"
