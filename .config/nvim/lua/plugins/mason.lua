return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "INSTALLED",
          package_pending = "PENDING",
          package_uninstalled = "UNINSTALLED",
        },
      },
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "eslint_d",
        "gopls",
        "java-debug-adapter",
        "java-test",
        "jdtls",
        "jsonls",
        "lua_ls",
        "prettier",
        "pyright",
        "pyright",
        "stylua",
        "ts_ls",
      },
    },
  },

  {
    "mfussenegger/nvim-jdtls",

    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
}
