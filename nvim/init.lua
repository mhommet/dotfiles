-- Measure startup time
vim.g.startuptime_start = vim.fn.reltime()

require('config.set')
require('config.lazy')
require('config.remap')
require('config.autocmd')

vim.cmd.colorscheme "oxocarbon"
