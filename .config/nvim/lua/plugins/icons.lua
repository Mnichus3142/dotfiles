-- File-type icons: mini.icons (cleaner glyphs) + mock of nvim-web-devicons
-- so neo-tree, lualine, barbecue and telescope pick them up automatically.
-- Colors follow Catppuccin/Caelestia via the mini integration.
return {
	{
		"nvim-mini/mini.icons",
		lazy = false,
		priority = 1500,
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
		config = function()
			local icons = require("config.icons")
			local test_files, test_exts = icons.test_file_entries()
			require("mini.icons").setup({
				style = "glyph",
				file = test_files,
				extension = test_exts,
			})
		end,
	},
}
