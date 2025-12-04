local M = {}

function M:setup()
  local jdtls = require("jdtls")

  local root_markers = { ".git", "mvnw", "gradlew", "pom.xml" }
  local root_dir = jdtls.setup.find_root(root_markers)

  if not root_dir then return end

  local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
  local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

  local java_version = "21.0.7-tem"
  local home = vim.uv.os_homedir()
  local java = home .. "/.sdkman/candidates/java/" .. java_version .. "/bin/java"

  local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
  local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  local config_os = ({
    Linux = "config_linux",
    Darwin = "config_mac",
    Windows_NT = "config_win",
  })[vim.loop.os_uname().sysname]

  local config = {
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
    settings = { java = {} },
    init_options = { bundles = {} },
  }

  jdtls.start_or_attach(config)
end

return M

