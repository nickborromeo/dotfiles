local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

----------------
--- plugins ---
----------------
require("lazy").setup({

    -- colorscheme
    { "ellisonleao/gruvbox.nvim", priority = 1000 },

    -- lualine
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function ()
        require("lualine").setup({
            options = { 
              icons_enabled = false,
              theme = 'gruvbox' 
            },
 
            sections = {
              lualine_a = {'mode'},
              lualine_b = {'branch', 'diff'},
              lualine_c = {'filename'},
              lualine_x = {},
              lualine_y = {},
              lualine_z = {'encoding', 'fileformat', 'filetype'},
            },
          })
      end,
    },

    -- file explorer
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require("nvim-tree").setup({
          disable_netrw = true,
          hijack_netrw = true,
          actions = {
            open_file = {
              quit_on_open = true,
            },
          },
          renderer = {
            icons = {
              webdev_colors = false,
              git_placement = "before",
              modified_placement = "after",
              padding = " ",
              symlink_arrow = " ➛ ",
              show = {
                file = false,
                folder = false,
                folder_arrow = true,
                git = true,
                modified = true,
              },
            },
          },
          sort_by = "case_sensitive",
          filters = {
            dotfiles = true,
          },
          update_focused_file = {
            enable = true,
            update_cwd = false,
          },
        })
      end,
    },

    -- commenting out lines
    {
      "numToStr/Comment.nvim",
      config = function()
        require('Comment').setup()
      end
    },

    -- fzf extension for telescope with better speed
    {
      "nvim-telescope/telescope-fzf-native.nvim", run = 'make'
    },

    {'nvim-telescope/telescope-ui-select.nvim' },

    -- fuzzy finder framework
    {
      "nvim-telescope/telescope.nvim",
      tag = '0.1.1',
      dependencies = {
        "nvim-lua/plenary.nvim" ,
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
      },
      config = function ()
        require("telescope").setup({
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

    -- Alternate between files, such as foo.go and foo_test.go
    {
      "rgroli/other.nvim",
      keys = {
        { ":A", "<cmd>Other<cr>", {noremap = true, silent = true}},
        { ":AV", "<cmd>OtherVSplit<cr>", {noremap = true, silent = true}},
        { ":AS", "<cmd>OtherSplit<cr>", {noremap = true, silent = true}},
      },
      config = function ()
        require("other-nvim").setup({
            mappings = {
              "rails", --builtin mapping
              {
                pattern = "(.*).go$",
                target = "%1_test.go",
                context = "test",
              },
              {
                pattern = "(.*)_test.go$",
                target = "%1.go",
                context = "file",
              },
            },
          })
      end,
    },

    -- Highlight, edit, and navigate code
    {
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      build = ":TSUpdate",
      config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = { 'go', 'gomod', 'lua', 'ruby', 'vimdoc', 'vim', 'bash' },
            indent = { enable = true },
            incremental_selection = {
              enable = true,
              keymaps = {
                init_selection = "<space>", -- maps in normal mode to init the node/scope selection with enter
                node_incremental = "<space>", -- increment to the upper named parent
                node_decremental = "<bs>", -- decrement to the previous node
                scope_incremental = "<tab>", -- increment to the upper scope (as defined in locals.scm)
              },
            },
            autopairs = {
              enable = true,
            },
            textobjects = {
              select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                  -- You can use the capture groups defined in textobjects.scm
                  ['aa'] = '@parameter.outer',
                  ['ia'] = '@parameter.inner',
                  ['af'] = '@function.outer',
                  ['if'] = '@function.inner',
                  ['ac'] = '@class.outer',
                  ['ic'] = '@class.inner',
                  ["iB"] = "@block.inner",
                  ["aB"] = "@block.outer",
                },
              },
              move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                  [']]'] = '@function.outer',
                },
                goto_next_end = {
                  [']['] = '@function.outer',
                },
                goto_previous_start = {
                  ['[['] = '@function.outer',
                },
                goto_previous_end = {
                  ['[]'] = '@function.outer',
                },
              },
              swap = {
                enable = true,
                swap_next = {
                  ['<leader>a'] = '@parameter.inner',
                },
                swap_previous = {
                  ['<leader>A'] = '@parameter.inner',
                },
              },
            },
          })
      end,
    },

    {
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup {
          check_ts = true,
        }
      end
    },

    -- autocompletion
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")

        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        luasnip.config.setup {}

        require('cmp').setup({
            snippet = {
              expand = function(args)
                luasnip.lsp_expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert {
              ['<C-n>'] = cmp.mapping.select_next_item(),
              ['<C-p>'] = cmp.mapping.select_prev_item(),
              ['<C-d>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<CR>'] = cmp.mapping.confirm { select = true },
              ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
        },
        window = {
          documentation = cmp.config.window.bordered(),
        },
        view = {
          entries = {
            name = "custom",
            selection_order = "near_cursor",
          },
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Insert,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = "luasnip" },
          { name = "buffer", keyword_length = 5 },
          { name = "path" },
        },
      })

    require('cmp').setup.cmdline("/", {
        sources = cmp.config.sources({
            { name = "nvim_lsp_document_symbol" },
          }, {
            { name = "buffer" },
          }),
      })

    require('cmp').setup.cmdline(":", {
        sources = cmp.config.sources({
            { name = "path" },
          }, {
            { name = "cmdline" },
          }),
      })
  end,
},

