# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"



local color00='#022b35'
local color01='#A7ADBA'
local color02='#FFFFFF'
local color03='#65737E'
local color04='#c94c22'
local color05='#1488ad'
local color06='#B4881D'

export FZF_DEFAULT_OPTS="
    --height 80%
    --no-reverse
    --border
    --color=bg:$color00,bg+:$color00
    --color=fg:$color01,fg+:$color02
    --color=hl:$color04,hl+:$color05
    --color=spinner:$color04,info:$color06
    --color=border:$color05,pointer:$color02
    --color=prompt:$color01,header:$color05
    --color=marker:$color05
    --inline-info
    --preview-window=right:50%
    --preview 'bat --style=numbers,changes --color=always {} | head -10000'
    --bind change:top,ctrl-e:preview-down,ctrl-y:preview-up,ctrl-u:preview-page-up,ctrl-d:preview-page-down,ctrl-j:page-down,ctrl-k:page-up
"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

bindkey '^R' up-line-or-history
bindkey '^F' down-line-or-history
bindkey '^Y' fzf-history-widget

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

FZF_TAB_COMMAND=(
    fzf
    --ansi   # Enable ANSI color support, necessary for showing groups
    --expect='$continuous_trigger' # For continuous completion
    '--color=hl:$(( $#headers == 0 ? 108 : 255 ))'
    --nth=2,3 --delimiter='\x00'  # Don't search prefix
    --layout=reverse --height='${FZF_TMUX_HEIGHT:=75%}'
    --tiebreak=begin -m --bind=tab:down,btab:up,change:top,ctrl-space:toggle --cycle
    '--query=$query'   # $query will be expanded to query string at runtime.
    '--header-lines=$#headers' # $#headers will be expanded to lines of headers at runtime
)
zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND
enable-fzf-tab
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always $realpath'




# Integration with z
# like normal z when used with arguments but displays an fzf prompt when used without.
unalias z 2> /dev/null
z() {
    [ $# -gt 0 ] && _z "$*" && return
    cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    rg -uu --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}

# Homebrew
# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]lugin
bip() {
    local token=$(brew search | fzf -m --query="$1" +m --preview 'brew info {}')

    # if [[ $inst ]]; then
    #     for prog in $(echo $inst);
    #     do; brew install $prog; done;
    # fi
    if [[ $token ]]; then
        echo "(I)nstall or open the (h)omepage of $token"
        read input
        if [ $input = "i" ] || [ $input = "I" ]; then
            brew install $token
        fi
        if [ $input = "h" ] || [ $input = "H" ]; then
            brew home $token
        fi
    fi
}

# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [U]ninstall [P]lugin (e.g. uninstall)
bup() {
    local uninst=$(brew leaves | fzf -m)

    if [[ $uninst ]]; then
        for prog in $(echo $uninst);
        do; brew uninstall $prog; done;
    fi
}

# Homebrew Cask
# Install or open the webpage for the selected application
# using brew cask search as input source
# and display a info quickview window for the currently marked application
bci() {
    local token
    token=$(brew search --casks | fzf --query="$1" +m --preview 'brew cask info {}')

    if [ "x$token" != "x" ]
    then
        echo "(I)nstall or open the (h)omepage of $token"
        read input
        if [ $input = "i" ] || [ $input = "I" ]; then
            brew cask install $token
        fi
        if [ $input = "h" ] || [ $input = "H" ]; then
            brew cask home $token
        fi
    fi
}


# Uninstall or open the webpage for the selected application
# using brew list as input source (all brew cask installed applications)
# and display a info quickview window for the currently marked application
bcu() {
    local token
    token=$(brew cask list | fzf --query="$1" +m --preview 'brew cask info {}')

    if [ "x$token" != "x" ]
    then
        echo "(U)ninstall or open the (h)omepage of $token"
        read input
        if [ $input = "u" ] || [ $input = "U" ]; then
            brew cask uninstall $token
        fi
        if [ $input = "h" ] || [ $token = "h" ]; then
            brew cask home $token
        fi
    fi
}


b() {
    bookmarks_path=~/Library/Application\ Support/com.operasoftware.Opera/Bookmarks

    jq_script='
        def ancestors: while(. | length >= 2; del(.[-1,-2]));
        . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'

    jq -r $jq_script < "$bookmarks_path" \
        | sed -E $'s/(.*)\t(.*)/\\1\t\x1b[36m\\2\x1b[m/g' \
        | fzf --ansi -m --no-preview \
        | cut -d$'\t' -f2 \
        | xargs open
}

envf() {
    printenv | awk -F'=' '/^[A-Z]+/ {print $1}' | fzf --preview 'echo ${(P)$(echo {})}'
}
