require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Save with Ctrl+S
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, desc = 'Save file' })

-- Select all
vim.keymap.set('n', '<C-a>', 'ggVG', { noremap = true, desc = 'Select all' })

-- [[ Window Navigation ]]
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })

-- Override nvchad nvim-tree mappings completely
-- Force override the <leader>e mapping from nvchad after it loads
vim.schedule(function()
  pcall(vim.keymap.del, "n", "<leader>e")
  vim.keymap.set("n", "<leader>e", function()
    require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
  end, { desc = "Open mini.files (Directory of Current File)" })
end)
