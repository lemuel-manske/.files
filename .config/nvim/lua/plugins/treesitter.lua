return {
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  opts = {
    ensure_installed = {
      "java",
      "lua",
      "vim",
      "vimdoc",
      "bash",
      "json",
      "html",
      "css",
      "javascript",
      "typescript",
      "python",
      "markdown",
      "markdown_inline",
    },

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    indent = {
      enable = true,
    },
  },

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
