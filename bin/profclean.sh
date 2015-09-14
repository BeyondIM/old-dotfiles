#!/usr/bin/env bash
clean() {
    bsize=$(du -k "$1" | cut -f 1)
    sqlite3 "$1" vacuum
    sqlite3 "$1" reindex
    asize=$(du -k "$1" | cut -f 1)
    echo -e "${GRN}${1##*.default/}${NRM} reduced by ${RED}$(( (${bsize}-${asize})/1024 ))${NRM} Mbytes"
}

[[ $(uname -s) != 'Darwin' ]] && { echo 'This script only work on Mac OS X.'; exit 1; }
command -v parallel >/dev/null 2>&1 || { echo "This script doesn't work without parallel."; exit 1; }

export RED="\033[0;31m" GRN="\033[0;32m" NRM="\033[0m"
export -f clean

toclean=()
while read i; do
    toclean+=("${i}")
done < <( find -L "${HOME}/Library/Application Support/Firefox/Profiles" -maxdepth 3 -type f -name '*.sqlite'  -print )
parallel clean ::: "${toclean[@]}" 2>/dev/null


