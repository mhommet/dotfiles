-- General settings
vim.g.mapleader = ' '       -- Set <space> as the leader key
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true -- Indicate if NERD fonts are available

-- Basic editor settings
vim.opt.number = true        -- Enable line numbers
vim.opt.mouse = ''           -- Disable mouse support
vim.opt.termguicolors = true -- Enable 24-bit RGB colors

-- Clipboard and undo
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.undofile = true           -- Save undo history

-- Search behavior
vim.opt.ignorecase = true -- Case-insensitive search
vim.opt.smartcase = true  -- Override ignorecase if search contains capital letters

-- Indentation and whitespace
vim.opt.breakindent = true -- Enable break indent
vim.opt.list = true        -- Display certain whitespace characters
vim.opt.listchars = {      -- Define whitespace display characters
    tab = '» ',
    trail = '·',
    nbsp = '␣',
}

-- Tab settings
vim.opt.tabstop = 4      -- Width of a tab character
vim.opt.shiftwidth = 4   -- Width of indentation
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.softtabstop = 4  -- Backspace removes 4 spaces

-- UI settings
vim.opt.cursorline = true    -- Highlight the current line
vim.opt.signcolumn = 'yes'   -- Always show the sign column
vim.opt.showmode = false     -- Disable mode display (shown in status line)
vim.opt.scrolloff = 10       -- Keep 10 lines above/below the cursor
vim.opt.inccommand = 'split' -- Preview substitutions live as you type

-- Split window behavior
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.splitbelow = true -- Open horizontal splits below

-- Performance tweaks
vim.opt.updatetime = 100 -- Faster completion and diagnostics (in ms)
vim.opt.timeoutlen = 300 -- Reduced timeout for mapped sequences (in ms)
vim.opt.swapfile = false -- Disable swap files for reduced disk usage
