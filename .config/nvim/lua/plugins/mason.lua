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
    "mfussenegger/nvim-jdtls",

    dependencies = {
      "mfussenegger/nvim-dap"
    }
  }
}
