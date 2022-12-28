local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Leader Key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Utilities
keymap("n", "<leader>hs", ":split<CR>", opts)
keymap("n", "<leader>vs", ":vsplit<CR>", opts)
keymap("n", "<leader>a",  ":Rg ", {})
keymap("n", "<leader>fw", ":FixWhitespace<CR>", opts)
keymap("n", "<leader>tn", ":tabnew<CR>", opts)
keymap("n", "<leader>tc", ":tabclose<CR>", opts)
keymap("n", ";", ":", {})
keymap("n", "<C-n>", ":silent! nohls<cr>", opts)
keymap("v", ";", ":", {})
keymap("v", "p", '"_dP', opts) -- remembers the yanked items when pasting

-- Git Stuff
keymap("n", "<leader>gs", ":Git<CR>", opts)
keymap("n", "<leader>gb", ":Git blame<CR>", opts)
keymap("n", "<leader>gh", ":GBrowse<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- File Navigator
keymap("n", "<leader>ft", ":Lex<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

--
-- Vimux
keymap("n", "<leader>op", ":VimuxRunCommand('')<CR>", opts)
keymap("n", "<leader>cp", ":VimuxCloseRunner<CR>", opts)
keymap("n", "<leader>vc", ":VimuxPromptCommand<CR>", opts)

-- Running Tests
keymap("n", "<leader>r", ":TestNearest<CR>", opts)
keymap("n", "<leader>rf", ":TestFile<CR>", opts)

-- Search under cursor
keymap("n", "<S-k>", ":Rg <C-R><C-W><CR>", opts)

-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
