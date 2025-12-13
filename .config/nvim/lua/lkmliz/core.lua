-- SETTINGS

local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

-- enables .editorconfig support
g.editorconfig = true

-- plugins
opt.timeoutlen = 250

-- searching
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- formatting
opt.tabstop = 2       -- 2 spcs for tabs
opt.shiftwidth = 2    -- 2 spcs for indent width
opt.expandtab = true  -- expand tab to spcs
opt.autoindent = true -- copy indent from curr line when starting new one

opt.scrolloff = 8     -- scroll when reach 10
opt.wrap = false

opt.showmode = false -- dont show mode on status line
opt.showmatch = true -- highlight matching brackets

-- colors
opt.termguicolors = true
opt.background = "dark"

-- line numbers
opt.number = true             -- show line numbers
opt.numberwidth = 2           -- line numbers width
opt.cursorline = true         -- show line on cursor pos
opt.relativenumber = true     -- show line numbers relative to cursor

opt.mouse = "a"               -- use mouse

opt.clipboard = "unnamedplus" -- use system cliboard

opt.undofile = true           -- keep undo file

opt.signcolumn = "yes"        -- sign column on left so that text doesn't shift
opt.colorcolumn = "80"        -- sign column on left so that text doesn't shift

opt.splitright = true         -- vsplit right
opt.splitbelow = true         -- split below

opt.swapfile = false          -- no swap file
opt.autowrite = false         -- no autosave

opt.updatetime = 300          -- faster completion

opt.errorbells = false        -- no error bells

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


-- KEYMAPS

local keymap = vim.keymap

-- Ignores accidental suspension of vim
keymap.set("n", "<C-z>", "<nop>")

-- Clear search highlighting
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Don't copy deleted text to clipboard
keymap.set("n", "x", '"_x', { remap = false })
keymap.set("n", "X", '"_d', { remap = false })

-- Redo
keymap.set("n", "U", "<C-r>", { remap = false })

-- Window navigation
keymap.set("n", "<A-h>", "<C-w><C-h>", { desc = "Move focus to the left window", remap = false })
keymap.set("n", "<A-l>", "<C-w><C-l>", { desc = "Move focus to the right window", remap = false })
keymap.set("n", "<A-j>", "<C-w><C-j>", { desc = "Move focus to the lower window", remap = false })
keymap.set("n", "<A-k>", "<C-w><C-k>", { desc = "Move focus to the upper window", remap = false })

-- Splits
keymap.set("n", "<A-s>v", "<C-w>v", { desc = "Split window vertically", remap = false })
keymap.set("n", "<A-s>h", "<C-w>s", { desc = "Split window horizontally", remap = false })
keymap.set("n", "<A-x>", "<cmd>close<CR>", { desc = "Split exclude", remap = false })

-- Windows
keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height", remap = false })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height", remap = false })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Decrease window width", remap = false })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width", remap = false })

-- Buffers
keymap.set("n", "<C-b>", ":bw<CR>", { desc = "Closes current buffer", remap = false })
keymap.set("n", "<C-n>", ":bnext<CR>", { desc = "Go to next buffer", remap = false })
keymap.set("n", "<C-p>", ":bprevious<CR>", { desc = "Return to previous buffer", remap = false })


-- Open file explorer
keymap.set("n", "<leader>se", ":Explore<CR>", { desc = "Open file explorer" })


-- Reload Neovim configuration
keymap.set("n", "<leader>rr", ":source ~/.config/nvim/init.lua<CR>", { desc = "Reload Neovim config" })


-- Replace all instances of highlighted words Keymaps
keymap.set("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>")

-- Sort highlighted text in visual mode
keymap.set("v", "<C-s>", ":sort<CR>")

-- Move lines up and down in visual mode
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection up", remap = false })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection down", remap = false })


-- Create and open a new file in the current file's directory
keymap.set('n', '<leader>nf', function()
  local dir = vim.fn.expand("%:h")
  local name = vim.fn.input("filename: ")

  if name == "" then return end
  vim.cmd("edit " .. dir .. "/" .. name)
end)


-- Show line diagnostic in a floating window
keymap.set("n", "<leader><leader>", function()
  vim.diagnostic.open_float({ scope = "line" })
end, { desc = "Show line diagnostic" })


-- Remove ^M characters from the current buffer
keymap.set("n", "<leader>mm", function()
  vim.cmd([[ %s/\r//g ]])
end, { desc = "Remove ^M characters" })




-- AUTO COMMANDS

local main_group = vim.api.nvim_create_augroup("main-group", { clear = true })

-- highlights text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",

  group = main_group,

  callback = function()
    vim.hl.on_yank()
  end,
})

-- create directories when writing files
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Create parent directories if not exist",

  group = main_group,

  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})
