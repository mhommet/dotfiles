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
} 