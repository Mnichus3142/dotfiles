local icons = require("config.icons")

return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			[[                                  ]],
			[[  __        __   _                ]],
			[[  \ \      / /__| | ___ ___  _ __ ___   ___  ]],
			[[   \ \ /\ / / _ \ |/ __/ _ \| '_ ` _ \ / _ \ ]],
			[[    \ V  V /  __/ | (_| (_) | | | | | |  __/ ]],
			[[     \_/\_/ \___|_|\___\___/|_| |_| |_|\___| ]],
			[[                                  ]],
		}
		dashboard.section.buttons.val = {
			dashboard.button("f", icons.ui.search .. "  Find File", ":Telescope find_files <CR>"),
			dashboard.button("r", icons.ui.recent .. "  Recent Files", ":Telescope oldfiles <CR>"),
			dashboard.button("t", icons.ui.text .. "  Find Text", ":Telescope live_grep <CR>"),
			dashboard.button("c", icons.ui.config .. "  Config", ":e $MYVIMRC <CR>"),
			dashboard.button("l", icons.ui.lazy .. "  Lazy", ":Lazy<CR>"),
			dashboard.button("q", icons.ui.quit .. "  Quit", ":qa<CR>"),
		}
		require("alpha").setup(dashboard.opts)
	end,
}
