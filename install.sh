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

if [[ ! -z "$CODESPACES" ]]; then
  # Install Packages
  apt-get install -y fzf libfuse2 ruby-dev tmux ripgrep
  mkdir -p $HOME/bin

  curl -L https://github.com/sharkdp/bat/releases/download/v0.18.2/bat-v0.18.2-x86_64-unknown-linux-gnu.tar.gz | tar -xz -C $HOME
  cp $HOME/bat-v0.18.2-x86_64-unknown-linux-gnu/bat $HOME/bin/.
  rm -rf $HOME/bat-v0.18.2-x86_64-unknown-linux-gnu
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

