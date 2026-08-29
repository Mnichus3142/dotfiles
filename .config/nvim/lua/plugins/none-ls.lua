return {
	'nvimtools/none-ls.nvim',
	dependencies = { 'nvimtools/none-ls-extras.nvim' },
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

		null_ls.setup({
			sources = {
				-- Lua
				null_ls.builtins.formatting.stylua,
				-- Web Development (Svelte, JS, TS, HTML, CSS, JSON)
				null_ls.builtins.formatting.prettier.with({
					filetypes = { "html", "json", "yaml", "markdown", "svelte", "javascript", "typescript", "javascriptreact", "typescriptreact", "css" },
				}),
				-- Go
				null_ls.builtins.formatting.gofumpt,
				null_ls.builtins.formatting.goimports_reviser,
				-- C / C++ / Java (requires clang-format installed via Mason)
				null_ls.builtins.formatting.clang_format,
				-- Python
				null_ls.builtins.formatting.black,
			},
			on_attach = function(client, bufnr)
				if client:supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
						end,
					})
				end
			end,
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format Document" })
	end,
}
