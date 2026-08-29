local icons = require("config.icons")

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		require("telescope").setup({
			defaults = {
				prompt_prefix = icons.ui.search .. "  ",
				selection_caret = icons.ui.caret,
				entry_prefix = "  ",
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})
		pcall(require("telescope").load_extension, "ui-select")
	end,
}
