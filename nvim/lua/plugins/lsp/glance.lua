return {
    {
        'dnlhc/glance.nvim',
        config = function()
            local glance = require('glance')
            local actions = glance.actions
            
            glance.setup({
                height = 18, -- Height of the window
                zindex = 45,
                
                -- Mappings inside the window
                mappings = {
                    list = {
                        ['j'] = actions.next,
                        ['k'] = actions.previous,
                        ['<C-u>'] = actions.preview_scroll_win(5),
                        ['<C-d>'] = actions.preview_scroll_win(-5),
                        ['v'] = actions.jump_vsplit,
                        ['s'] = actions.jump_split,
                        ['t'] = actions.jump_tab,
                        ['<CR>'] = actions.jump,
                        ['o'] = actions.jump,
                        ['<leader>l'] = actions.enter_win('preview'),
                        ['q'] = actions.close,
                        ['Q'] = actions.close,
                        ['<Esc>'] = actions.close,
                    },
                    preview = {
                        ['q'] = actions.close,
                        ['Q'] = actions.close,
                        ['<Esc>'] = actions.close,
                        ['<leader>l'] = actions.enter_win('list'),
                    },
                },
                
                -- List with borders, preview without borders
                border = {
                    enable = true,
                    top_char = '─',
                    bottom_char = '─',
                    right_char = '│',
                    left_char = '│',
                    top_left_char = '╭',
                    top_right_char = '╮',
                    bottom_left_char = '╰',
                    bottom_right_char = '╯',
                },
                
                -- Appearance
                theme = { -- Custom style
                    enable = true,
                    mode = 'auto',
                },
                
                -- Results order
                folds = {
                    fold_closed = '›',
                    fold_open = '⤵',
                    folded = true,
                },
                
                -- Type-specific options
                hooks = {
                    before_open = function(results, open, jump, method)
                        if #results == 1 then
                            jump(results[1]) -- Go directly to the result if there's only one
                        else
                            open(results) -- Otherwise, open the Glance window
                        end
                    end,
                },
                
                -- Type-specific options
                lists = {
                    -- Configuration for references
                    references = {
                        prompt_title = 'References',
                    },
                    -- Configuration for definitions
                    definitions = {
                        prompt_title = 'Definitions',
                    },
                    -- Configuration for implementations
                    implementations = {
                        prompt_title = 'Implementations',
                    },
                    -- Configuration for type definitions
                    type_definitions = {
                        prompt_title = 'Type Definitions',
                    },
                },
            })
            
            -- Keymaps to replace default LSP commands
            vim.keymap.set('n', 'gd', '<CMD>Glance definitions<CR>', { desc = 'Glance Definitions' })
            vim.keymap.set('n', 'gr', '<CMD>Glance references<CR>', { desc = 'Glance References' })
            vim.keymap.set('n', 'gD', '<CMD>Glance type_definitions<CR>', { desc = 'Glance Type Definitions' })
            vim.keymap.set('n', 'gI', '<CMD>Glance implementations<CR>', { desc = 'Glance Implementations' })
        end
    }
} 