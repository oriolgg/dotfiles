alias e=exit
alias zs='source ~/.zshrc && clear'

# Brew
alias bup='brew update && brew upgrade && brew cu -ay && brew cleanup && brew doctor'
alias br='brew'
alias bi='brew info'
alias bl='brew list'
alias bs='brew search'
alias bis='brew install'
alias bus='brew uninstall'
alias bci='brew cask info'
alias bcis='brew cask install'
alias bcus='brew cask uninstall'

alias l='exa -lahH --git'
alias lt='exa --tree --level=2'

alias tmux='tmux -f ~/.config/tmux/tmux.conf'
alias tk='tmux list-panes -s -F '\''#{pane_pid} #{pane_current_command}'\'' | grep -v tmux | awk '\''{print $1}'\'' | xargs kill -9 ; e'
alias ts='tmux-start'


# Git
alias gcd='git checkout develop'
alias gf='git fetch -p'
alias gs='git status'
alias gp='git push'
alias gl='git pull'
alias ga='git add .'
alias go='git commit -m'
alias gc='git checkout'
alias gmd='git-merge-develop'
alias gbpurge='git branch --merged develop | grep -v "\*" | grep -v "master" | grep -v "develop" | grep -v "staging" | xargs -n 1 git branch -d'
alias gmodpull='git submodule foreach git pull origin master'
alias gu='gf ; gcm ; gl ; gcd ; gl ; gbpurge'

alias edf='cd $HOME/.dotfiles && nvim -S $HOME/.cache/nvim/nvim_sessions/dotfiles.vim'

alias v=nvim
alias vi=nvim
alias vim=nvim

alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

alias lynx='lynx -cfg=$HOME/.config/lynx/lynx.cfg -lss=$HOME/.config/lynx/lynx.lss -session=$HOME/.cache/lynx/session'

ansi-colors() {
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

manp() {
    man -t "$1" | open -f -a Preview
}
rmdsstore() {
    find "${@:-.}" -type f -name .DS_Store -delete
}
# Create a new directory and enter it
mkd() {
    mkdir -p "$@" && cd "$_";
}
vf() { fzf -m | xargs -o $EDITOR ;}

# Tmuxinator aliases
# alias txs='tmuxinator start'
# alias txo='tmuxinator open'
# alias txn='tmuxinator new'
# alias txl='tmuxinator list'
