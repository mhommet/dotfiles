vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.cob", "*.cbl", "*.cpy" },
    callback = function()
        vim.bo.filetype = "cobol"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "cobol",
    callback = function()
        vim.opt_local.colorcolumn = "7,72"
        vim.opt_local.tabstop = 4
        vim.opt_local.expandtab = true
        vim.opt_local.textwidth = 72
        -- Folding par divisions
        vim.opt_local.foldmethod = "indent"
        vim.opt_local.foldlevelstart = 1
        
        -- Highlights pour zones COBOL
        vim.cmd [[
            syntax match cobolMargeA "^......\zs "
            syntax match cobolMargeB "^.\{7}\zs.\{65}"
            highlight cobolMargeA guibg=#3a3a3a
            highlight cobolMargeB guibg=#2a2a2a
        ]]
    end
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.jcl",
    callback = function()
        vim.bo.filetype = "jcl"
        vim.opt.colorcolumn = "1,2,11,73" -- Marge A (//), séparateur (col 11), fin de ligne
        vim.cmd [[
      syntax match jclMargeA "^//"
      highlight jclMargeA guifg=#ff5c57 gui=bold
    ]]
    end
})
