-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local config = function(name)
	return string.format("require('plugins.%s')", name)
end

return require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")

		--
		-- Speed
		--
		use({ "lewis6991/impatient.nvim" })
		use({ "nathom/filetype.nvim" })

		--
		-- Common
		--
		use({
			"nvim-lua/plenary.nvim",
		})
		use({
			"nvim-lua/popup.nvim",
		})

		--
		-- LSP
		--
		use({
			"neovim/nvim-lspconfig",
			config = config("lspconfig"),
		})
		use({ "williamboman/nvim-lsp-installer" })
		use({
			"jose-elias-alvarez/null-ls.nvim",
			requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		})
		use({ "b0o/schemastore.nvim" }) -- Provides access to Schema Store catalog

		--
		-- Auto complete & Snippets
		--
		use({ "ms-jpq/coq_nvim", branch = "coq" })
		use({
			"ms-jpq/coq.thirdparty",
			config = function()
				require("coq_3p")({
					{ src = "nvimlua", short_name = "nLUA" },
				})
			end,
		})

		--
		-- Treesitter
		--
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = config("treesitter"),
		})
		use({ "nvim-treesitter/playground" })
		use({ "nvim-treesitter/nvim-treesitter-textobjects" })
		use({
			"andymass/vim-matchup",
			event = "VimEnter",
			config = function()
				vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
			end,
		})
		use({
			"windwp/nvim-ts-autotag",
		})

		--
		-- Auto pair
		--
		use({
			"windwp/nvim-autopairs",
			config = config("nvim-autopairs"),
		})

		--
		-- Terminal
		--
		use({
			"akinsho/toggleterm.nvim",
			config = function()
				require("toggleterm").setup({
					open_mapping = [[<c-\>]],
				})
			end,
		})

		--
		-- Search
		--
		use({
			"nvim-telescope/telescope.nvim",
			config = config("telescope"),
		})
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

		--
		-- Navigation
		--
		use({
			"kyazdani42/nvim-tree.lua",
			config = config("nvim-tree"),
		})

		--
		-- Git
		--
		use({
			"lewis6991/gitsigns.nvim",
			config = function()
				require("gitsigns").setup()
			end,
		})

		--
		-- Color scheme
		--
		use({
			"projekt0n/github-nvim-theme",
			config = function()
				require("github-theme").setup({
					transparent = false,
					comment_style = "NONE",
					keyword_style = "NONE",
					function_style = "NONE",
					variable_style = "NONE",
					dark_sidebar = true,
					dark_float = true,
				})
			end,
		})
		use({
			"hoob3rt/lualine.nvim",
			config = function()
				require("lualine").setup({
					options = {
						theme = "github",
						component_separators = { left = "|", right = "|" },
						section_separators = { left = "", right = "" },
					},
					sections = {
						lualine_x = { "encoding" },
						lualine_y = {},
					},
				})
			end,
		})

		--
		-- Icons
		--
		use({
			"projekt0n/circles.nvim",
			requires = { { "kyazdani42/nvim-web-devicons" }, { "kyazdani42/nvim-tree.lua", opt = true } },
			config = function()
				require("circles").setup()
			end,
		})

		--
		-- Misc
		--
		use("tpope/vim-surround")
		use("tpope/vim-repeat")
		use({
			"b3nj5m1n/kommentary",
			config = config("kommentary"),
		})
		use({
			"editorconfig/editorconfig-vim",
			event = "BufEnter",
		})
	end,
	config = {
		-- Move to lua dir so impatient.nvim can cache it
		compile_path = vim.fn.stdpath("config") .. "/plugin/packer_compiled.lua",
	},
})
