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
if [[ $(uname -s) == "Darwin" ]]; then
    typeset -A cmds
    cmds=(
        getopt /usr/local/opt/gnu-getopt/bin/getopt
        sed /usr/local/opt/gnu-sed/bin/gsed
        find /usr/local/opt/findutils/bin/gfind
    )
    for i in ${(k)cmds}; do
        [[ -x ${cmds[$i]} ]] && eval "function '$i' { ${cmds[$i]} \"\$@\"; }"
    done
fi

typeset -gU path
path=(
    $HOME/bin
    $HOME/.rbenv/bin
    /opt/bin
    /usr/local/sbin
    /usr/local/bin
    $path
)

if (( ${+commands[rbenv]} )); then 
    eval "$(rbenv init -)"
fi
