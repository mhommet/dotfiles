return {
        "olimorris/onedarkpro.nvim",
        lazy = false,
        config = function()
            require("onedarkpro").setup({
              options = {
                transparency = true
              }
            })
            vim.cmd("colorscheme onedark")
        end,
}
