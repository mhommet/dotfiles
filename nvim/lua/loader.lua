-- Loading plugins
require('lazy').setup {
    'tpope/vim-sleuth',
    {
        { import = 'plugins.editor' },
        { import = 'plugins.git' },
        { import = 'plugins.lsp' },
        { import = 'plugins.ui' },
        { import = 'plugins.ai' },
    },
}
