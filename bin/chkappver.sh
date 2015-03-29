#!/bin/bash
record=~/.appver
if [[ ! -f ${record} ]]; then
    echo "Please specify app name and url separated by comma in ${record}"
    exit 1
fi
len=$(awk -F',' '{max=(length($1)>max?length($1):max)} END {printf "%d%s",max,RS}' ${record})
fail=()
while read line; do
    app=$(echo ${line} | awk -F',' '{print $1}')
    url=$(echo ${line} | awk -F',' '{print $2}')
    rv=$(curl -s ${url} | grep 'twitter:data2' | awk -F'"' '{print $4}')
    lv=$(tr '\r' '\n' < "/Applications/${app}.app/Contents/Info.plist" 2>/dev/null | xargs | sed 's@.*CFBundleShortVersionString<[^>]\+>\s*<[^>]\+>\([^<]\+\)<[^>]\+>.*@\1@')
    if [[ ${lv} =~ ^[0-9.]+$ ]]; then
        if awk "BEGIN {exit !(${rv} > ${lv})}"; then
            printf "$(tput setaf 3)%${len}s$(tput sgr 0): $(tput setaf 2)%s$(tput sgr 0) => $(tput setaf 1)%s$(tput sgr 0)\n" "${app}" "${lv}" "${rv}"
        else
            printf "%${len}s: up to date\n" "${app}"
        fi
    else
        printf "%${len}s: can't get installed version info, skipping\n" "${app}"
        fail+=(${app})
        continue
    fi
done < ${record}
# deleting invalid line from record file
for i in ${fail[@]}; do
    echo "=== Remove line about $i from ${record} ==="
    sed -i "/$i/d" ${record}
done
