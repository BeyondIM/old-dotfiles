#!/usr/bin/env bash
vercomp() {
    [[ $1 == $2 ]] && return 1
    local IFS=.-_
    local i ver1=($1) ver2=($2)
    for (( i=${#ver1[@]}; i<${#ver2[@]}; i++ )); do
        ver1[i]=0
    done
    for (( i=0; i<${#ver1[@]}; i++ )); do
        [[ -z ${ver2[i]} ]] && ver2[i]=0
        (( 1${ver1[i]} > 1${ver2[i]} )) && return
        (( 1${ver1[i]} < 1${ver2[i]} )) && return 1
    done
    return 1
}

[[ $(uname -s) != 'Darwin' ]] && { echo 'This script only work on Mac OS X'; exit 1; }
record=$HOME/.appver
if [[ ! -f ${record} ]]; then
    echo "Please specify app name and url separated by comma in ${record}"
    exit 1
fi
len=$(awk -F',' '{max=(length($1)>max?length($1):max)} END {printf "%d%s",max,RS}' "${record}")
fail=()
while read line; do
    app=$(awk -F',' '{print $1}' <<< "${line}")
    url='http://www.macupdate.com/app/mac/'$(awk -F',' '{print $2}' <<< "${line}")
    rv=$(curl -s ${url} | grep 'twitter:data2' | awk -F'"' '{print $4}')
    if [[ -d /Applications/${app}.app ]]; then
        appPath=/Applications/${app}.app
    elif [[ -d ${HOME}/Applications/${app}.app ]]; then
        appPath=${HOME}/Applications/${app}.app
    else
        printf "%${len}s: doesn't install, skipping\n" "${app}"
        fail+=("${app}")
        continue
    fi
    lv=$(tr '\r' '\n' < "${appPath}/Contents/Info.plist" 2>/dev/null | xargs | sed 's@.*CFBundleShortVersionString<[^>]\+>\s*<[^>]\+>\([^<]\+\)<[^>]\+>.*@\1@')
    if [[ ${lv} =~ ^[0-9._-]+$ ]]; then
        if vercomp ${rv} ${lv}; then
            printf "$(tput setaf 3)%${len}s$(tput sgr 0): $(tput setaf 2)%s$(tput sgr 0) => $(tput setaf 1)%s$(tput sgr 0)\n" "${app}" "${lv}" "${rv}"
        else
            printf "%${len}s: up to date\n" "${app}"
        fi
    else
        printf "%${len}s: can't get installed version info, skipping\n" "${app}"
        fail+=("${app}")
        continue
    fi
done < "${record}"
# deleting invalid line from record file
for i in "${fail[@]}"; do
    echo "=== Remove line about $i from ${record} ==="
    sed -i "/$i/d" "${record}"
done
