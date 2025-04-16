return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {'NvimTree', 'Trouble', 'help'},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {
                    'branch',
                    {
                        'diff',
                        colored = true,
                        diff_color = {
                            added = { fg = "#98be65" },
                            modified = { fg = "#ecbe7b" },
                            removed = { fg = "#ec5f67" },
                        },
                        symbols = {added = '+', modified = '~', removed = '-'},
                    }
                },
                lualine_c = {
                    {
                        'filename',
                        file_status = true,
                        path = 1, -- Relative path
                        shorting_target = 40,
                        symbols = {
                            modified = ' ●',
                            readonly = ' ',
                            unnamed = '[No Name]',
                            newfile = '[New]',
                        }
                    },
                    {
                        'diagnostics',
                        sources = {'nvim_diagnostic'},
                        symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
                        diagnostics_color = {
                            error = { fg = "#ec5f67" },
                            warn = { fg = "#ecbe7b" },
                            info = { fg = "#008080" },
                            hint = { fg = "#98be65" },
                        },
                    }
                },
                lualine_x = {
                    {
                        function()
                            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
                            if #clients == 0 then return 'NO LSP' end
                            local names = {}
                            for _, client in ipairs(clients) do
                                table.insert(names, client.name)
                            end
                            return ' ' .. table.concat(names, ', ')
                        end,
                        icon = '',
                        color = { fg = '#b4befe' },
                    },
                    {
                        'filetype',
                        colored = true,
                        icon_only = false,
                        icon = { align = 'right' },
                    },
                    'encoding',
                    'fileformat',
                },
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
    end,
}

