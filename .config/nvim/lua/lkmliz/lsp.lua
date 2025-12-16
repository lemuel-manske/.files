vim.lsp.set_log_level("DEBUG")

vim.lsp.handlers["window/showMessage"] = function(_, result, ctx, _)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local client_name = client and client.name or "Unknown LSP"

  local level_names = { "ERROR", "WARN", "INFO", "LOG" }
  local level_name = level_names[result.type] or "INFO"

  vim.lsp.log.info(string.format("[%s] %s: %s", client_name, level_name, result.message))

  if result.type <= 2 then -- error or warning
    local notify_level = result.type == 1 and vim.log.levels.ERROR or vim.log.levels.WARN

    vim.notify(
      string.format("%s", result.message),
      notify_level,
      { title = string.format("%s %s", client_name, level_name) }
    )
  end
end

vim.lsp.handlers["window/logMessage"] = function(_, result, ctx, _)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local client_name = client and client.name or "Unknown LSP"

  local level_names = { "ERROR", "WARN", "INFO", "LOG" }
  local level_name = level_names[result.type] or "LOG"

  vim.lsp.log.info(string.format("[%s] %s: %s", client_name, level_name, result.message))

  if result.type == 1 then -- error
    vim.notify(
      string.format("%s", result.message),
      vim.log.levels.ERROR,
      { title = string.format("%s Error", client_name) }
    )
  end
end

vim.lsp.enable({
  "gopls",
  "lua_ls",
  "ts_ls",
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

vim.lsp.config("gopls", {
  on_attach = on_attach,
})

vim.lsp.config("ts_ls", {
  on_attach = on_attach,
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

local logging = {}

logging.open_lsp_log = function()
  local log_path = vim.lsp.log.get_filename()

  vim.cmd("split " .. log_path)
  vim.cmd("normal! G")
end

logging.tail_lsp_log = function()
  local log_path = vim.lsp.log.get_filename()

  vim.cmd("terminal tail -f " .. log_path)
end

logging.show_lsp_info = function()
  local clients = vim.lsp.get_clients()

  if #clients == 0 then
    vim.notify("No active LSP clients", vim.log.levels.INFO)
    return
  end

  local info_lines = { "Active LSP Clients:" }

  for _, client in ipairs(clients) do
    table.insert(info_lines, string.format("  • %s (ID: %d)", client.name, client.id))
  end

  table.insert(info_lines, "")
  table.insert(info_lines, "LSP Log file: " .. vim.lsp.log.get_filename())

  vim.notify(table.concat(info_lines, "\n"), vim.log.levels.INFO, { title = "LSP Info" })
end

vim.api.nvim_create_user_command("LspLog", logging.open_lsp_log, { desc = "Open LSP log file" })
vim.api.nvim_create_user_command("LspLogTail", logging.tail_lsp_log, { desc = "Tail LSP log file" })
vim.api.nvim_create_user_command("LspInfo", logging.show_lsp_info, { desc = "Show LSP client info" })

vim.keymap.set("n", "<leader>ll", logging.open_lsp_log, { desc = "Open LSP Log" })
vim.keymap.set("n", "<leader>lt", logging.tail_lsp_log, { desc = "Tail LSP Log" })
vim.keymap.set("n", "<leader>li", logging.show_lsp_info, { desc = "LSP Info" })
