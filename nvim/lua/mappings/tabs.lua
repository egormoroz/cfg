local mapn = function(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end

mapn('<leader>tj', '<cmd>tabnext<CR>', 'next tab')
mapn('<leader>tk', '<cmd>tabprevious<CR>', 'previous tab')
mapn('<leader>tq', '<cmd>tabclose<CR>', 'close tab')
