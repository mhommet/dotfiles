vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.cob", "*.cbl", "*.cpy" },
    callback = function()
        vim.bo.filetype = "cobol"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "cobol",
    callback = function()
        vim.opt.colorcolumn = "7,72"
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.jcl",
    callback = function()
        vim.bo.filetype = "jcl"
        vim.opt.colorcolumn = "3,11,73" -- Marge A (//), séparateur (col 11), fin de ligne
        vim.cmd [[
      syntax match jclMargeA "^//"
      highlight jclMargeA guifg=#ff5c57 gui=bold
    ]]
    end
})
