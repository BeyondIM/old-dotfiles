#!/usr/bin/env bash
function usage {
    echo "Usage: $(basename $0) [-k] [--keep] [-e extension] [--ext extension] [--ext=extension]"
    echo -e "\t[-g[size]] [--geometry[=size]] dir1...dirn file1...filen"
    echo -e "\n-k, --keep\n\tkeep original extension"
    echo -e "-e extension, --ext extension, --ext=extension\n\tspecify customized extension"
    echo -e "-g[size], --geometry[=size]\n\tresize to customized size"
    echo -e "-h, --help\n\tshow help"
}

function color {
    local message=$1
    local prefix=""
    [[ $2 =~ [0-7] ]] && prefix=$(tput setaf $2)
    [[ $3 =~ [0-7] ]] && prefix=$(tput setaf $2; tput setab $3)
    echo "${prefix}${message}$(tput sgr 0)"
}

function preprocess {
    local f="$1"
    local s="$2"
    [[ $f != *-${ext}.$s && -f ${f%%.$s}-${ext}.$s ]] && skip='true'
    if [[ $f == *-${ext}.$s ]]; then
        [[ -f $(sed "s/\(-${ext}\)\{1,\}.$s/.$s/g" <<< $f) ]] && contin='true' || delete='true'
    fi
}

function process {
    local f="$1"
    local s="$2"
    local n="${f%%.$s}-${ext}.$s"
    echo "===== Compress $f ====="
    if [[ $s =~ ^jpe?g$ ]]; then
        command -v convert >/dev/null 2>&1 || { color "Please install imagemagick at first, skipping!" 1; continue; }
        command -v jpegtran >/dev/null 2>&1 || { color "Please install mozjpeg at first, skipping!" 1; continue; }
        convert -strip -quality 80% "$f" "$n"
        jpegtran -copy none -optimize -progressive -outfile "$n" "$n"
    fi
    if [[ $s == 'png' ]]; then
        command -v pngquant >/dev/null 2>&1 || { color "Please install pngquant at first, skipping!" 1; continue; }
        command -v pngout >/dev/null 2>&1 || { color "Please install pngout at first, skipping!" 1; continue; }
        pngquant --speed 1 --ext -${ext}.png "$f"
        pngout -f6 -kp -ks "$n"
    fi
    if [[ $s == 'gif' ]]; then
        command -v gifsicle >/dev/null 2>&1 || { color "Please install giflossy at first, skipping!" 1; continue; }
        gifsicle -O3 --lossy=80 -o "$n" "$f"
    fi
}

function resize {
    local f="$1"
    local s="$2"
    local n="${f%%.$s}-${ext}.$s"
    echo "===== Resize $n ====="
    convert -resize "${GEOMETRY}" "$n" "$n"
}

function rename {
    local f="$1"
    local s="$2"
    local n="${f%%.$s}-${ext}.$s"
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
    if [[ $s =~ ^([jJ][pP][Ee]?[gG]|[pP][nN][gG]|[Gg][Ii][Ff])$ ]]; then
        e=$(tr '[:upper:]' '[:lower:]' <<< "$s")
        n="${f%%.$s}.$e"
        [[ $e != $s ]] && mv "$f" "$n"
        exe "$n" "$e"
    fi
}

(( $# )) || { usage; exit 1; }

TEMP=$(getopt -o ke:g::h --long keep,ext:,geometry::,help -n $(basename $0) -- "$@")
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
        -h|--help) usage; exit 0;;
        --) shift; break;;
        *) echo "Internal error!"; exit 1;;
    esac
done

ext="${EXTENSION:=v5GwJ2}"
for i in "$@"; do
    if [[ -d $i ]]; then
        ( cd "$i"; for f in *; do opt "$f"; done )
    elif [[ -f $i ]]; then
        opt "$i"
    fi
done
