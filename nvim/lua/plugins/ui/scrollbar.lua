return {
    'petertriho/nvim-scrollbar',
    dependencies = {
        'lewis6991/gitsigns.nvim', -- Optional for git integration
        'kevinhwang91/nvim-hlslens', -- Add hlslens for better search experience
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
                hide_if_all_visible = true,
            },
            marks = {
                Search = { color = "#fe8019" },
                Error = { color = "#fb4934" },
                Warn = { color = "#fabd2f" },
                Info = { color = "#83a598" },
                Hint = { color = "#8ec07c" },
                Misc = { color = "#d3869b" },
            },
            excluded_filetypes = {
                "prompt",
                "TelescopePrompt",
                "noice",
                "NvimTree",
                "alpha",
            },
            autocmd = {
                render = {
                    "BufWinEnter",
                    "TabEnter",
                    "TermEnter",
                    "WinEnter",
                    "CmdwinLeave",
                    "TextChanged",
                    "VimResized",
                    "WinScrolled",
                },
            },
            handlers = {
                diagnostic = true,
                search = true,
                gitsigns = true, -- Requires gitsigns
            },
        })
        
        -- Add keymaps for hlslens (optional but recommended)
        vim.api.nvim_set_keymap('n', 'n',
            [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'N',
            [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]],
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]],
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]],
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]],
            { noremap = true, silent = true })
    end,
} 