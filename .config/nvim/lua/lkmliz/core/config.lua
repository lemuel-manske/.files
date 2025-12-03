local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

-- used at plugins
g.have_nerd_font = false

opt.timeoutlen = 250 -- usefull for plugins

-- formatting
opt.tabstop = 2 -- 2 spcs for tabs
opt.shiftwidth = 2 -- 2 spcs for indent width
opt.expandtab = true -- expand tab to spcs
opt.autoindent = true -- copy indent from curr line when starting new one

opt.scrolloff = 10 -- scroll when reach 10

opt.wrap = false

-- colors
opt.termguicolors = true
opt.background = "dark"

-- line numbers
opt.number = true -- show line numbers
opt.numberwidth = 2 -- line numbers width
opt.cursorline = true -- show line on cursor pos
opt.relativenumber = true -- show line numbers relative to cursor

opt.mouse = "a" -- use mouse
opt.showmode = false -- don't show mode - pugin does it
opt.clipboard = "unnamedplus" -- use system cliboard
opt.undofile = true -- keep undo file

-- searching
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if mixed case then case-sensitive

opt.signcolumn = "yes" -- sign column on left so that text doesn't shift

opt.splitright = true -- vsplit right
opt.splitbelow = true -- split below

-- lists
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

opt.inccommand = "split"
