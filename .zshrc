#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# cd to the path of the front Finder window
cdf() {
    local target=$(osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')
    [[ ${target} != "" ]] && (cd "$target"; pwd) || echo 'No Finder window found'>&2
}

# prevent the system from sleeping
nosleep() {
    [[ $# == 0 ]] && local time=3600
    [[ $1 =~ ^[1-5]$ ]] && local time=$(($1*3600))
    [[ -n ${time} ]] && (pkill caffeinate>/dev/null; caffeinate -i -t ${time} &) || echo "Usage: nosleep or nosleep [1-5]"
}

# toggle show or hide files in Finder
hide() {
    [[ $1 == 1 ]] && local str='TRUE'
    [[ $1 == 0 ]] && local str='FALSE'
    [[ -n ${str} ]] && (defaults write com.apple.finder AppleShowAllFiles -bool ${str}; killall Finder) || echo "Usage: $(basename $0) [0,1]"
}

alias vim="$HOME/Documents/MacVim_Build/src/MacVim/build/Release/MacVim.app/Contents/MacOS/Vim"
alias f='open -a Finder ./'
