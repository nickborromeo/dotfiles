#!/bin/sh

DIR="$(pwd -P $0)/starship"
CONFIG_DIR="$HOME/.config/"

echo "Setting up Starship Prompt."

echo "📋️ Copying starship prompt templates..."
if [ ! -d $HOME/.config/ ]; then
  mkdir -p $CONFIG_DIR
fi

mv $DIR/starship.toml $CONFIG_DIR
