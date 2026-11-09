return {
  "lewis6991/gitsigns.nvim",

  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signs_staged = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    })

    local gitsigns = require("gitsigns")

    local keymap = vim.keymap.set


    keymap("n", "<leader>ggd", gitsigns.preview_hunk, {
        desc = "Git diff under cursor",
    })
  end,
}
