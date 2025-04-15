return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        {
            'j-hui/fidget.nvim',
            opts = {},
        },
        {
            'folke/lazydev.nvim',
            ft = 'lua',
            opts = {
                library = {
                    {
                        path = 'luvit-meta/library',
                        words = { 'vim%.uv' },
                    },
                },
            },
        },
        {
            'Bilal2453/luvit-meta',
            lazy = true,
        },
    },
    config = function()
        local lspconfig = require('lspconfig')
        local mason = require('mason')
        local mason_lspconfig = require('mason-lspconfig')

        mason.setup()
        mason_lspconfig.setup {
            ensure_installed = {
                'intelephense',   -- PHP
                'ts_ls',       -- JavaScript and TypeScript
                'vuels',          -- Vue.js
                'cssls',          -- CSS
                'tailwindcss',    -- Tailwind CSS
                'emmet_ls',       -- Emmet (HTML, CSS, etc.)
                'twiggy_language_server', -- Twig
                'lua_ls',         -- Lua
            },
        }

        -- LSP servers configuration
        local servers = {
            intelephense = {},
            ts_ls = {},
            vuels = {},
            cssls = {},
            tailwindcss = {},
            emmet_ls = {},
            twiggy_language_server = {},
            lua_ls = {},
        }

        for server, config in pairs(servers) do
            lspconfig[server].setup {
                on_attach = function(_, bufnr)
                    local opts = { noremap = true, silent = true, buffer = bufnr }

                    -- Keymaps for LSP functionality
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                end,
                settings = config,
            }
        end
    end,
} 