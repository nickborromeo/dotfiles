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

        -- Project Tree
    {
      'nvim-tree/nvim-tree.lua',
      config = function()
        require("nvim-tree").setup({
          disable_netrw = true,
          sync_root_with_cwd = true,
          view = {
            width = 50,
          },
          renderer = {
            icons = {
              show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = false,
              },
            },
          },
          actions = {
            open_file = {
              quit_on_open = true,
            },
          }
        })
      end
    },

    -- lsp-config
    {
      "neovim/nvim-lspconfig",
      config = function ()
        util = require "lspconfig/util"

        local lspconfig = require('lspconfig')
        local cwd = vim.loop.cwd()
        local ruby_lsp_gemfile = ".ruby-lsp/Gemfile"
        local ruby_lsp_path = cwd .. ruby_lsp_gemfile

				lspconfig.ruby_lsp.setup({
          cmd = { "ruby-lsp" },
          cmd_env = {
            BUNDLE_GEMFILE = ruby_lsp_path,
          },
      		init_options = {
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

        -- lspconfig.sorbet.setup({
        --   cmd = { "bundle", "exec", "/workspaces/github/bin/srb", "tc", "--lsp" }
        -- })

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

vim.cmd.colorscheme 'catppuccin'

vim.opt.number = true        -- Show line numbers
vim.opt.showmatch = true     -- Highlight matching parenthesis
vim.opt.splitright = true    -- Split windows right to the current windows
vim.opt.splitbelow = true    -- Split windows below to the current windows
vim.opt.autowrite = true     -- Automatically save before :next, :make etc.
vim.opt.cursorline = true    -- Highlight current line

vim.opt.swapfile = false           -- Don't use swapfile
vim.opt.ignorecase = true          -- Search case insensitive...
vim.opt.smartcase = true           -- ... but not it begins with upper case

-- Visual settings
vim.opt.termguicolors = true                                           -- Enable 24-bit colors
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert', 'popup'}     -- Autocomplete options
vim.opt.showmatch = true                                               -- Highlight matching brackets
vim.opt.tw = 120

-- File handling
vim.opt.undofile = true                            -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")  -- Undo directory
vim.opt.autoread = true                            -- Auto reload files changed outside vim

-- Indent Settings
vim.opt.expandtab = true  -- expand tabs into spaces
vim.opt.shiftwidth = 2    -- number of spaces to use for each step of indent.
vim.opt.tabstop = 2       -- number of spaces a TAB counts for
vim.opt.autoindent = true -- copy indent from current line when starting a new line
vim.opt.wrap = true

-- Behavior settings
vim.opt.mouse = 'a'                         -- Enable mouse support
vim.opt.backspace = "indent,eol,start"      -- Better backspace behavior
vim.opt.clipboard:append("unnamedplus")     -- Use system clipboard

-- Borders
vim.o.winborder = 'rounded'

-- Leader Key
vim.g.mapleader = ','

-- Y to EOL
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })

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
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })


-- Terminal
vim.keymap.set('', '<leader>ot', ':split | terminal zsh<CR>')

-- Source the current Neovim file
vim.keymap.set('n', '<leader>pr', ':luafile %<CR>')

-- Better split switchlng
vim.keymap.set('', '<C-j>', '<C-W>j')
vim.keymap.set('', '<C-k>', '<C-W>k')
vim.keymap.set('', '<C-h>', '<C-W>h')
vim.keymap.set('', '<C-l>', '<C-W>l')

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- So we don't have to press shift when we want to get into command mode.
vim.keymap.set('n', ';', ':')
vim.keymap.set('v', ';', ':')

-- File-tree mappings
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFileToggle<CR>', { noremap = true })

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
vim.keymap.set('n', 'cp', ':let @*=expand("%")<CR>', { noremap = true, silent = true }) -- copy file name to unamed register
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("osc52", { clear = true }),
  callback = function()
    if vim.v.operator == "y" then
      require("vim.ui.clipboard.osc52").copy("+")(vim.v.event.regcontents)
    end
  end,
})

-- LSP
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    vim.keymap.set('n', '<C-i>', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'sd', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', '<leader>d', '<cmd>lua vim.diagnostic.setloclist()<cr>', opts)
    vim.keymap.set('i', '<Tab>', '<cmd>lua vim.lsp.completion.get()<cr>', opts)
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

-- ============================================================================
-- USEFUL FUNCTIONS
-- ============================================================================

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end


-- ============================================================================
-- FLOATING TERMINAL
-- ============================================================================

-- terminal
local terminal_state = {
  buf = nil,
  win = nil,
  is_open = false
}

local function FloatingTerminal()
  -- If terminal is already open, close it (toggle behavior)
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
    return
  end

  -- Create buffer if it doesn't exist or is invalid
  if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
    terminal_state.buf = vim.api.nvim_create_buf(false, true)
    -- Set buffer options for better terminal experience
    vim.api.nvim_buf_set_option(terminal_state.buf, 'bufhidden', 'hide')
  end

  -- Calculate window dimensions
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create the floating window
  terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Start terminal if not already running
  local has_terminal = false
  local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
  for _, line in ipairs(lines) do
    if line ~= "" then
      has_terminal = true
      break
    end
  end

  if not has_terminal then
    vim.fn.termopen(os.getenv("SHELL"))
  end

  terminal_state.is_open = true
  vim.cmd("startinsert")

  -- Set up auto-close on buffer leave
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = terminal_state.buf,
    callback = function()
      if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
      end
    end,
    once = true
  })
end

-- Function to explicitly close the terminal
local function CloseFloatingTerminal()
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end

-- Key mappings
vim.keymap.set("n", "<leader>ot", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", function()
  if terminal_state.is_open then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end, { noremap = true, silent = true, desc = "Close floating terminal from terminal mode" })
