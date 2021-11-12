#!/bin/sh

DIR="$(pwd -P $0)"
MUX_DIR=$HOME/.config/tmuxinator

# Install tmuxinator
echo "Install tmuxinator..."
gem install tmuxinator

if [ ! -d $HOME/.config/tmuxinator ]; then
  mkdir $MUX_DIR

  for config in $DIR/**/*.yml; do
    echo "📋️ copying $config"
    cp $config $MUX_DIR
  done
fi
