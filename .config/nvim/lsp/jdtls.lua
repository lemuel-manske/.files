local bundles = {}

local mason = vim.fn.stdpath("data") .. "/mason/packages"

vim.list_extend(bundles, vim.split(
  vim.fn.glob(
    mason .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
  ),
  "\n"
))

vim.list_extend(bundles, vim.split(
  vim.fn.glob(
    mason .. "/java-test/extension/server/com.microsoft.java.test.runner-*.jar"
  ),
  "\n"
))

local home = vim.uv.os_homedir()

local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" })
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

return {
  filetypes = "java",

  root_markers = { ".git", "mvnw", "gradlew", "pom.xml" },

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

  settings = {
    java = {
      completion = {
        importOrder = { "*" },
      },

      format = {
        settings = {
          url = home .. "/.config/nvim/lsp/java-default-formatter.xml",
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

  init_options = { bundles = bundles }
}
