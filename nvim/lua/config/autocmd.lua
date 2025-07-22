vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.cob", "*.cbl", "*.cpy"},
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
