return {
  "github/copilot.vim",

  init = function()
    vim.g.copilot_enabled = true

    local handle = io.popen(
      "ls -d " .. vim.fn.expand("~") .. "/.nvm/versions/node/v* 2>/dev/null | sort -V | tail -1"
    )
    if handle then
      local latest = handle:read("*l")
      handle:close()
      if latest and latest ~= "" then
        vim.g.copilot_node_command = latest .. "/bin/node"
      end
    end
  end
}
