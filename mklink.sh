#!/bin/bash
curDir=$(cd $(dirname $0) && pwd)
destDir=~

contents=()
for i in {.,}*; do
    [[ $i == "." || $i == ".." || $i == *".git" || $i == *$(basename $0) ]] && continue
    contents+=($i)
done

for i in ${contents[@]}; do
    [[ -e ${destDir}/$i ]] && rm -rf ${destDir}/$i
    if [[ $(uname -s) == "CYGWIN"* ]]; then
        [[ -d $i ]] && a='/J' || a='/H'
        cmd /C "mklink $a $(cygpath -w ${destDir}/$i) $(cygpath -w ${curDir}/$i)"
    else
        ln -s ${curDir}/$i ${destDir}/$i
    fi
done

# deleting invalid symbolic link (don't work for file link on CYGWIN, so you must delete it manually)
for i in ${destDir}/{.,}*; do
    [[ $i == "." || $i == ".." ]] && continue
    if [[ -L $i ]]; then
        p=$(readlink $i)
        [[ ${p%/*} == ${curDir} && ! -e $p ]] && rm -f $i
    fi
done

