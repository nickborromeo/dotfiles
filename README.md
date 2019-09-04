### Nick Borromeo's dot files

Config files to setup most of my dev environment and the rest are just some sprinkles to make life more productive. 


### Installation

  git clone git://github.com/nickborromeo/dotfiles ~/.dotfiles
  cd ~/.dotfiles
  rake install

  Vim plugins are managed through Vim Plug. You'll need to install [vim-plug](https://github.com/junegunn/vim-plug) to get them.

  ```
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ```
  
  Run `:PlugInstall` in vim.
