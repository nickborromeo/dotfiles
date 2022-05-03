#!/bin/sh

DIR="$(pwd -P $0)/tmux"
MUX_DIR="$HOME/.config/tmuxinator"

echo "📋️ Copying tmuxinator templates..."
mkdir -p $MUX_DIR
mv $DIR/config/tmuxinator/*.yml $MUX_DIR

# Install tmuxinator
echo "Install tmuxinator..."
sudo gem install tmuxinator

