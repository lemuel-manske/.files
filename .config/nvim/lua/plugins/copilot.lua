return {
  "github/copilot.vim",

  init = function()
    vim.g.copilot_enabled = false

    -- always use nvm's latest node version
    local node = vim.fn.system("bash -lc 'nvm which node'"):gsub("%s+$", "")

    vim.g.copilot_node_command = node
  end
}
