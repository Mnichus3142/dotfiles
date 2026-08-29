-- Catppuccin fed by Caelestia's live Material You palette
-- (~/.local/state/caelestia/scheme.json). Reloads when the wallpaper/theme changes.
return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		local palette_keys = {
			"rosewater",
			"flamingo",
			"pink",
			"mauve",
			"red",
			"maroon",
			"peach",
			"yellow",
			"green",
			"teal",
			"sky",
			"sapphire",
			"blue",
			"lavender",
			"text",
			"subtext1",
			"subtext0",
			"overlay2",
			"overlay1",
			"overlay0",
			"surface2",
			"surface1",
			"surface0",
			"base",
			"mantle",
			"crust",
		}

		local function scheme_path()
			local state = os.getenv("XDG_STATE_HOME") or (os.getenv("HOME") .. "/.local/state")
			return state .. "/caelestia/scheme.json"
		end

		local function read_scheme()
			local path = scheme_path()
			local file = io.open(path, "r")
			if not file then
				return nil
			end
			local content = file:read("*a")
			file:close()

			local ok, scheme = pcall(vim.json.decode, content)
			if not ok or type(scheme) ~= "table" or type(scheme.colours) ~= "table" then
				return nil
			end

			local palette = {}
			for _, key in ipairs(palette_keys) do
				local value = scheme.colours[key]
				if type(value) == "string" and value ~= "" then
					palette[key] = value:find("^#") and value or ("#" .. value)
				end
			end

			return {
				mode = scheme.mode == "light" and "light" or "dark",
				palette = palette,
			}
		end

		local function apply(notify)
			local scheme = read_scheme()
			local flavour = "mocha"
			local overrides = {}

			if scheme then
				flavour = scheme.mode == "light" and "latte" or "mocha"
				vim.o.background = scheme.mode
				overrides[flavour] = scheme.palette
			end

			require("catppuccin").setup({
				flavour = flavour,
				background = { light = "latte", dark = "mocha" },
				transparent_background = true,
				show_end_of_buffer = false,
				term_colors = true,
				dim_inactive = { enabled = false },
				color_overrides = overrides,
				custom_highlights = function(colors)
					return {
						NormalFloat = { bg = "NONE" },
						FloatBorder = { fg = colors.overlay0, bg = "NONE" },
						FloatTitle = { fg = colors.lavender, bg = "NONE" },
						Pmenu = { bg = "NONE" },
						TelescopeNormal = { bg = "NONE" },
						TelescopeBorder = { fg = colors.overlay0, bg = "NONE" },
						NeoTreeNormal = { bg = "NONE" },
						NeoTreeNormalNC = { bg = "NONE" },
						NotifyBackground = { bg = "NONE" },
					}
				end,
				integrations = {
					alpha = true,
					cmp = true,
					gitsigns = true,
					mason = true,
					markdown = true,
					render_markdown = true,
					mini = true,
					neotree = true,
					noice = true,
					notify = true,
					telescope = true,
					treesitter = true,
					native_lsp = {
						enabled = true,
						underlines = {
							errors = { "undercurl" },
							hints = { "undercurl" },
							warnings = { "undercurl" },
							information = { "undercurl" },
						},
					},
				},
			})

			vim.cmd.colorscheme("catppuccin")

			if notify then
				vim.notify("Caelestia: motyw Nvima odświeżony", vim.log.levels.INFO)
			end
		end

		apply(false)

		local debounce_gen = 0
		local function apply_debounced()
			debounce_gen = debounce_gen + 1
			local this = debounce_gen
			vim.defer_fn(function()
				if this == debounce_gen then
					apply(true)
				end
			end, 80)
		end

		local uv = vim.uv or vim.loop
		local handle = uv.new_fs_event()
		if not handle then
			return
		end

		local dir = vim.fn.fnamemodify(scheme_path(), ":h")
		handle:start(
			dir,
			{},
			vim.schedule_wrap(function(err, filename)
				if err then
					return
				end
				if filename == nil or filename == "scheme.json" then
					apply_debounced()
				end
			end)
		)
	end,
}
