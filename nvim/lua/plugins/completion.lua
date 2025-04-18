return {{
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
}, {
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
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    config = function()
        local lspconfig = require('lspconfig')
        local mason = require('mason')
        local mason_lspconfig = require('mason-lspconfig')

        -- Configure diagnostic appearance
        vim.diagnostic.config({
            virtual_text = {
                prefix = '●', -- Use a bullet point for virtual text
                source = 'if_many', -- Show source if there are multiple diagnostics
            },
            float = {
                source = 'always', -- Always show source in hover
                border = 'rounded', -- Rounded border for diagnostics float
                header = '', -- No header in diagnostics float
                prefix = ' ', -- Space before diagnostics
            },
            signs = true, -- Show signs in the sign column
            underline = true, -- Underline the text with diagnostics
            update_in_insert = false, -- Don't update diagnostics in insert mode
            severity_sort = true, -- Sort diagnostics by severity
        })

        -- Change diagnostic symbols in the sign column
        local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        mason.setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })
        
        mason_lspconfig.setup {
            ensure_installed = {
                'intelephense',   -- PHP
                'ts_ls', -- JavaScript and TypeScript
                'vuels',          -- Vue.js
                'cssls',          -- CSS
                'tailwindcss',    -- Tailwind CSS
                'emmet_ls',       -- Emmet (HTML, CSS, etc.)
                'twiggy_language_server', -- Twig
                'lua_ls',         -- Lua
            },
        }

        -- Common on_attach function for all servers
        local on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }

            -- Enhanced keymaps for LSP functionality
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<leader>f', function() 
                vim.lsp.buf.format { async = true } 
            end, opts)

            -- Create format-on-save autocmd if the LSP supports it
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        -- Only format if format_on_save is enabled globally
                        if vim.g.format_on_save == 1 then
                            vim.lsp.buf.format({ async = false })
                        end
                    end,
                })
            end
            
            -- Special handling for PHP to avoid CMP errors with Copilot
            if client.name == "intelephense" then
                -- Need to override the LSP's completion capabilities for PHP
                client.server_capabilities.completionProvider.resolveProvider = false
            end
        end

        -- Capabilities with proper handling for completion
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        -- Fix for the PHP buffer error with copilot-cmp
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        -- LSP servers configuration with enhanced settings
        local servers = {
            intelephense = {
                settings = {
                    intelephense = {
                        stubs = {
                            "apache", "bcmath", "bz2", "calendar", "Core", "curl", "date", 
                            "dba", "dom", "enchant", "fileinfo", "filter", "ftp", "gd", "gettext", 
                            "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", 
                            "mysqli", "mysqlnd", "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", 
                            "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix", 
                            "pspell", "readline", "Reflection", "session", "shmop", "SimpleXML", 
                            "snmp", "soap", "sockets", "sodium", "SPL", "sqlite3", "standard", 
                            "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", 
                            "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "zip", "wordpress", 
                            "phpunit", "symfony"
                        },
                        files = {
                            maxSize = 5000000,
                        },
                        diagnostics = {
                            enable = true,
                        },
                        completion = {
                            -- Limit completions to avoid buffer errors
                            maxItems = 100,
                            fullyQualifyGlobalConstantsAndFunctions = false,
                            triggerParameterHints = false,
                        },
                    },
                },
            },
            ts_ls = {
                settings = {
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                },
            },
            vuels = {},
            cssls = {},
            tailwindcss = {},
            emmet_ls = {},
            twiggy_language_server = {},
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' } -- Recognize vim global in lua
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true), -- Make server aware of Neovim runtime files
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false, -- Disable telemetry
                        },
                        hint = {
                            enable = true,
                            setType = true,
                            paramType = true,
                            paramName = "Literal",
                            arrayIndex = "Auto",
                        },
                    },
                },
            },
        }

        -- Setup all configured servers
        for server, config in pairs(servers) do
            config.on_attach = on_attach
            config.capabilities = capabilities
            lspconfig[server].setup(config)
        end
    end,
}, 
{
    'VidocqH/lsp-lens.nvim',
    config = function()
        require('lsp-lens').setup()
    end,
}
}