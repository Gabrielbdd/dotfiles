vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_root_folder_modifier = ":p:~"
vim.g.nvim_tree_show_icons = {
	git = 0,
	folders = 0,
	files = 0,
	folder_arrows = 0,
}

require("nvim-tree").setup({
	diagnostic = { enable = true },
	tab_open = true,
	auto_close = false,
	view = { width = 40 },
})
