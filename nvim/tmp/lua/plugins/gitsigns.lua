return {
	"lewis6991/gitsigns.nvim",

	opts = {
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},

		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			vim.keymap.set("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, { desc = "Next hunk", buffer = bufnr })

			vim.keymap.set("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, { desc = "Previous hunk", buffer = bufnr })

			vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { desc = "[H]unk [S]tage", buffer = bufnr })
			vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[H]unk [R]eset", buffer = bufnr })

			vim.keymap.set("v", "<leader>hs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "[H]unk [S]tage (visual)" })

			vim.keymap.set("v", "<leader>hr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "[H]unk [R]eset (visual)" })

			vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, { desc = "[S]tage buffer", buffer = bufnr })
			vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, { desc = "[R]eset buffer", buffer = bufnr })
			vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { desc = "[P]review hunk", buffer = bufnr })

			vim.keymap.set("n", "<leader>hb", function()
				gitsigns.blame_line({ full = true })
			end, { desc = "[B]lame line (full)", buffer = bufnr })

			vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { desc = "[D]iff against index", buffer = bufnr })

			vim.keymap.set("n", "<leader>hD", function()
				gitsigns.diffthis("~")
			end, { desc = "[D]iff against last commit", buffer = bufnr })
		end,
	},
}
