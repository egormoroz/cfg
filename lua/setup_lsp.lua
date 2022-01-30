-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = { noremap = true, silent = true }
  local function buf_set_keymap(key, cmd) vim.api.nvim_buf_set_keymap(bufnr, 'n', key, cmd, opts) end

  buf_set_keymap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  buf_set_keymap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_set_keymap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  buf_set_keymap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  buf_set_keymap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  buf_set_keymap('<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  buf_set_keymap('<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  buf_set_keymap('<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
  buf_set_keymap('<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  buf_set_keymap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  buf_set_keymap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  buf_set_keymap('ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  buf_set_keymap('<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
  buf_set_keymap('g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  buf_set_keymap('g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
  buf_set_keymap('<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')
  buf_set_keymap('<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

nvim_lsp.pylsp.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

nvim_lsp.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

nvim_lsp.sumneko_lua.setup({
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

require('rust-tools').setup({
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
  },
  server = {
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        },
      },
    },
  },
})

-- vim.opt.updatetime = 300
-- vim.cmd('autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()')
-- vim.cmd('autocmd CursorHold * lua vim.diagnostic.open_float()')

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

