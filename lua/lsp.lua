local setup = function(M)
    local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        for key, mapping in pairs(M.lsp_mappings) do
            vim.api.nvim_buf_set_keymap(bufnr, 'n',
                key, mapping[1],  { noremap = true, silent = true })
        end
    end

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local lspconfig = require 'lspconfig'
    local servers = { 'clangd', 'pyright', 'rust_analyzer', 'gopls' }
    for _, server in pairs(servers) do
        lspconfig[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end

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
