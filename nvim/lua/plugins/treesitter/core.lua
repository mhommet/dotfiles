return {
    'nvim-treesitter/nvim-treesitter',
    opts = {
        ensure_installed = {
            'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline',
            'query', 'vim', 'vimdoc', 'vue', 'javascript', 'php', 'typescript', 'tsx',
            'twig', 'css', 'scss',
        },
        auto_install = false, -- Disable automatic parser installation
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = {
            enable = true,
            disable = { 'ruby' }, -- Disable Treesitter-based indentation for Ruby
        },
    },
    config = function(_, opts)
        require('nvim-treesitter.install').prefer_git = true -- Prefer git for parser installations
        require('nvim-treesitter.configs').setup(opts)
    end,
} 