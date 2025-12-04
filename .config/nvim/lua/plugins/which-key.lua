return {
  "folke/which-key.nvim",

  event = "VeryLazy",

  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },

    window = {
      border = "rounded",
      margin = { 1, 1, 1, 1 },
      padding = { 2, 2, 2, 2 },
    },

    layout = {
      spacing = 4,
      align = "left",
    },

    show_help = true,
    show_keys = true,
  }
}

