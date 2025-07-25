return {
  'echasnovski/mini.files',
  version = false,
  opts = {
    -- Customization of shown content
    content = {
      filter = nil,
      prefix = nil,
      sort = nil,
    },
    -- Customization of explorer mappings
    mappings = {
      close       = 'q',
      go_in       = 'l',
      go_in_plus  = 'L',
      go_out      = 'h',
      go_out_plus = 'H',
      reset       = '<BS>',
      reveal_cwd  = '@',
      show_help   = 'g?',
      synchronize = '=',
      trim_left   = '<',
      trim_right  = '>',
    },
    -- General options
    options = {
      permanent_delete = true,
      use_as_default_explorer = false,
    },
    -- Customization of explorer windows
    windows = {
      preview = false,
      width_focus = 50,
      width_nofocus = 15,
      width_preview = 25,
    },
  },
  keys = {
    -- Removed <leader>e from here as it's handled in mappings.lua
    -- to properly override nvchad's mapping
  },
  config = function(_, opts)
    require("mini.files").setup(opts)

    local show_dotfiles = true
    local filter_show = function(fs_entry)
      return true
    end
    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, ".")
    end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      require("mini.files").refresh({ content = { filter = new_filter } })
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
      end,
    })
  end,
} 