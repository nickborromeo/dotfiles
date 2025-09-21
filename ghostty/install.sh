#!/bin/sh

DIR="$(pwd -P $0)/ghostty"
GHOSTTY_DIR="$HOME/.config/ghostty"
OS="$(uname)"

if [ "$OS" = "Darwin" ]; then
  echo "Setting up Ghostty."
  
  echo "📋️ Copying ghostty settings..."
  mkdir -p $GHOSTTY_DIR
  mv $DIR/config $GHOSTTY_DIR
fi
