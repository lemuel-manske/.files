-- highlights text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",

	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),

	callback = function()
		vim.highlight.on_yank()
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

