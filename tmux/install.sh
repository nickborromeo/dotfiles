#!/bin/sh

DIR="$(pwd -P $0)/tmux"
MUX_DIR="$HOME/.config/tmuxinator"

echo "📋️ Copying tmuxinator templates..."
mkdir -p $MUX_DIR
mv $DIR/config/tmuxinator/*.yml $MUX_DIR

# Install tmuxinator
echo "Install tmuxinator..."
sudo gem install tmuxinator

# Install theme
mkdir -p $HOME/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
