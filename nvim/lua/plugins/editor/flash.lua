return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        -- Default options
        labels = "abcdefghijklmnopqrstuvwxyz",
        search = {
            -- Search multi-window
            multi_window = true,
            -- Search using fuzzy matching
            forward = true,
            -- When true, flash will disable its own highlighting after a jump
            wrap = true,
            -- Set to true to word mode by default
            incremental = false,
        },
        jump = {
            -- Register with which to jump to a location
            register = '"',
            -- Clear highlight after jump
            nohlsearch = true,
            -- When true, automatically jump when there is only one match
            autojump = true,
        },
        label = {
            -- Customize label appearance
            style = "overlay", -- "overlay" or "inline"
            -- Enable this to make the flash label appear in a fixed position
            reuse = "all",
        },
        highlight = {
            -- Flash.nvim matches
            matches = "FlashMatch",
            -- Flash.nvim label
            label = "FlashLabel",
            -- Flash.nvim background
            backdrop = "FlashBackdrop",
        },
        modes = {
            -- Options used for character search mode
            char = {
                enabled = true,
                -- Highlight the typed characters
                highlight = { backdrop = false },
                -- Automatically jump when there is only one match
                autojump = true,
                -- Jump position
                jump_labels = false,
            },
            -- Options used for word search mode
            search = {
                enabled = true,
                highlight = { backdrop = true },
                incremental = false,
            },
            -- Options used for treesitter selections
            treesitter = {
                enabled = true,
                labels = "abcdefghijklmnopqrstuvwxyz",
                jump = { pos = "range" },
            },
        },
    },
    -- stylua: ignore
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
} 