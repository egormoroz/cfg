--[[ local on_attach = function(client, bufnr)
  require('nvim-navic').attach(client, bufnr)
end ]]

local servers = {
  zls = {
    settings = {
      zls = {
        enable_snippets = false,
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
        hint = { enable = true },
      },
    },
  },
  gopls = {
    settings = {
      gopls = {
        hints = {
          constantValues = true,
        },
        staticcheck = true,
      },
    },
  },
  clangd = {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", },
  },
  basedpyright = {
    settings = {
      basedpyright = {
        analysis = {
          diagnosticSeverityOverrides = {
            reportUnknownVariableType = "none",
            reportUnknownMemberType = "none",
            reportUnknownArgumentType = "none",
            reportMissingParameterType = "none",
            reportUnknownParameterType = "none",

            reportOptionalMemberAccess = "none",

            reportPrivateLocalImportUsage = "none",
            reportUnknownLambdaType = "none",
            reportAny = "none",
            reportArgumentType = "none",

            reportUnusedCallResult = "none",
            reportMissingTypeArgument = "none",

            reportImplicitOverride = "none",
            reportMissingTypeStubs = "none",
          }
        }
      }
    }
  },
  rust_analyzer = {
    settings = {
      rust_analyzer = {
      },
    },
  },
  svelte = {},
  ts_ls = {},
}

local lspconfig = require 'lspconfig'

for server, config in pairs(servers) do
  local caps = require('blink.cmp').get_lsp_capabilities(config.capabilities, true)
  config.capabilities = caps
  lspconfig[server].setup(config)
end
