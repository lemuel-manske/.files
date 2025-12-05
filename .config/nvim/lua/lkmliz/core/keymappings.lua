vim.keymap.set("n", "<C-z>", "<nop>")

vim.keymap.set("n", "x", '"_x', { remap = false })
vim.keymap.set("n", "X", '"_d', { remap = false })
vim.keymap.set("n", "\\", '"_', { remap = false })
vim.keymap.set("n", "U", "<C-r>", { remap = false })

vim.keymap.set("n", "<A-h>", "<C-w><C-h>", { desc = "Move focus to the left window", remap = false })
vim.keymap.set("n", "<A-l>", "<C-w><C-l>", { desc = "Move focus to the right window", remap = false })
vim.keymap.set("n", "<A-j>", "<C-w><C-j>", { desc = "Move focus to the lower window", remap = false })
vim.keymap.set("n", "<A-k>", "<C-w><C-k>", { desc = "Move focus to the upper window", remap = false })
vim.keymap.set("n", "<A-s>v", "<C-w>v", { desc = "[S]plit window [v]ertically", remap = false })
vim.keymap.set("n", "<A-s>h", "<C-w>s", { desc = "[S]plit window [h]orizontally", remap = false })
vim.keymap.set("n", "<A-x>", "<cmd>close<CR>", { desc = "[S]plit e[x]clude", remap = false })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>sv", "<cmd>Vexpl<CR>")

vim.keymap.set("n", "<leader><leader>", ":lua vim.diagnostic.open_float(0, { scope = \"line\" })<CR>", { desc = "Show line diagnostic" })

vim.keymap.set("n", "<leader>rm", function()
  vim.cmd([[ %s/\r//g ]])
end, { desc = "Remove ^M characters" })

