return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		check_ts = true, -- Enable treesitter check
		disable_filetype = { "TelescopePrompt", "vim" },
	},
}
