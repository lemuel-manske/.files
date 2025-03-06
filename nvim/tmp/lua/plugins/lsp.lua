local servers = {
	"lua_ls",
	"stylua",
	"sqlfmt",
	"jdtls",
	"typescript-language-server",
}

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}

						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({ ensure_installed = servers })
		end,
	},

	{
		"hrsh7th/cmp-nvim-lsp",
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local telescope = require("telescope.builtin")

			vim.keymap.set("n", "gd", telescope.lsp_definitions, { desc = "[G]oto [D]efinition" })
			vim.keymap.set("n", "gr", telescope.lsp_references, { desc = "[G]oto [R]eferences" })
			vim.keymap.set("n", "gI", telescope.lsp_implementations, { desc = "[G]oto [I]mplementation" })
			vim.keymap.set("n", "<leader>D", telescope.lsp_type_definitions, { desc = "Type [D]efinition" })
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
