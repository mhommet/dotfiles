return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            ensure_installed = {
                'bash',
                'c',
                'diff',
                'html',
                'lua',
                'luadoc',
                'markdown',
                'markdown_inline',
                'query',
                'vim',
                'vimdoc',
                'vue',
                'javascript',
                'php',
                'typescript',
                'tsx',
                'twig',
                'css',
                'scss'
            },
            auto_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = {
                enable = true,
                disable = { 'ruby' },
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.install').prefer_git = true
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
}
