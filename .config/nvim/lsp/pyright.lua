return {
  cmd = {
    "pyright-langserver",
    "--stdio",
  },

  filetypes = {
    "python",
  },

  root_markers = {
    "pyproject.toml",
    ".git",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
  },

  single_file_support = true,

  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },

  on_new_config = function(new_config, new_root_dir)
    local venv_python = new_root_dir .. "/.venv/bin/python"

    if vim.fn.executable(venv_python) == 1 then
      new_config.settings.python.pythonPath = venv_python
    else
      local python = vim.fn.exepath("python")
      if python == "" then
        python = vim.fn.exepath("python3")
      end

      new_config.settings.python.pythonPath = python
    end
  end,
}
