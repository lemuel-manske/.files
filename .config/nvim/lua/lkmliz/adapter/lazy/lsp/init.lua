-- Initialize LSP with attach callback
local attach = require("lkmliz/adapter/lazy/lsp/attach")

-- List of LSP servers to enable with attach callback
local servers = {
  'clojure_lsp',
  'gopls',
  'lua_ls',
  'ts_ls',
}

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    on_attach = attach.on_attach,
  })
end

-- Setup Java LSP
local java_config = "lkmliz/adapter/lazy/lsp/java"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    require(java_config).setup()
  end
})
