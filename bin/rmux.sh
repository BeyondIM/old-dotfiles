#!/usr/bin/env bash
function process {
    local session=${1##*/}
    cd $1
    tmux new-session -s ${session} -n "editor" -d
    tmux send-keys "vim" C-m
    tmux new-window -t ${session}:2 -n 'server'
    tmux split-window -h
    tmux split-window -v
    [[ -z $(ps aux | grep "zeus slave: test_helper" | grep -v "grep") && -e $1/.zeus.sock ]] && rm -f $1/.zeus.sock
    tmux send-keys "zeus start" C-m
    # check zeus is ready
    until [[ -n $(ps aux | grep "zeus slave: test_helper" | grep -v "grep") ]]; do 
        sleep 2
    done
    tmux select-pane -t 2
    # kill rails s process if exists
    [[ -f $1/tmp/pids/server.pid ]] && kill $(cat $1/tmp/pids/server.pid)
    tmux send-keys "zeus s -b 0.0.0.0" C-m
    tmux select-pane -t 1
    tmux resize-pane -R 30
    tmux new-window -t ${session}:3 -n "console"
    tmux send-keys "zeus c" C-m
    tmux select-window -t ${session}:1
}

command -v tmux >/dev/null 2>&1 || { echo "Please install tmux at first"; exit 1; }
(( $# )) && ARGS="$@" || ARGS="${HOME}/Sites"
dirs=()
for i in ${ARGS}; do
    [[ -d "$i" ]] || { echo "$i is not a directory, skipping."; continue; }
    for j in "$i"/{.[a-zA-Z0-9],}*; do
        if [[ -d "$j" && -x "$j/bin/rails" ]]; then
            tmux has -t "${j##*/}" 2>/dev/null 
            (( $? )) && dirs+=("$j") || dirs+=("$j: Active")
        fi
    done
done
(( ${#dirs[@]} )) || { echo "No exist rails projects."; exit 1; }

IFS=$'\n'
PS3="Please select a rails project: "
select dir in ${dirs[@]}; do
    if [[ -n "${dir}" ]]; then
        s="${dir%%:*}"
        tmux has -t "${s##*/}" 2>/dev/null 
        (( $? )) && process "$s"
        tmux attach-session -t "${s##*/}" -d
        exit 0
    else
        echo "Invalid index '$REPLY', please retry"
    fi
done
