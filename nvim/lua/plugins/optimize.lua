return {
  -- High priority plugins that must be loaded immediately
  {
    "folke/lazy.nvim", -- The plugin manager itself
    priority = 1000, 
    lazy = false,
  },
  
  -- Theme (loaded immediately to avoid screen flashes)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
  },

  -- Deferred UI input (dressing.nvim)
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- Loading time optimization
  {
    "lewis6991/impatient.nvim",
    priority = 1001, -- Make sure it's loaded before everything else
    lazy = false, -- Must be loaded immediately
    config = function()
      require('impatient').enable_profile()
    end
  },
  
  -- Define global performance settings for lazy.nvim
  {
    "LazyVim/LazyVim",
    lazy = true, -- Don't load this plugin (just to inherit configurations)
    config = function() end,
  },
} 