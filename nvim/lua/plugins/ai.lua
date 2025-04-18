return {{
    "github/copilot.vim",
    event = "BufRead",
    cmd = "Copilot",
    config = function()
        -- Prioritise Copilot over nvim-cmp
        vim.g.copilot_no_tab_map = true
        vim.g.copilot_assume_mapped = true
        vim.g.copilot_tab_fallback = ""
        
        vim.api.nvim_set_keymap("i", "<Tab>", 'copilot#Accept("<Tab>")', { expr = true, silent = true })
    end,
},{
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "CodeCompanion" },
    opts = {
        strategies = {
            chat = {
                adapter = "copilot",
            },
            inline = {
                adapter = "copilot",
            },
        },
    },
}

}
