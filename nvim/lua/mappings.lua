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

-- telescope

map('n', '<leader>fg', function()
    local current_file = vim.fn.expand('%:p')
    local parent_dir = vim.fn.fnamemodify(current_file, ':h')
    require('telescope.builtin').live_grep({
        search_dirs = { parent_dir },
        cwd = parent_dir,
    })
end, { desc = 'telescope bufdir live grep' })

map('n', '<leader>fG', '<cmd>Telescope live_grep<CR>',
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

map('n', '<leader>ur', '<cmd>Telescope lsp_references<CR>',
  { desc = 'telescope lsp references' })
map('n', '<leader>us', '<cmd>Telescope lsp_document_symbols<CR>',
  { desc = 'telescope lsp doc symbols' })
map('n', '<leader>ud', '<cmd>Telescope diagnostics<CR>',
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

local s = require('utils.surround')

map('n', '<leader>wt', function()
  local tag = vim.fn.input('Tag: ')
  if tag == '' then return end
  local line = vim.api.nvim_get_current_line()
  local new_line = s.surround(line, tag, 1, #line)
  vim.api.nvim_set_current_line(new_line)
end, { desc = 'surround curline with tag' })

local update_lines = function(update)
  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")

  local tag = vim.fn.input('Tag: ')
  if tag == '' then return end

  local s_line = math.min(start_pos[2], end_pos[2])
  local e_line = math.max(start_pos[2], end_pos[2])
  local s_col = math.min(start_pos[3], end_pos[3])
  local e_col = math.max(start_pos[3], end_pos[3])

  local lines = vim.api.nvim_buf_get_lines(0, s_line - 1, e_line, false)
  lines = update(lines, tag, s_col, e_col)

  vim.api.nvim_buf_set_lines(0, s_line - 1, e_line, false, lines)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
end

map('v', '<leader>wt', function()
  update_lines(function (lines, tag, sc, ec)
    return s.surround_lines(lines, tag, true, sc, ec)
  end)
end, { desc = 'surround lines with tag inline' })

map('v', '<leader>wT', function()
  update_lines(function (lines, tag, sc, ec)
    return s.surround_lines(lines, tag, false, sc, ec)
  end)
end, { desc = 'surround lines with tag' })

map('v', '<leader>wy', function()
  update_lines(function (lines, tag, _, _)
    return s.surround_block(lines, tag, false)
  end)
end, { desc = 'surround block with tag' })

map('v', '<leader>wY', function()
  update_lines(function (lines, tag, _, _)
    return s.surround_block(lines, tag, true)
  end)
end, { desc = 'surround block with tag inline', noremap = true })
