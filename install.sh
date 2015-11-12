# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

# Install shell utilities
brew install brew-cask
brew install brew-rmtree
brew install ctags
brew install findutils
brew install geoip
brew install git
brew install git-extras
brew install git-flow-avh
brew install imagemagick
brew install jpeg
brew install libmagic
brew install libpng
brew install libtiff
brew install libtool
brew install links
brew install mongodb
brew install mysql
brew install nginx
brew install openssl
brew install rabbitmq
brew install reattach-to-user-namespace
brew install rename
brew install the_silver_searcher
brew install tmux
brew install tree
brew install unrar
brew install zint
brew install zsh

# Install Homebrew cask
brew tap caskroom/cask
brew install brew-cask

# Install Applications
brew cask install --appdir=/Applications 1password
brew cask install --appdir=/Applications airmail-beta
brew cask install --appdir=/Applications appcleaner
brew cask install --appdir=/Applications betterzip
brew cask install --appdir=/Applications betterzipql
brew cask install --appdir=/Applications cyberduck
brew cask install --appdir=/Applications disk-inventory-x
brew cask install --appdir=/Applications dropbox
brew cask install --appdir=/Applications evernote
brew cask install --appdir=/Applications fantastical
brew cask install --appdir=/Applications firefox
brew cask install --appdir=/Applications google-chrome
brew cask install --appdir=/Applications handbrake
brew cask install --appdir=/Applications iexplorer
brew cask install --appdir=/Applications iterm2
brew cask install --appdir=/Applications java
brew cask install --appdir=/Applications jdownloader
brew cask install --appdir=/Applications macvim
brew cask install --appdir=/Applications moom
brew cask install --appdir=/Applications mysqlworkbench
brew cask install --appdir=/Applications p4merge
brew cask install --appdir=/Applications perian
brew cask install --appdir=/Applications plex-media-server
brew cask install --appdir=/Applications qlcolorcode
brew cask install --appdir=/Applications qlimagesize
brew cask install --appdir=/Applications qlmarkdown
brew cask install --appdir=/Applications qlprettypatch
brew cask install --appdir=/Applications qlstephen
brew cask install --appdir=/Applications quicklook-csv
brew cask install --appdir=/Applications quicklook-json
brew cask install --appdir=/Applications quicktime-player7
brew cask install --appdir=/Applications skype
brew cask install --appdir=/Applications sourcetree
brew cask install --appdir=/Applications spotify
brew cask install --appdir=/Applications suspicious-package
brew cask install --appdir=/Applications techstoreclub-simple-comic
brew cask install --appdir=/Applications textmate
brew cask install --appdir=/Applications transmission
brew cask install --appdir=/Applications vlc
brew cask install --appdir=/Applications webpquicklook
brew cask install --appdir=/Applications wkhtmltopdf

# Install working utilities
sudo easy_install pip
sudo pip install virtualenv

# I don't want the accent menu in OSx
defaults write -g ApplePressAndHoldEnabled -bool false

git clone https://github.com/oriolgg/dotfiles ~/.dotfiles --recursive

# Start nginx at start
sudo cp ~/.dotfiles/com.oriol.nginx.plist /Library/LaunchDaemons
sudo launchctl load /Library/LaunchDaemons/com.oriol.nginx.plist

# Start mongodb at start
ln -s $(which mongod)/../../homebrew.mxcl.mongodb.plist ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist

# Change the default shell
chsh -s /bin/zsh

ln -s .dotfiles/agignore .agignore
ln -s .dotfiles/bash/bash-alias .bash-alias
ln -s .dotfiles/bash/bashrc .bashrc
ln -s .dotfiles/bash/bashrc-osx .bashrc-osx
ln -s .dotfiles/bash/profile .profile
ln -s .dotfiles/ctags .ctags
ln -s .dotfiles/git/gitconfig .gitconfig
ln -s .dotfiles/git/gitignore_global .gitignore_global
ln -s .dotfiles/aliases .aliases
ln -s .dotfiles/tmux/tmux .tmux
ln -s .dotfiles/tmux/tmux-osx.conf .tmux-osx.conf
ln -s .dotfiles/tmux/tmux-vim-select-pane /usr/local/bin/tmux-vim-select-pane
ln -s .dotfiles/tmux/tmux.conf .tmux.conf
ln -s .dotfiles/vim .vim
ln -s .dotfiles/vim/gvimrc .gvimrc
ln -s .dotfiles/vim/vimrc .vimrc
ln -s .dotfiles/vim/xvimrc .xvimrc
ln -s .dotfiles/zsh/oh-my-zsh .oh-my-zsh
ln -s .dotfiles/zsh/oh-my-zsh .oh-my-zsh
ln -s .dotfiles/zsh/zshrc .zshrc
ln -s .dotfiles/zsh/zshrc-osx .zshrc-osx
