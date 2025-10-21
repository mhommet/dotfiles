require("nvchad.configs.lspconfig").defaults()

local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

-- Configure diagnostic appearance
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    source = 'if_many',
  },
  float = {
    source = 'always',
    border = 'rounded',
    header = '',
    prefix = ' ',
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Change diagnostic symbols
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

mason.setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

mason_lspconfig.setup {
  ensure_installed = {
    'intelephense',   -- PHP
    'ts_ls',         -- JavaScript and TypeScript
    'cssls',          -- CSS
    'tailwindcss',    -- Tailwind CSS
    'emmet_ls',       -- Emmet (HTML, CSS, etc.)
    'lua_ls',         -- Lua
    'pyright',        -- Python LSP
    'ruff',          -- Python linter/formatter
  },
}

-- Common on_attach function
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>f', function() 
    vim.lsp.buf.format { async = true } 
  end, opts)
end

-- Capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Server configurations
local servers = {
  intelephense = {
    settings = {
      intelephense = {
        stubs = {
          "apache", "bcmath", "bz2", "calendar", "Core", "curl", "date", 
          "dba", "dom", "enchant", "fileinfo", "filter", "ftp", "gd", "gettext", 
          "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", 
          "mysqli", "mysqlnd", "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", 
          "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix", 
          "pspell", "readline", "Reflection", "session", "shmop", "SimpleXML", 
          "snmp", "soap", "sockets", "sodium", "SPL", "sqlite3", "standard", 
          "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", 
          "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "zip", "wordpress", 
          "phpunit", "symfony"
        },
        completion = {
          maxItems = 100,
          fullyQualifyGlobalConstantsAndFunctions = false,
          triggerParameterHints = false,
        },
      },
    },
  },
  ts_ls = {},
  cssls = {},
  tailwindcss = {},
  emmet_ls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { 'vim' } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          autoImportCompletions = true,
        }
      }
    }
  },
  ruff = {},
}

-- Setup all servers
for server, config in pairs(servers) do
  config.on_attach = on_attach
  config.capabilities = capabilities
  lspconfig[server].setup(config)
end 
