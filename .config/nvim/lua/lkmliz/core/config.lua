local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

g.editorconfig = true

-- plugins
opt.timeoutlen = 250

-- searching
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- formatting
opt.tabstop = 2 -- 2 spcs for tabs
opt.shiftwidth = 2 -- 2 spcs for indent width
opt.expandtab = true -- expand tab to spcs
opt.autoindent = true -- copy indent from curr line when starting new one

opt.scrolloff = 8 -- scroll when reach 10
opt.wrap = false

opt.showmode = false -- dont show mode on status line
opt.showmatch = true -- highlight matching brackets

-- colors
opt.termguicolors = true
opt.background = "dark"

-- line numbers
opt.number = true -- show line numbers
opt.numberwidth = 2 -- line numbers width
opt.cursorline = true -- show line on cursor pos
opt.relativenumber = true -- show line numbers relative to cursor

opt.mouse = "a" -- use mouse

opt.clipboard = "unnamedplus" -- use system cliboard

opt.undofile = true -- keep undo file

opt.signcolumn = "yes" -- sign column on left so that text doesn't shift
opt.colorcolumn = "80" -- sign column on left so that text doesn't shift

opt.splitright = true -- vsplit right
opt.splitbelow = true -- split below

opt.swapfile = false -- no swap file
opt.autowrite = false -- no autosave

opt.updatetime = 300 -- faster completion

opt.errorbells = false -- no error bells

-- lists
opt.list = true

opt.listchars = {
  space = "·",
  tab = "→ ",
  trail = "•",
  extends = "⟩",
  precedes = "⟨",
  nbsp = "␣",
}

opt.inccommand = "split"
