-- Measure startup time
vim.g.startuptime_start = vim.fn.reltime()

-- Preload impatient.nvim to optimize module loading
local ok, impatient = pcall(require, 'impatient')
if ok then
  impatient.enable_profile()
end

require('config.set')
require('config.autocmd')
require('config.lazy')
require('config.remap')
