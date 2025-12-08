-- highlights text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",

	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),

	callback = function()
		vim.highlight.on_yank()
	end,
})

-- opens NvimTree by default when opening nvim on directory
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if not directory then return end

    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open()
  end,
})

-- renames NvimTree status line
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    vim.opt_local.statusline = "File Explorer"
  end,
})

-- create JUnit test with "test<"
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()

  end,
})

