return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	config = function()
		require("nvim-tree").setup({
      renderer = {
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = false,
          },
        },
      },
			hijack_netrw = true,
			auto_reload_on_write = true,
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				vim.keymap.set(
					"n",
					"g?",
					api.tree.toggle_help,
					{ desc = "Help", buffer = bufnr, noremap = true, silent = true, nowait = true }
				)

				vim.keymap.set(
					"n",
					"x",
					api.fs.remove,
					{ desc = "E[x]clude file", buffer = bufnr, noremap = true, silent = true, nowait = true }
				)

			  vim.keymap.set(
					"n",
					"cf",
					api.fs.copy.filename,
					{ desc = "[C]opy [f]ilename", buffer = bufnr, noremap = true, silent = true, nowait = true }
				)

				vim.keymap.set(
					"n",
					"r",
					api.fs.rename_full,
					{ desc = "[R]ename file", buffer = bufnr, noremap = true, silent = true, nowait = true }
				)

				vim.keymap.set(
					"n",
					"n",
					api.fs.create,
					{ desc = "[N]ew file", buffer = bufnr, noremap = true, silent = true, nowait = true }
				)

				vim.keymap.set(
					"n",
					"l",
					api.node.open.tab_drop,
					{ desc = "Drop tab", buffer = bufnr, noremap = true, silent = true, nowait = true }
				)

				vim.keymap.set(
					"n",
					"<CR>",
					api.node.open.edit,
					{ desc = "Open", buffer = bufnr, noremap = true, silent = true, nowait = true }
				)

				vim.keymap.set(
					"n",
					"h",
					api.node.navigate.parent_close,
					{ desc = "Close parent", buffer = bufnr, noremap = true, silent = true, nowait = true }
				)

				vim.keymap.set(
					"n",
					"t",
					api.node.open.tab,
					{ desc = "Open in new [T]ab", buffer = bufnr, noremap = true, silent = true, nowait = true }
				)
			end,
		})

		vim.keymap.set("n", "<leader>se", "<cmd>NvimTreeFindFile<CR>", { desc = "[S]how file in [e]xplorer" })
	end,
}
