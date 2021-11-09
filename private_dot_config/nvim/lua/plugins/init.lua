-- Auto install Packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

local config = function(name)
	return string.format("require('plugins.%s')", name)
end

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

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
	use("williamboman/nvim-lsp-installer")
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	})

	--
	-- Auto complete & Snippets
	--

	use({ "ms-jpq/coq_nvim", branch = "coq" })
	use("rafamadriz/friendly-snippets")

	--
	-- Treesitter
	--

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = config("treesitter"),
	})
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use({
		"andymass/vim-matchup",
		event = "VimEnter",
	})
	use({
		"windwp/nvim-ts-autotag",
	})

	--
	-- Auto pair
	--

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
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
	use({
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
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
				dark_sidebar = false,
				colors = { bg_search = "green", fg_search = "black" },
			})
		end,
	})
	use({
		"hoob3rt/lualine.nvim",
		config = function()
			require("lualine").setup({ options = { theme = "github" } })
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
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	})
	use({
		"b3nj5m1n/kommentary",
		config = function()
			require("kommentary.config").setup()
		end,
	})
	use({
		"editorconfig/editorconfig-vim",
		event = "BufEnter",
	})
end)
