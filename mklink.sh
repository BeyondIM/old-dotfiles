#!/bin/bash
curDir=$(cd $(dirname $0) && pwd)
destDir=~

for i in {.,}*; do
    [[ $i == "." || $i == ".." ]] && continue
    [[ -e ${destDir}/$i ]] && rm -rf ${destDir}/$i
    if [[ -d $i && $i != *".git" ]]; then
        if [[ $(uname -s) == "CYGWIN"* ]]; then
            cmd /C "mklink /J $(cygpath -w ${destDir}/$i) $(cygpath -w ${curDir}/$i)"
        else
            ln -s ${curDir}/$i ${destDir}/$i
        fi
    elif [[ -f $i && $i != *$(basename $0) ]]; then
        if [[ $(uname -s) == "CYGWIN"* ]]; then
            cmd /C "mklink /H $(cygpath -w ${destDir}/$i) $(cygpath -w ${curDir}/$i)"
        else
            ln -s ${curDir}/$i ${destDir}/$i
        fi
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

