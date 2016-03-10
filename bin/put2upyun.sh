#!/usr/bin/env bash
usage() {
    echo "Usage: ${0##*/} [-b bucket_name] [--bucket bucket_name] [--bucket=bucket_name]" 
    echo -e '\t[-c category_name] [--category category_name] [--category=category_name]'
    echo -e '\t[-g[size]] [--geometry[=size]] file'
    echo -e '\n-b bucket_name, --bucket bucket_name, --bucket=bucket_name\n\tspecify customized bucket'  
    echo -e '-c category_name, --category category_name, --category=category_name\n\tspecify customized category'
    echo -e '-g[size], --geometry[=size]\n\tresize to customized size'
    echo -e '-h, --help\n\tshow help'
}

(( $# )) || { usage; exit 1; }

TEMP=$(getopt -o b:c:g::h --long bucket:,category:,geometry::,help -n ${0##*/} -- "$@")
eval set -- "$TEMP"
while true; do
    case "$1" in
        -b|--bucket)
            case "$2" in
                "") shift 2;;
                *) BUCKET_NAME="$2"; shift 2;;
            esac;;
        -c|--category)
            case "$2" in
                "") shift 2;;
                *) CATEGORY="$2"; shift 2;;
            esac;;
        -g|--geometry)
            case "$2" in
                "") shift 2;;
                *) GEO="$2"; shift 2;;
            esac;;
        -h|--help) usage; exit 0;;
        --) shift; break;;
        *) echo 'Internal error!'; exit 1;;
    esac
done

api_file=${HOME}/.upyun_api
[[ $(uname -s) == "Darwin"* ]] && md5=md5 || md5=md5sum
bucket="${BUCKET_NAME:=beyondim-notes}"
api="$(grep ${bucket}, ${api_file} | cut -f2 -d',')"
cat="${CATEGORY:=$(grep ${bucket}, ${api_file} | cut -f3 -d',')}"
geo="${GEO:=$(grep ${bucket}, ${api_file} | cut -f4 -d',')x>}"

json="{\"bucket\":\"${bucket}\",\"expiration\":1640966400,\"save-key\":\"/${cat}/{random}{.suffix}\"}"
policy=$(echo -n "${json}" | base64 | sed ':a;N;$!ba;s/\n//g')
signature=$(echo -n "${policy}&${api}" | ${md5} | cut -f1 -d' ')
# optimize when uploading file is image and optimgs.sh exists 
[[ ${1##*.} =~ ^([Jj][Pp][Ee]?[Gg]|[Pp][Nn][Gg]|[Gg][Ii][Ff])$ ]] && IS_IMG='true'
[[ -n ${IS_IMG} ]] && command -v imgoptz.sh >/dev/null 2>&1 && imgoptz.sh -k -g${geo} "$1"
# generate url
put=$(curl -s http://v0.api.upyun.com/${bucket} -F file=@"\"$1\"" -F policy="${policy}" -F signature="${signature}")
if [[ $(grep -oE '"message":"[^,]*?"' <<< "${put}") == '"message":"ok"' ]]; then
    uri=$(grep -oE '"url":"[^,]*?"' <<< "${put}" | cut -d '"' -f 4 | sed 's/\\//g')
    url="http://${bucket}.b0.upaiyun.com${uri}"
    echo "${url}"
    # send markdown format to clipboard on Mac OS X when uploaded file is image
    [[ -n ${IS_IMG} && $(uname -s) == 'Darwin'* ]] && echo "![](${url})" | pbcopy
else
    echo 'Upload error, please check again!'
fi
