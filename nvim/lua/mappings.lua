require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Save with Ctrl+S
map('n', '<C-s>', ':w<CR>', { noremap = true, desc = 'Save file' })

-- Select all
map('n', '<C-a>', 'ggVG', { noremap = true, desc = 'Select all' })

-- [[ Window Navigation ]]
map('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })

-- [[ Améliorer l'édition ]]
-- Déplacement de lignes
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Meilleure navigation dans les wraps
map("n", "j", "gj", { desc = "Down (wrapped)" })
map("n", "k", "gk", { desc = "Up (wrapped)" })

-- Effacer le highlight de recherche
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Override nvchad nvim-tree mappings completely
-- Force override the <leader>e mapping from nvchad after it loads
vim.schedule(function()
  pcall(vim.keymap.del, "n", "<leader>e")
  vim.keymap.set("n", "<leader>e", function()
    require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
  end, { desc = "Open mini.files (Directory of Current File)" })
end)
