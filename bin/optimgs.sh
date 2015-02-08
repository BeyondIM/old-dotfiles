#!/bin/bash
function usage {
    echo "Usage: `basename $0` [options] dirname filename"
    exit 1
}

function preprocess {
    local f="$1"
    local s="$2"
    [[ $f != *${ext}.$s && -f ${f%%.$s}${ext}.$s ]] && skip='true'
    if [[ $f == *${ext}.$s ]]; then
        if [[ -f ${f/${ext}*.$s/.$s} ]]; then
            contin='true'
        else
            delete='true'
        fi
    fi
}

function process {
    local f="$1"
    local s="$2"
    local n="${f%%.$s}${ext}.$s"
    echo "===== Compress $f ====="
    if [[ $s == 'jpg' ]]; then
        convert -strip -quality 80% "$f" "$n"
        /usr/local/opt/mozjpeg/bin/jpegtran -copy none -optimize -progressive -outfile "$n" "$n"
    fi
    if [[ $s == 'png' ]]; then
        pngquant --speed 1 --ext ${ext}.png "$f"
        pngout -f6 -kp -ks "$n"
    fi
}

function resize {
    local f="$1"
    local s="$2"
    local n="${f%%.$s}${ext}.$s"
    echo "===== Resize $n ====="
    convert -resize "${GEOMETRY}" "$n" "$n"
}

function rename {
    local f="$1"
    local s="$2"
    local n="${f%%.$s}${ext}.$s"
    echo "===== Rename $n ====="
    mv "$n" "$f"
}

function exe {
    local f="$1"
    local s="$2"
    preprocess "$f" "$s"
    [[ ${contin} == 'true' ]] && continue
    [[ ${delete} == 'true' ]] && rm -f "$f" && continue
    [[ ${skip} == 'false' ]] && process "$f" "$s"
    [[ -n ${GEOMETRY} ]] && resize "$f" "$s"
    [[ -n ${KEEP} ]] && rename "$f" "$s"
}

function opt {
    local f="$1"
    local s="${f##*.}"
    skip='false'
    contin='false'
    delete='false'
    [[ $s == 'jpg' || $s == 'png' ]] && exe "$f" "$s"
    if [[ $s == 'jpeg' ]]; then
        n="${f%%.jpeg}.jpg"
        mv "$f" "$n"
        exe "$n" 'jpg'
    fi
}

[[ $# == "0" ]] && usage

TEMP=$(/usr/local/opt/gnu-getopt/bin/getopt -o ke:g:: --long keep,ext:,geometry:: -n 'optimgs.sh' -- "$@")
eval set -- "$TEMP"

while true; do
    case "$1" in
        -k|--keep) KEEP="yes"; shift;;
        -e|--ext)
            case "$2" in
                "") shift 2;;
                *) EXTENSION="$2"; shift 2;;
            esac;;
        -g|--geometry)
            case "$2" in
                "") GEOMETRY="600x>"; shift 2;;
                *) GEOMETRY="$2"; shift 2;;
            esac;;
        --) shift; break;;
        *) echo "Internal error!"; exit 1;;
    esac
done

ext="${EXTENSION:=-v5GwJ2}"
for i in "$@"; do
    if [[ -d $i ]]; then
        ( cd "$i"; for f in *; do opt "$f"; done )
    elif [[ -f $i ]]; then
        opt "$i"
    fi
done
