return {
        'kdheepak/lazygit.nvim',
        cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
        dependencies = { 'nvim-lua/plenary.nvim' }, -- Required dependency
        keys = {
            { '<leader>lg', '<cmd>LazyGit<CR>', desc = 'Open LazyGit' },
        },
        event = 'VeryLazy',
}
