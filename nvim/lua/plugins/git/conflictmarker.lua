return {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = function()
        require('git-conflict').setup({
            default_mappings = true,        -- Disable default mappings
            default_commands = true,        -- Disable default commands
            disable_diagnostics = false,    -- Enable diagnostics integration
            highlights = {                  -- Customize highlight groups
                incoming = 'DiffAdd',
                current = 'DiffText',
            },
            debug = false,                  -- Enable debug logging
        })
        
        -- Mappings for conflict resolution
        vim.keymap.set('n', 'co', '<Plug>(git-conflict-ours)', { desc = 'Choose ours' })
        vim.keymap.set('n', 'ct', '<Plug>(git-conflict-theirs)', { desc = 'Choose theirs' })
        vim.keymap.set('n', 'cb', '<Plug>(git-conflict-both)', { desc = 'Choose both' })
        vim.keymap.set('n', 'c0', '<Plug>(git-conflict-none)', { desc = 'Choose none' })
        vim.keymap.set('n', ']x', '<Plug>(git-conflict-next-conflict)', { desc = 'Next conflict' })
        vim.keymap.set('n', '[x', '<Plug>(git-conflict-prev-conflict)', { desc = 'Previous conflict' })
        vim.keymap.set('n', '<leader>cL', '<cmd>GitConflictListQf<CR>', { desc = 'List all conflicts' })
    end
} 