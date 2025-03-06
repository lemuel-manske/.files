return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	config = function()
		require("nvim-tree").setup({
			hijack_netrw = true,
			auto_reload_on_write = true,
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				vim.keymap.set(
					"n",
					"l",
					api.node.open.tab_drop,
					{ buffer = bufnr, noremap = true, silent = true, nowait = true }
				)

				vim.keymap.set(
					"n",
					"<CR>",
					api.node.open.edit,
					{ buffer = bufnr, noremap = true, silent = true, nowait = true }
				)

				vim.keymap.set(
					"n",
					"h",
					api.node.navigate.parent_close,
					{ buffer = bufnr, noremap = true, silent = true, nowait = true }
				)
			end,
		})

		vim.keymap.set("n", "<leader>se", "<cmd>NvimTreeFindFile<CR>", { desc = "[S]how file in [e]xplorer" })
	end,
}
