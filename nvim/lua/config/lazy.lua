-- Ensure lazy.nvim is installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim and load plugins
require('lazy').setup({
    -- Load all plugins
    { import = "plugins" },
}, {
    defaults = {
        -- By default, set all plugins to lazy load
        lazy = true,
        -- Don't set version for packages that are not pinned
        version = false,
    },
    -- Enable performance profiling
    performance = {
        -- Cache plugin loads
        cache = {
            enabled = true,
        },
        reset_packpath = true, -- Reset the package path to improve startup time
        rtp = {
            reset = true,      -- Reset the runtime path to improve startup time
            -- Disable some runtime plugins
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
                -- Additional plugins to disable
                "spellfile",
                "shada",
                "man",
                "2html_plugin",
                "getscript",
                "logipat",
                "rrhelper",
                "vimball",
            },
        },
        -- Optimize loading
        loader = {
            -- Don't check if plugins exist
            check_rtp = false,
        },
    },
    -- Change checker settings to weekly
    checker = {
        enabled = true,
        frequency = 604800, -- check for updates every week
        notify = false,     -- disable update notifications
    },
    -- Optimize UI loading display
    ui = {
        border = "rounded",
        icons = {
            loaded = "✓",
            not_loaded = "○",
        },
        throttle = 100, -- Limit UI updates
    },
    -- Disable profiling by default (too expensive)
    profiling = {
        loader = false,
        require = false,
    },
})
