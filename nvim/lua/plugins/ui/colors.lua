return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
        require('catppuccin').setup  {
            transparent_background = true,

            -- Lualine options --
            lualine = {
                transparent = true, -- lualine center bar transparency
            },
        }
        vim.cmd.colorscheme 'catppuccin'
    end,
}
