#!/bin/sh

DIR="$(pwd -P $0)"
MUX_DIR=$HOME/.config/tmuxinator

# Install tmuxinator
echo "Install tmuxinator..."
gem install tmuxinator

if [ ! -d $HOME/.config/tmuxinator ]; then
  mkdir $MUX_DIR
  cp $DIR/**/*.yml $MUX_DIR
fi
