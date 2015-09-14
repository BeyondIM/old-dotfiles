#!/usr/bin/env bash
objects=$(git verify-pack -v .git/objects/pack/pack-*.idx | grep -v -e 'non delta' -e 'chain length' -e '.git/objects' | sort -k3nr | head)
echo "All sizes are in kB's. The pack column is the size of the object, compressed, inside the pack file."
output="size,pack,SHA,location"
while read line; do
    # extract the size in bytes
    size=$(($(awk -F' ' '{print $3}' <<< "${line}")/1024))
    # extract the compressed size in bytes
    compressedSize=$(($(awk -F' ' '{print $4}' <<< "${line}")/1024))
    # extract the SHA
    sha=$(awk -F' ' '{print $1}' <<< "${line}")
    # find the objects location in the repository tree
    other=$(git rev-list --all --objects | grep $sha)
    output="${output}\n${size},${compressedSize},${other}"
done <<< "${objects}"
echo -e $output | column -t -s ', '
