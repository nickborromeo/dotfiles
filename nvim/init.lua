-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

----------------
--- plugins ---
----------------
require("lazy").setup({
    -- colorscheme
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function ()
        require("catppuccin").setup({
          flavour = "macchiato",
        })
      end,
    },

    -- tmux navigate
    {
      "christoomey/vim-tmux-navigator",
    },
    -- delimiter pairs
    {
      "cohama/lexima.vim"
    },
    -- TPope Stuff
    { "tpope/vim-fugitive" },
    { "tpope/vim-surround" },

    -- Whitespace
    { "ntpeters/vim-better-whitespace" },

    -- Testing
    { "vim-test/vim-test" },

    -- Ripgrep
    { "jremmen/vim-ripgrep" },

    -- Go
    {  "fatih/vim-go",
     config = function ()
	     -- we disable most of these features because treesitter and nvim-lsp
	     -- take care of it
	     vim.g['go_gopls_enabled'] = 0
	     vim.g['go_code_completion_enabled'] = 0
	     vim.g['go_fmt_autosave'] = 0
	     vim.g['go_imports_autosave'] = 0
	     vim.g['go_mod_fmt_autosave'] = 0
	     vim.g['go_doc_keywordprg_enabled'] = 0
	     vim.g['go_def_mapping_enabled'] = 0
	     vim.g['go_textobj_enabled'] = 0
	     vim.g['go_list_type'] = 'quickfix'
	     vim.g['go_rename_command'] = 'gorename'
	     vim.g['go_diagnostics_level'] = 1
	     vim.g['go_metalinter_autosave'] = 1
     end,
    },

    -- Fuzzy Finder
    -- fzf extension for telescope with better speed
    {
      "nvim-telescope/telescope-fzf-native.nvim", run = 'make'
    },

    {'nvim-telescope/telescope-ui-select.nvim' },

    {
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim"
      },
    },

    -- fuzzy finder framework
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim" ,
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
      },
      config = function ()
        require("telescope").setup({
            pickers = {
              find_files = {
                disable_devicons = true
              },
              git_files = {
                disable_devicons = true
              },
            },
            extensions = {
              -- fzf = {
              --   fuzzy = true,                    -- false will only do exact matching
              --   override_generic_sorter = true,  -- override the generic sorter
              --   override_file_sorter = true,     -- override the file sorter
              --   case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
              --                                    -- the default case_mode is "smart_case"
              -- }
            }
          })

        -- To get fzf loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        -- require('telescope').load_extension('fzf')

        -- To get ui-select loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        require("telescope").load_extension("ui-select")
      end,
    },

    -- lsp-config
    {
      "neovim/nvim-lspconfig",
      config = function ()
        util = require "lspconfig/util"

        local lspconfig = require('lspconfig')

	lspconfig.ruby_lsp.setup({
		init_options = {
			formatter = "rubocop",
			linters = { "rubocop" },
			enabledFeatures = {
				codeActions = false,
				codeLens = false,
				completion = true,
				definition = true,
				diagnostics = true,
				documentHighlights = false,
				documentLink = false,
				documentSymbols = true,
				foldingRanges = true,
				formatting = true,
				hover = true,
				inlayHint = false,
				onTypeFormatting = true,
				selectionRanges = false,
				semanticHighlighting = true,
				signatureHelp = true,
				typeHierarchy = true,
				workspaceSymbol = false
			},
			featuresConfiguration = {
				inlayHint = {
					implicitHashValue = true,
					implicitRescue = true
				}
			},
		},
	})
				
        lspconfig.ts_ls.setup({})

        lspconfig.gopls.setup({
          flags = { debounce_text_changes = 200 },
          settings = {
            gopls = {
              usePlaceholders = true,
              gofumpt = true,
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              experimentalPostfixCompletions = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-node_modules" },
              semanticTokens = true,
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        })
      end,
    },
})

----------------
--- SETTINGS ---
----------------

vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 30

vim.cmd.colorscheme 'catppuccin'

vim.opt.number = true        -- Show line numbers
vim.opt.showmatch = true     -- Highlight matching parenthesis
vim.opt.splitright = true    -- Split windows right to the current windows
vim.opt.splitbelow = true    -- Split windows below to the current windows
vim.opt.autowrite = true     -- Automatically save before :next, :make etc.

vim.opt.mouse = 'a'                -- Enable mouse support
-- vim.opt.clipboard = 'unnamedplus'  -- Copy/paste to system clipboard
vim.opt.swapfile = false           -- Don't use swapfile
vim.opt.ignorecase = true          -- Search case insensitive...
vim.opt.smartcase = true           -- ... but not it begins with upper case
vim.opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"

