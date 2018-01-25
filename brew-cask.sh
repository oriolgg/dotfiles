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
brew untap caskroom/cask

# Make sure we’re using the latest Homebrew.
brew update

# Handle dependencies
brew tap caskroom/cask
brew tap caskroom/versions
brew tap buo/cask-upgrade

# Apps for caskroom
apps=(
    1password
    alfred
    appcleaner
    beamer
    betterzip
    cakebrew
    cyberduck
    disk-inventory-x
    dropbox
    evernote
    firefox
    google-chrome
    handbrake
    iterm2
    kaleidoscope
    key-codes
    macvim
    mono-mdk
    monolingual
    moom
    opera
    p4merge
    qlcolorcode
    qlimagesize
    qlmarkdown
    qlprettypatch
    qlstephen
    qlvideo
    quicklook-csv
    quicklook-json
    script-debugger
    scummvm
    sequel-pro
    skype
    slack
    soapui
    sourcetree
    spotify
    sublime-text
    suspicious-package
    textmate
    torbrowser
    transmission
    vagrant
    vagrant-manager
    virtualbox
    visual-studio-code
    vlc
    webpquicklook
    whatsapp
    wkhtmltopdf
    zeplin
)

# Install apps to /Applications - default is: /Users/$user/Applications
echo "installing cask apps..."

brew cask install "${apps[@]}"

brew cask cleanup
