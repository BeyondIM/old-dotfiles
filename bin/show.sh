#!/usr/bin/env bash
[[ $(uname -s) != 'Darwin' ]] && { echo 'This script only work on Mac OS X'; exit 1; }
if [[ $1 == 1 ]]; then
    defaults write com.apple.finder AppleShowAllFiles -bool TRUE && killall Finder 
    echo "Current all hidden files status: $(tput setaf 1)show$(tput sgr 0)"
elif [[ $1 == 0 ]]; then
    defaults write com.apple.finder AppleShowAllFiles -bool FALSE && killall Finder
    echo "Current all hidden files status: $(tput setaf 2)hide$(tput sgr 0)"
else
    echo "Usage: ${0##*/} [0,1]"
fi

