# Readme #

This dotfiles include my configuration for [Zsh][zsh], [tmux][tmux] and [Vim][vim].

The configuration of each one is in a folder with its name.

After installing and the first time you use vim, some folders will be created in your home directory:

    .vim_backup: All your backup files will go here.
    .vim_sessions: If you use sessions (I recommend it), they will be stored here.
    .vim_swap: For your swap files.
    .vim_undo: In this folder you will have all your changes of all your files stored.
    .vim_view: Will store your latest status view of your files (like folding, cursor, etc).

## Pre-requisites ##

In order to make it working, you have to follow few previous steps:

Install [XCode][xcode] and its Command Line Tools.

Install [iTerm2][iterm2].

Install [Homebrew][homebrew]:

    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    brew update

Install [Git][git]:

    brew install git

Install [MacVim][macvim]:

    brew install macvim

Install [SilverSercher][silversercher]:

    brew install the_silver_searcher

Install [Tmux][tmux]:

    brew install tmux

Install [reattach-to-user-namespace][reattach-to-user-namespace]:

    brew install reattach-to-user-namespace

Install [Zsh][zsh]:

    brew install zsh

Make zsh your default shell:

    sudo chsh -s /bin/zsh

## Clone dotfiles ##

To clone my dotfiles:

    git clone https://github.com/oriolgg/dotfiles ~/.dotfiles --recursive

Finally, you just need to create some symlinks:

    ln -s ~/.dotfiles/zsh/oh-my-zsh ~/.oh-my-zsh
    ln -s ~/.dotfiles/bash/profile ~/.profile
    ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
    ln -s ~/.dotfiles/vim/ ~/.vim
    ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
    ln -s ~/.dotfiles/vim/gvimrc ~/.gvimrc
    ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
    ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
    ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global
    ln -s ~/.dotfiles/agignore ~/.agignore
    ln -s ~/.dotfiles/tmux/tmux-vim-select-pane /usr/local/bin/tmux-vim-select-pane

[zsh]: http://www.zsh.org/
[tmux]: http://tmux.sourceforge.net/
[vim]: http://www.vim.org/
[xcode]: https://developer.apple.com/xcode/
[iterm2]: http://www.iterm2.com/#/section/home
[homebrew]: http://brew.sh/
[git]: http://git-scm.com/
[macvim]: https://code.google.com/p/macvim/
[silversercher]: https://github.com/ggreer/the_silver_searcher
[reattach-to-user-namespace]: https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard

