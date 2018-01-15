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
    adns
    ansible
    autoconf
    autojump
    awscli
    bison
    boost
    brew-rmtree
    cairo
    coreutils
    cscope
    ctags
    elinks
    exiftool
    fasd
    findutils
    flac
    fontconfig
    freetype
    gd
    gdbm
    gettext
    git
    git-extras
    git-flow
    gitsh
    glib
    glib-networking
    gmp
    gnu-getopt
    gnupg
    gnutls
    gobject-introspection
    graphite2
    graphviz
    gsettings-desktop-schemas
    gst-plugins-base
    gstreamer
    harfbuzz
    highlight
    htop
    htop-osx
    icu4c
    igbinary
    imagemagick
    jpeg
    libassuan
    libevent
    libffi
    libgcrypt
    libgpg-error
    libksba
    libogg
    libpng
    libshout
    libsoup
    libtasn1
    libtiff
    libtool
    libunistring
    libusb
    libvorbis
    libxml2
    libyaml
    links
    little-cms2
    lua
    lynx
    macvim
    mcrypt
    mhash
    mysql
    netcat
    nettle
    nginx
    node
    npth
    nvm
    openssl
    openssl@1.1
    orc
    p11-kit
    p7zip
    packer
    pango
    pass
    pcre
    php56
    php56-igbinary
    php56-imagick
    php56-intl
    php56-mcrypt
    php56-redis
    php56-tidy
    phpunit
    pinentry
    pixman
    pkg-config
    postgresql
    pwgen
    python
    python3
    qrencode
    readline
    reattach-to-user-namespace
    redis
    rename
    shellcheck
    speex
    sqlite
    swiftlint
    taglib
    the_silver_searcher
    thefuck
    theora
    tidy-html5
    tig
    tmux
    tree
    unar
    unixodbc
    vala
    varnish
    webp
    wifi-password
    xz
    youtube-dl
    zlib
    zsh
)

# Install apps to /Applications - default is: /Users/$user/Applications
echo "installing brew formulas..."

brew install "${apps[@]}"

# Remove outdated versions from the cellar.
brew cleanup
