return {
    -- Flutter Tools for Dart
    {
        'akinsho/flutter-tools.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim',
        },
        config = true,
    },
    {
        'dart-lang/dart-vim-plugin',
        ft = 'dart',
    },
}