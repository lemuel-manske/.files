return {
  "iamcco/markdown-preview.nvim",

  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },

  build = "cd app && yarn install",

  ft = { "markdown", "md" },

  init = function()
    vim.g.mkdp_filetypes = { "markdown", "md" }

    vim.g.mkdp_echo_preview_url = 1
    vim.g.mkdp_browser='wslview'
  end,
}
