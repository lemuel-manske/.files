return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      dap.adapters.java = function(callback, _)
        callback({
          type = "server",
          host = "127.0.0.1",
          port = 5005,
        })
      end

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
