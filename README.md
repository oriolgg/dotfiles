# Readme #

This dotfiles include my configuration for [Zsh][zsh], [tmux][tmux] and [Neovim][nvim].

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

    cp ~/.dotfiles/git/gitconfig ~/.gitconfig
    ln -s ~/.dotfiles/bin ~/.bin
    ln -s ~/.dotfiles/ctags.d ~/.ctags.d
    ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global
    
    ln -s ~/.dotfiles/config ~/.config
    ln -s ~/.config/nvim ~/.vim
    ln -s ~/.config/nvim/init.vim ~/.vimrc
    ln -s ~/.config/nvim/xvimrc ~/.ideavimrc
    ln -s ~/.config/nvim/xvimrc ~/.xvimrc
    ln -s ~/.config/qutebrowser ~/.qutebrowser
    ln -s ~/.config/rg/ignore ~/.ignore
    
    ln -s ~/.dotfiles/zsh ~/.zsh
    ln -s ~/.zsh/oh-my-zsh ~/.oh-my-zsh
    ln -s ~/.zsh/zshrc ~/.zshrc
    cp -r ~/.dotfiles/cache ~/.cache

[zsh]: http://zsh.org/
[tmux]: http://tmux.sourceforge.net/
[nvim]: https://neovim.io/
[xcode]: https://developer.apple.com/xcode/
[iterm2]: http://iterm2.com/
[homebrew]: http://brew.sh/
[git]: http://git-scm.com/
[macvim]: https://macvim-dev.github.io/macvim
[vimr]: http://vimr.org/
[ripgrep]: https://github.com/BurntSushi/ripgrep
[reattach-to-user-namespace]: https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard

