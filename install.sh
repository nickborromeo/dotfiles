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
  BREW=/home/linuxbrew/.linuxbrew/bin/brew

  $BREW install bat
  $BREW install fzf
  $BREW install neovim
  $BREW install ripgrep
  $BREW install tmux
  $BREW install tmuxinator
  $BREW install universal-ctags

  /home/linuxbrew/.linuxbrew/opt/fzf/install --key-bindings --completion --update-rc
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
