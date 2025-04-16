return {
    {
        'rcarriga/nvim-notify',
        config = function()
            local notify = require('notify')
            notify.setup({
                -- Animation style
                stages = 'fade_in_slide_out',
                -- Default display duration for notifications
                timeout = 3000,
                -- Notification limits
                max_width = 80,
                max_height = 20,
                -- Background opacity (fix for warnings)
                background_colour = "#000000",
                -- Icons for notification levels (requires Nerd Font)
                icons = {
                    ERROR = '',
                    WARN = '',
                    INFO = '',
                    DEBUG = '',
                    TRACE = '✎',
                },
                -- Set minimum width
                minimum_width = 50,
                -- Add render options
                render = "default",
                -- Add top_down option
                top_down = true,
            })
            
            -- Store the original notify function for Noice to use later
            vim._original_notify = notify
        end,
    },
    {
        'folke/noice.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
        config = function()
            require('noice').setup({
                lsp = {
                    -- Override LSP message system
                    override = {
                        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                        ['vim.lsp.util.stylize_markdown'] = true,
                        ['cmp.entry.get_documentation'] = true,
                    },
                    -- Display signatures in insert mode
                    signature = {
                        enabled = true,
                    },
                    -- Display progress messages
                    progress = {
                        enabled = true,
                    },
                    -- Display hover information
                    hover = {
                        enabled = true,
                    },
                },
                -- Configure message popups
                messages = {
                    enabled = true,
                    view = 'notify',
                    view_error = 'notify',
                    view_warn = 'notify',
                    view_history = 'messages',
                    view_search = 'virtualtext',
                },
                -- Command line at the bottom
                cmdline = {
                    enabled = true,
                    view = 'cmdline',
                    format = {
                        cmdline = { icon = '>' },
                        search_down = { icon = '🔍⌄' },
                        search_up = { icon = '🔍⌃' },
                        filter = { icon = '$' },
                        lua = { icon = '☾' },
                        help = { icon = '?' },
                    },
                },
                -- Configure notifications - IMPORTANT: Disable overriding of vim.notify
                notify = {
                    enabled = false, -- Disable Noice's notification system override
                    view = 'notify',
                },
                -- More subtle popupmenu
                popupmenu = {
                    enabled = true,
                    backend = 'nui',
                },
                -- Search history
                routes = {
                    {
                        filter = {
                            event = 'msg_show',
                            find = 'written',
                        },
                        opts = { skip = true },
                    },
                    -- Filter out "hls module not available" messages
                    {
                        filter = {
                            event = 'msg_show',
                            find = 'hls module not available',
                        },
                        opts = { skip = true },
                    },
                },
                -- Hide ~ messages at end of buffer
                views = {
                    cmdline = {
                        position = {
                            row = -1,
                            col = 0,
                        },
                        size = {
                            width = "100%",
                            height = "auto",
                        },
                    },
                    mini = {
                        win_options = {
                            winblend = 0,
                        },
                    },
                },
                -- Quiet mode presets
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                    inc_rename = true,
                },
            })
            
            -- Keymaps for notification and command history
            vim.keymap.set("n", "<leader>fn", function()
                require("noice").cmd("telescope")
            end, { desc = "Noice Telescope" })
            
            vim.keymap.set("n", "<leader>nl", function()
                require("noice").cmd("last")
            end, { desc = "Noice Last Message" })
            
            vim.keymap.set("n", "<leader>nh", function()
                require("noice").cmd("history")
            end, { desc = "Noice History" })
            
            vim.keymap.set("n", "<leader>nd", function()
                require("noice").cmd("dismiss")
            end, { desc = "Dismiss All" })
        end,
    }
} 