-- Load NvChad's default LSP configuration
local nvlsp = require("nvchad.configs.lspconfig")
local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

-- Mason setup
mason.setup()
mason_lspconfig.setup {
  ensure_installed = {
    "intelephense",       -- PHP
    "ts_ls",           -- JavaScript and TypeScript
    "vuels",              -- Vue.js
    "cssls",              -- CSS
    "tailwindcss",        -- Tailwind CSS
    "emmet_ls",           -- Emmet (HTML, CSS, etc.)
    "twiggy_language_server", -- Twig
    "lua_ls",             -- Lua
  },
}

-- Define LSP servers with custom configurations
local servers = {
  intelephense = {},
  ts_ls = {},
  vuels = {},
  cssls = {},
  tailwindcss = {},
  emmet_ls = {},
  twiggy_language_server = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
      },
    },
  },
}

-- Attach configurations to each LSP server
for server, config in pairs(servers) do
  lspconfig[server].setup(vim.tbl_deep_extend("force", {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }, config))
end

-- Add custom keymaps for LSP
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})
