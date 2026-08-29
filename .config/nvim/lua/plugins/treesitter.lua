return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"css",
				"go",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"php",
				"toml",
				"yaml",
				"python",
				"query",
				"rust",
				"svelte",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		})

		-- nvim-treesitter master + Neovim 0.12: `#set-lang-from-info-string!`
		-- crashes on fenced code blocks. Use Neovim's injection query instead.
		vim.treesitter.query.set(
			"markdown",
			"injections",
			[[
				(fenced_code_block
				  (info_string
				    (language) @injection.language)
				  (code_fence_content) @injection.content)

				((html_block) @injection.content
				  (#set! injection.language "html")
				  (#set! injection.combined)
				  (#set! injection.include-children))

				((minus_metadata) @injection.content
				  (#set! injection.language "yaml")
				  (#offset! @injection.content 1 0 -1 0)
				  (#set! injection.include-children))

				((plus_metadata) @injection.content
				  (#set! injection.language "toml")
				  (#offset! @injection.content 1 0 -1 0)
				  (#set! injection.include-children))

				([
				  (inline)
				  (pipe_table_cell)
				] @injection.content
				  (#set! injection.language "markdown_inline"))
			]]
		)
	end,
}
