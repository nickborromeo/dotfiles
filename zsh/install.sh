#!/bin/sh

OS="$(uname)"

if [ "$OS" = "Darwin" ]; then
  if ! command -v brew &> /dev/null; then
    echo 'Installing OhMyZsh.'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
fi
