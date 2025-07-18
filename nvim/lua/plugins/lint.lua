return {
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('trouble').setup {
                position = 'bottom',       -- Position of the list (bottom, top, left, right)
                height = 10,               -- Height of the trouble list
                icons = {
                    error = "",
                    warning = "",
                    hint = "",
                    information = "",
                    other = "",
                },
                mode = 'diagnostics', -- Default mode (updated)
                fold_open = '',            -- Icon for open folds
                fold_closed = '',          -- Icon for closed folds
                group = true,              -- Group results by file
                padding = true,            -- Add padding between diagnostics
                action_keys = {
                    -- Key mappings for actions in the trouble list
                    close = 'q',           -- Close the list
                    cancel = '<esc>',      -- Cancel
                    refresh = 'r',         -- Refresh
                    jump = {'<cr>', '<tab>'}, -- Jump to the diagnostic
                    open_split = {'<c-x>'}, -- Open in horizontal split
                    open_vsplit = {'<c-v>'}, -- Open in vertical split
                    open_tab = {'<c-t>'},  -- Open in new tab
                    jump_close = {'o'},    -- Jump and close
                    toggle_mode = 'm',     -- Toggle between modes
                    toggle_preview = 'P',  -- Toggle preview
                    hover = 'K',           -- Hover
                    preview = 'p',         -- Preview
                    close_folds = {'zM', 'zm'}, -- Close all folds
                    open_folds = {'zR', 'zr'}, -- Open all folds
                    toggle_fold = {'zA', 'za'}, -- Toggle fold
                    previous = 'k',        -- Previous item
                    next = 'j'             -- Next item
                },
                auto_open = false,         -- Auto open list on errors
                auto_close = false,        -- Auto close when no more diagnostics
                auto_preview = true,       -- Auto preview
                auto_fold = false,         -- Auto fold
                use_diagnostic_signs = true -- Use diagnostic signs from your LSP
            }
            
            -- Keymaps to open Trouble in different modes
            vim.keymap.set('n', '<leader>xx', function() require('trouble').toggle() end, 
                { desc = 'Trouble: Toggle' })
            vim.keymap.set('n', '<leader>xw', function() require('trouble').toggle('diagnostics') end, 
                { desc = 'Trouble: Workspace Diagnostics' })
            vim.keymap.set('n', '<leader>xd', function() require('trouble').toggle('document') end, 
                { desc = 'Trouble: Document Diagnostics' })
            vim.keymap.set('n', '<leader>xl', function() require('trouble').toggle('loclist') end, 
                { desc = 'Trouble: Location List' })
            vim.keymap.set('n', '<leader>xq', function() require('trouble').toggle('quickfix') end, 
                { desc = 'Trouble: Quickfix List' })
            
            -- Navigate through errors
            vim.keymap.set('n', ']d', function() require('trouble').next({skip_groups = true, jump = true}) end, 
                { desc = 'Next Diagnostic' })
            vim.keymap.set('n', '[d', function() require('trouble').previous({skip_groups = true, jump = true}) end, 
                { desc = 'Previous Diagnostic' })
            
            -- Navigate to definitions and references
            vim.keymap.set('n', 'gR', function() require('trouble').toggle('lsp_references') end, 
                { desc = 'Go To References' })
        end
    },{
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local lint = require 'lint'
    
            -- Configure linters by filetype
            lint.linters_by_ft = {
                markdown = { 'markdownlint' },
            }
    
            -- Auto lint on specific events
            local lint_augroup = vim.api.nvim_create_augroup('LintAutogroup', { clear = true })
            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
        end
    },
} 