return {
  "github/copilot.vim",

  init = function()
    vim.g.copilot_enabled = false

    local home = vim.uv.os_homedir()

    vim.g.copilot_node_command = home .. "/.nvm/versions/node/v24.12.0/bin/node"
  end
}
