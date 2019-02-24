#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Make ZSH the default shell environment
chsh -s $(which zsh)

# Install Composer
if test ! $(which composer); then
  curl -sS https://getcomposer.org/installer | php
  mv composer.phar /usr/local/bin/composer
fi

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer \
  laravel/spark-installer laravel/valet pyrech/composer-changelogs phpmd/phpmd \
  squizlabs/php_codesniffer laravel/spark-installer

# Install global NPM packages
npm install --global yarn vtop fsevents ghost-cli npm pure-prompt yarn

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Symlink the Mackup config file to the home directory
ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Ultimate VIM
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# Powerline fonts download and setup
git clone git@github.com:powerline/fonts.git ~/powerline-fonts
~/powerline-fonts/install.sh

# AWS cli
pip install awscli

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
