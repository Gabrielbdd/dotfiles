local wezterm = require("wezterm")
return {
	default_prog = { "wsl" },
	color_scheme = "My GitHub Dark",
	font = wezterm.font({
		family = "JetBrains Mono",
    weight = "Medium"
	}),
	font_size = 8,
	font_rules = {
		{
			intensity = "Bold",
			font = wezterm.font_with_fallback({ { family = "JetBrains Mono", weight = "Bold" } }),
		},
	},
	line_height = 1.2,
	keys = {
		{ key = "F11", action = "ToggleFullScreen" },
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
		["My GitHub Dark"] = {
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
	},
}
