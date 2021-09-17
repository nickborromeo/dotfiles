#!/bin/sh

DIR="$(pwd -P $0)/bash"

echo "Setting up Bash"

if [ ! -d $HOME/.bash ]; then
  if [ $(uname) = "Darwin" ]; then
    ln -s $DIR $HOME/.bash
  else
    ln -sd $DIR $HOME/.bash
  fi
fi
