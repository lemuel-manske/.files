local servers = {
	"lua_ls",
	"ts_ls",
}

return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")

			mason.setup({})

			mason_lspconfig.setup({
				ensure_installed = servers,
				automatic_installation = true,
			})
		end,
	},

	{
		"hrsh7th/cmp-nvim-lsp",
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local telescope = require("telescope.builtin")

			vim.keymap.set("n", "<leader>gd", telescope.lsp_definitions, { desc = "[G]oto [D]efinition" })
			vim.keymap.set("n", "<leader>gr", telescope.lsp_references, { desc = "[G]oto [R]eferences" })
			vim.keymap.set("n", "<leader>gi", telescope.lsp_implementations, { desc = "[G]oto [I]mplementation" })
			vim.keymap.set("n", "<leader>gt", telescope.lsp_type_definitions, { desc = "Type [D]efinition" })
			vim.keymap.set("n", "<leader>ds", telescope.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
			vim.keymap.set(
				"n",
				"<leader>ws",
				telescope.lsp_dynamic_workspace_symbols,
				{ desc = "[W]orkspace [S]ymbols" }
			)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
			vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
		end,
	},
}
