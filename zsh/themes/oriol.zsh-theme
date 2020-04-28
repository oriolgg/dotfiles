function _host_prompt_info {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

function _pwd_prompt_info {
    echo "${PWD/#$HOME/~}"
}

function _git_prompt_info {
    [[ -n $(whence git_prompt_info) ]] && git_prompt_info
}

function _virtualenv_prompt_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

PROMPT='
╭ %{$fg[yellow]%}%n%{$reset_color%} in %{$fg[green]%}$(_pwd_prompt_info)$(_git_prompt_info)%{$reset_color%}
╰ %{$fg[cyan]%}$(_virtualenv_prompt_info)%{$reset_color%}➤ '

ZSH_THEME_GIT_PROMPT_PREFIX="$reset_color on $fg[magenta]"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[yellow]✗"
ZSH_THEME_GIT_PROMPT_CLEAN=""

