#!/usr/bin/env bash

# Install command-line tools using Homebrew.

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

#homebrew now includes cask, so let's get rid of the old version
brew uninstall --force brew-cask

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

apps=(
    awscli
    coreutils
    ctags
    exiftool
    findutils
    git
    lynx
    neovim
    python
    python3
    readline
    reattach-to-user-namespace
    rename
    the_silver_searcher
    tmux
    tree
    unar
    unrar
    vim --with-python3
    wifi-password
    youtube-dl
    zsh
    Rigellute/tap/spotify-tui

    fzf
)

# Install apps to /Applications - default is: /Users/$user/Applications
echo "installing brew formulas..."

brew install "${apps[@]}"

# Remove outdated versions from the cellar.
brew cleanup
