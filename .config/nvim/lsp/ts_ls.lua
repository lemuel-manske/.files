return {
  cmd = {
    "typescript-language-server", "--stdio"
  },

  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },

  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },

  single_file_support = true,

  log_level = vim.lsp.protocol.MessageType.Warning,
}
