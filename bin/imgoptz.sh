#!/usr/bin/env bash
usage() {
    echo "Usage: ${0##*/} [-k] [--keep] [-e extension] [--ext extension] [--ext=extension]"
    echo -e '\t[-g[size]] [--geometry[=size]] dir1...dirn file1...filen'
    echo -e '\n-k, --keep\n\tkeep original extension'
    echo -e '-e extension, --ext extension, --ext=extension\n\tspecify customized extension'
    echo -e '-g[size], --geometry[=size]\n\tresize to customized size'
    echo -e '-h, --help\n\tshow help'
}

preprocess() {
    [[ $1 != *-${ext}.$2 && -f ${1%%.$2}-${ext}.$2 ]] && skip_cur='true'
    if [[ $1 == *-${ext}.$2 ]]; then
        [[ -f $(sed "s/\(-${ext}\)\{1,\}.$2/.$2/g" <<< $1) ]] && skip_ful='true' || delete='true'
    fi
}

process() {
    local n="${1%%.$2}-${ext}.$2"
    echo "===== Compress $1 ====="
    if [[ $2 =~ ^jpe?g$ ]]; then
        command -v convert >/dev/null 2>&1 || { echo -e "Please install ${RED}imagemagick${NRM} at first."; exit 1; }
        command -v jpegtran >/dev/null 2>&1 || { echo -e "Please install ${RED}mozjpeg${NRM} at first."; exit 1; }
        convert -strip -quality 80% "$1" "$n"
        jpegtran -copy none -optimize -progressive -outfile "$n" "$n"
    fi
    if [[ $2 == 'png' ]]; then
        command -v pngquant >/dev/null 2>&1 || { echo -e "Please install ${RED}pngquant${NRM} at first."; exit 1; }
        command -v pngout >/dev/null 2>&1 || { echo -e "Please install ${RED}pngout${NRM} at first."; exit 1; }
        pngquant --speed 1 --ext -${ext}.png "$1"
        pngout -f6 -kp -ks "$n"
    fi
    if [[ $2 == 'gif' ]]; then
        command -v gifsicle >/dev/null 2>&1 || { echo -e "Please install ${RED}giflossy${NRM} at first."; exit 1; }
        gifsicle -O3 --lossy=80 -o "$n" "$1"
    fi
}

resize() {
    local n="${1%%.$2}-${ext}.$2"
    echo "===== Resize $n ====="
    convert -resize "${GEO}" "$n" "$n"
}

rename() {
    local n="${1%%.$2}-${ext}.$2"
    echo "===== Rename $n ====="
    mv "$n" "$1"
}

exe() {
    preprocess "$1" "$2"
    [[ ${skip_ful} == 'true' ]] && exit 0
    [[ ${delete} == 'true' ]] && rm -f "$1" && exit 0
    [[ ${skip_cur} == 'false' ]] && process "$1" "$2"
    [[ -n ${GEO} ]] && resize "$1" "$2"
    [[ -n ${KEEP} ]] && rename "$1" "$2"
}

opt() {
    local s="${1##*.}"
    skip_cur='false'
    skip_ful='false'
    delete='false'
    if [[ $s =~ ^([jJ][pP][Ee]?[gG]|[pP][nN][gG]|[Gg][Ii][Ff])$ ]]; then
        e=$(tr '[:upper:]' '[:lower:]' <<< "$s")
        n="${1%%.$s}.$e"
        [[ $e != $s ]] && mv "$1" "$n"
        exe "$n" "$e"
    fi
}

(( $# )) || { usage; exit 1; }
command -v parallel >/dev/null 2>&1 || { echo "This script doesn't work without parallel."; exit 1; }

TEMP=$(getopt -o ke:g::h --long keep,ext:,geometry::,help -n ${0##*/} -- "$@")
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
                "") GEO='600x>'; shift 2;;
                *) GEO="$2"; shift 2;;
            esac;;
        -h|--help) usage; exit 0;;
        --) shift; break;;
        *) echo 'Internal error!'; exit 1;;
    esac
done

export KEEP GEO ext="${EXTENSION:=v5GwJ2}"
export RED="\033[0;31m" NRM="\033[0m"
export -f preprocess process resize rename exe opt
for i in "$@"; do
    if [[ -d $i ]]; then
        ( cd "$i"; parallel -k opt ::: *.* 2>/dev/null )
    elif [[ -f $i ]]; then
        opt "$i"
    fi
done
