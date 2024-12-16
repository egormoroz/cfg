local map = vim.keymap.set

local on_attach = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = 'LSP ' .. desc, noremap = true }
  end

  require('nvim-navic').attach(client, bufnr)

  map('n', 'gD', vim.lsp.buf.declaration, opts 'go to decl')
  map('n', 'gd', vim.lsp.buf.definition, opts 'go to def')
  map('n', 'gi', vim.lsp.buf.implementation, opts 'go to impl')
  map('n', '<leader>D', vim.lsp.buf.type_definition, opts 'go to type def')
  map('n', 'gr', vim.lsp.buf.references, opts 'go to references')

  map('n', 'g[', vim.diagnostic.goto_prev, opts 'go to next diagnostic')
  map('n', 'g]', vim.diagnostic.goto_next, opts 'go to prev diagnostic')

  map('n', 'ga', vim.lsp.buf.code_action, opts 'code actions')
  map('n', '<leader>rn', vim.lsp.buf.rename, opts 'rename symbol')

  map('n', 'K', vim.lsp.buf.hover, opts 'show hover info')
  map({'n', 'i'}, '<C-K>', vim.lsp.buf.signature_help, opts 'show sig help')

  map('n', '<leader>e', vim.diagnostic.open_float, opts 'expand diagnostic')

  map('n', '<leader>ur', '<cmd>Telescope lsp_references<CR>',
    opts 'telescope lsp references')
  map('n', '<leader>us', '<cmd>Telescope lsp_document_symbols<CR>',
    opts 'telescope lsp doc symbols')
  map('n', '<leader>ud', '<cmd>Telescope diagnostics<CR>',
    opts 'telescope diagnostic')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local lspconfig = require 'lspconfig'

lspconfig['gopls'].setup{
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        unusedvariables = true,
        shadow = true,
        unusedwrite = true,
        useany = true,
      },
      staticcheck = true,
      gofumpt = true,
      experimentalPostfixCompletions = true,
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig['clangd'].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", },
})

lspconfig["basedpyright"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
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
}

lspconfig.lua_ls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
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
}

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
-- lspconfig.eslint.setup {
--   -- on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- lspconfig.buf_ls.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
