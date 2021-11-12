#!/bin/sh

DIR="$(pwd -P $0)"
MUX_DIR="$HOME/.config/tmuxinator"

echo "📋️ Copying tmuxinator templates..."
mkdir -p $MUX_DIR
mv $DIR/config/tmuxinator/*.yml $MUX_DIR

# Install tmuxinator
echo "Install tmuxinator..."
gem install tmuxinator

