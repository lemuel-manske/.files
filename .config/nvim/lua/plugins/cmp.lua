return {
  {
    "hrsh7th/nvim-cmp",

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },

    config = function()
      local cmp = require("cmp")

      cmp.setup({
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),

        mapping = cmp.mapping.preset.insert({
          ["<C-m>"] = cmp.mapping.scroll_docs(-4),
          ["<C-n>"] = cmp.mapping.scroll_docs(4),

          ["<C-e>"] = cmp.mapping.abort(),

          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),

          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
      })

      local junit = require("plugins/ext/cmp/junit").new()

      cmp.register_source("junit", junit)

      cmp.setup.filetype("java", {
        sources = cmp.config.sources({
          { name = "junit" },
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end
  },

  {
    "hrsh7th/cmp-nvim-lsp"
  },

  {
    "hrsh7th/cmp-buffer"
  },

  {
    "hrsh7th/cmp-path"
  }
}

