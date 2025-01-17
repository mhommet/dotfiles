return {
    -- Core LSP Config
    {
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
    },

    -- Autocompletion (nvim-cmp)
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                build = (function()
                    if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
            },
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'path' },
                }),
            }
        end,
    },

    -- Additional Plugins
    {
        'VidocqH/lsp-lens.nvim',
        config = function()
            require('lsp-lens').setup()
        end,
    },

    -- Flutter Tools for Dart
    {
        'akinsho/flutter-tools.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim',
        },
        config = true,
    },
    {
        'dart-lang/dart-vim-plugin',
        ft = 'dart',
    },
}
