#!/bin/sh

DIR=$(pwd -P "$0")/nvim

echo "Setting up NeoVim."

if [ ! -d $HOME/.config/nvim ]; then
  ln -sd "$DIR" $HOME/.config/nvim
fi

if command -v nvim > /dev/null; then
  nvim -u $HOME/.config/nvim/install.vim
else
  echo "Whooops! No Neovim!"
fi
