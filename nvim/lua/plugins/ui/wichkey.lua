return {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
        require('which-key').setup()
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
        }}
    end
}
