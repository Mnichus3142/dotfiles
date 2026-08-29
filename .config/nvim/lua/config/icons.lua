-- Shared glyphs used by statusline, explorer, diagnostics, completion, etc.
local M = {
	-- Distinct from language icons so tests are easy to spot in neo-tree.
	test = {
		glyph = "󰙨",
		hl = "MiniIconsOrange",
	},
	diagnostics = {
		Error = "",
		Warn = "",
		Hint = "",
		Info = "",
	},
	git = {
		added = "",
		modified = "",
		removed = "",
		renamed = "➜",
		untracked = "★",
		ignored = "◌",
		unstaged = "✗",
		staged = "✓",
		conflict = "",
	},
	folders = {
		closed = "",
		open = "",
		empty = "",
		empty_open = "",
		default = "",
	},
	ui = {
		search = "",
		recent = "",
		text = "",
		config = "",
		lazy = "󰒲",
		quit = "",
		branch = "",
		lock = "",
		dot = "",
		chevron = "",
		prompt = "❯ ",
		caret = " ",
	},
	kinds = {
		Array = "",
		Boolean = "",
		Class = "",
		Color = "",
		Constant = "",
		Constructor = "",
		Copilot = "",
		Enum = "",
		EnumMember = "",
		Event = "",
		Field = "",
		File = "",
		Folder = "",
		Function = "",
		Interface = "",
		Key = "",
		Keyword = "",
		Method = "",
		Module = "",
		Namespace = "",
		Null = "",
		Number = "",
		Object = "",
		Operator = "",
		Package = "",
		Property = "",
		Reference = "",
		Snippet = "",
		String = "",
		Struct = "",
		Text = "",
		TypeParameter = "",
		Unit = "",
		Value = "",
		Variable = "",
	},
}

function M.is_test_file(name)
	if type(name) ~= "string" or name == "" then
		return false
	end
	local base = name:match("([^/]+)$") or name
	base = base:lower()
	return base:match("^tests?%.")
		or base:match("^spec%.")
		or base:match("%.tests?%.")
		or base:match("%.spec%.")
		or base:match("_tests?%.")
		or base:match("_spec%.")
		or base:match("^test_")
		or base:match("^spec_")
		or false
end

-- Exact basenames + compound extensions that mini.icons can resolve.
function M.test_file_entries()
	local languages = {
		"ts",
		"tsx",
		"js",
		"jsx",
		"mjs",
		"cjs",
		"mts",
		"cts",
		"py",
		"go",
		"lua",
		"rs",
		"svelte",
	}
	local stems = { "test", "tests", "spec" }
	local file, extension = {}, {}
	for _, stem in ipairs(stems) do
		for _, lang in ipairs(languages) do
			local name = stem .. "." .. lang
			file[name] = M.test
			extension[name] = M.test
		end
	end
	return file, extension
end

return M

