return { {
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
}, {
    'chrisgrieser/nvim-rip-substitute',
    config = function()
        require('rip-substitute').setup {
            -- Add any additional configuration options here
            on_open = function()
                -- Ensure the buffer name is unique
                local buf_name = 'RipSubstitute'
                local buf_exists = vim.fn.bufexists(buf_name) == 1
                if buf_exists then
                    vim.cmd('bwipeout ' .. buf_name)
                end
            end
        }
    end
}, { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local lint = require 'lint'
        lint.linters_by_ft = {
            markdown = { 'markdownlint' }
        }

        -- To allow other plugins to add linters to require('lint').linters_by_ft,
        -- instead set linters_by_ft like this:
        -- lint.linters_by_ft = lint.linters_by_ft or {}
        -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
        --
        -- However, note that this will enable a set of default linters,
        -- which will cause errors unless these tools are available:
        -- {
        --   clojure = { "clj-kondo" },
        --   dockerfile = { "hadolint" },
        --   inko = { "inko" },
        --   janet = { "janet" },
        --   json = { "jsonlint" },
        --   markdown = { "vale" },
        --   rst = { "vale" },
        --   ruby = { "ruby" },
        --   terraform = { "tflint" },
        --   text = { "vale" }
        -- }
        --
        -- You can disable the default linters by setting their filetypes to nil:
        -- lint.linters_by_ft['clojure'] = nil
        -- lint.linters_by_ft['dockerfile'] = nil
        -- lint.linters_by_ft['inko'] = nil
        -- lint.linters_by_ft['janet'] = nil
        -- lint.linters_by_ft['json'] = nil
        -- lint.linters_by_ft['markdown'] = nil
        -- lint.linters_by_ft['rst'] = nil
        -- lint.linters_by_ft['ruby'] = nil
        -- lint.linters_by_ft['terraform'] = nil
        -- lint.linters_by_ft['text'] = nil

        -- Create autocommand which carries out the actual linting
        -- on the specified events.
        local lint_augroup = vim.api.nvim_create_augroup('lint', {
            clear = true
        })
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end
        })
    end
}, {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
}, {
    'gpanders/editorconfig.nvim',
}, {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = { {
        '<leader>f',
        function()
            require('conform').format {
                async = true,
                lsp_fallback = true
            }
        end,
        mode = '',
        desc = 'Format buffer'
    } },
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            return false
        end,
        formatters_by_ft = {
            lua = { 'stylua' },
            python = { 'black' },
            javascript = { 'prettier' },
            php = { { 'phpactor', 'format' } }
        }
    }
}, {
    'numToStr/Comment.nvim',
    event = 'BufRead',
    config = function()
        require('Comment').setup()
    end
}, { "mistricky/codesnap.nvim", build = "make" }, {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
}
}
