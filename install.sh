#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
  true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Exit if, for some reason, Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Homebrew failed to install." && return 1

brew update
brew install "git"

git clone https://github.com/oriolgg/dotfiles ~/.dotfiles --recursive

# Installs brew and the default formulas
/bin/bash ~/.dotfiles/brew.sh

# Installs brew and the default cask formulas
/bin/bash ~/.dotfiles/brew-cask.sh

# Change the default shell
chsh -s /bin/zsh

ln -s .dotfiles/agignore .agignore
ln -s .dotfiles/applescript .applescript
ln -s .dotfiles/bash/bash-alias .bash-alias
ln -s .dotfiles/bash/bashrc .bashrc
ln -s .dotfiles/bash/bashrc-osx .bashrc-osx
ln -s .dotfiles/bash/profile .profile
ln -s .dotfiles/bin .bin
ln -s .dotfiles/ctags .ctags
ln -s .dotfiles/git/gitconfig .gitconfig
ln -s .dotfiles/git/gitignore_global .gitignore_global
ln -s .dotfiles/aliases .aliases
ln -s .dotfiles/tmux/tmux .tmux
ln -s .dotfiles/tmux/tmux-osx.conf .tmux-osx.conf
ln -s .dotfiles/tmux/tmux-vim-select-pane /usr/local/bin/tmux-vim-select-pane
ln -s .dotfiles/tmux/tmux.conf .tmux.conf
ln -s .dotfiles/vim .vim
ln -s .dotfiles/vim/gvimrc .gvimrc
ln -s .dotfiles/vim/vimrc .vimrc
ln -s .dotfiles/vim/xvimrc .xvimrc
ln -s .dotfiles/zsh/oh-my-zsh .oh-my-zsh
ln -s .dotfiles/zsh/oh-my-zsh .oh-my-zsh
ln -s .dotfiles/zsh/zshrc .zshrc
ln -s .dotfiles/zsh/zshrc-osx .zshrc-osx

# Set default osx defaults
/bin/bash ~/.dotfiles/osx-defaults.sh
