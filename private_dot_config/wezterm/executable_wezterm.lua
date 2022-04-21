local wezterm = require("wezterm")
return {
  -- debug_key_events = true,
	-- default_prog = { "wsl" },
	color_scheme = "Rider Dark",
	font = wezterm.font({
		family = "JetBrains Mono",
		weight = "Medium",
	}),
	font_size = 10,
	font_rules = {
		{
			intensity = "Bold",
			font = wezterm.font_with_fallback({ { family = "JetBrains Mono", weight = "Bold" } }),
		},
	},
	line_height = 1.2,
	keys = {
		{ key = "F11", action = "ToggleFullScreen" },
		-- Teporarily fix as with the "20220408-101518-b908e2dd" release, wezterm started mapping C-i to toggle between tabs
		{ key = "phys:i", mods = "CTRL", action = { SendKey = { key = "i", mods = "CTRL" } } },
    -- map ctrl-ç to ctrl-\
    -- on neovim ctrl-\ is mapped to toggle the built in terminal
		{ key = "raw:47", mods = "CTRL", action = { SendKey = { key = "\\", mods = "CTRL" } } },
	},
	mouse_bindings = {
		-- Change the default click behavior so that it populates
		-- the Clipboard rather the PrimarySelection.
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = wezterm.action({ CompleteSelectionOrOpenLinkAtMouseCursor = "Clipboard" }),
		},
	},
	-- use_fancy_tab_bar = false,
	enable_tab_bar = false,
	initial_cols = 120,
	initial_rows = 30,
	window_close_confirmation = "NeverPrompt",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	color_schemes = {
		["GitHub Dark"] = {
			foreground = "#E1E4E8",
			background = "#24292E",
			cursor_bg = "#c9d1d9",
			cursor_border = "#c9d1d9",
			cursor_fg = "#ffffff",
			selection_bg = "#3b5070",
			selection_fg = "#ffffff",
			ansi = {
				"#000000",
				"#F97583", -- red
				"#85E89D", -- green
				"#FFEA7F", -- yellow
				"#6ca4f8",
				"#db61a2",
				"#89DDFF",
				"#ffffff",
			},
			brights = {
				"#4d4d4d",
				"#f78166",
				"#34D058", -- bright green
				"#FFDF5D",
				"#82AAFF", -- bright blue
				"#8A63D2",
				"#89DDFF",
				"#ffffff",
			},
		},
		["Rider Dark"] = {
			foreground = "#BDBDBD",
			background = "#262626",
			cursor_bg = "#c9d1d9",
			cursor_border = "#c9d1d9",
			cursor_fg = "#ffffff",
			selection_bg = "#3b5070",
			selection_fg = "#ffffff",
			ansi = {
				"#BDBDBD", -- black
				"#FF5647", -- red
				"#85C46C", -- green
				"#D9B72B", -- yellow
				"#6C95EB", -- blue
				"#D688D4", -- magenta
				"#39CC8F", -- cyan
				"#DDDDDD", -- white
			},
			brights = {
				"#4d4d4d", -- bright black
				"#FF8870", -- bright red
				"#ADEB96", -- bright green
				"#F5D86A", -- bright yellow
				"#ADD3FF", -- bright blue
				"#FFBFFE", -- bright magenta
				"#7DF0C0", -- bright cyan
				"#EEEEEE", -- bright white
			},
		},
	},
}
