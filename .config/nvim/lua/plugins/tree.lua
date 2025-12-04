return {
  "nvim-tree/nvim-tree.lua",

  dependencies = {
    "nvim-tree/nvim-web-devicons", -- icons
  },

  cmd = { "NvimTreeToggle", "NvimTreeFocus" },

  keys = {
    { "<leader>se", "<cmd>NvimTreeFocus<cr>", desc = "Focus file tree" },
  },

  opts = {
    sort_by = "case_sensitive",
    view = {
      width = 35,
      side = "left",
    },
    renderer = {
      group_empty = true,
      icons = {
        show = {
          folder = true,
          file = true,
          git = true,
        },
        glyphs = {
          git = {
            unstaged  = "~",   -- modified but not staged
            staged    = "+",   -- added or modified and staged
            unmerged  = "!",   -- merge conflict
            renamed   = ">",   -- renamed
            untracked = "?",   -- new file
            deleted   = "-",   -- removed
            ignored   = "$",   -- ignored by git 
          },
        },
      },
    },
    filters = {
      dotfiles = false,
      custom = { "^.git$" },
    },
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    git = {
      enable = true,
      ignore = false,
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
  },

  config = function(_, opts)
    local function on_attach(bufnr)
      local api = require("nvim-tree.api")

      -- Default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- "l" to open, "h" to close nodes
      vim.keymap.set("n", "l", api.node.open.edit, { buffer = bufnr, desc = "Open" })
      vim.keymap.set("n", "h", api.node.navigate.parent_close, { buffer = bufnr, desc = "Close parent" })
    end

    opts.on_attach = on_attach

    require("nvim-tree").setup(opts)
  end
}
  