-- TPope Stuff
{ "tpope/vim-fugitive" },
{ "tpope/vim-surround" },
{ "tpope/vim-endwise" },

-- Codespaces Copy
{ "ojroques/vim-oscyank" },

-- Testing
{ "vim-test/vim-test" },

-- Ripgrep
{ "jremmen/vim-ripgrep" },

})

----------------
--- SETTINGS ---
----------------

-- disable netrw at the very start of our init.lua, because we use nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true -- Enable 24-bit RGB colors

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

vim.opt.number = true        -- Show line numbers
vim.opt.showmatch = true     -- Highlight matching parenthesis
vim.opt.splitright = true    -- Split windows right to the current windows
vim.opt.splitbelow = true    -- Split windows below to the current windows
vim.opt.autowrite = true     -- Automatically save before :next, :make etc.

vim.opt.mouse = 'a'                -- Enable mouse support
vim.opt.clipboard = 'unnamed'  -- Copy/paste to system clipboard
vim.opt.swapfile = false           -- Don't use swapfile
vim.opt.ignorecase = true          -- Search case insensitive...
vim.opt.smartcase = true           -- ... but not it begins with upper case
vim.opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"

-- Indent Settings
-- I'm in the Spaces camp (sorry Tabs folks), so I'm using a combination of
-- settings to insert spaces all the time.
vim.opt.expandtab = true  -- expand tabs into spaces
vim.opt.shiftwidth = 2    -- number of spaces to use for each step of indent.
vim.opt.tabstop = 2       -- number of spaces a TAB counts for
vim.opt.autoindent = true -- copy indent from current line when starting a new line
vim.opt.wrap = true

vim.opt.tw=120
-- vim.opt.colorcolumn=120

-- This comes first, because we have mappings that depend on leader
-- With a map leader it's possible to do extra key combinations
-- i.e: <leader>w saves the current filek
vim.g.mapleader = ','

-- Git Stuff
vim.keymap.set('', '<leader>gs', ':Git<CR>')
vim.keymap.set('', '<leader>gb', ':Git blame<CR>')
vim.keymap.set('', '<leader>gh', ':GBrowse<CR>')

-- Fast saving
vim.keymap.set('n', '<leader>w', ':write!<CR>')
vim.keymap.set('n', '<leader>q', ':q!<CR>', { silent = true })

-- Remove search highlight
vim.keymap.set('n', '<C-n>', ':nohlsearch<CR>')

-- Search under cursor
vim.keymap.set('n', 'K', ':Rg <C-R><C-W><CR>')

-- Utilities
vim.keymap.set('', '<leader>hs', ':split<CR>')
vim.keymap.set('', '<leader>vs', ':vsplit<CR>')
vim.keymap.set('', '<leader>a', ':Rg')
vim.keymap.set('', '<leader>fw', ':FixWhitespace<CR>')
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

-- Yanking a line should act like D and C
vim.keymap.set('n', 'Y', 'y$')

-- File-tree mappings
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true })
vim.keymap.set('n', '<leader>f', ':NvimTreeFindFileToggle<CR>', { noremap = true })

-- telescope
local builtin = require('telescope.builtin')
local function grep_cword()
  return builtin.grep_string({cwd = "%:p:h"})
end
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>t', builtin.git_files, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', 'K', grep_cword, {})

-- copy file name to unamed register
vim.keymap.set('n', 'cp', ':let @*=expand("%")<CR>')
vim.keymap.set('n', 'yp', ':let @*=expand("%:p")<CR>')

-- Run Tests
vim.g["test#strategy"] = "neovim"
vim.g["test#ruby#use_binstubs"] = 1
vim.g["test#enabled_runners"] = { "ruby#rails" }
vim.g["test#neovim#start_normal"] = 1
vim.g["test#neovim#term_position"] = "hor bo 15"

vim.keymap.set('', '<leader>r', ':TestNearest<CR>', { silent = true })
vim.keymap.set('n', '<leader>rf', ':TestFile<CR>', { silent = true })

-- Yanking in SSH session
vim.cmd([[
  autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankRegister "' | endif
]])
vim.g.oscyank_max_length = 1000000
vim.g.oscyank_silent = 'v:true'
vim.g.oscyank_term = 'default'
