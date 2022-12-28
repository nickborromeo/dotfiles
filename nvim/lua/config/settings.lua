vim.opt.autoindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.directory = "/tmp"
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.lazyredraw = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.re = 1
vim.opt.relativenumber = false
vim.opt.ruler = true
vim.opt.showmode = true
vim.opt.smartindent = true
vim.opt.splitright = true
vim.opt.sts = 2
vim.opt.sw = 2
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.ts = 2
vim.opt.tw = 120
vim.opt.updatetime = 300

-- Yank Settings
require('osc52').setup {
  max_length = 0,  -- Maximum length of selection (0 for no limit)
  silent = false,  -- Disable message on successful copy
  trim = false,    -- Trim text before copy
}

function copy()
  if vim.v.event.operator == 'y' and vim.v.event.regname == '"' then
    require('osc52').copy_register('"')
  end
end

vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})
