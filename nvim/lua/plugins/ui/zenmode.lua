return {
    'folke/zen-mode.nvim',
    keys = {{
        '<leader>zm',
        '<cmd>ZenMode<CR>',
        desc = 'Zen Mode'
    }},
    opts = {
        plugins = {
            alacritty = {
                enabled = true,
                font = '14'
            }
        }
    }
}
