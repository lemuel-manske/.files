require("lkmliz/core")

if vim.g.vscode then
  require("lkmliz/adapter/vscode")
else
  require("lkmliz/adapter/lazy")
end

