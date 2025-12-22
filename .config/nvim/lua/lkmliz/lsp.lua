vim.lsp.set_log_level("DEBUG")

local lsp_utils = require("lkmliz.lsp_utils")
local on_attach = lsp_utils.on_attach

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


local attach_debugger = function()
  local dap = require("dap")

  dap.configurations.java = {
    {
      name = "Attach",
      type = "java",
      request = "attach",
      hostName = "127.0.0.1",
      port = 5005,
      skipFiles = { "<stdlib>" },
    },
  }

  dap.continue();
end

local toggle_breakpoint = function()
  local dap = require("dap")

  dap.toggle_breakpoint();
end

local open_repl = function()
  local dap = require("dap")

  dap.repl.open();
end

local step_into = function()
  local dap = require("dap")

  dap.step_into();
end

local step_over = function()
  local dap = require("dap")

  dap.step_over();
end

vim.keymap.set("n", "<leader>da", attach_debugger, { desc = "Attach Java Debugger" })
vim.keymap.set("n", "<leader>de", open_repl, { desc = "Open REPL" })

vim.keymap.set("n", "<leader>db", toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>di", step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>di", step_over, { desc = "Step Over" })

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
