#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
# if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
#   source "${ZDOTDIR:-$HOME}/.zprofile"
# fi

# provides for the interactive use of GNU utilities on BSD systems

typeset -gU path
path=(
    $HOME/bin
    $HOME/.rbenv/bin
    $HOME/node_modules/.bin
    /opt/bin
    /usr/local/sbin
    /usr/local/bin
    $path
)

if (( ${+commands[rbenv]} )); then 
    eval "$(rbenv init -)"
fi
