local M = {}

local JDTLS = {}

-- Attach the debugger to a Java project
-- Returns: nil
JDTLS.attach_debugger = function()
  local dap = require("dap")

  local function start(project_name)
    dap.configurations.java = {
      {
        name = "Attach",
        type = "java",
        request = "attach",
        hostName = "127.0.0.1",
        port = 5005,
        projectName = project_name,
        timeout = 10000,
      },
    }

    dap.continue()
  end

  local project = JDTLS.read_debug_project()

  if project then
    start(project)
  else
    JDTLS.select_debug_project(start)
  end
end

-- Toggle a breakpoint in the debugger
-- Returns: nil
JDTLS.toggle_breakpoint = function()
  local dap = require("dap")

  dap.toggle_breakpoint()
end

-- Open the REPL for the debugger
-- Returns: nil
JDTLS.open_repl = function()
  local dap = require("dap")

  dap.repl.open()
end

-- Step into the current line in the debugger
-- Returns: nil
JDTLS.step_into = function()
  local dap = require("dap")

  dap.step_into()
end

-- Step over the current line in the debugger
-- Returns: nil
JDTLS.step_over = function()
  local dap = require("dap")

  dap.step_over()
end

-- Get the jdtls workspace directory based on the project root
-- Returns: string
JDTLS.get_workspace_dir = function()
  local root_dir = JDTLS.find_project_root()
  local project_name = JDTLS.get_workspace_name(root_dir)

  local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

  return workspace_dir
end

-- Get the debug project file path
-- Returns: string|nil
JDTLS.get_debug_project_file = function()
  local data_dir = JDTLS.get_workspace_dir()

  if not data_dir or data_dir == "" then
    return nil
  end

  local debug_file = data_dir .. "/.debug-project"

  return debug_file
end

-- Read the debug project from file
-- Returns: string|nil
JDTLS.read_debug_project = function()
  local file = JDTLS.get_debug_project_file()

  if not file or vim.fn.filereadable(file) == 0 then
    return nil
  end

  local lines = vim.fn.readfile(file)
  return lines[1]
end

-- Write the debug project to file
-- Params: project: string
-- Returns: nil
JDTLS.write_debug_project = function(project)
  local file = JDTLS.get_debug_project_file()

  if not file then
    return
  end

  vim.fn.mkdir(vim.fn.fnamemodify(file, ":h"), "p")
  vim.fn.writefile({ project }, file)
end

-- Get the jdtls workspace name based on the project root
-- Params: root_dir: string
-- Returns: string
JDTLS.get_workspace_name = function(root_dir)
  local project_name = vim.fn.fnamemodify(root_dir, ":t")

  return project_name
end

-- Find the jdtls project root directory
-- Returns: string|nil
JDTLS.find_project_root = function()
  local root_dir = require("jdtls.setup").find_root({
    "gradlew",
    "mvnw",
  })

  return root_dir
end

-- Prompt the user to select a jdtls project for debugging
-- Params: callback: function(project: string)
-- Returns: nil
JDTLS.select_debug_project = function(callback)
  local ui_input = vim.ui.input

  vim.ui.input = function(input_opts, on_confirm)
    if input_opts.prompt == "Debug project name: " then
      input_opts.default = ""
    end

    ui_input(input_opts, on_confirm)
    vim.ui.input = ui_input
  end

  vim.ui.input({
    prompt = "Debug project name: ",
  }, function(project)
    if not project or project == "" then
      return
    end

    -- persist selection
    local file = JDTLS.get_debug_project_file()
    if file then
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":h"), "p")
      vim.fn.writefile({ project }, file)
    end

    callback(project)
  end)
end

M.jdtls = JDTLS

local PYTHON = {}

-- Resolve the python interpreter for the current buffer.
PYTHON.resolve_python = function()
  local venv = vim.env.VIRTUAL_ENV
  if venv and vim.fn.executable(venv .. "/bin/python") == 1 then
    return venv .. "/bin/python"
  end

  local buf_dir = vim.fn.expand("%:p:h")
  local dir = buf_dir
  for _ = 1, 10 do
    local candidate = dir .. "/.venv/bin/python"
    if vim.fn.executable(candidate) == 1 then
      return candidate
    end
    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then
      break
    end
    dir = parent
  end

  return vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3") or "python"
end

-- Call dap-python.setup() with the resolved interpreter.
-- This must be called before any debug action so the adapter is launched
-- from the correct venv (and debugpy is found there).
-- Returns: nil
PYTHON.setup = function()
  require("dap-python").setup(PYTHON.resolve_python())
end

-- Run the current test method under the cursor
-- Returns: nil
PYTHON.test_method = function()
  PYTHON.setup()
  require("dap-python").test_method()
end

-- Run the current test class
-- Returns: nil
PYTHON.test_class = function()
  PYTHON.setup()
  require("dap-python").test_class()
end

-- Debug the current file as a script (launch)
-- Returns: nil
PYTHON.debug_file = function()
  PYTHON.setup()
  local dap = require("dap")
  dap.run({
    type = "python",
    request = "launch",
    name = "Launch file",
    program = vim.fn.expand("%:p"),
    pythonPath = PYTHON.resolve_python(),
  })
end

-- Attach the debugger to a running FastAPI process via debugpy on localhost:5678
-- Returns: nil
PYTHON.attach_fastapi = function()
  PYTHON.setup()
  local dap = require("dap")
  dap.run({
    type = "python",
    request = "attach",
    name = "Attach to FastAPI",
    connect = {
      host = "localhost",
      port = 5678,
    },
    pathMappings = {
      {
        localRoot = vim.fn.getcwd(),
        remoteRoot = ".",
      },
    },
    justMyCode = false,
  })
end

-- Toggle a breakpoint
-- Returns: nil
PYTHON.toggle_breakpoint = function()
  require("dap").toggle_breakpoint()
end

-- Continue / start debugging
-- Returns: nil
PYTHON.continue = function()
  PYTHON.setup()
  require("dap").continue()
end

-- Step over the current line
-- Returns: nil
PYTHON.step_over = function()
  require("dap").step_over()
end

-- Step into the current line
-- Returns: nil
PYTHON.step_into = function()
  require("dap").step_into()
end

-- Step out of the current frame
-- Returns: nil
PYTHON.step_out = function()
  require("dap").step_out()
end

M.python = PYTHON

-- on_attach function to set up key mappings and other configurations
-- Params: client: lsp.Client, bufnr: number
-- Returns: nil
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
    buffer = bufnr,
  })

  vim.keymap.set("n", "<leader>gd", function()
    telescope.lsp_definitions(opts)
  end, {
    desc = "Go to Definition",
    buffer = bufnr,
  })

  vim.keymap.set("n", "<leader>gi", function()
    telescope.lsp_implementations(opts)
  end, {
    desc = "Go to Implementation",
    buffer = bufnr,
  })

  vim.keymap.set("n", "<leader>gr", function()
    telescope.lsp_references(opts)
  end, {
    desc = "Go to References",
    buffer = bufnr,
  })

  vim.keymap.set("n", "<leader>gt", function()
    telescope.lsp_type_definitions(opts)
  end, {
    desc = "Go to Type Definition",
    buffer = bufnr,
  })

  vim.keymap.set("n", "K", vim.lsp.buf.hover, {
    desc = "Hover Documentation",
    buffer = bufnr,
  })

  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
    desc = "Code Action",
    buffer = bufnr,
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
    buffer = bufnr,
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
