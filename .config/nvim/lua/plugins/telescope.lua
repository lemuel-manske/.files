return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        previewer = false,

        prompt_prefix = "   ",
        selection_caret = " ",
        path_display = { "smart" },

        sorting_strategy = "ascending",
        layout_strategy = "flex",

        layout_config = {
          prompt_position = "top",
          horizontal = { width = 0.9, preview_width = 0.5 },
          vertical = { width = 0.9, preview_height = 0.4 },
        },

        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },

      pickers = {
        find_files = {
          previewer = false,
          hidden = true,
          no_ignore = false,
        },
        buffers = {
          previewer = false,
          sort_mru = true,
          ignore_current_buffer = true,
        },
        live_grep = {
          previewer = false,
        },
      },

      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    telescope.load_extension("fzf")

    local keymap = vim.keymap.set
    local builtin = require("telescope.builtin")


    local function find_in_curr_dir()
      builtin.find_files({ cwd = vim.fn.expand('%:h:p') })
    end

    local function grep_in_curr_dir()
      builtin.live_grep({ cwd = vim.fn.expand('%:h:p') })
    end

    keymap("n", "<leader>sf", find_in_curr_dir, { desc = "Find files in current directory" })
    keymap("n", "<leader>sG", builtin.find_files, { desc = "Find files" })
    keymap("n", "<leader>sg", grep_in_curr_dir, { desc = "Live grep in current directory" })
    keymap("n", "<leader>sG", builtin.live_grep, { desc = "Live grep on project" })

    keymap("n", "<leader>sb", builtin.buffers, { desc = "Buffers" })
    keymap("n", "<leader>sh", builtin.help_tags, { desc = "Help" })

    keymap("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
    keymap("n", "<leader>gs", builtin.git_status, { desc = "Git status" })

    keymap("n", "<leader>ld", builtin.lsp_definitions, { desc = "Go to definition" })
    keymap("n", "<leader>lr", builtin.lsp_references, { desc = "References" })
    keymap("n", "<leader>li", builtin.lsp_implementations, { desc = "Implementations" })
    keymap("n", "<leader>lt", builtin.lsp_type_definitions, { desc = "Type definitions" })
    keymap("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "Document symbols" })
  end,
}
