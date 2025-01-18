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
map({'n', 't'}, '<c-l>', (function ()
  local lazygit = nil
  return function ()
    if not lazygit then
      local Terminal = require('toggleterm.terminal').Terminal
      lazygit = Terminal:new({
        cmd = 'lazygit',
        hidden = true,
        direction = 'float',
        dir = 'git_dir',
        on_exit = function ()
          lazygit = nil
        end
      })
    end
    lazygit:toggle()
  end
end)(), { desc = 'run lazy git in toggleterm' })

-- nerd tree
map('n', '<C-n>', '<cmd>NERDTreeToggle<CR>',
  { desc = 'toggle NERDTree' })
map('n', '<leader>t', '<cmd>NERDTreeFind<CR>',
  { desc = 'find current file in NERDTree' })


-- dbee
map('n', '<leader>do', '<cmd>Dbee open<CR>', { desc = 'dbee open' })
map('n', '<leader>dc', '<cmd>Dbee close<CR>', { desc = 'dbee close' })
map('n', '<leader>dd', '<cmd>Dbee toggle<CR>', { desc = 'dbee toggle' })
map('n', '<leader>de', '<cmd>Dbee execute<CR>', { desc = 'dbee exec' })

map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk_inline<CR>',
  { desc = 'gitsigns preview hunk' })

map('n', '<leader>w\\', function()
  local save_cursor = vim.fn.getpos(".")
  local old_query = vim.fn.getreg('/')
  local had_hl = vim.v.hlsearch == 1
  vim.cmd([[:%s/\s\+$//e]])
  if had_hl then
    vim.fn.setreg('/', old_query)
  else
    vim.cmd 'nohl'
  end
  vim.fn.setpos('.', save_cursor)
end, {
  desc = 'rem trailing whitespace',
  silent = true,
  noremap = true,
})

