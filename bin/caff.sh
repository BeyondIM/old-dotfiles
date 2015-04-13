#!/usr/bin/env bash
[[ $(uname -s) != 'Darwin' ]] && { echo "This script only work on Mac OS X"; exit 1; }
function process {
    local duration=$(( $1 ))
    pkill caffeinate
    caffeinate -i -t ${duration} &
    echo "$(date +%s),${duration}" > ${info}
}

function status {
    local start=$(cat ${info} | cut -d',' -f1)
    local duration=$(cat ${info} | cut -d',' -f2)
    echo "Current caff left time: $(date -u -r $(( ${duration}-$(date +%s)+${start} )) +%T)"
}

info=/tmp/htXASQR87m9zlsvtfoStl0y76xWuygwh

[[ $1 =~ ^[1-5]$ ]] && { process $1*3600; status; exit 0; }
if (( ! $# )); then
    s=$(ps aux | grep "caffeinate -i -t" | grep -v "grep")
    if [[ -z $s ]]; then
        echo "Caffeinate process doesn't exist, please execute $(basename $0) [1-5] at first."
    else
        [[ -f ${info} ]] || process $(awk -F' ' '{print $NF}' <<< $s)
        status
    fi
else
    echo "Usage: $(basename $0) or $(basename $0) [1-5]"
fi


