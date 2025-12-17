local jdtls = require("jdtls")
local lsp_utils = require("lkmliz.lsp_utils")

local bundles = {}

local home = vim.uv.os_homedir()

local function java_on_attach(client, bufnr)
  -- Call the base on_attach from lsp_utils
  lsp_utils.on_attach(client, bufnr)
  
  -- Add Java-specific keymaps
  vim.keymap.set("n", "<leader>oi", function()
    jdtls.organize_imports()
  end, { buffer = bufnr, desc = "Organize Imports" })
end

local function find_project_root()
  local root_dir = require("jdtls.setup").find_root({
    "gradlew", "mvnw"
  })

  return root_dir
end

local function get_workspace_name(root_dir)
  local project_name = vim.fn.fnamemodify(root_dir, ":t")

  return project_name
end

local function get_jdtls_config()
  local root_dir = find_project_root()
  local project_name = get_workspace_name(root_dir)

  local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

  local java = home .. "/.sdkman/candidates/java/current/bin/java"

  local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
  local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

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

      "-Xmx1g",
      "-Xms100m",

      "--add-modules=ALL-SYSTEM",

      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",

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