-- Indent Settings
vim.opt.expandtab = true  -- expand tabs into spaces
vim.opt.shiftwidth = 2    -- number of spaces to use for each step of indent.
vim.opt.tabstop = 2       -- number of spaces a TAB counts for
vim.opt.autoindent = true -- copy indent from current line when starting a new line
vim.opt.wrap = true

vim.opt.tw=120

-- Leader Key
vim.g.mapleader = ','

-- Git Stuff
vim.keymap.set('', '<leader>gs', ':Git<CR>')
vim.keymap.set('', '<leader>gb', ':Git blame<CR>')

-- Fast saving
vim.keymap.set('n', '<leader>w', ':write!<CR>')
vim.keymap.set('n', '<leader>q', ':q!<CR>', { silent = true })

-- Remove search highlight
vim.keymap.set('n', '<C-n>', ':nohlsearch<CR>')

-- Utilities
vim.keymap.set('', '<leader>hs', ':split<CR>')
vim.keymap.set('', '<leader>vs', ':vsplit<CR>')
vim.keymap.set('', '<leader>fw', ':StripWhitespace<CR>')
vim.keymap.set('', '<leader>tn', ':tabnew<CR>')
vim.keymap.set('', '<leader>tc', ':tabclose<CR>')

-- Source the current Vim file
vim.keymap.set('n', '<leader>pr', ':luafile %<CR>')

-- Better split switchlng
vim.keymap.set('', '<C-j>', '<C-W>j')
vim.keymap.set('', '<C-k>', '<C-W>k')
vim.keymap.set('', '<C-h>', '<C-W>h')
vim.keymap.set('', '<C-l>', '<C-W>l')

-- So we don't have to press shift when we want to get into command mode.
vim.keymap.set('n', ';', ':')
vim.keymap.set('v', ';', ':')

-- File-tree mappings
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true })
vim.keymap.set('n', '<leader>f', ':NvimTreeFindFileToggle<CR>', { noremap = true })

-- telescope
local builtin = require('telescope.builtin')
local function grep_cword()
  return builtin.grep_string()
end
local function grep_something()
  return builtin.live_grep()
end
vim.keymap.set('n', '<leader>p', builtin.find_files, {})
vim.keymap.set('n', '<leader>t', builtin.git_files, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', 'K', grep_cword, {})
vim.keymap.set('', '<leader>g', grep_something, {})
vim.keymap.set('', '<leader>a', ':Rg ', {})

-- copy file name to unamed register
vim.keymap.set('n', 'cp', ':let @*=expand("%")<CR>')
vim.keymap.set('n', 'yp', ':let @*=expand("%:p")<CR>')

-- Run Tests
vim.g["test#strategy"] = "neovim"
vim.g["test#ruby#use_binstubs"] = 1
vim.g["test#enabled_runners"] = { "ruby#rails", "go#gotest" }
vim.g["test#neovim#start_normal"] = 1
vim.g["test#neovim#term_position"] = "hor bo 15"

vim.keymap.set('', '<leader>r', ':TestNearest<CR>', { silent = true })
vim.keymap.set('n', '<leader>rf', ':TestFile<CR>', { silent = true })

-- Fix Whitespace
vim.g["strip_whitespace_on_save"] = 1
vim.g["strip_whitespace_confirm"] = 0

-- Copy and Paste
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy,
    ['*'] = require('vim.ui.clipboard.osc52').copy,
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste,
    ['*'] = require('vim.ui.clipboard.osc52').paste,
  },
}
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("osc52", { clear = true }),
  callback = function()
    -- vim.print(vim.v.event)
    if vim.v.operator == "y" then
      require("vim.ui.clipboard.osc52").copy("+")(vim.v.event.regcontents)
      -- require("osc52").copy_register("+")
    end
  end,
})

-- LSP
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'OP', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  end,
})

-- Navigation
vim.cmd([[
  nnoremap <silent> <C-h> <Cmd>TmuxNavigateLeft<CR>
  nnoremap <silent> <C-j> <Cmd>TmuxNavigateDown<CR>
  nnoremap <silent> <C-k> <Cmd>TmuxNavigateUp<CR>
  nnoremap <silent> <C-l> <Cmd>TmuxNavigateRight<CR>
  nnoremap <silent> <C-\> <Cmd>TmuxNavigateLastActive<CR>
  nnoremap <silent> <C-Space> <Cmd>TmuxNavigateNext<CR>
]])
