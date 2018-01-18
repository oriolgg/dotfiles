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

Install [Homebrew][homebrew]:

    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    brew update

Install [Git][git]:

    brew install git

Clone my dotfiles:

    git clone https://github.com/oriolgg/dotfiles ~/.dotfiles --recursive

Execute brew.sh in order to install necessary packages:

    ~/.dotfiles/brew.sh

Execute brew-cask.sh in order to install my most used apps:

    ~/.dotfiles/brew-cask.sh

Make zsh your default shell:

    sudo chsh -s /bin/zsh

Finally, you just need to create some symlinks:

    ln -s ~/.dotfiles/agignore ~/.agignore
    ln -s ~/.dotfiles/bash/profile ~/.profile
    ln -s ~/.dotfiles/ctags ~/.ctags
    ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
    ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global
    ln -s ~/.dotfiles/tmux/tmux-vim-select-pane /usr/local/bin/tmux-vim-select-pane
    ln -s ~/.dotfiles/tmux ~/.tmux
    ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
    ln -s ~/.dotfiles/tmux/tmux-osx.conf ~/.tmux-osx.conf
    ln -s ~/.dotfiles/vim ~/.vim
    ln -s ~/.dotfiles/vim/gvimrc ~/.gvimrc
    ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
    ln -s ~/.dotfiles/zsh/oh-my-zsh ~/.oh-my-zsh
    ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
    ln -s ~/.dotfiles/zsh/zshrc-osx ~/.zshrc-osx

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

