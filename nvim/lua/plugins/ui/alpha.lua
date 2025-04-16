return {
	'goolord/alpha-nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons', 'rcarriga/nvim-notify' },
	config = function()
		-- We don't need to suppress errors here as Noice was configured to filter them
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.config.layout = {
			{ type = "padding", val = 1 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 1 },
			dashboard.section.footer,
		}

		-- ASCII Art Logo
		local art = {
			[[]],
			[[                      ██████                     ]],
			[[                  ████▒▒▒▒▒▒████                 ]],
			[[                ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██               ]],
			[[              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██             ]],
			[[            ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒               ]],
			[[            ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓           ]],
			[[            ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓           ]],
			[[          ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██         ]],
			[[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
			[[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
			[[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
			[[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
			[[          ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██         ]],
			[[          ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██         ]],
			[[          ██      ██      ████      ████         ]],
			[[                                                 ]],
			[[]],
		}

		local centered_art = {}
		for _ = 1, 3 do
			table.insert(centered_art, "")
		end
		for _, line in ipairs(art) do
			table.insert(centered_art, line)
		end
		dashboard.section.header.val = centered_art

		-- Navigation Buttons with Emojis
		dashboard.section.buttons.val = {
            dashboard.button("f", "🔍  Find File", ":Telescope find_files<CR>"),
            dashboard.button("e", "✨  New File", ":ene <BAR> startinsert<CR>"),
            dashboard.button("r", "🕒  Recent Files", ":Telescope oldfiles<CR>"),
            dashboard.button("t", "🔎  Find Text", ":Telescope live_grep<CR>"),
            dashboard.button("c", "⚙️   Configuration", ":e $MYVIMRC <CR>"),
            dashboard.button("l", "📦  Lazy", ":Lazy<CR>"),
            dashboard.button("q", "🚪  Quit", ":qa<CR>"),
		}

		-- Footer with system info and plugins
		local function footer()
			-- Neovim version, time and date
			local version = vim.version()
			local nvim_version = string.format("Neovim %d.%d.%d", version.major, version.minor,
				version.patch)

			-- Startup time (safe fallback)
			local startup_time = "N/A"
			if vim.g.startuptime_start then
				startup_time = string.format("%.2f",
					vim.fn.reltimefloat(vim.fn.reltime(vim.g.startuptime_start)))
			end
            
            -- Get plugin statistics from lazy.nvim
            local stats = require("lazy").stats()
            local plugins_loaded = stats.loaded
            local plugins_total = stats.count
            local plugins_startuptime = string.format("%.2f", stats.startuptime)
            
            -- Format with plugins info
			local footer_text = string.format(
				" %s | Started in %s ms | Plugins: %d/%d loaded in %s ms ",
				nvim_version,
				startup_time,
                plugins_loaded,
                plugins_total,
                plugins_startuptime
			)

			return footer_text
		end
        
		dashboard.section.footer.val = footer()
        dashboard.section.footer.opts.hl = "AlphaFooter"

		-- Configure Alpha
		alpha.setup(dashboard.opts)
        
        -- Auto-command to update footer when all plugins are loaded
        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                dashboard.section.footer.val = footer()
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
        
        -- Set up nvim-notify after Alpha is loaded
        if vim._original_notify then
            vim.notify = vim._original_notify
        end
	end
} 