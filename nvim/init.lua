-- Measure startup time
vim.g.startuptime_start = vim.fn.reltime()

require('config.set')
require('config.autocmd')
require('config.lazy')
require('config.remap')
