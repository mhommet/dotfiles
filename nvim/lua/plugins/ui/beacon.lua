return {
    "DanilaMihailov/beacon.nvim", 
    lazy = true,
    
    -- Load beacon.nvim only when really needed (jumps, not just any cursor movement)
    keys = {
        -- Common jump commands
        { "G", mode = { "n" } },
        { "<C-u>", mode = { "n" } },
        { "<C-d>", mode = { "n" } },
        { "<C-f>", mode = { "n" } },
        { "<C-b>", mode = { "n" } },
        { "gg", mode = { "n" } },
        { "n", mode = { "n" } },
        { "N", mode = { "n" } },
        { "{", mode = { "n" } },
        { "}", mode = { "n" } },
        { "''", mode = { "n" } },
        { "``", mode = { "n" } },
        { "''", mode = { "n" } },
        { "L", mode = { "n" } },
        { "M", mode = { "n" } },
        { "H", mode = { "n" } },
    },
    config = function()
        -- Set up beacon to blink on cursor movement
        vim.g.beacon_enable = true
        vim.g.beacon_size = 40
        vim.g.beacon_show_jumps = true
        vim.g.beacon_minimal_jump = 10 -- Increase the minimal jump lines to avoid false triggers
        vim.g.beacon_shrink = true
        vim.g.beacon_fade = true
    end,
} 