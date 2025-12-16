local jdtls = require("jdtls")

local bundles = {}

local home = vim.uv.os_homedir()

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

    on_attach = function(_, bufnr)
      local telescope = require("telescope.builtin")

      local opts = {
        path_display = { "smart" },
        fname_width = 60,
        trim_text = true,
        previewer = true,
      }

      vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {
        desc = "Go to Declaration",
        buffer = bufnr
      })

      vim.keymap.set("n", "<leader>gd", function()
        telescope.lsp_definitions(opts)
      end, {
        desc = "Go to Definition",
        buffer = bufnr
      })

      vim.keymap.set("n", "<leader>gi", function()
        telescope.lsp_implementations(opts)
      end, {
        desc = "Go to Implementation",
        buffer = bufnr
      })

      vim.keymap.set("n", "<leader>gr", function()
        telescope.lsp_references(opts)
      end, {
        desc = "Go to References",
        buffer = bufnr
      })

      vim.keymap.set("n", "<leader>gt", function()
        telescope.lsp_type_definitions(opts)
      end, {
        desc = "Go to Type Definition",
        buffer = bufnr
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {
        desc = "Hover Documentation",
        buffer = bufnr
      })

      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
        desc = "Code Action",
        buffer = bufnr
      })

      vim.keymap.set("n", "<leader>rn", function()
        vim.lsp.buf.rename()
      end, {
        desc = "Rename Symbol",
        buffer = bufnr
      })

      vim.keymap.set("n", "Q", function()
        vim.lsp.buf.format({ async = true })
      end, { buffer = bufnr, desc = "Format file" })

      -- Java-specific keymaps
      vim.keymap.set("n", "<leader>oi", function()
        jdtls.organize_imports()
      end, { buffer = bufnr, desc = "Organize Imports" })

      vim.keymap.set("n", "<leader>ev", function()
        jdtls.extract_variable()
      end, { buffer = bufnr, desc = "Extract Variable" })

      vim.keymap.set("v", "<leader>ev", function()
        jdtls.extract_variable(true)
      end, { buffer = bufnr, desc = "Extract Variable" })

      vim.keymap.set("n", "<leader>ec", function()
        jdtls.extract_constant()
      end, { buffer = bufnr, desc = "Extract Constant" })

      vim.keymap.set("v", "<leader>ec", function()
        jdtls.extract_constant(true)
      end, { buffer = bufnr, desc = "Extract Constant" })

      vim.keymap.set("v", "<leader>em", function()
        jdtls.extract_method(true)
      end, { buffer = bufnr, desc = "Extract Method" })

      vim.keymap.set("n", "<leader>tc", function()
        jdtls.test_class()
      end, { buffer = bufnr, desc = "Test Class" })

      vim.keymap.set("n", "<leader>tm", function()
        jdtls.test_nearest_method()
      end, { buffer = bufnr, desc = "Test Method" })

      vim.notify("JDTLS attached successfully", vim.log.levels.INFO, { title = "JDTLS" })
    end,
  }

  return config
end

jdtls.start_or_attach(get_jdtls_config())
