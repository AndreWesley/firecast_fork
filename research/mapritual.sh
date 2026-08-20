#!/bin/bash
# Builds <level>\t<name>\t<discipline>\t<book key>\t<printed page> for all 284 rituals.
# The book is already known per file (research/rd_<book>.tsv); only the page is looked up.
S="$(dirname "$0")"      # findpage.sh e os .idx ficam AQUI, em research/
R="c:/Users/awlol/OneDrive/Documents/firecast_fork/research"

emit() {   # emit <tsv> <keys...>
  local tsv="$1"; shift
  local keys=("$@")
  while IFS=$'\t' read -r lvl name disc; do
    [ -z "$name" ] && continue
    local hit="" k=""
    for k in "${keys[@]}"; do
      local off=1
      [ "$k" = "core" ] && off=8
      hit="$("$S/findpage.sh" "$S/txt/$k.idx" "$off" "$name")"
      if [ -n "$hit" ]; then printf '%s\t%s\t%s\t%s\t%s\n' "$lvl" "$name" "$disc" "$k" "$hit"; break; fi
    done
    [ -z "$hit" ] && printf '%s\t%s\t%s\t%s\t\n' "$lvl" "$name" "$disc" "${keys[0]}"
  done < "$R/$tsv"
}

emit rd_core.tsv core
emit rd_rob.tsv  rob
emit rd_misc.tsv lotc lob dac bh
emit rd_tos.tsv  tos
emit rd_da.tsv   da
