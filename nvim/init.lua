-- Measure startup time
vim.g.startuptime_start = vim.fn.reltime()

-- Preload impatient.nvim to optimize module loading
local ok, impatient = pcall(require, 'impatient')
if ok then
  impatient.enable_profile()
end

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

