#!/usr/bin/env bash
process() {
    local duration=$(( $1 ))
    pkill caffeinate
    caffeinate -i -t ${duration} &
}

stat() {
    local p=$(ps -axo lstart,user,args | grep 'caffeinate -i -t' | grep -v 'grep')
    local t=$(awk -F"[ \t]+$(whoami)[ \t]+" '{print $1}' <<< "$p")
    local start=$(date -jf '%a %m/%d %T %Y' "$t" +%s)
    local duration=$(awk -F' ' '{print $NF}' <<< "$p")
    echo "Current caff left time: $(date -u -r $(( ${duration}-$(date +%s)+${start} )) +%T)"
}

[[ $(uname -s) != 'Darwin' ]] && { echo 'This script only work on Mac OS X.'; exit 1; }
[[ $1 =~ ^[1-5]$ ]] && { process $1*3600; stat; exit 0; }
if (( ! $# )); then
    if [[ -z $(ps -axo args | grep 'caffeinate -i -t' | grep -v 'grep') ]]; then
        echo "Caffeinate process doesn't exist, please execute ${0##*/} [1-5] at first."
    else
        stat
    fi
else
    echo "Usage: ${0##*/} or ${0##*/} [1-5]"
fi


