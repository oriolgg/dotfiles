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

# Homebrew now includes cask, so let's get rid of the old version
brew uninstall --force brew-cask

# Add some new tabs
brew tap homebrew/cask-fonts
brew tap universal-ctags/universal-ctags

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

apps=(

    awscli
    bat
    coreutils
    diff-so-fancy
    exa
    exiftool
    fd
    fzf
    gh
    git
    git-flow
    hub
    jq
    lynx
    neovim
    python3
    readline
    reattach-to-user-namespace
    rename
    ripgrep
    sqlite
    terminal-notifier
    tmux
    tmuxinator
    tree
    unar
    universal-ctags
    unrar
    vifm
    wifi-password
    youtube-dl

)

# Install apps to /Applications - default is: /Users/$user/Applications
echo "installing brew formulas..."

brew install "${apps[@]}"

brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# Remove outdated versions from the cellar.
brew cleanup
