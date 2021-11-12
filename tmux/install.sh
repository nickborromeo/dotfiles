#!/bin/sh

DIR="$(pwd -P $0)"
MUX_DIR=$HOME/.config/tmuxinator

# Install tmuxinator
echo "Install tmuxinator..."
gem install tmuxinator

if [ ! -d $HOME/.config/tmuxinator ]; then
  mkdir $MUX_DIR

  for linkable in $DIR/**/*.symlink; do
    target=$MUX_DIR"/."$(basename $linkable | sed 's/.symlink//')
    if [ ! -L $target ]; then
      echo "🔗 Linking $target → $linkable."
      ln -Ff -s $linkable $target
    fi
  done
fi
