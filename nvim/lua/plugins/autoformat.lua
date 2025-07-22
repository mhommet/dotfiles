return {
    "https://git.sr.ht/~nedia/auto-format.nvim",
    event = "BufWinEnter",
    config = function()
        require("auto-format").setup({
            -- The name of the augroup.
            augroup_name = "AutoFormat",

            -- If formatting takes longer than this amount of time, it will fail. Having no
            -- timeout at all tends to be ugly - larger files, complex or poor formatters
            -- will struggle to format within whatever the default timeout
            -- `vim.lsp.buf.format` uses.
            timeout = 2000,

            -- These filetypes will not be formatted automatically.
            exclude_ft = {},

            -- Prefer formatting via LSP for these filetypes.
            prefer_lsp = {},
        })
    end
}
