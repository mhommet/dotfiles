return {
    -- LSP Configuration
    {
        'neovim/nvim-lspconfig',
        config = function()
            require 'configs.lspconfig' -- Charge la configuration dans configs/lspconfig.lua
        end,
        dependencies = {
            'williamboman/mason.nvim', -- LSP/DAP manager
            'williamboman/mason-lspconfig.nvim', -- Mason bridge to lspconfig
            'j-hui/fidget.nvim', -- LSP status UI
            {
                'folke/lazydev.nvim',
                ft = 'lua', -- Charge uniquement pour Lua
                opts = {
                    library = { path = 'luvit-meta/library', words = { 'vim%.uv' } },
                },
            },
            {
                'Bilal2453/luvit-meta',
                lazy = true, -- Charge uniquement à la demande
            },
        },
    },

    -- Autocompletion (nvim-cmp)
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm { select = true },
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
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'path' },
                }),
            }
        end,
    },
    -- Rip Substitute: Advanced search and replace
    {
        'chrisgrieser/nvim-rip-substitute',
        config = function()
            require('rip-substitute').setup {
                on_open = function()
                    -- Ensure unique buffer name for RipSubstitute
                    local buf_name = 'RipSubstitute'
                    if vim.fn.bufexists(buf_name) == 1 then
                        vim.cmd('bwipeout ' .. buf_name)
                    end
                end,
            }
        end,
    },

}

