#!/usr/bin/env bash
[[ $(uname -s) != 'Darwin' ]] && { echo 'This script only work on Mac OS X.'; exit 1; }

RED="\033[0;31m" GRN="\033[0;32m" NRM="\033[0m"

if [[ $1 == 1 ]]; then
    defaults write com.apple.finder AppleShowAllFiles -bool TRUE && killall Finder 
    echo -e "Current all hidden files status: ${RED}show${NRM}"
elif [[ $1 == 0 ]]; then
    defaults write com.apple.finder AppleShowAllFiles -bool FALSE && killall Finder
    echo -e "Current all hidden files status: ${GRN}hide${NRM}"
else
    echo "Usage: ${0##*/} [0,1]"
fi

