-- Measure startup time
local start = vim.loop.hrtime()

-- Load core settings, keymaps, and autocommands
local modules = { 'set', 'remap', 'autocmd' }
for _, module in ipairs(modules) do
    local ok, err = pcall(require, module)
    if not ok then
        vim.notify('Error loading module: ' .. module .. '\n\n' .. err, vim.log.levels.ERROR)
    end
end

-- Load plugins (lazy.nvim)
local ok, err = pcall(require, 'loader')
if not ok then
    vim.notify('Error loading plugins:\n\n' .. err, vim.log.levels.ERROR)
end

-- Notify startup time
vim.notify('Config loaded in ' .. (vim.loop.hrtime() - start) / 1e6 .. 'ms')
