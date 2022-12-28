local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'benmills/vimux'
  use 'bronson/vim-trailing-whitespace'
  use 'bswinnerton/vim-test-github'
  use 'christoomey/vim-tmux-navigator'
  use 'cwebster2/github-coauthors.nvim'
  use 'ellisonleao/gruvbox.nvim'
  use 'godlygeek/tabular'
  use 'janko-m/vim-test'
  use 'jremmen/vim-ripgrep'
  use 'leafgarland/typescript-vim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'ojroques/nvim-osc52'
  use 'sheerun/vim-polyglot'
  use 'tpope/vim-commentary'
  use 'tpope/vim-endwise'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rails'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-surround'
  use 'tpope/vim-tbone'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
