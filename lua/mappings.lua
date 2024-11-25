return {
  mappings = {
    {
      key = '<leader>q',
      mapping = '<cmd>bd<CR>',
      descr = 'Close current buffer'
    },
    {
      key = '<leader>th',
      mapping = '<cmd>ToggleTerm direction=horizontal<CR>',
      descr = 'Open horizontal terminal'
    },
    {
      key = '<leader>tv',
      mapping = '<cmd>ToggleTerm direction=vertical<CR>',
      descr = 'Open vertical terminal'
    },
    {
      key = '<leader>tf',
      mapping = '<cmd>ToggleTerm direction=float<CR>',
      descr = 'Open floating terminal'
    },
    {
      key = '<C-t>',
      mapping = ':ToggleTerm direction=float<CR>',
      mode = 'n',
    },
    {
      key = '<C-t>',
      mapping = '<C-\\><C-n>:ToggleTerm<CR>',
      mode = 't',
    },
    {
      key = '<Esc>',
      mapping = '<C-\\><C-n>',
      mode = 't',
    },
    {
      key = '<C-n>',
      mapping = '<cmd>NERDTreeToggle<CR>',
      descr ='Toggle NERDTree'
    },
    {
      key = '<leader>t',
      mapping = '<cmd>NERDTreeFind<CR>',
      descr = 'Find current file in NERDTree'
    },
    {
      key = '<leader>f?',
      mapping = [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]]
    },
    {
      key = '<leader>ff',
      mapping = [[<cmd>lua require('telescope.builtin').find_files({previewer=false})<CR>]]
    },
    {
      key = '<leader>fb',
      mapping = [[<cmd>lua require('telescope.builtin').buffers()<CR>]]
    },
    {
      key = '<leader>fg',
      mapping = [[<cmd>lua require('telescope.builtin').live_grep()<CR>]]
    },
    {
      key = '<leader>fs',
      mapping = [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]]
    },
    {
      key = '<Enter>',
      mapping = 'o<ESC>'
    },
    {
      key = '<A-Enter>',
      mapping = 'O<ESC>'
    },
    {
      key = '<leader>do',
      mapping = [[<cmd>lua require('dbee').open()<CR>]]
    },
    {
      key = '<leader>dc',
      mapping = [[<cmd>lua require('dbee').close()<CR>]]
    },
    {
      key = '<leader>dd',
      mapping = [[<cmd>lua require('dbee').toggle()<CR>]]
    },
    {
      key = '<leader>de',
      mapping = [[<cmd>lua require('dbee').execute()<CR>]]
    },
    {
      key = '<leader>lg',
      mapping = '<cmd>TermExec direction=float cmd="lazygit"<CR>'
    },
    {
      key = '<leader>wj',
      mapping = '<C-w>1w'
    },
    {
      key = '<leader>wk',
      mapping = '<C-w>2w'
    },
    {
      key = '<leader>wl',
      mapping = '<C-w>3w'
    },
    {
      key = '<leader>w;',
      mapping = '<C-w>4w'
    },
    {
      key = '<leader>wq',
      mapping = '<C-w>c'
    },
    {
      key = '<leader>wo',
      mapping = '<C-w>o'
    },
  },

  opts = {
    mode = 'n',
    silent = true,
  },

  -- TODO: add descriptions
  lsp_mappings = {
    ['gD'] = { '<cmd>lua vim.lsp.buf.declaration()<CR>' },
    ['gd'] = { '<cmd>lua vim.lsp.buf.definition()<CR>' },
    ['K'] = { '<cmd>lua vim.lsp.buf.hover()<CR>' },
    ['gi'] = { '<cmd>lua vim.lsp.buf.implementation()<CR>' },
    ['<C-k>'] = { '<cmd>lua vim.lsp.buf.signature_help()<CR>' },
    ['<leader>D'] = { '<cmd>lua vim.lsp.buf.type_definition()<CR>' },
    ['<leader>rn'] = { '<cmd>lua vim.lsp.buf.rename()<CR>' },
    ['gr'] = { '<cmd>lua vim.lsp.buf.references()<CR>' },
    ['ga'] = { '<cmd>lua vim.lsp.buf.code_action()<CR>' },
    ['<leader>e'] = { '<cmd>lua vim.diagnostic.open_float()<CR>' },
    ['g['] = { '<cmd>lua vim.diagnostic.goto_prev()<CR>' },
    ['g]'] = { '<cmd>lua vim.diagnostic.goto_next()<CR>' },
    ['<leader>q'] = { '<cmd>lua vim.diagnostic.setloclist()<CR>' },

    ['<leader>lr'] = { '<cmd>Telescope lsp_references<CR>' },
    ['<leader>ls'] = { '<cmd>Telescope lsp_document_symbols<CR>' },
    ['<leader>ld'] = { '<cmd>Telescope diagnostics<CR>' },
  },

  make_telescope_mappings = function (actions)
    return { i = {
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
    }}
  end,

  apply_manual = function ()
    vim.keymap.set('n', '<Enter>', function()
      if vim.bo.modifiable then
        return "o<Esc>"
      else
        return "<Enter>"
      end
    end, { expr = true, desc = "Insert line below" })

    vim.keymap.set('n', '<A-Enter>', function()
      if vim.bo.modifiable then
        return "O<Esc>"
      else
        return "<A-Enter>"
      end
    end, { expr = true, desc = "Insert line above" })
  end
}
