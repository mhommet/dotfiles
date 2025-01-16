return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy", -- Load lazily unless overridden
    lazy = false,       -- Explicitly disable lazy-loading
    version = false,    -- Always pull the latest version
    build = "make",     -- Build command (adjust for Windows if needed)
    opts = {
      -- Add your custom options here if needed
    },
    dependencies = {
      "stevearc/dressing.nvim",          -- UI improvements for prompts
      "nvim-lua/plenary.nvim",           -- Utility functions
      "MunifTanjim/nui.nvim",            -- UI components
      "hrsh7th/nvim-cmp",                -- Autocompletion for commands and mentions
      "nvim-tree/nvim-web-devicons",     -- Icons for UI elements
      "zbirenbaum/copilot.lua",          -- Support for Copilot as a provider
      {
        "HakonHarnes/img-clip.nvim",     -- Image pasting support
        event = "VeryLazy",              -- Load lazily
        opts = {
          embed_image_as_base64 = false, -- Embed image as base64 (false for external file)
          prompt_for_file_name = false,  -- No prompt for file name on paste
          drag_and_drop = {
            insert_mode = true,          -- Enable drag-and-drop in insert mode
          },
          use_absolute_path = true,      -- Use absolute paths (important for Windows)
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim", -- Render Markdown and Avante files
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" }, -- Load only for these file types
      },
    },
    config = function()
      require("avante").setup {
        provider = "copilot", -- Set Copilot as the provider
      }
    end,
  },
  {
    "github/copilot.vim", -- Copilot plugin for enhanced AI integration
    event = "VimEnter",   -- Load on VimEnter event
  },
}
