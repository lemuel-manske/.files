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

    win = {
      border = "rounded",
      padding = { 1, 2 },
      title = true,
      title_pos = "center",
    },

    layout = {
      spacing = 4,
      align = "left",
    },

    show_help = true,
    show_keys = true,
  }
}

