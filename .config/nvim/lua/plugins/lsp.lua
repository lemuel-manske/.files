-- LSP configurations
return {
  {
    "neovim/nvim-lspconfig"
  },

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
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_enable = {
        exclude = {
          -- we shall give special treatment to Java LSP
          'jdtls'
        }
      }
    }
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load for lua files
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim$.uv" } }
      }
    }
  },

  { 
    "mfussenegger/nvim-jdtls"
  }
}
