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
    
    echo 'FZF install useful key bindings and fuzzy completion'
    $(brew --prefix)/opt/fzf/install
  fi
fi

if [ -n "$CODESPACES" ]; then
  echo 'Installing some packages into the Codespace...'

  sudo apt update
  sudo apt-get install -y fzf \
    tmux \
    universal-ctags \
    ripgrep \
    libfuse2 \ 
    xsel

  # Install neovim
  #NVIM_VERSION=0.8.1
  #curl -L -o $HOME/bin/nvim --create-dirs https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim.appimage
  #chmod a+x $HOME/bin/nvim

  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  ./nvim.appimage --appimage-extract
  ./squashfs-root/AppRun --version
  sudo mv squashfs-root /
  sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

  # Vim Plug
  # sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  #     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  # Install ruby-lsp
  # Only run this inside a dotcom codespace
  if [ -d "/workspaces/github" ]; then
    export RAILS_ROOT="/workspaces/github"
    export PATH=$RAILS_ROOT/vendor/ruby/"$(/workspaces/github/config/ruby-version)"/bin:$PATH
    gem install ruby-lsp ruby-lsp-rails
  fi
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
