vim.lsp.enable({
  "gopls",
  "lua_ls",
  "ts_ls",
  "jdtls",
})

local function on_attach(_, bufnr)
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

    vim.ui.input = function(_, on_confirm)
      if opts.prompt == "New name: " then
        opts.default = ""
      end
      ui_input(opts, on_confirm)
      vim.ui.input = ui_input
    end

    vim.lsp.buf.rename()
  end, {
    desc = "Rename Symbol",
    buffer = bufnr
  })

  vim.keymap.set("n", "Q", function()
    vim.lsp.buf.format({ async = true })
  end, { buffer = bufnr, desc = "Format file" })
end

local function java_on_attach(client, bufnr)
  on_attach(bufnr)

  vim.keymap.set("n", "<leader>oi", function()
    client:exec_cmd({
      command = "java.edit.organizeImports",
      arguments = { vim.uri_from_bufnr(bufnr) }
    })
  end, { buffer = bufnr, desc = "Organize Imports" })

  print("Java LSP attached.")
end

vim.lsp.config("gopls", {
  on_attach = on_attach,
})

vim.lsp.config("ts_ls", {
  on_attach = on_attach,
})

vim.lsp.config("jdtls", {
  on_attach = java_on_attach,
})

vim.lsp.config("lua_ls", {
  on_attach = on_attach,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
})

vim.diagnostic.config({
  underline = true,

  update_in_insert = false,

  severity_sort = true,

  float = {
    border = "rounded",
    source = true,
  },

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },

    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})
