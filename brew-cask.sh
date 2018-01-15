#!/usr/bin/env bash

#install binaries using homebrewcask

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
brew untap phinze/cask
brew untap caskroom/cask

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Handle dependencies
brew tap caskroom/cask
brew tap caskroom/versions
brew tap buo/cask-upgrade

# Apps for caskroom
apps=(
    alfred
    appcleaner
    betterzip
    cakebrew
    cyberduck
    disk-inventory-x
    firefox
    google-chrome
    iterm2
    key-codes
    macvim
    mono-mdk
    monolingual
    moom
    p4merge
    qlcolorcode
    qlimagesize
    qlmarkdown
    qlprettypatch
    qlstephen
    quicklook-csv
    quicklook-json
    sequel-pro
    skype
    slack
    sonarr
    sourcetree
    spotify
    suspicious-package
    torbrowser
    vagrant
    virtualbox
    vlc
    webpquicklook
)

# Install apps to /Applications - default is: /Users/$user/Applications
echo "installing cask apps..."

for app in "${apps[@]}"
do
  brew cask install --appdir="/Applications" $app --force
done

brew cask cleanup
