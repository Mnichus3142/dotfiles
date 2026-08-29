-- General editor settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Persistent undo
vim.opt.undofile = true

-- Search configuration
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Better appearance
vim.opt.fillchars = {
	eob = " ",
	fold = " ",
	foldopen = "",
	foldclose = "",
	foldsep = " ",
	diff = "╱",
}
vim.opt.termguicolors = true

-- System clipboard support
vim.opt.clipboard = "unnamedplus"

-- Auto-save on focus lost or insert leave
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertLeave" }, {
	callback = function()
		if vim.bo.modified and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
			vim.api.nvim_command("silent! update")
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 150,
		})
	end,
})
