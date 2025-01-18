--[[ local on_attach = function(client, bufnr)
  require('nvim-navic').attach(client, bufnr)
end ]]

local servers = {
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
      },
    },
  },
  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          unusedvariables = true,
          unusedwrite = true,
          useany = true,
        },
        staticcheck = true,
        gofumpt = true,
        experimentalPostfixCompletions = true,
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
          }
        }
      }
    }
  },
  ts_ls = {},
  tailwindcss = {},
}

local lspconfig = require 'lspconfig'

for server, config in pairs(servers) do
  local caps = require('blink.cmp').get_lsp_capabilities(config.capabilities)
  config.capabilities = caps
  lspconfig[server].setup(config)
end
