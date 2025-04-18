return {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    keys = {
        { '<leader>lg', '<cmd>LazyGit<CR>', desc = 'Open LazyGit' },
    },
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
    },
} 