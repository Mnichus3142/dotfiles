local icons = require("config.icons")

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "auto",
			icons_enabled = true,
			component_separators = "",
			section_separators = { left = "", right = "" },
			globalstatus = true,
		},
		sections = {
			lualine_a = { { "mode", separator = { left = "", right = "" } } },
			lualine_b = {
				{ "branch", icon = icons.ui.branch, color = { bg = "NONE" } },
				{
					"diff",
					symbols = {
						added = icons.git.added .. " ",
						modified = icons.git.modified .. " ",
						removed = icons.git.removed .. " ",
					},
					color = { bg = "NONE" },
				},
			},
			lualine_c = { { "filename", path = 1, symbols = { modified = "●", readonly = icons.ui.lock }, color = { bg = "NONE" } } },
			lualine_x = {
				{
					"diagnostics",
					symbols = {
						error = icons.diagnostics.Error .. " ",
						warn = icons.diagnostics.Warn .. " ",
						info = icons.diagnostics.Info .. " ",
						hint = icons.diagnostics.Hint .. " ",
					},
					color = { bg = "NONE" },
				},
				{ "filetype", icon_only = false, color = { bg = "NONE" } },
			},
			lualine_y = { { "progress", color = { bg = "NONE" } } },
			lualine_z = { { "location", separator = { left = "", right = "" } } },
		},
	},
}
