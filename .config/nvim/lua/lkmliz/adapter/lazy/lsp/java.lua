local keymappings = require("lkmliz/adapter/lazy/lsp/keymappings")

local M = {}

function M:setup()
  local jdtls = require("jdtls")

  local root_markers = { ".git", "mvnw", "gradlew", "pom.xml" }
  local root_dir = jdtls.setup.find_root(root_markers)

  if not root_dir then return end

  local home = vim.uv.os_homedir()

  local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
  local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

  local java = home .. "/.sdkman/candidates/java/current/bin/java"

  local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
  local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  local config_os = ({
    Linux = "config_linux",
    Darwin = "config_mac",
    Windows_NT = "config_win",
  })[vim.loop.os_uname().sysname]

  local config = {
    settings = {
      java = {
        -- favor static imports
        completion = {
          importOrder = { "*" },

          favoriteStaticMembers = {
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*"
          },
        },

        -- use default formatter
        format = {
          enabled = true,
          settings = {
            url = home .. ".config/nvim/java/code-style/default-formatter.xml",
            profile = "Default",
          },
        },

        -- no start imports
        codeGeneration = {
          organizeImports = {
            starThreshold = 99,
            staticStarThreshold = 99,
          },
        },
      },
    },

    cmd = {
      java,
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "-jar", launcher,
      "-configuration", jdtls_path .. "/" .. config_os,
      "-data", workspace_dir,
    },

    root_dir = root_dir,

    on_attach = function(client, bufnr) 
      keymappings.on_attach(client, bufnr)

      vim.keymap.set("n", "<leader>oi", function()
        client:exec_cmd({
          command = "java.edit.organizeImports",
          arguments = { vim.uri_from_bufnr(bufnr) }
        })
      end, { buffer = bufnr, desc = "Organize Imports" })
    end
  }

  jdtls.start_or_attach(config)
end

return M

