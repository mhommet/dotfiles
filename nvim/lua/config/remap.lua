-- Save with Ctrl+S
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, desc = 'Save file' })

-- [[ Basic Keymaps ]]
-- Set highlight on search, but clear it with <Esc>
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Select all
vim.keymap.set('n', '<C-a>', 'ggVG', { noremap = true, desc = 'Select all' })

-- [[ Diagnostic Keymaps ]]
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

-- [[ Window Navigation ]]
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })

-- [[ RipSubstitute ]]
vim.keymap.set('n', '<leader>rr', ':RipSubstitute<CR>', { desc = 'RipSubstitute' })

