local icons = require("config.icons")

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	---@module "neo-tree"
	---@diagnostic disable-next-line: undefined-doc-name
	---@type neotree.Config?
	opts = {},
	config = function()
		require("neo-tree").setup({
			default_component_configs = {
				icon = {
					folder_closed = icons.folders.closed,
					folder_open = icons.folders.open,
					folder_empty = icons.folders.empty,
					folder_empty_open = icons.folders.empty_open,
					default = icons.folders.default,
					provider = function(icon, node)
						if node.type ~= "file" then
							return
						end
						if icons.is_test_file(node.name) then
							icon.text = icons.test.glyph
							icon.highlight = icons.test.hl
							return
						end
						local ok, web_devicons = pcall(require, "nvim-web-devicons")
						if not ok then
							return
						end
						local devicon, hl = web_devicons.get_icon(node.name)
						icon.text = devicon or icon.text
						icon.highlight = hl or icon.highlight
					end,
				},
				modified = {
					symbol = "●",
				},
				git_status = {
					symbols = {
						added = icons.git.added,
						modified = icons.git.modified,
						deleted = icons.git.removed,
						renamed = icons.git.renamed,
						untracked = icons.git.untracked,
						ignored = icons.git.ignored,
						unstaged = icons.git.unstaged,
						staged = icons.git.staged,
						conflict = icons.git.conflict,
					},
				},
				indent = {
					indent_size = 2,
					padding = 1,
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					expander_collapsed = "",
					expander_expanded = "",
				},
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
			window = {
				position = "right",
				width = 30,
			},
		})
	end,
}
