return {{
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
} , {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local gitsigns = require 'gitsigns'

        -- Utility function for mapping keybinds
        local function map(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr -- Bind to the current buffer
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- [[ Navigation ]]
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal { ']c', bang = true }
            else
                gitsigns.nav_hunk('next')
            end
        end, { desc = 'Jump to next git change' })

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal { '[c', bang = true }
            else
                gitsigns.nav_hunk('prev')
            end
        end, { desc = 'Jump to previous git change' })

        -- [[ Actions ]]
        -- Visual mode
        map('v', '<leader>hs', function()
            gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
        end, { desc = 'Stage selected git hunk' })

        map('v', '<leader>hr', function()
            gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
        end, { desc = 'Reset selected git hunk' })

        -- Normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Stage git hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset git hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Stage entire buffer' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Undo stage hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Reset entire buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview git hunk' })
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'Blame current line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Diff against index' })
        map('n', '<leader>hD', function()
            gitsigns.diffthis('@')
        end, { desc = 'Diff against last commit' })

        -- [[ Toggles ]]
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle blame line' })
        map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = 'Toggle deleted lines' })
    end
}, {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    keys = {
        { '<leader>lg', '<cmd>LazyGit<CR>', desc = 'Open LazyGit' },
    },
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
    },
} 
}