return {
  "stevearc/conform.nvim",

  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "eslint_d", "prettier" },
        typescript = { "eslint_d", "prettier" },
        javascriptreact = { "eslint_d", "prettier" },
        typescriptreact = { "eslint_d", "prettier" },
        vue = { "eslint_d", "prettier" },
        svelte = { "eslint_d", "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        go = { "gofmt", "goimports" },
      },

      formatters = {
        eslint_d = {
          command = "eslint_d",
          args = { "--fix", "--stdin", "--stdin-filename", "$FILENAME" },
          stdin = true,
        },

        stylua = {
          command = "stylua",
          args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            "2",
            "-",
          },
          stdin = true,
        },
      },
    })
  end,
}
