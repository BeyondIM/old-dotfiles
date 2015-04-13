#!/usr/bin/env bash
curDir=$(cd "${0%/*}" && pwd)
destDir=~

for i in {.[a-zA-Z0-9],}*; do
    [[ $i == *".git" || $i == *"${0##*/}" ]] && continue
    [[ -e ${destDir}/$i ]] && rm -rf "${destDir}/$i"
    ln -s "${curDir}/$i" "${destDir}/$i"
done

for i in ${destDir}/{.[a-zA-Z0-9],}*; do
    if [[ -L $i ]]; then
        p=$(readlink "$i")
        [[ ${p%/*} == ${curDir} && ! -e $p ]] && rm -f "$i"
    fi
done

