return {{
    'goolord/alpha-nvim',
    lazy = false, -- Dashboard must be loaded immediately for the welcome screen
    priority = 900, -- Priority just after the theme
    dependencies = {{
        'nvim-tree/nvim-web-devicons',
        lazy = true,
        module = true
    }, {
        'rcarriga/nvim-notify',
        lazy = true,
        module = true,
        init = function()
            -- Store the real notify until alpha is loaded
            if not vim._original_notify then
                vim._original_notify = vim.notify
            end

            -- Use a basic notify function until nvim-notify is loaded
            vim.notify = function(msg, level, opts)
                if vim._original_notify then
                    return vim._original_notify(msg, level, opts)
                else
                    return vim.api.nvim_echo({{msg, level or "INFO"}}, true, {})
                end
            end
        end
    }},
    config = function()
        -- We don't need to suppress errors here as Noice was configured to filter them
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.config.layout = {{
            type = "padding",
            val = 1
        }, dashboard.section.header, {
            type = "padding",
            val = 2
        }, dashboard.section.buttons, {
            type = "padding",
            val = 1
        }, dashboard.section.footer}

        -- ASCII Art Logo
        local art = {[[]], [[                      ██████                     ]],
                     [[                  ████▒▒▒▒▒▒████                 ]],
                     [[                ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██               ]],
                     [[              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██             ]],
                     [[            ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒               ]],
                     [[            ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓           ]],
                     [[            ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓           ]],
                     [[          ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██         ]],
                     [[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
                     [[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
                     [[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
                     [[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
                     [[          ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██         ]],
                     [[          ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██         ]],
                     [[          ██      ██      ████      ████         ]],
                     [[                                                 ]], [[]]}

        local centered_art = {}
        for _ = 1, 3 do
            table.insert(centered_art, "")
        end
        for _, line in ipairs(art) do
            table.insert(centered_art, line)
        end
        dashboard.section.header.val = centered_art

        -- Navigation Buttons with Emojis
        dashboard.section.buttons.val = {dashboard.button("f", "🔍  Find File", ":Telescope find_files<CR>"),
                                         dashboard.button("e", "✨  New File", ":ene <BAR> startinsert<CR>"),
                                         dashboard.button("r", "🕒  Recent Files", ":Telescope oldfiles<CR>"),
                                         dashboard.button("t", "🔎  Find Text", ":Telescope live_grep<CR>"),
                                         dashboard.button("c", "⚙️   Configuration", ":e $MYVIMRC <CR>"),
                                         dashboard.button("l", "📦  Lazy", ":Lazy<CR>"),
                                         dashboard.button("q", "🚪  Quit", ":qa<CR>")}

        -- Footer with system info and plugins
        local function footer()
            -- Neovim version, time and date
            local version = vim.version()
            local nvim_version = string.format("Neovim %d.%d.%d", version.major, version.minor, version.patch)

            -- Startup time (safe fallback)
            local startup_time = "N/A"
            if vim.g.startuptime_start then
                startup_time = string.format("%.2f", vim.fn.reltimefloat(vim.fn.reltime(vim.g.startuptime_start)))
            end

            -- Get plugin statistics from lazy.nvim
            local stats = require("lazy").stats()
            local plugins_loaded = stats.loaded
            local plugins_total = stats.count
            local plugins_startuptime = string.format("%.2f", stats.startuptime)

            -- Format with plugins info
            local footer_text = string.format(" %s | Started in %s ms | Plugins: %d/%d loaded in %s ms ", nvim_version,
                startup_time, plugins_loaded, plugins_total, plugins_startuptime)

            return footer_text
        end

        dashboard.section.footer.val = footer()
        dashboard.section.footer.opts.hl = "AlphaFooter"

        -- Configure Alpha
        alpha.setup(dashboard.opts)

        -- Auto-command to update footer when all plugins are loaded
        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                dashboard.section.footer.val = footer()
                pcall(vim.cmd.AlphaRedraw)
            end
        })

        -- Load nvim-notify lazily after Alpha is done
        vim.defer_fn(function()
            require("lazy").load({
                plugins = {"nvim-notify"}
            })
            if vim._original_notify then
                vim.notify = vim._original_notify
            end
        end, 500)
    end
}, {
    'yamatsum/nvim-cursorline',
    config = function()
        require('nvim-cursorline').setup {
            cursorline = {
                enable = true,
                timeout = 1000,
                number = false
            },
            cursorword = {
                enable = true,
                min_length = 3,
                hl = {
                    underline = true
                }
            }
        }
    end
}, {
    'nvim-lualine/lualine.nvim',
    lazy = true,
    event = 'UIEnter',
    dependencies = {{
        'nvim-tree/nvim-web-devicons',
        lazy = true
    }},
    config = function()
        vim.defer_fn(function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = {
                        left = '',
                        right = ''
                    },
                    section_separators = {
                        left = '',
                        right = ''
                    },
                    disabled_filetypes = {
                        statusline = {'NvimTree', 'Trouble', 'help'},
                        winbar = {}
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000
                    }
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', {
                        'diff',
                        colored = true,
                        diff_color = {
                            added = {
                                fg = "#98be65"
                            },
                            modified = {
                                fg = "#ecbe7b"
                            },
                            removed = {
                                fg = "#ec5f67"
                            }
                        },
                        symbols = {
                            added = '+',
                            modified = '~',
                            removed = '-'
                        }
                    }},
                    lualine_c = {{
                        'filename',
                        file_status = true,
                        path = 1, -- Relative path
                        shorting_target = 40,
                        symbols = {
                            modified = ' ●',
                            readonly = ' ',
                            unnamed = '[No Name]',
                            newfile = '[New]'
                        }
                    }, {
                        'diagnostics',
                        sources = {'nvim_diagnostic'},
                        symbols = {
                            error = ' ',
                            warn = ' ',
                            info = ' ',
                            hint = ' '
                        },
                        diagnostics_color = {
                            error = {
                                fg = "#ec5f67"
                            },
                            warn = {
                                fg = "#ecbe7b"
                            },
                            info = {
                                fg = "#008080"
                            },
                            hint = {
                                fg = "#98be65"
                            }
                        }
                    }},
                    lualine_x = {{
                        function()
                            local clients = vim.lsp.get_active_clients({
                                bufnr = 0
                            })
                            if #clients == 0 then
                                return 'NO LSP'
                            end
                            local names = {}
                            for _, client in ipairs(clients) do
                                table.insert(names, client.name)
                            end
                            return ' ' .. table.concat(names, ', ')
                        end,
                        icon = '',
                        color = {
                            fg = '#b4befe'
                        }
                    }, {
                        'filetype',
                        colored = true,
                        icon_only = false,
                        icon = {
                            align = 'right'
                        }
                    }, 'encoding', 'fileformat'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {'nvim-tree', 'trouble', 'mason', 'lazy'}
            }
        end, 50)
    end
}, {
    'rcarriga/nvim-notify',
    lazy = true,
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
                TRACE = '✎'
            },
            -- Set minimum width
            minimum_width = 50,
            -- Add render options
            render = "default",
            -- Add top_down option
            top_down = true
        })

        -- Store the original notify function for Noice to use later
        vim._original_notify = notify
    end
}, {
    'folke/noice.nvim',
    event = "VeryLazy",
    cmd = {"NoiceEnable", "NoiceDisable", "NoiceToggle", "NoiceErrors", "NoiceLast", "NoiceTelescope"},
    keys = {{
        "<leader>fn",
        function()
            require("noice").cmd("telescope")
        end,
        desc = "Noice Telescope"
    }, {
        "<leader>nl",
        function()
            require("noice").cmd("last")
        end,
        desc = "Noice Last Message"
    }, {
        "<leader>nh",
        function()
            require("noice").cmd("history")
        end,
        desc = "Noice History"
    }, {
        "<leader>nd",
        function()
            require("noice").cmd("dismiss")
        end,
        desc = "Dismiss All"
    }},
    dependencies = {'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify', 'hrsh7th/nvim-cmp' -- Need cmp for cmdline
    },
    config = function()
        require('noice').setup({
            lsp = {
                -- Override LSP message system
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true
                },
                -- Display signatures in insert mode
                signature = {
                    enabled = true
                },
                -- Display progress messages
                progress = {
                    enabled = true
                },
                -- Display hover information
                hover = {
                    enabled = true
                }
            },
            -- Configure message popups
            messages = {
                enabled = true,
                view = 'notify',
                view_error = 'notify',
                view_warn = 'notify',
                view_history = 'messages',
                view_search = 'virtualtext'
            },
            -- Command line at the bottom
            cmdline = {
                enabled = true,
                view = 'cmdline',
                format = {
                    cmdline = {
                        icon = '>'
                    },
                    search_down = {
                        icon = '🔍⌄'
                    },
                    search_up = {
                        icon = '🔍⌃'
                    },
                    filter = {
                        icon = '$'
                    },
                    lua = {
                        icon = '☾'
                    },
                    help = {
                        icon = '?'
                    }
                }
            },
            -- Configure notifications - IMPORTANT: Disable overriding of vim.notify
            notify = {
                enabled = false, -- Disable Noice's notification system override
                view = 'notify'
            },
            -- More subtle popupmenu
            popupmenu = {
                enabled = true,
                backend = 'nui'
            },
            -- Search history
            routes = {{
                filter = {
                    event = 'msg_show',
                    find = 'written'
                },
                opts = {
                    skip = true
                }
            }, -- Filter out "hls module not available" messages
            {
                filter = {
                    event = 'msg_show',
                    find = 'hls module not available'
                },
                opts = {
                    skip = true
                }
            }},
            -- Hide ~ messages at end of buffer
            views = {
                cmdline = {
                    position = {
                        row = -1,
                        col = 0
                    },
                    size = {
                        width = "100%",
                        height = "auto"
                    }
                },
                mini = {
                    win_options = {
                        winblend = 0
                    }
                }
            },
            -- Quiet mode presets
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true
            }
        })
    end
}, {
    'petertriho/nvim-scrollbar',
    dependencies = {'lewis6991/gitsigns.nvim', -- Optional for git integration
    'kevinhwang91/nvim-hlslens' -- Add hlslens for better search experience
    },
    config = function()
        -- Configure hlslens first
        require('hlslens').setup({
            calm_down = true,
            nearest_only = false,
            nearest_float_when = 'always'
        })

        -- Setup scrollbar with hlslens integration
        require("scrollbar").setup({
            show = true,
            handle = {
                text = " ",
                color = "#504945",
                hide_if_all_visible = true
            },
            marks = {
                Search = {
                    color = "#fe8019"
                },
                Error = {
                    color = "#fb4934"
                },
                Warn = {
                    color = "#fabd2f"
                },
                Info = {
                    color = "#83a598"
                },
                Hint = {
                    color = "#8ec07c"
                },
                Misc = {
                    color = "#d3869b"
                }
            },
            excluded_filetypes = {"prompt", "TelescopePrompt", "noice", "NvimTree", "alpha"},
            autocmd = {
                render = {"BufWinEnter", "TabEnter", "TermEnter", "WinEnter", "CmdwinLeave", "TextChanged",
                          "VimResized", "WinScrolled"}
            },
            handlers = {
                diagnostic = true,
                search = true,
                gitsigns = true -- Requires gitsigns
            }
        })

        -- Add keymaps for hlslens (optional but recommended)
        vim.api.nvim_set_keymap('n', 'n',
            [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], {
                noremap = true,
                silent = true
            })
        vim.api.nvim_set_keymap('n', 'N',
            [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], {
                noremap = true,
                silent = true
            })
        vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], {
            noremap = true,
            silent = true
        })
        vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], {
            noremap = true,
            silent = true
        })
        vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], {
            noremap = true,
            silent = true
        })
        vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], {
            noremap = true,
            silent = true
        })
    end
}, {
    'folke/which-key.nvim',
    keys = {"<leader>", "[", "]", "g"},
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        require('which-key').setup({
            plugins = {
                presets = {
                    operators = false,
                    motions = false
                }
            }
        })
        require('which-key').add {{
            '<leader>d',
            group = 'Document'
        }, {
            '<leader>r',
            group = 'Refactor'
        }, {
            '<leader>s',
            group = 'Search'
        }, {
            '<leader>w',
            group = 'Workspace'
        }, {
            '<leader>t',
            group = 'Toggle'
        }, {
            '<leader>h',
            group = 'Git Hunk',
            mode = {'n', 'v'}
        }, {
            '<leader>x',
            group = 'Trouble',
            desc = 'Diagnostics'
        }, {
            '<leader>f',
            group = 'Find/File'
        }, {
            '<leader>b',
            group = 'Buffer'
        }, {
            '<leader>c',
            group = 'Code'
        }, {
            '<leader>g',
            group = 'Git'
        }, {
            '<leader>l',
            group = 'LSP'
        }, {
            '<leader>n',
            group = 'Notifications'
        }, {
            '<leader>p',
            group = 'Project'
        }, {
            '<leader>q',
            group = 'Quickfix'
        }, {
            '[',
            group = 'Previous'
        }, {
            ']',
            group = 'Next'
        }, {
            'g',
            group = 'Go To'
        }}
    end
}}
