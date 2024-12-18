return {
    'stevearc/conform.nvim',
    event = {'BufWritePre'},
    cmd = {'ConformInfo'},
    keys = {{
        '<leader>f',
        function()
            require('conform').format {
                async = true,
                lsp_fallback = true
            }
        end,
        mode = '',
        desc = 'Format buffer'
    }},
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            return false
        end,
        formatters_by_ft = {
            lua = {'stylua'},
            python = {'black'},
            javascript = {'prettier'},
            php = {{'phpactor', 'format'}}
        }
    }
}
