return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim'},
    cmd = 'Neotree',
    keys = {{
        '\\',
        ':Neotree reveal<CR>',
        desc = 'NeoTree reveal'
    }, {
        '<leader>e',
        ':Neotree toggle<CR>',
        desc = 'Toggle NeoTree'
    }},
    opts = {
        filesystem = {
            filtered_items = {
                visible = true
            },
            window = {
                mappings = {
                    ['\\'] = 'close_window'
                }
            }
        }
    }
}