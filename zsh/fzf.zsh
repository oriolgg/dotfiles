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
# [Ctrl-T] -> Posa a la línia de comandes el nom del fitxer o directori seleccionat
# [Alt-C] -> Llista directoris dins del directori actual i fa cd a ell. Si hi havi alguna cosa escrita, ho manté un cop s'ha fet cd al directori
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# Obre fzf amb l'historial de comandes
bindkey '^Y' fzf-history-widget

bindkey '^R' up-line-or-history
bindkey '^F' down-line-or-history

# Busca a l'historial comandes que comencen pel que ja s'ha escrit
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

local color00='#022b35'
local color01='#A7ADBA'
local color02='#FFFFFF'
local color03='#65737E'
local color04='#c94c22'
local color05='#1488ad'
local color06='#B4881D'

export FZF_DEFAULT_OPTS="
    --height 75%
    --reverse
    -s
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
    --bind change:top,ctrl-w:backward-kill-word,ctrl-a:beginning-of-line,ctrl-e:end-of-line,shift-right:forward-word,shift-left:backward-word,ctrl-c:clear-query,ctrl-f:page-down,ctrl-b:page-up,ctrl-u:half-page-up,ctrl-d:half-page-down,ctrl-t:top,ctrl-p:up,ctrl-n:down,ctrl-o:toggle-sort,ctrl-x:toggle,tab:toggle-out,btab:toggle-up,alt-e:preview-down,alt-y:preview-up,alt-f:preview-page-down,alt-b:preview-page-up,alt-p:toggle-preview
"

# Search Field
#   [ctrl-w] - (backward-kill-word) Esborra la paraula anterior del cursor
#   [ctrl-a] - (beginning-of-line)
#   [ctrl-e] - (end-of-line)
#   [shift-right] - (backward-word) Mou el cursor a la paraula anterior
#   [shift-left] - (forward-word) Mou el cursor a la paraula següent
#   [ctrl-c] - (clear-query) Esborra el camp de cerca

# Search Result List
#   [ctrl-f] - (page-down) Mou una pàgina avall
#   [ctrl-b] - (page-up) Mou una pàgina amunt
#   [ctrl-u] - (half-page-up) Mou mitja pàgina amunt
#   [ctrl-d] - (half-page-down) Mou mitja pàgina avall
#   [ctrl-t] - (top) Mou el resultat marcat al primer de la llista
#   [change] - (top) Mou el resultat marcat al primer de la llista quan hi ha un canvi al search field
#   [ctrl-n] - (up) Mou el resultat marcat al següent
#   [ctrl-p] - (down) Mou el resultat marcat a l'anterior
#   [ctrl-o] - (toggle-sort) Ordena/desordena els resultats de la cerca
#   [ctrl-x] - (toggle) Selecciona/deselecciona el resultat de cerca marcat
#   [tab] - (toggle-out) Selecciona/deselecciona el resultat marcat i mou al següent
#   [btab] - (toggle-out) Selecciona/deselecciona el resultat marcat i mou al anterior

# Preview
#   [alt-e] - (preview-down) Mou una línia avall
#   [alt-y] - (preview-up) Mou una pàgina amunt
#   [alt-f] - (preview-page-down) Mou una pàgina avall
#   [alt-b] - (preview-page-up) Mou una pàgina amunt
#   [alt-p] - (toggle-preview) Mostra/oculta el panell de previsualització

FZF_TAB_COMMAND=(
    fzf
    --ansi   # Enable ANSI color support, necessary for showing groups
    --expect='$continuous_trigger' # For continuous completion
    '--color=hl:$(( $#headers == 0 ? 108 : 255 ))'
    --nth=2,3 --delimiter='\x00'  # Don't search prefix
    --layout=reverse --height='${FZF_TMUX_HEIGHT:=75%}'
    --tiebreak=begin -m
    --bind change:top,ctrl-w:backward-kill-word,ctrl-a:beginning-of-line,ctrl-e:end-of-line,shift-right:forward-word,shift-left:backward-word,ctrl-c:clear-query,ctrl-f:page-down,ctrl-b:page-up,ctrl-u:half-page-up,ctrl-d:half-page-down,ctrl-t:top,ctrl-p:up,ctrl-n:down,ctrl-o:toggle-sort,ctrl-x:toggle,tab:toggle-out,btab:toggle-up,alt-e:preview-down,alt-y:preview-up,alt-f:preview-page-down,alt-b:preview-page-up,alt-p:toggle-preview
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

# Mostra les variables d'entorn
envf() {
  local token
  token=$(printenv | awk -F'=' '/^[A-Z]+/ {print $1}' | fzf --preview 'echo ${(P)$(echo {})}')

  if [ "x$token" != "x" ]
  then
      echo $token'\n'$(printenv $token)
  fi
}

# Mostra els commits d'un projecte o els commits que han afectat al fitxer indicat per paràmetre
gitcom() {
  local filter
  if [ -n $@ ] && [ -f $@ ]; then
    filter="-- $@"
  fi

  git log \
    --graph --color=always --abbrev=7 --format='%C(auto)%h %an %C(blue)%s %C(yellow)%cr' $@ | \
    fzf \
      --ansi --no-sort --reverse --tiebreak=index \
      --preview "f() { set -- \$(echo -- \$@ | grep -o '[a-f0-9]\{7\}'); [ \$# -eq 0 ] || git show --color=always \$1 $filter; }; f {}" \
      --bind "change:top,ctrl-b:backward-word,ctrl-w:backward-kill-word,ctrl-t:top,ctrl-u:half-page-up,ctrl-d:half-page-down,ctrl-x:toggle,alt-a:toggle-all,ctrl-o:toggle-sort,tab:toggle-out,btab:toggle-in,alt-e:preview-down,alt-y:preview-up,alt-u:preview-page-up,alt-d:preview-page-down,alt-p:toggle-preview,enter:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
                FZF-EOF" \
      --preview-window=right:60% \
      --height 80%
}
