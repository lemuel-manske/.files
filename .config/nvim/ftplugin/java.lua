local jdtls = require("jdtls")

local bundles = {}

local home = vim.uv.os_homedir()

local function get_jdtls_config()
  local root_dir = require("jdtls.setup").find_root({
    "settings.gradle", "settings.gradle.kts",
    "gradlew", "mvnw",
    ".git"
  })

  if not root_dir then
    root_dir = vim.fn.getcwd()
  end

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
    cmd = {
      java,
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
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
        import = {
          gradle = {
            wrapper = {
              enabled = true
            }
          }
        },

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

        -- Enhanced error reporting and validation
        compile = {
          nullAnalysis = {
            mode = "automatic",
          },
        },

        errors = {
          incompleteClasspath = {
            severity = "warning",
          },
        },

        -- Enable verbose logging for troubleshooting
        trace = {
          server = "verbose",
        },

        -- Additional configuration for better error detection
        configuration = {
          checkProjectSettings = true,
          updateBuildConfiguration = "automatic",
        },

        -- Maven settings for better project detection
        maven = {
          downloadSources = true,
          updateSnapshots = true,
        },

        -- References and implementations
        references = {
          includeDecompiledSources = true,
        },

        -- Signaturehelp and hover
        signatureHelp = {
          enabled = true,
          description = {
            enabled = true,
          },
        },

        -- Content assist
        contentAssist = {
          overwrite = true,
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

    on_attach = function(client, bufnr)
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
        local ui_input = vim.ui.input

        vim.ui.input = function(_, on_confirm)
          if opts.prompt == "New name: " then
            opts.default = ""
          end
          ui_input(opts, on_confirm)
          vim.ui.input = ui_input
        end

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

vim.api.nvim_create_user_command("JdtlsRestart", function()
  vim.cmd("LspRestart jdtls")
end, { desc = "Restart JDTLS" })
