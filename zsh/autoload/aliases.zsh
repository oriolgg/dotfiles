#!/bin/zsh

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

# Changes ls for exa
alias l='exa -lahH --git'
alias lt='exa --tree --level=2'

# Tmux
alias tmux='tmux -f ~/.config/tmux/tmux.conf'
alias ts='tmux-start'

# Git
alias gcd='git checkout develop'
alias gcm='git checkout master'
alias gf='git fetch -p'
alias gs='git status'
alias gpo='git push origin'
alias gp='git pull'
alias go='git commit -m'
alias gc='git checkout'
alias gmd='git-merge-develop'
alias gbpurge='git branch --merged develop | grep -v "\*" | grep -v "master" | grep -v "develop" | grep -v "staging" | xargs -n 1 git branch -d'
alias gupurge='gf ; gcm ; gl ; gcd ; gl ; gbpurge'
alias gmodpull='git submodule foreach git pull origin master'

# Batgrep uses Rg internally but with a more friendly result
alias bg='batgrep'

# Edit dotfiles
alias edf='cd $HOME/.dotfiles && nvim'

alias v=nvim
alias vi=nvim
alias vim=nvim

# Lynx start with custom config files
alias lynx='lynx -cfg=$HOME/.config/lynx/lynx.cfg -lss=$HOME/.config/lynx/lynx.lss -session=$HOME/.cache/lynx/session'

alias ytd=youtube-dl -f bestvideo+bestaudio
