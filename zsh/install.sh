#!/bin/sh

OS="$(uname)"
MY_CONFIG="$HOME/.zshrc.pre-oh-my-zsh"
DEFAULT_CONFIG="$HOME/.zshrc"
DIR="$(pwd -P $0)/zsh"

if [ "$OS" = "Darwin" ]; then
  if [ ! -d ~/.oh-my-zsh ]; then
    echo 'Installing OhMyZsh.'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  if [ -d ~/.oh-my-zsh ]; then
    if [ -f $MY_CONFIG ]; then
      echo "Removing default zshrc"
      rm $DEFAULT_CONFIG
      echo "Using your zshrc"
      mv $MY_CONFIG $HOME/.zshrc
    fi

    if [ ! -f ~/.oh-my-zsh/themes/nickborromeo.zsh-theme ]; then
      echo "Copying theme..."
      cp $DIR/theme ~/.oh-my-zsh/themes/nickborromeo.zsh-theme
    fi
  fi

  echo "Oh My ZSH! We are done!"
fi
