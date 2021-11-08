require("packerInit")

local packer = require("packer")
local use = packer.use

local config = function(name)
	return string.format("require('plugins.%s')", name)
end

return packer.startup(function()
	use({
		"wbthomason/packer.nvim",
		event = "VimEnter",
	})

	-- Lsp
	use({
		"kabouzeid/nvim-lspinstall",
		event = "BufRead",
	})

	use({
		"folke/lua-dev.nvim",
		event = "BufRead",
	})

	use({
		"neovim/nvim-lspconfig",
		after = { "nvim-lspinstall", "lua-dev.nvim" },
		config = config("lspconfig"),
	})

	use({
		"onsails/lspkind-nvim",
		event = "BufEnter",
		config = config("lspkind"),
	})

	use({
		"ray-x/lsp_signature.nvim",
		after = "nvim-lspconfig",
		config = config("lspsignature"),
	})

	use({
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
	})

	use({
		"hrsh7th/nvim-compe",
		event = "InsertEnter",
		config = config("compe"),
	})

	use({
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
	})

	use({
		"lewis6991/gitsigns.nvim",
		after = "plenary.nvim",
		config = config("gitsigns"),
	})

	use({
		"editorconfig/editorconfig-vim",
		event = "BufEnter",
	})

	-- syntax
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		event = "BufRead",
		config = config("treesitter"),
	})

	use({
		"nvim-treesitter/playground",
		cmd = { "TSHighlightCapturesUnderCursor", "TSPlaygroundToggle" },
	})

	use("~/projects/opensource/material.nvim")

	use({
		"nvim-lua/plenary.nvim",
		event = "BufRead",
	})

	use({
		"nvim-lua/popup.nvim",
		after = "plenary.nvim",
	})

	use({
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = config("telescope"),
	})

	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		cmd = "Telescope",
	})

	use({ "kyazdani42/nvim-web-devicons" })

	use({
		"famiu/feline.nvim",
		config = config("statusline"),
	})

	-- Editor
	use({
		"terrortylor/nvim-comment",
		cmd = "CommentToggle",
		config = config("comment"),
	})

	use({
		"windwp/nvim-autopairs",
		after = "nvim-compe",
		config = config("autopairs"),
	})

	use({
		"andymass/vim-matchup",
		event = "CursorMoved",
		config = config("matchup"),
	})

	use({
		"mhartington/formatter.nvim",
		cmd = { "Format", "FormatWrite" },
		config = function()
			require("formatter").setup({
				filetype = {
					rust = {
						-- Rustfmt
						function()
							return {
								exe = "rustfmt",
								args = { "--emit=stdout" },
								stdin = true,
							}
						end,
					},
					lua = {
						-- stylua
						function()
							return {
								exe = "stylua",
								args = { "-" },
								stdin = true,
							}
						end,
					},
				},
			})
		end,
	})
end)
