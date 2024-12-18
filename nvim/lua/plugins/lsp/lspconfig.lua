return {
    'neovim/nvim-lspconfig',
    dependencies = {{
        'williamboman/mason.nvim',
        config = true
    }, 'williamboman/mason-lspconfig.nvim', 'WhoIsSethDaniel/mason-tool-installer.nvim', {
        'j-hui/fidget.nvim',
        opts = {}
    }, {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {{
                path = 'luvit-meta/library',
                words = {'vim%.uv'}
            }}
        }
    }, {
        'Bilal2453/luvit-meta',
        lazy = true
    }},
    config = function()
        local lspconfig = require('lspconfig')
        local mason = require('mason')
        local mason_lspconfig = require('mason-lspconfig')

        mason.setup()
        mason_lspconfig.setup {
            ensure_installed = {'intelephense', -- PHP
            'ts_ls', -- JavaScript and TypeScript
            'vuels', -- Vue.js
            'cssls', -- CSS
            'tailwindcss', -- Tailwind CSS
            'emmet_ls', -- Emmet (HTML, CSS, etc.)
            'twiggy_language_server', -- Twig
            'lua_ls', -- Lua
            'clangd', -- C, C++, Objective-C
            }
        }

        local servers = {
            intelephense = {},
            ts_ls = {},
            vuels = {},
            cssls = {},
            tailwindcss = {},
            emmet_ls = {},
            twiggy_language_server = {},
            lua_ls = {},
            clangd = {}
        }

        for server, config in pairs(servers) do
            lspconfig[server].setup {
                on_attach = function(client, bufnr)
                    -- Go to function definition
                    local function buf_set_keymap(...)
                        vim.api.nvim_buf_set_keymap(bufnr, ...)
                    end
                    local opts = { noremap = true, silent = true }

                    -- Keybinding for Go to Definition
                    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                end,
                settings = config
            }
        end
    end
}
