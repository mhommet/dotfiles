return {
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
