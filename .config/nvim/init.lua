require("lkmliz/core")

if vim.g.vscode then
  require("config.vscode")
else
  require("config.lazy")
  require("config.lspconfig")
end

