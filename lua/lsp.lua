local setup = function(M)
    local on_attach = function(_, bufnr)
        for key, mapping in pairs(M.lsp_mappings) do
            vim.api.nvim_buf_set_keymap(bufnr, 'n',
                key, mapping[1],  { noremap = true, silent = true })
        end
    end

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local lspconfig = require 'lspconfig'
    local servers = { 'clangd', 'rust_analyzer', 'gopls' }
    for _, server in pairs(servers) do
        lspconfig[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end

    lspconfig["basedpyright"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            basedpyright = {
                analysis = {
                    diagnosticSeverityOverrides = {
                        -- pyright cant properly infer the types, so don't bother
                        reportUnknownVariableType = "none",
                        reportUnknownMemberType = "none",
                        reportUnknownArgumentType = "none",
                        reportMissingParameterType = "none",
                        reportUnknownParameterType = "none",

                        --
                        reportOptionalMemberAccess = "none",

                        -- retarded
                        reportPrivateLocalImportUsage = "none",
                        reportUnknownLambdaType = "none",
                        reportAny = "none",

                        -- just annoying
                        reportUnusedCallResult = "none",
                        reportMissingTypeArgument = "none",

                        -- i use older python
                        reportImplicitOverride = "none",
                    }
                }
            }
        }
    })

    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    })

    require('nvim-cmp').setup()
end

return { setup = setup }
