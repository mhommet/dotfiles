vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
      local buffers = vim.fn.getbufinfo({ buflisted = true })
      if #buffers > 10 then -- Limit to 10 buffers
        vim.cmd("bdelete " .. buffers[1].bufnr)
      end
    end,
  })
  