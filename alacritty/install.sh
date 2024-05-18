#!/bin/sh

DIR="$(pwd -P $0)/alacritty"
ALACRITTY_DIR="$HOME/.config/alacritty"

echo "Setting up Alacritty."

echo "📋️ Copying alacritty settings..."
mkdir -p $ALACRITTY_DIR
mv $DIR/*.toml $ALACRITTY_DIR
