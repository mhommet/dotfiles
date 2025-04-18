return {{
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        'intelephense',   -- PHP
        'typescript-language-server', -- JavaScript and TypeScript
        'vetur-vls',      -- Vue.js (Vetur)
        'css-lsp',          -- CSS
        'tailwindcss-language-server',    -- Tailwind CSS
        'emmet-ls',       -- Emmet (HTML, CSS, etc.)
        'twiggy-language-server', -- Twig
        'lua-language-server',         -- Lua
        'pyright',
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        'php',
        'javascript',
        'typescript',
        'vue',
        'css',
        'html',
        'twig',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'tsx',
        'typescript',
        'yaml',
        'twig',
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        intelephense = {},
        tsserver = {},
        vuels = {},  -- Pour vetur-vls
        cssls = {},
        tailwindcss = {},
        emmet_ls = {},
        twiggy_language_server = {},
        lua_ls = {},
        pyright = {},
      },
    },
  },
}