local map = vim.keymap.set

-- insert lines
map('n', '<Enter>', function()
  if vim.bo.modifiable then
    return "o<Esc>"
  else
    return "<Enter>"
  end
end, { expr = true, desc = "Insert line below" })

map('n', '<leader><Enter>', function()
  if vim.bo.modifiable then
    return "O<Esc>"
  else
    return "<Enter>"
  end
end, { expr = true, desc = "Insert line below" })

-- windows
map('n', '<leader>wj', '<C-w>1w', { desc = 'nav to window 1' })
map('n', '<leader>wk', '<C-w>2w', { desc = 'nav to window 2' })
map('n', '<leader>wl', '<C-w>3w', { desc = 'nav to window 3' })
map('n', '<leader>w;', '<C-w>4w', { desc = 'nav to window 4' })
map('n', '<leader>wq', '<C-w>c', { desc = 'close cur window' })
map('n', '<leader>wo', '<C-w>o', { desc = 'close other windows' })
map('n', '<leader>ws', '<C-w>s', { desc = 'horizontal split' })
map('n', '<leader>wv', '<C-w>v', { desc = 'vertical split' })

-- toggleterm
map('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>',
  { desc = 'open horizontal terminal' })
map('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>',
  { desc = 'open vertical terminal' })
map('n', '<leader>tf', ':ToggleTerm direction=float<CR>',
  { desc = 'open floating terminal' })
map({'n', 'i'}, '<C-t>', ':ToggleTerm direction=float<CR>',
  { desc = 'open floating terminal' })

map('t', '<C-t>', '<C-\\><C-n>:ToggleTerm<CR>', { desc = 'close terminal' })
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'enter normal mode' })

-- run lazy git in toggleterm
map('n', '<leader>lg', '<cmd>TermExec direction=float cmd="lazygit"<CR>',
  { desc = 'run lazy git in toggleterm' })

-- nerd tree
map('n', '<C-n>', '<cmd>NERDTreeToggle<CR>',
  { desc = 'toggle NERDTree' })
map('n', '<leader>t', '<cmd>NERDTreeFind<CR>',
  { desc = 'find current file in NERDTree' })

-- telescope
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>',
  { desc = 'telescope live grep' })
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>',
  { desc = 'telescope find buffers' })
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>',
  { desc = 'telescope find files' })
map('n', '<leader>f?', '<cmd>Telescope oldfiles<CR>',
  { desc = 'telescope find oldfiles' })
map('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<CR>',
  { desc = 'telescope find in current buffer' })
map('n', '<leader>cm', '<cmd>Telescope git_commits<CR>',
  { desc = 'telescope git commits' })
map('n', '<leader>gt', '<cmd>Telescope git_status<CR>',
  { desc = 'telescope git status' })

map('n', '<leader>n', '<cmd>Telescope file_browser<CR>',
  { desc = 'telescope file browser' })

map('n', '<leader>lr', '<cmd>Telescope lsp_references<CR>',
  { desc = 'telescope lsp references' })
map('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<CR>',
  { desc = 'telescope lsp doc symbols' })
map('n', '<leader>ld', '<cmd>Telescope diagnostics<CR>',
  { desc = 'telescope diagnostics' })

-- find current file
map('n', '<leader>m', function()
    local current_file = vim.fn.expand('%:p')
    local parent_dir = vim.fn.fnamemodify(current_file, ':h')
    require('telescope').extensions.file_browser.file_browser({
        path = parent_dir,
        cwd = parent_dir,
    })
end, { desc = 'telescope parent directory' })

-- dbee
map('n', '<leader>do', '<cmd>Dbee open<CR>', { desc = 'dbee open' })
map('n', '<leader>dc', '<cmd>Dbee close<CR>', { desc = 'dbee close' })
map('n', '<leader>dd', '<cmd>Dbee toggle<CR>', { desc = 'dbee toggle' })
map('n', '<leader>de', '<cmd>Dbee execute<CR>', { desc = 'dbee exec' })
