#!/bin/sh

DIR="$(pwd -P $0)"
OS="$(uname)"

if [ "$OS" = "Darwin" ]; then
  if ! command -v brew &> /dev/null; then
    echo 'Installing Homebrew...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  echo 'Any packages today...?'
  if ! brew bundle check; then
    echo 'Bundling them up for you now...'
    brew bundle install
  fi
fi

if [ -n "$CODESPACES" ]; then
  # Install Packages
  echo 'Installing some packages into the Codespace...'
  sudo apt-get install -y fzf libfuse2 rbenv ruby-dev tmux ripgrep zsh bat vim-gtk xsel universal-ctags neovim

  echo 'Installing Packer for Neovim'
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
   ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

# Link all linkable files
for linkable in $DIR/**/*.symlink; do
  target=$HOME"/."$(basename $linkable | sed 's/.symlink//')
  if [ ! -L $target ]; then
    echo "🔗 Linking $target → $linkable."
    ln -Ff -s $linkable $target
  fi
done

for executable in $DIR/**/install.sh; do
  echo "👟 Running $executable."
  sh $executable
done
