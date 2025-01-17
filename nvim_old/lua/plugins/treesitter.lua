return {
    -- Core Treesitter Plugin
    {
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

    -- Linting Plugin
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local lint = require 'lint'

            -- Configure linters by filetype
            lint.linters_by_ft = {
                markdown = { 'markdownlint' },
            }

            -- Auto lint on specific events
            local lint_augroup = vim.api.nvim_create_augroup('LintAutogroup', { clear = true })
            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },

    -- Indentation Guides
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}, -- Add options if needed
    },

    -- EditorConfig Support
    {
        'gpanders/editorconfig.nvim',
    },

    -- Formatting Plugin
    {
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<leader>f',
                function()
                    require('conform').format {
                        async = true,
                        lsp_fallback = true,
                    }
                end,
                mode = '',
                desc = 'Format buffer',
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                return false -- Disable format on save by default
            end,
            formatters_by_ft = {
                lua = { 'stylua' },
                python = { 'black' },
                javascript = { 'prettier' },
                php = { { 'phpactor', 'format' } },
            },
        },
    },

    -- Commenting Plugin
    {
        'numToStr/Comment.nvim',
        event = 'BufRead',
        config = function()
            require('Comment').setup()
        end,
    },

    -- Code Snapshot Plugin
    {
        "mistricky/codesnap.nvim",
        build = "make",
    },

    -- Autopairs Plugin
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
    },
}
