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

if [[ $(uname -s) == 'Darwin' ]]; then
    # cd to the path of the front Finder window
    function cdf() {
        local target=$(osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')
        [[ -n "${target}" ]] && { cd "$target"; pwd; } || echo 'No Finder window found'>&2
    }

    # opens man pages in Dash.app
    function mand {
        if (( $# )); then
            open "dash://manpages:$1" 2>/dev/null
            (( $? )) && { print "$0: Dash is not installed" >&2; break; }
        else
            print 'What manual page do you want?' >&2
        fi
    }

    alias vim="$HOME/Documents/MacVim_Build/src/MacVim/build/Release/MacVim.app/Contents/MacOS/Vim"
    alias f='open -a Finder ./'
fi

export RUBYTAOBAO=1
export BASH_ENV=${HOME}/.startup.bash
