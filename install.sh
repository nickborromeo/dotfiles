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
  echo 'Installing some packages into the Codespace...'

  sudo apt-get install -y fzf \
    tmux \
    universal-ctags \
    ripgrep \
    libfuse2

  # Install neovim
  NVIM_VERSION=0.8.1
  curl -L -o $HOME/bin/nvim https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim.appimage
  chmod a+x $HOME/bin/nvim
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
