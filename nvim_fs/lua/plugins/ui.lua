return {
    -- Rose Pine Colorscheme
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup {
                variant = "auto", -- auto, main, moon, or dawn
                dark_variant = "main", -- main, moon, or dawn
                dim_inactive_windows = false,
                extend_background_behind_borders = true,
                enable = {
                    terminal = true,
                    legacy_highlights = true,
                    migrations = true,
                },
                styles = {
                    bold = true,
                    italic = true,
                    transparency = true,
                },
                groups = {
                    border = "muted",
                    link = "iris",
                    panel = "surface",
                    error = "love",
                    hint = "iris",
                    info = "foam",
                    note = "pine",
                    todo = "rose",
                    warn = "gold",
                    git_add = "foam",
                    git_change = "rose",
                    git_delete = "love",
                    git_dirty = "rose",
                    git_ignore = "muted",
                    git_merge = "iris",
                    git_rename = "pine",
                    git_stage = "iris",
                    git_text = "rose",
                    git_untracked = "subtle",
                    h1 = "iris",
                    h2 = "foam",
                    h3 = "rose",
                    h4 = "gold",
                    h5 = "pine",
                    h6 = "foam",
                },
                highlight_groups = {
                    -- Add specific highlight overrides if needed
                },
                before_highlight = function(_, highlight)
                    -- Modify highlight groups dynamically if needed
                end,
            }
            vim.cmd("colorscheme rose-pine")
        end,
    },

    -- Lualine Statusline
    {
        'nvim-lualine/lualine.nvim',
        opts = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = { statusline = {}, winbar = {} },
                    always_divide_middle = true,
                    globalstatus = false,
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {},
                },
            }
        end,
    },

    -- Mini.nvim for enhanced text objects and surrounding
    {
        "echasnovski/mini.nvim",
        config = function()
            require("mini.ai").setup()
            require("mini.surround").setup()
        end,
    },

    -- Todo Comments
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            signs = false,
        },
    },

    -- Which Key (Keybinding Helper)
    {
        'folke/which-key.nvim',
        event = 'VimEnter',
        config = function()
            require('which-key').setup()
            require('which-key').add {
                { '<leader>d', group = 'Document' },
                { '<leader>r', group = 'Refactor' },
                { '<leader>s', group = 'Search' },
                { '<leader>w', group = 'Workspace' },
                { '<leader>t', group = 'Toggle' },
                { '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } },
            }
        end,
    },
}
