local lazy = {}

function lazy.install(path)
  print("Installing lazy.nvim...")

  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    path,
  })

  print("Finish installing lazy.nvim")
end

function lazy.setup(plugins)
  lazy.path = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy.nvim")

  if not vim.uv.fs_stat(lazy.path) then
    lazy.install(lazy.path)
  end

  vim.opt.rtp:prepend(lazy.path)

  require("lazy").setup(plugins, lazy.opts)
end

lazy.opts = {
  ui = {
    border = "rounded",
  },
  install = {
    missing = true, -- install missing plugins on startup.
  },
  change_detection = {
    enabled = false, -- check for config file changes
    notify = false,  -- get a notification when changes are found
  },
}

lazy.setup({
  { import = "plugins" },
})
