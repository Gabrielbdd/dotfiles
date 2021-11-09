local opt = vim.opt
local g = vim.g
local wo = vim.wo
local bo = vim.bo

g.coq_settings = { auto_start = "shut-up" }
g.chadtree_settings = { theme = { text_colour_set = "nord" } }

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevelstart = 3

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
opt.hidden = true
opt.ignorecase = true
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.cul = true
opt.mouse = "a"
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.updatetime = 250 -- update interval for gitsigns
opt.timeoutlen = 400
opt.clipboard = "unnamedplus"
-- opt.shell = "nu.exe"

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
