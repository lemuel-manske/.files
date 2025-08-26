return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",

      build = "make",

      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
  config = function()
    local actions = require("telescope.actions")

    local open_after_tree = function(prompt_buffer)
      vim.defer_fn(function()
        actions.select_default(prompt_buffer)
      end, 100)
    end

    require("telescope").setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-f>"] = actions.to_fuzzy_refine,
          ["<CR>"] = open_after_tree,
        },
        n = {
          ["<CR>"] = open_after_tree
        },
      },
    })

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "live_grep_args")

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>ss", builtin.buffers, { desc = "[ ] Find existing buffers" })
    vim.keymap.set("n", "<leader>sg", ":Telescope live_grep search_dirs=.<CR>", { desc = "[G]rep" })

    local ext = require("telescope").extensions

    vim.keymap.set("n", "<leader>sa", ext.live_grep_args.live_grep_args, { desc = "Grep with [a]rgs" })
  end,
}
