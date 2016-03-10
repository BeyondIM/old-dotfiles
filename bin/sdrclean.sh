#!/usr/bin/env bash
mpoint=$(df -h | grep -i kindle | awk '{print $NF}' 2>/dev/null)
[[ -z ${mpoint} ]] && { echo "Kindle was not mounted"; exit 1; }

IFS=$'\n'
for sdr in $(find ${mpoint}/documents -name "*.sdr" -maxdepth 1 2>/dev/null); do
    p=${sdr%.sdr}
    if ! [[ -f $p.mobi || -f $p.azw || -f $p.azw3 || -f $p.pdf || -f $p.txt ]]; then
        echo ${sdr}
        rm -rf ${sdr}
    fi
done
