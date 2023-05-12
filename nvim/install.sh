#!/bin/sh

DIR=$(pwd -P "$0")/nvim

echo "Setting up NeoVim."

if [ ! -d $HOME/.config/nvim ]; then
  ln -s "$DIR" $HOME/.config/nvim
fi

if command -v nvim > /dev/null; then
  nvim --headless "+Lazy! install" +qa
else
  echo "Whooops! No Neovim!"
fi
