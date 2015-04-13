#!/usr/bin/env bash
function color {
    local message=$1
    local prefix=""
    [[ $2 =~ [0-7] ]] && prefix=$(tput setaf $2)
    [[ $3 =~ [0-7] ]] && prefix=$(tput setaf $2; tput setab $3)
    echo "${prefix}${message}$(tput sgr 0)"
}

(( $# )) && ARGS="$@" || ARGS="${HOME}/Sites"

for i in ${ARGS}; do
    gitDirs=($(find -L $i -maxdepth 2 -name ".git"))
    (( ${#gitDirs[@]} )) || continue
    for gitDir in "${gitDirs[@]}"; do
        stat=""
        workTree=${gitDir%/*}
        git --git-dir="${gitDir}" remote update >/dev/null 2>&1
        head=$(git --git-dir="${gitDir}" symbolic-ref HEAD)
        branch=${head##*/}
        lRef=$(git --git-dir="${gitDir}" rev-parse ${branch})
        rRef=$(git --git-dir="${gitDir}" rev-parse origin/${branch})
        base=$(git --git-dir="${gitDir}" merge-base ${branch} origin/${branch})
        [[ ${lRef} != ${rRef} && ${lRef} == ${base} ]] && stat="${stat} $(color ' Unmerged ' 0 6)"
        [[ ${lRef} != ${rRef} && ${rRef} == ${base} ]] && stat="${stat} $(color ' Unpushed ' 0 3)"
        # git status check
        res=$(git --git-dir="${gitDir}" --work-tree="${workTree}" status)
        grep 'Untracked' <<< ${res} >/dev/null 2>&1
        (( $? )) || stat="${stat} $(color ' Untracked ' 7 1)"
        grep 'Changes not staged for commit' <<< ${res} >/dev/null 2>&1
        (( $? )) || stat="${stat} $(color ' Modified ' 7 1)"
        grep 'Changes to be committed' <<< ${res} >/dev/null 2>&1
        (( $? )) || stat="${stat} $(color ' Staged ' 0 2)"

        [[ ${branch} != master ]] && b=" $(color " ${branch} " 7 4)" || b=""
        [[ -n ${stat} ]] && echo -e "${workTree}${b} :${stat}"
    done
done

