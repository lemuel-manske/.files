return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- Java Debug Adapter configuration
      dap.adapters.java = function(callback, config)
        callback({
          type = "server",
          host = "127.0.0.1",
          port = 5005,
        })
      end

      -- Java Debug Configuration
      dap.configurations.java = {
        {
          name = "Debug (Attach) - Local",
          type = "java",
          request = "attach",
          hostName = "127.0.0.1",
          port = 5005,
          skipFiles = { "<stdlib>" },
        },
      }
    end,
  },
}
