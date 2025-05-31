local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc='LSP '..desc, noremap=true })
end

map('n', 'gD', vim.lsp.buf.declaration, 'go to decl')
map('n', 'gd', vim.lsp.buf.definition, 'go to def')
-- map('n', 'gi', vim.lsp.buf.implementation, 'go to impl')
map('n', '<leader>D', vim.lsp.buf.type_definition, 'go to type def')
map('n', 'gr', vim.lsp.buf.references, 'go to references')

map('n', 'g[', vim.diagnostic.goto_prev, 'go to next diagnostic')
map('n', 'g]', vim.diagnostic.goto_next, 'go to prev diagnostic')

map('n', 'ga', vim.lsp.buf.code_action, 'code actions')
map('n', '<leader>rn', vim.lsp.buf.rename, 'rename symbol')

map('n', 'K', vim.lsp.buf.hover, 'show hover info')
map({'n', 'i'}, '<C-K>', vim.lsp.buf.signature_help, 'show sig help')

map('n', '<leader>e', vim.diagnostic.open_float, 'expand diagnostic')
