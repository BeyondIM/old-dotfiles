#!/usr/bin/env bash
comp() {
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

cask() {
    local rv=$(brew cask info $1 | awk -F': ' 'NR == 1 {print $2}')
    local lvs=($(ls -td /opt/homebrew-cask/Caskroom/$1/* | awk -F'/' '{print $NF}'))
    local lv="${lvs[0]}"
    [[ ${#lvs[@]} -ne 1 ]] && local chaos="${RED}*${NRM}" || local chaos=''
    if [[ ${rv} =~ ^[0-9._-]+$ ]] && [[ ${lv} =~ ^[0-9._-]+$ ]]; then
        if comp ${rv} ${lv}; then
            echo -e "${YLW}$1${NRM}${chaos}: ${GRN}${lv}${NRM} => ${RED}${rv}${NRM}"
        else
            echo -e "$1${chaos}: up to date"
        fi
    else
        echo -e "${CYN}$1${NRM}${chaos}" >> ${tmp}
    fi
}

macupdate() {
    local app=$(cut -d ',' -f 1 <<< "$1")
    local url='http://www.macupdate.com/app/mac/'$(cut -d ',' -f 2 <<< "$1")
    local rv=$(curl -s ${url} | grep 'twitter:data2' | awk -F'"' '{print $4}')
    if [[ -d /Applications/${app}.app ]]; then
        local appPath=/Applications/${app}.app
    elif [[ -d ${HOME}/Applications/${app}.app ]]; then
        local appPath=${HOME}/Applications/${app}.app
    else
        echo "${app}: doesn't install ... removing from ${record}"
        sed -i "/${app}/d" "${record}"
        exit 1
    fi
    local lv=$(mdls -name kMDItemVersion -raw "${appPath}")
    if [[ ${lv} =~ ^[0-9._-]+$ ]]; then
        if comp ${rv} ${lv}; then
            echo -e "${YLW}${app}${NRM}: ${GRN}${lv}${NRM} => ${RED}${rv}${NRM}"
        else
            echo "${app}: up to date"
        fi
    else
        echo "${app}: can't get installed version info ... removing from ${record}"
        sed -i "/${app}/d" "${record}"
        exit 1
    fi
}

[[ $(uname -s) != 'Darwin' ]] && { echo 'This script only work on Mac OS X.'; exit 1; }
command -v parallel >/dev/null 2>&1 || { echo "This script doesn't work without parallel."; exit 1; }

export record=${HOME}/.appver
export tmp=/tmp/vertrack-$(hexdump -n 16 -v -e '/1 "%02X"' /dev/urandom)
export RED="\033[0;31m" GRN="\033[0;32m" YLW="\033[0;33m" CYN="\033[0;36m" NRM="\033[0m"
export -f comp cask macupdate

caskApps=($(brew cask list)) fail=()
echo "=== checking from cask ==="
parallel cask ::: "${caskApps[@]}" 2>/dev/null
while read i; do
    fail+=("$i")
done < "${tmp}"
echo -e "[${fail[@]}]: need to upgrade forcedly"
rm -f ${tmp}
echo "=== done ==="

if [[ ! -f ${record} ]]; then
    echo "Please specify app name and url separated by comma in ${record}."
    exit 1
fi

macupdateApps=()
while read i; do
    macupdateApps+=("$i")
done < "${record}"
echo "=== checking from macupdate ==="
parallel macupdate ::: "${macupdateApps[@]}" 2>/dev/null
echo "=== done ==="
