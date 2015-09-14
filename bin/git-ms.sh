#!/usr/bin/env bash
process() {
    local stat='' b=''
    local workTree=${1%/*}
    git --git-dir="${1}" remote update >/dev/null 2>&1
    local head=$(git --git-dir="${1}" symbolic-ref HEAD)
    local branch=${head##*/}
    local lRef=$(git --git-dir="${1}" rev-parse ${branch})
    local rRef=$(git --git-dir="${1}" rev-parse origin/${branch})
    local base=$(git --git-dir="${1}" merge-base ${branch} origin/${branch})
    [[ ${lRef} != ${rRef} && ${lRef} == ${base} ]] && stat="${stat} ${CYN} Unmerged ${NRM}"
    [[ ${lRef} != ${rRef} && ${rRef} == ${base} ]] && stat="${stat} ${YLW} Unpushed ${NRM}"
    # git status check
    local res=$(git --git-dir="${1}" --work-tree="${workTree}" status)
    grep 'Untracked' <<< ${res} >/dev/null 2>&1
    (( $? )) || stat="${stat} ${RED} Untracked ${NRM}"
    grep 'Changes not staged for commit' <<< ${res} >/dev/null 2>&1
    (( $? )) || stat="${stat} ${RED} Modified ${NRM}"
    grep 'Changes to be committed' <<< ${res} >/dev/null 2>&1
    (( $? )) || stat="${stat} ${GRN} Staged ${NRM}"

    [[ ${branch} != master ]] && b=" ${BLU} ${branch} ${NRM}"
    [[ -n ${stat} ]] && echo -e "${workTree}${b} :${stat}"
}

command -v parallel >/dev/null 2>&1 || { echo "This script doesn't work without parallel."; exit 1; }

(( $# )) && ARGS="$@" || ARGS="${HOME}/Sites"
export RED="\033[0;41m" GRN="\033[0;42;30m" YLW="\033[0;43;30m" BLU="\033[0;44m" CYN="\033[0;46;30m" NRM="\033[0m"
export -f process

gitDirs=()
for i in ${ARGS}; do
    s=($(find -L $i -maxdepth 2 -name ".git"))
    (( ${#s[@]} )) || continue
    gitDirs+=("${s[@]}")
done
parallel process ::: "${gitDirs[@]}" 2>/dev/null

