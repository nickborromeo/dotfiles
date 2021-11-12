#!/bin/sh

OS="$(uname)"
MY_CONFIG="$HOME/.zshrc.pre-oh-my-zsh"
DEFAULT_CONFIG="$HOME/.zshrc"
DIR="$(pwd -P $0)/zsh"

if [ ! -d $HOME/.oh-my-zsh ]; then
  echo 'Installing OhMyZsh.'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ -d $HOME/.oh-my-zsh ]; then
  if [ -f $MY_CONFIG ]; then
    echo "Removing default zshrc"
    rm $DEFAULT_CONFIG
    echo "Using your zshrc"
    mv $MY_CONFIG $HOME/.zshrc
  fi

  if [ ! -f $HOME/.oh-my-zsh/themes/nickborromeo.zsh-theme ]; then
    echo "Copying theme..."
    cp $DIR/theme $HOME/.oh-my-zsh/themes/nickborromeo.zsh-theme
  fi

  if [ ! -f $HOME/.zsh/aliases ]; then
    echo "Copying aliases.."
    cp $DIR/aliases $HOME/.zsh/aliases
  fi
fi

chsh -s $(which zsh)

echo "Oh My ZSH! We are done!"
