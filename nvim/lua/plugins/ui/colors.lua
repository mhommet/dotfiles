return {
    'Mofiqul/dracula.nvim',
    name = 'dracula',
    priority = 1000,
    config = function()
        require('dracula').setup  {
            transparent_bg = true,
        }
        vim.cmd.colorscheme 'dracula'
    end,
}
