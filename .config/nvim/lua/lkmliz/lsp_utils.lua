local M = {}

M.on_attach = function(_, bufnr)
  local telescope = require("telescope.builtin")

  local opts = {
    path_display = { "smart" },
    fname_width = 60,
    trim_text = true,
    previewer = true,
  }

  vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {
    desc = "Go to Declaration",
    buffer = bufnr
  })

  vim.keymap.set("n", "<leader>gd", function()
    telescope.lsp_definitions(opts)
  end, {
    desc = "Go to Definition",
    buffer = bufnr
  })

  vim.keymap.set("n", "<leader>gi", function()
    telescope.lsp_implementations(opts)
  end, {
    desc = "Go to Implementation",
    buffer = bufnr
  })

  vim.keymap.set("n", "<leader>gr", function()
    telescope.lsp_references(opts)
  end, {
    desc = "Go to References",
    buffer = bufnr
  })

  vim.keymap.set("n", "<leader>gt", function()
    telescope.lsp_type_definitions(opts)
  end, {
    desc = "Go to Type Definition",
    buffer = bufnr
  })

  vim.keymap.set("n", "K", vim.lsp.buf.hover, {
    desc = "Hover Documentation",
    buffer = bufnr
  })

  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
    desc = "Code Action",
    buffer = bufnr
  })

  vim.keymap.set("n", "<leader>rn", function()
    local ui_input = vim.ui.input

    vim.ui.input = function(input_opts, on_confirm)
      if input_opts.prompt == "New name: " then
        input_opts.default = ""
      end
      ui_input(input_opts, on_confirm)
      vim.ui.input = ui_input
    end

    vim.lsp.buf.rename()
  end, {
    desc = "Rename Symbol",
    buffer = bufnr
  })

  vim.keymap.set("n", "Q", function()
    local conform = require("conform")

    conform.format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 3000,
    })
  end, { buffer = bufnr, desc = "Format file" })
end

return M
