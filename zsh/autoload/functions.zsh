#!/bin/zsh

# Removes a submodule from git
git_remove_submodule() {
    [[ ! -d "$1" ]] && echo "$1 is not a directory" && return
    [[ ! -d ".git/modules/$1" ]] && echo "$1 is not a git submodule" && return
    [[ ! -f "$1/.git" ]] && echo "$1 is not a git submodule" && return

    git submodule deinit -f -- "$1"
    git rm -f "$1"
    rm -rf ".git/modules/$1"
}

# Printss the 256 colors available in terminal
ansi-colors() {
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

# Creates a pdf of a manpage and opens it in Preview
manp() {
    man -t "$1" | open -f -a Preview
}

# Removes all .DS_Store files recursively
rmdsstore() {
    find "${@:-.}" -type f -name .DS_Store -delete
}

# Create a new directory and cd there
mkcd() {
    [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# Executes 10 times the start of zsh and prints the time of each
timezsh() {
    shell=${1-$SHELL}
    for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# Shows the time spent by the start of zsh by plugin
profzsh() {
    shell=${1-$SHELL}
    ZPROF=true $shell -i -c exit
}

# Executes 10 times the opening of vim and prints the time of each
timevim() {
    for i in $(seq 1 10); do /usr/bin/time vim +qa; done
}
