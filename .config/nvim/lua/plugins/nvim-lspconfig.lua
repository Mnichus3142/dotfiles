return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require('lspconfig')
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Ulepszony capabilities dla LSP z completion
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Automatyczny setup serwerów przez mason-lspconfig
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls", "ts_ls", "pyright", "gopls", "rust_analyzer",
				"jsonls", "html", "cssls", "tailwindcss", "intelephense", "clangd",
				"svelte", "marksman"
			},
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				-- Specyficzne ustawienia dla wybranych serwerów
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = { globals = { "vim" } },
								workspace = { checkThirdParty = false },
							}
						}
					})
				end,
			}
		})

		-- Keymaps and inlay hints setup
		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function(args)
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				
				-- Enable inlay hints for this buffer if supported
				if client:supports_method('textDocument/inlayHint') then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
			end,
		})

		-- Keymaps
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP Hover" })
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action" })
		vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic error' })
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show signature help' })
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Show references' })
		vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format File' })

		-- Diagnostic customization
		local icons = require("config.icons")
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
				spacing = 2,
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
					[vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
					[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
					[vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
				},
			},
			underline = true,
			update_in_insert = false,
		})
	end
}
