return {
  cmd = {
    "pyright-langserver",
    "--stdio",
  },

  filetypes = {
    "python",
  },

  root_markers = {
    ".git",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
  },

  single_file_support = true,

  log_level = vim.lsp.protocol.MessageType.Warning,

  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },

  before_init = function(_, config)
    local venv_python = (config.root_dir or "") .. "/.venv/bin/python"

    if vim.fn.executable(venv_python) == 1 then
      config.settings.python.pythonPath = venv_python
    else
      local fallback = vim.fn.exepath("python3")
      config.settings.python.pythonPath = fallback ~= "" and fallback or "python"
    end
  end,
}
