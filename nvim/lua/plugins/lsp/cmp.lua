return {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    cmd = "CmpStatus",
    dependencies = {
        {
            'L3MON4D3/LuaSnip',
            lazy = true,
            dependencies = {},
            build = (function()
                if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
                    return
                end
                return 'make install_jsregexp'
            end)(),
        },
        { 'saadparwaiz1/cmp_luasnip', lazy = true },
        { 'hrsh7th/cmp-nvim-lsp', lazy = true },
        { 'hrsh7th/cmp-path', lazy = true },
        { 'hrsh7th/cmp-buffer', lazy = true },
        { 'hrsh7th/cmp-emoji', lazy = true },
        { 'onsails/lspkind.nvim', lazy = true },
        { 'hrsh7th/cmp-cmdline', lazy = true },
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')
        
        -- Helper function to check if there are words before cursor
        local has_words_before = function()
            if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
        end
        
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
                    if cmp.visible() and has_words_before() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
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
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol_text',
                    maxwidth = 50,
                    ellipsis_char = '...',
                    show_labelDetails = true,
                    symbol_map = {
                        Copilot = "",
                    },
                    before = function(entry, vim_item)
                        if entry.source.name == 'emoji' then
                            vim_item.kind = '󰱫'
                            vim_item.kind_hl_group = 'CmpItemKindEmoji'
                        end
                        
                        if entry.source.name == 'copilot' then
                            vim_item.kind_hl_group = 'CmpItemKindCopilot'
                        end
                        
                        return vim_item
                    end
                })
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp', group_index = 2 },
                { name = 'luasnip', group_index = 2 },
                { name = 'buffer', group_index = 2 },
                { name = 'path', group_index = 2 },
                { name = 'emoji', group_index = 2 },
            }),
            sorting = {
                priority_weight = 2,
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            window = {
                completion = {
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    col_offset = -3,
                    side_padding = 0,
                },
                documentation = {
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                }
            },
            completion = {
                autocomplete = { 'InsertEnter', 'TextChanged' },
            },
            view = {
                entries = "custom",
            },
        }
        
        -- Set custom highlight for Copilot suggestions
        vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644", bold = true })
        
        -- Setup cmdline completion right away (needed for noice.nvim)
        require("lazy").load({ plugins = { "cmp-cmdline" }})
        
        -- Command-line completion setup
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })
        
        -- Search completion setup
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })
    end,
} 