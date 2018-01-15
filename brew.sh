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

brew install adns
brew install ansible
brew install autoconf
brew install autojump
brew install awscli
brew install bison
brew install boost
brew install brew-rmtree
brew install cairo
brew install coreutils
brew install cscope
brew install ctags
brew install elinks
brew install exiftool
brew install fasd
brew install findutils
brew install flac
brew install fontconfig
brew install freetype
brew install gd
brew install gdbm
brew install gettext
brew install git
brew install git-extras
brew install git-flow
brew install gitsh
brew install glib
brew install glib-networking
brew install gmp
brew install gnu-getopt
brew install gnupg
brew install gnutls
brew install gobject-introspection
brew install graphite2
brew install graphviz
brew install gsettings-desktop-schemas
brew install gst-plugins-base
brew install gstreamer
brew install harfbuzz
brew install highlight
brew install htop
brew install htop-osx
brew install icu4c
brew install igbinary
brew install imagemagick
brew install jpeg
brew install libassuan
brew install libevent
brew install libffi
brew install libgcrypt
brew install libgpg-error
brew install libksba
brew install libogg
brew install libpng
brew install libshout
brew install libsoup
brew install libtasn1
brew install libtiff
brew install libtool
brew install libunistring
brew install libusb
brew install libvorbis
brew install libxml2
brew install libyaml
brew install links
brew install little-cms2
brew install lua
brew install lynx
brew install macvim
brew install mcrypt
brew install mhash
brew install mysql
brew install netcat
brew install nettle
brew install nginx
brew install node
brew install npth
brew install nvm
brew install openssl
brew install openssl@1.1
brew install orc
brew install p11-kit
brew install p7zip
brew install packer
brew install pango
brew install pass
brew install pcre
brew install php56
brew install php56-igbinary
brew install php56-imagick
brew install php56-intl
brew install php56-mcrypt
brew install php56-redis
brew install php56-tidy
brew install phpunit
brew install pinentry
brew install pixman
brew install pkg-config
brew install postgresql
brew install pwgen
brew install python
brew install python3
brew install qrencode
brew install readline
brew install reattach-to-user-namespace
brew install redis
brew install rename
brew install speex
brew install sqlite
brew install swiftlint
brew install taglib
brew install the_silver_searcher
brew install thefuck
brew install theora
brew install tidy-html5
brew install tig
brew install tmux
brew install tree
brew install unar
brew install unixodbc
brew install vala
brew install varnish
brew install webp
brew install xz
brew install youtube-dl
brew install zlib
brew install zsh

# Remove outdated versions from the cellar.
brew cleanup
