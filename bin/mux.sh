#!/usr/bin/env bash
function usage {
    echo "Usage: $(basename $0) [-d] [--detach]"
    echo -e "\n-k, --detach\n\tdetach other sessions"
    echo -e "-h, --help\n\tshow help"
}

TEMP=$(getopt -o dh --long detach,help -n $(basename $0) -- "$@")
eval set -- "$TEMP"
while true; do
    case "$1" in
        -d|--detach) detach_others="-d"; shift;;
        -h|--help) usage; exit 0;;
        --) shift; break;;
        *) echo "Internal error!"; exit 1;;
    esac
done

command -v tmux >/dev/null 2>&1 || { echo "Please install tmux at first"; exit 1; }
if [[ -n $1 ]]; then
    tmux -2 attach ${detach_others} -t $1 || tmux -2 new -s $1
    exit 0
else
    sessions=$(tmux list-sessions -F "#{session_name}: #{session_windows} windows")
    [[ -z "${sessions}" ]] && { tmux -2 new -s 'Misc'; exit 0; }
    if [[ $(wc -l <<< "${sessions}") -eq 1 ]]; then
        tmux -2 attach ${detach_others} -t "${sessions%%:*}"
        exit 0
    else
        IFS=$'\n'
        PS3="Please select a session: "
        select session in ${sessions}; do
            [[ -n "${session}" ]] && { tmux -2 attach ${detach_others} -t "${session%%:*}"; exit 0; } || echo "Invalid index '$REPLY', please retry"
        done
    fi
fi



