local opt = vim.opt
local g = vim.g
local wo = vim.wo
local bo = vim.bo
local o = vim.o

-- filetype.nvim
-- Do not source the default filetype.vim
vim.g.did_load_filetypes = 1

-- coq
g.coq_settings = { keymap = { recommended = false }, auto_start = "shut-up" }

-- fold settings
wo.foldmethod = "expr"
o.foldtext =
	[[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
wo.foldexpr = "nvim_treesitter#foldexpr()"
wo.fillchars = "fold:\\"
wo.foldminlines = 1
o.foldlevelstart = 1

opt.syntax = "on"
opt.errorbells = false
opt.smartcase = true
opt.showmode = false
bo.swapfile = false
opt.backup = false
opt.incsearch = true
opt.completeopt = "menuone,noinsert,noselect"
wo.wrap = true

opt.undofile = true
opt.ruler = false
opt.hidden = true -- buffer hidden
opt.ignorecase = true -- case sens ignore search
opt.splitbelow = true -- split behavior
opt.splitright = true -- split behavior
opt.termguicolors = true
opt.cul = true
opt.mouse = "a"
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.updatetime = 250 -- update interval for gitsigns
opt.timeoutlen = 400
opt.clipboard = "unnamedplus"

-- speed
opt.ttyfast = true
opt.lazyredraw = true

-- disable nvim intro
opt.shortmess:append("sI")

-- disable tilde on end of buffer: https://github.com/  neovim/neovim/pull/8546#issuecomment-643643758
opt.fillchars = { eob = " " }

-- Numbers
opt.number = false
opt.numberwidth = 2
opt.relativenumber = true

-- Indenline
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
bo.autoindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>hl")

g.mapleader = " "
g.auto_save = false
