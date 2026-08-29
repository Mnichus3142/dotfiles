-- In-buffer markdown rendering (headings, lists, tables, code, checkboxes).
-- Insert mode shows the raw source; normal mode renders it.
return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
	ft = { "markdown" },
	opts = {
		completions = { lsp = { enabled = true } },
		heading = {
			sign = false,
			border = true,
		},
		code = {
			sign = false,
			width = "block",
			right_pad = 1,
		},
	},
	keys = {
		{ "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle markdown render" },
		{ "<leader>mp", "<cmd>RenderMarkdown preview<CR>", desc = "Markdown side preview" },
	},
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				vim.opt_local.wrap = true
				vim.opt_local.linebreak = true
				vim.opt_local.breakindent = true
			end,
		})
	end,
}
