-- highlights text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",

	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),

	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if not directory then return end

    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open()
  end,
})

