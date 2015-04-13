#!/usr/bin/env bash

# if [[ $(uname -s) == "Darwin" ]]; then
#     declare -A arr=(
#         ["getopt"]="/usr/local/opt/gnu-getopt/bin/getopt"
#         ["sed"]="/usr/local/opt/gnu-sed/bin/gsed"
#         ["find"]="/usr/local/opt/findutils/bin/gfind"
#     )
#
#     for i in "${!arr[@]}"; do
#         [[ -x ${arr[$i]} ]] && eval "function $i { ${arr[$i]} \"\$@\"; }"
#     done
# fi

# bash 3 compatible
if [[ $(uname -s) == "Darwin" ]]; then
    arr=(
        "getopt:/usr/local/opt/gnu-getopt/bin/getopt"
        "sed:/usr/local/opt/gnu-sed/bin/gsed"
        "find:/usr/local/opt/findutils/bin/gfind"
    )

    for i in "${arr[@]}" ; do
        key="${i%%:*}"
        value="${i##*:}"
        [[ -x ${value} ]] && eval "function ${key} { ${value} \"\$@\"; }"
    done
fi
