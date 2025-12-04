local M = {}

function M.on_attach(client, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
  end

  local telescope = require("telescope.builtin")

  -- LSP Navigation via Telescope (short paths, no preview)
  local opts = {
    path_display = { "smart" },
    fname_width = 60,
    trim_text = true,
    previewer = true,
  }

  -- Go to Declaration (Telescope doesn't have this one)
  map("n", "<leader>gD", vim.lsp.buf.declaration)

  -- Go to Definition
  map("n", "<leader>gd", function()
    telescope.lsp_definitions(opts)
  end)

  -- Go to Implementation
  map("n", "<leader>gi", function()
    telescope.lsp_implementations(opts)
  end)

  -- References
  map("n", "<leader>gr", function()
    telescope.lsp_references(opts)
  end)

  -- Type Definition
  map("n", "<leader>gt", function()
    telescope.lsp_type_definitions(opts)
  end)

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

