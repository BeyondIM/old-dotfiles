#!/usr/bin/env bash
[[ $(uname -s) != 'Darwin' ]] && { echo 'This script only work on Mac OS X.'; exit 1; }

store=${HOME}/Pictures/Wallpapers
pics=()
for f in "${store}"/*.jpg; do
    pics+=("$f")
done

cur=$(osascript -e 'tell application "Finder" to set cur to desktop picture' -e 'return displayed name of cur' 2>/dev/null)
(( $? )) && { osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"${pics[0]}\""; exit 0; }

for (( i=0; i<${#pics[@]}; i++ )); do
    [[ ${pics[$i]##*/} == ${cur} ]] && idx=$i
done

if (( ! $# )) || [[ $1 =~ ^[n+]$ ]]; then
    (( ${idx} < $((${#pics[@]}-1)) )) && idx=$((${idx}+1)) || idx=0
    change='true'
elif [[ $1 =~ ^[p-]$ ]]; then
    (( ${idx} > 0 )) && idx=$((${idx}-1)) || idx=$((${#pics[@]}-1))
    change='true'
else
    echo "Usage: ${0##*/} or ${0##*/} [n,p,+,-]"
    exit 1
fi
[[ -n ${change} ]] && osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"${pics[${idx}]}\""

