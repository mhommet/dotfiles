local wezterm = require 'wezterm'
return {
	color_scheme = 'Dracula',
	enable_tab_bar = false,
	font_size = 13.0,
	font = wezterm.font('JetBrains Mono'),
	window_background_opacity = 1,
	window_decorations = 'RESIZE',
	keys = {
		{
			key = 'f',
			mods = 'CTRL',
			action = wezterm.action.ToggleFullScreen,
		},
	},
	mouse_bindings = {
	  -- Ctrl-click will open the link under the mouse cursor
	  {
	    event = { Up = { streak = 1, button = 'Left' } },
	    mods = 'CTRL',
	    action = wezterm.action.OpenLinkAtMouseCursor,
	  },
	},
}
