local vscode = require('vscode')

-- add selection to next find match
vim.keymap.set({ "n", "x", "i" }, "<C-d>", function()
  vscode.with_insert(function()
    vscode.action("editor.action.addSelectionToNextFindMatch")
  end)
end)

-- C-S-e 
vim.keymap.set({ "n" }, "<leader>se", function()
  vscode.action("workbench.files.action.showActiveFileInExplorer")
end)

-- C-p
vim.keymap.set({ "n" }, "<leader>sf", function()
  vscode.action("workbench.action.quickOpen")
end)

-- C-S-p
vim.keymap.set({ "n" }, "<leader>sc", function()
  vscode.action("workbench.action.showCommands")
end)

-- C-S-f
vim.keymap.set({ "n" }, "<leader>ss", function()
  vscode.action("workbench.action.findInFiles")
end)

