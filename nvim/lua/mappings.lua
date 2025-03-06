require "nvchad.mappings"

local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Select all with ctrl + a
map("n", "<C-a>", "ggVG", { noremap = true })

-- Toggle Tree with space + t
map("n", "<space>t", ":NvimTreeToggle<CR>", { noremap = true })

-- Find file with space + space
map("n", "<space><space>", ":Telescope find_files<CR>", { noremap = true })

-- Live grep with space + f + g
map("n", "<space>fg", ":Telescope live_grep<CR>", { noremap = true })
