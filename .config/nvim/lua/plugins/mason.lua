return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "INSTALLED",
          package_pending = "PENDING",
          package_uninstalled = "UNINSTALLED"
        }
      }
    }
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "gopls",
        "lua_ls",
        "pyright",
        "ts_ls",
      },
    },
  },

  {
    "mfussenegger/nvim-jdtls",

    dependencies = {
      "mfussenegger/nvim-dap"
    }
  }
}
