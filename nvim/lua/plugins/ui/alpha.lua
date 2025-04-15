return {
	'goolord/alpha-nvim',
	config = function()
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

		-- Nouveau logo ASCII
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

		-- Vide les boutons
		dashboard.section.buttons.val = {}

		-- Footer

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

			local footer_text = string.format(
				" %s - Started in  %s ms ",
				nvim_version,
				startup_time
			)

			return footer_text
		end
		dashboard.section.footer.val = footer()

		-- Configurer Alpha
		alpha.setup(dashboard.opts)
	end
} 