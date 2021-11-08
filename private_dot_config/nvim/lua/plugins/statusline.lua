local present, feline = pcall(require, "feline")
if present then
	local lsp = require("feline.providers.lsp")
	local vi_mode_utils = require("feline.providers.vi_mode")

	local theme_colors = {
		green = "#ADEB96",
		blue = "#ADD3FF",
		aqua = "#7DF0C0",
		yellow = "#F5D86A",
		red = "#FF8870",
		orange = "#f57d26",
		purple = "#FFBFFE",
	}

	local mode_colors = {
		NORMAL = theme_colors.green,
		OP = theme_colors.green,
		INSERT = theme_colors.red,
		VISUAL = theme_colors.blue,
		BLOCK = theme_colors.blue,
		REPLACE = theme_colors.purple,
		["V-REPLACE"] = theme_colors.purple,
		ENTER = theme_colors.aqua,
		MORE = theme_colors.aqua,
		SELECT = theme_colors.red,
		COMMAND = theme_colors.green,
		SHELL = theme_colors.green,
		TERM = theme_colors.green,
		NONE = theme_colors.yellow,
	}

	local b = vim.b

	local M = {
		default_fg = "#A5A5AA",
		default_bg = "#3B3B3B",
		properties = {
			force_inactive = {
				filetypes = {},
				buftypes = {},
				bufnames = {},
			},
		},
		components = {
			left = {
				active = {},
				inactive = {},
			},
			mid = {
				active = {},
				inactive = {},
			},
			right = {
				active = {},
				inactive = {},
			},
		},
	}

	M.properties.force_inactive.filetypes = {
		"NvimTree",
		"packer",
		"startify",
		"fugitive",
		"fugitiveblame",
		"qf",
		"help",
	}

	M.properties.force_inactive.buftypes = {
		"terminal",
	}

	M.components.left.active[1] = {
		provider = function()
			return "  " .. string.sub(vi_mode_utils.get_vim_mode(), 0, 1) .. "  "
		end,
		hl = function()
			local mode = vi_mode_utils.get_vim_mode()
			return {
				fg = "#2f383e",
				bg = mode_colors[mode],
			}
		end,
	}

	M.components.left.active[2] = {
		provider = "file_info",
		left_sep = " ",
		right_sep = " ",
		icon = "",
	}

	M.components.left.active[3] = {
		provider = "diagnostic_errors",
		enabled = function()
			return lsp.diagnostics_exist("Error")
		end,
		hl = { fg = "#e67e80" },
		left_sep = " ",
	}

	M.components.left.active[4] = {
		provider = "diagnostic_warnings",
		enabled = function()
			return lsp.diagnostics_exist("Warning")
		end,
		hl = { fg = "#dbbc7f" },
		left_sep = " ",
	}

	M.components.left.active[5] = {
		provider = "diagnostic_hints",
		enabled = function()
			return lsp.diagnostics_exist("Hint")
		end,
		hl = { fg = "#7fbbb3" },
		left_sep = " ",
	}

	M.components.left.active[6] = {
		provider = "diagnostic_info",
		enabled = function()
			return lsp.diagnostics_exist("Information")
		end,
		hl = { fg = "#83c092" },
		left_sep = " ",
	}

	M.components.right.active[1] = {
		provider = "git_branch",
		hl = {
			style = "bold",
		},
		right_sep = function()
			local val = { hl = { fg = "NONE" } }
			if b.gitsigns_status_dict then
				val.str = " "
			else
				val.str = ""
			end

			return val
		end,
	}

	M.components.right.active[2] = {
		provider = "position",
		left_sep = " ",
		right_sep = " ",
	}

	M.components.right.active[3] = {
		provider = "line_percentage",
		hl = {
			style = "bold",
		},
		left_sep = " ",
		right_sep = " ",
	}

	feline.setup(M)
end
