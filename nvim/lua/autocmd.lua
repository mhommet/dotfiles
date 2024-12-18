return { -- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {
        clear = true
    }),
    callback = function()
        vim.highlight.on_yank()
    end
}),

-- Create a Neovim command to execute the script (Only work at work)
vim.api.nvim_create_user_command('Pointage', function(opts)
    local args = table.concat(opts.fargs, ' ')
    local handle = io.popen('~/pointage ' .. args)
    local result = handle:read('*a')
    handle:close()
    -- Remove ANSI escape codes
    result = result:gsub("\27%[%d+m", "")
    print(result)
end, { nargs = '*' }),
}

