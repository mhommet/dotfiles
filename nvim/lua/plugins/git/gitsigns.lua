return {
    'lewis6991/gitsigns.nvim',
    opts = {
        on_attach = function(bufnr)
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
        end,
    },
} 