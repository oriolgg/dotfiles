# Readme #

This dotfiles include my configuration for zsh, tmux and vim.

## Pre-requisites ##

In order to make it working, you have to follow few previous steps:

Install [XCode][xcode] and its Command Line Tools.

Install [iTerm2][iterm].

Install Homebrew:

    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    brew update

Install Git:

    brew install git

Install MacVim:

    brew install macvim

Install SilverSearcher:

    brew install the_silver_searcher

Install Tmux:

    brew install tmux

Install reattach-to-user-namespace:

    brew install reattach-to-user-namespace

Install zsh:

    brew install zsh

Make zsh default shell:

    sudo chsh -s /usr/local/bin/zsh

## Clone dotfiles ##

To clone my dotfiles:

    cd
    git clone git://github.com/oriolgg/dotfiles.git

Finally, you just need to create some symlinks:

    ln -s ~/dotfiles/zsh/oh-my-zsh ~/.oh-my-zsh↵
    ln -s ~/dotfiles/bash/profile ~/.profile↵
    ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf↵
    ln -s ~/dotfiles/vim/ ~/.vim↵
    ln -s ~/dotfiles/vim/vimrc ~/.vimrc↵
    ln -s ~/dotfiles/zsh/zshrc ~/.zshrc↵

