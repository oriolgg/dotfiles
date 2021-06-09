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

# Installs brew and formulas and casks
/bin/bash ~/.dotfiles/install/brew.sh
/bin/bash ~/.dotfiles/install/brew-cask.sh

# Change the default shell
chsh -s /bin/zsh

ln -s ~/.dotfiles/bin ~/.bin
ln -s ~/.dotfiles/ctags.d ~/.ctags.d

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

ln -s ~/.dotfiles/term-preferences/com.pancake.therm.plist ~/Library/Preferences/com.pancake.therm.plist
ln -s ~/.dotfiles/term-preferences/com.qvacua.VimR.plist ~/Library/Preferences/com.qvacua.VimR.plist

# Set default osx defaults
/bin/bash ~/.dotfiles/install/osx-defaults.sh

$(brew --prefix)/opt/fzf/install --all
bat cache --build

# Zsh Plugins
ln -s ~/.dotfiles/zsh/plugins/fast-syntax-highlighting ~/.zsh/oh-my-zsh/custom/plugins/fast-syntax-highlighting
ln -s ~/.dotfiles/zsh/plugins/forgit ~/.zsh/oh-my-zsh/custom/plugins/forgit
ln -s ~/.dotfiles/zsh/plugins/fzf-tab ~/.zsh/oh-my-zsh/custom/plugins/fzf-tab
ln -s ~/.dotfiles/zsh/plugins/zsh-autosuggestions ~/.zsh/oh-my-zsh/custom/plugins/zsh-autosuggestions
ln -s ~/.dotfiles/zsh/plugins/zsh-vi-mode ~/.zsh/oh-my-zsh/custom/plugins/zsh-vi-mode

# Zsh Theme
ln -s  ~/.dotfiles/zsh/themes/oriol.zsh-theme ~/.zsh/oh-my-zsh/custom/themes/oriol.zsh-theme

cp ~/.dotfiles/font/*.* ~/Library/Fonts
mkdir ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
cp ~/.dotfiles/term-preferences/dracula-xcode/Dracula.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/

# Update vim plugins opening nvim and executing :PlugInstall

sudo easy_install pip
pip install pynvim
pip3 install pynvim
