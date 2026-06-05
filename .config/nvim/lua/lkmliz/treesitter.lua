local group = vim.api.nvim_create_augroup("lkmliz_treesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" then
      return
    end

    pcall(vim.treesitter.start, args.buf)
  end,
})
