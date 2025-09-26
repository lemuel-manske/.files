local vscode = require('vscode')

-- add selection to next find match
vim.keymap.set({ "n", "x", "i" }, "<C-d>", function()
  vscode.with_insert(function()
    vscode.action("editor.action.addSelectionToNextFindMatch")
  end)
end)

-- reveal file in explorer view
vim.keymap.set({ "n" }, "<leader>se", function()
  vscode.action("workbench.files.action.showActiveFileInExplorer")
end)

