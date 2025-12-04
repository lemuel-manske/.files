return {
  "catppuccin/nvim",
  
  name = "catppuccin",

  priority = 1000, -- load before everything else

  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha

    integrations = {
      treesitter = true,
      nvimtree = true,
      telescope = true,
      mason = true,
      lsp_trouble = true,
      cmp = true,
      gitsigns = true,
      fidget = true,
      indent_blankline = {
        enabled = true,
        scope_color = "lavender",
      },
      which_key = true,
      notify = true,
      illuminate = true,
      mini = true,
    },
  },

  config = function(_, opts)
    require("catppuccin").setup(opts)
    
    vim.cmd.colorscheme("catppuccin")
  end,
}

