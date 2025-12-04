local M = {}

function M.on_attach(client, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
  end

  -- LSP Navigation
  map("n", "<leader>gD", vim.lsp.buf.declaration)
  map("n", "<leader>gd", vim.lsp.buf.definition)
  map("n", "<leader>gi", vim.lsp.buf.implementation)
  map("n", "<leader>gr", vim.lsp.buf.references)
  map("n", "<leader>gt", vim.lsp.buf.type_definition)

  -- Hover + actions
  map("n", "K", vim.lsp.buf.hover)
  map("n", "<leader>ca", vim.lsp.buf.code_action)

  -- Rename
  map("n", "<leader>rn", vim.lsp.buf.rename)

  -- Diagnostics
  map("n", "<leader>e", vim.diagnostic.open_float)
  map("n", "[d", vim.diagnostic.goto_prev)
  map("n", "]d", vim.diagnostic.goto_next)
end

return M
