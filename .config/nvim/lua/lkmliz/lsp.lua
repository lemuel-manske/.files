local lsp_utils = require("lkmliz.lsp_utils")



vim.lsp.log.set_level("WARN")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    lsp_utils.on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
  end,
})

vim.lsp.config("jsonls", {})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})



vim.keymap.set("n", "<leader>dA", function()
  lsp_utils.jdtls.select_debug_project(function(project)
    vim.notify("Debug project set to: " .. project)
  end)
end, { desc = "Select Java debug project" })

vim.keymap.set("n", "<leader>da", lsp_utils.jdtls.attach_debugger, { desc = "Attach Java Debugger" })
vim.keymap.set("n", "<leader>de", lsp_utils.jdtls.open_repl, { desc = "Open REPL" })

vim.keymap.set("n", "<leader>db", lsp_utils.jdtls.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>di", lsp_utils.jdtls.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>di", lsp_utils.jdtls.step_over, { desc = "Step Over" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function(args)
    local buf = args.buf
    local py = lsp_utils.python
    vim.keymap.set("n", "<leader>dc", py.continue, { buffer = buf, desc = "Debug: Continue / Start" })
    vim.keymap.set("n", "<leader>db", py.toggle_breakpoint, { buffer = buf, desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dF", py.debug_file, { buffer = buf, desc = "Debug: Launch File" })
    vim.keymap.set("n", "<leader>dm", py.test_method, { buffer = buf, desc = "Debug: Test Method" })
    vim.keymap.set("n", "<leader>dC", py.test_class, { buffer = buf, desc = "Debug: Test Class" })
    vim.keymap.set("n", "<leader>do", py.step_over, { buffer = buf, desc = "Debug: Step Over" })
    vim.keymap.set("n", "<leader>di", py.step_into, { buffer = buf, desc = "Debug: Step Into" })
    vim.keymap.set("n", "<leader>dO", py.step_out, { buffer = buf, desc = "Debug: Step Out" })
    vim.keymap.set("n", "<leader>da", py.attach_fastapi, { buffer = buf, desc = "Debug: Attach to FastAPI" })
  end,
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

vim.lsp.enable({
  "gopls",
  "lua_ls",
  "pyright",
  "ts_ls",
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

vim.keymap.set("n", "<leader>ll", logging.open_lsp_log, { desc = "Open LSP Log" })
vim.keymap.set("n", "<leader>lt", logging.tail_lsp_log, { desc = "Tail LSP Log" })
vim.keymap.set("n", "<leader>li", logging.show_lsp_info, { desc = "LSP Info" })
