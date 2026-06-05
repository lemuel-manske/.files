local jdtls = require("jdtls")
local lsp_utils = require("lkmliz.lsp_utils")

local home = vim.uv.os_homedir()

local function java_on_attach(client, bufnr)
  lsp_utils.on_attach(client, bufnr)

  jdtls.setup_dap({ hotcodereplace = "auto" })

  jdtls.setup.add_commands()

  vim.keymap.set("n", "<leader>oi", function()
    jdtls.organize_imports()
  end, { buffer = bufnr, desc = "Organize Imports" })

  vim.keymap.set("n", "<leader>tc", function()
    jdtls.test_class()
  end, { buffer = bufnr, desc = "Test Class" })

  vim.keymap.set("n", "<leader>tm", function()
    jdtls.test_nearest_method()
  end, { buffer = bufnr, desc = "Test Nearest Method" })

  vim.keymap.set("n", "<leader>tp", function()
    jdtls.pick_test()
  end, { buffer = bufnr, desc = "Pick Test" })
end

local function get_jdtls_config()
  local root_dir = lsp_utils.jdtls.find_project_root()
  local project_name = lsp_utils.jdtls.get_workspace_name(root_dir)

  local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

  local java = home .. "/.sdkman/candidates/java/current/bin/java"

  local packages = vim.fn.stdpath("data") .. "/mason/packages"

  local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
  local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

  local java_debug = vim.fn.glob(packages .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1)
  local java_test = vim.fn.glob(packages .. "/java-test/extension/server/*.jar", 1)

  local bundles = {
    java_debug,
    java_test
  }

  local lombok_path = jdtls_path .. "/lombok.jar"

  local config_os = ({
    Linux = "config_linux",
    Darwin = "config_mac",
    Windows_NT = "config_win",
  })[vim.loop.os_uname().sysname]

  local config = {
    cmd = {
      java,

      "-javaagent:" .. lombok_path,
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",

      "-Dosgi.bundles.defaultStartLevel=4",

      "-Dlog.protocol=true",
      "-Dlog.level=ALL",

      "-Dfile.encoding=UTF-8",

      "-XX:+UseParallelGC",
      "-XX:GCTimeRatio=4",
      "-XX:AdaptiveSizePolicyWeight=90",

      "-Dsun.zip.disableMemoryMapping=true",
      "-Djava.import.generatesMetadataFilesAtProjectRoot=false",

      "-Xmx4g",
      "-Xms512m",

      "--add-modules=ALL-SYSTEM",

      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang.invoke=ALL-UNNAMED",
      "--add-opens", "java.base/java.nio=ALL-UNNAMED",
      "--add-opens", "java.base/java.io=ALL-UNNAMED",
      "--add-opens", "java.base/java.net=ALL-UNNAMED",
      "--add-opens", "java.base/sun.nio.ch=ALL-UNNAMED",

      "-jar", launcher,
      "-configuration", jdtls_path .. "/" .. config_os,
      "-data", workspace_dir,
    },

    root_dir = root_dir,

    settings = {
      java = {
        completion = {
          importOrder = { "*" },
        },

        format = {
          settings = {
            url = home .. "/.config/nvim/ftplugin/java-default-formatter.xml",
            profile = "default",
          },
        },

        codeGeneration = {
          organizeImports = {
            starThreshold = 99,
            staticStarThreshold = 99,
          },
        },
      },
    },

    init_options = {
      bundles = bundles,
      settings = {
        java = {
          errors = {
            incompleteClasspath = {
              severity = "warning",
            },
          },
        },
      },
    },

    capabilities = vim.tbl_deep_extend("force",
      vim.lsp.protocol.make_client_capabilities(),
      {
        workspace = {
          configuration = true,
        },
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true,
            },
          },
        },
      }
    ),

    on_attach = java_on_attach,
  }

  return config
end

jdtls.start_or_attach(get_jdtls_config())
