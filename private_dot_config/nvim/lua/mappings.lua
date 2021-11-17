local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--move line shortcuts
map("n", "<A-j>", ":m .+1<CR>==", {})
map("n", "<A-k>", ":m .-2<CR>==", {})
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", {})
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", {})
map("v", "<A-j>", ":m '>+1<CR>gv=gv", {})
map("v", "<A-k>", ":m '<-2<CR>gv=gv", {})

-- telescope
map("n", "<Leader>fw", ":Telescope live_grep<CR>", {})
map("n", "<Leader>ff", ":Telescope find_files <CR>", {})
map("n", "<Leader>fb", ":Telescope buffers<CR>", {})

-- nvim-tree
map("n", "<C-b>", ":NvimTreeFindFileToggle<CR>", {})

-- toggleterm
function _G.set_terminal_keymaps()
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], {})
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], {})
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
