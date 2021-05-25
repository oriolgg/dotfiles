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

    autoconf
    automake
    awscli
    bat
    broot
    brotli
    c-ares
    coreutils
    diff-so-fancy
    exa
    exiftool
    fd
    fzf
    gdbm
    gettext
    gh
    git
    git-flow
    highlight
    htop
    hub
    icu4c
    jansson
    jemalloc
    jq
    lazygit
    libev
    libevent
    libtermkey
    libuv
    libvterm
    libyaml
    libzip
    lua
    luajit
    luajit-openresty
    luv
    lynx
    m4
    mpdecimal
    msgpack
    ncurses
    neovim
    nghttp2
    node
    oniguruma
    openssl@1.1
    pcre2
    pkg-config
    python@3.9
    readline
    reattach-to-user-namespace
    rename
    ripgrep
    ruby
    sqlite
    tcl-tk
    terminal-notifier
    tldr
    tmux
    tmuxinator
    tree
    unar
    unibilium
    universal-ctags
    utf8proc
    vifm
    wifi-password
    xz
    youtube-dl

)

# Install apps to /Applications - default is: /Users/$user/Applications
echo "installing brew formulas..."

brew install "${apps[@]}"

brew install --with-jansson --HEAD universal-ctags/universal-ctags/universal-ctags

# Remove outdated versions from the cellar.
brew cleanup
