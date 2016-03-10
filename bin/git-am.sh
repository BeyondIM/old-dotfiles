#!/usr/bin/env bash
git config -f .gitmodules --get-regexp '^submodule\..*\.url$' |
while read key url
do
    path=$(sed 's/submodule\.\(.*\)\.url/\1/' <<< ${key})
    git submodule add $url $path
done
