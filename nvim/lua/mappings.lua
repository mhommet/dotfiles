require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Select all with ctrl + a
map("n", "<C-a>", "ggVG", { noremap = true })
