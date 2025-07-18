return {{
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
                  theme = "auto",
                  component_separators = '',
                  section_separators = { left = '', right = '' },
                },
                sections = {
                  lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                  lualine_b = { 'filename', 'branch' },
                  lualine_c = {
                    '%=', --[[ add your center components here in place of this comment ]]
                  },
                  lualine_x = {},
                  lualine_y = { 'filetype', 'progress' },
                  lualine_z = {
                    { 'location', separator = { right = '' }, left_padding = 2 },
                  },
                },
                inactive_sections = {
                  lualine_a = { 'filename' },
                  lualine_b = {},
                  lualine_c = {},
                  lualine_x = {},
                  lualine_y = {},
                  lualine_z = { 'location' },
                },
                tabline = {},
                extensions = {},
              }
        end, 50)
    end
},{
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
