local telescope = require('telescope')

local actions = require("telescope.actions")
telescope.setup{
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    prompt_prefix = "🔍️ ",
    mappings = {
      -- Esc to close while in insert mode
      i = {
        ["<esc>"] = actions.close
      },
    },
  },
  pickers = {
      find_files = {
        theme = "ivy",
      },
      buffers = {
        theme = "ivy",
      }
  },
}

telescope.load_extension('githubcoauthors')

-- Disable copilot in Telescope
vim.g.copilot_filetypes = vim.g.copilot_filetypes or {}
vim.g.copilot_filetypes["TelescopeResults"] = false

local map = vim.api.nvim_set_keymap
map("n", "<Leader>t", "<CMD>Telescope find_files<CR>", { noremap = true })
map("n", "<Leader>b", "<CMD>Telescope buffers<CR>", { noremap = true })
map("n", "<Leader>c", "<CMD>lua require('telescope').extensions.githubcoauthors.coauthors()<CR>", { noremap = true })
