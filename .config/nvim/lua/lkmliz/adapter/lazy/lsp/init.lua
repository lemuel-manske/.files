-- Initialize fast-forward LSPs
vim.lsp.enable('clojure_lsp')
vim.lsp.enable('gopls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('ts_ls')

local java_config = "lkmliz/adapter/lazy/lsp/java"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    require(java_config).setup()
  end
})

