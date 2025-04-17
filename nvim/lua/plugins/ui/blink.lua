return {
    "DanilaMihailov/beacon.nvim", -- Or use appropriate blink plugin name
    event = { "CursorMoved" },
    config = function()
        -- Set up beacon to blink on cursor movement
        vim.g.beacon_enable = true
        vim.g.beacon_size = 40
        vim.g.beacon_show_jumps = true
        vim.g.beacon_minimal_jump = 10
        vim.g.beacon_shrink = true
        vim.g.beacon_fade = true
    end,
} 