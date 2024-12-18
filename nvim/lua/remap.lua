-- Save with ctrl+s
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', {
    noremap = true,
})

-- [[ Basic Keymaps ]]
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Select all
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG', {
    noremap = true,
})

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {
    desc = 'Open diagnostic [Q]uickfix list',
})

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', {
    desc = 'Move focus to the left window',
})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', {
    desc = 'Move focus to the right window',
})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', {
    desc = 'Move focus to the lower window',
})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', {
    desc = 'Move focus to the upper window',
})

-- Pointage command (At work only)
vim.api.nvim_set_keymap('n', '<leader>p', ':Pointage<Space>', {
    noremap = true,
    silent = false
})
vim.api.nvim_set_keymap('n', '<leader>pt', ':Pointage time<CR>', {
    noremap = true,
    silent = false
})
vim.api.nvim_set_keymap('n', '<leader>pe', ':Pointage entree<CR>', {
    noremap = true,
    silent = false
})
vim.api.nvim_set_keymap('n', '<leader>ps', ':Pointage sortie<CR>', {
    noremap = true,
    silent = false
})

-- RipSubstitute
vim.keymap.set("n", "<leader>rr", ":RipSubstitute<CR>")

