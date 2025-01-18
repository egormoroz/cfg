local s = require('utils.surround')
local map = function (mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc=desc, noremap=true })
end

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

map('n', '<leader>wt', function()
  local tag = vim.fn.input('Tag: ')
  if tag == '' then return end
  local line = vim.api.nvim_get_current_line()
  local new_line = s.surround(line, tag, 1, #line)
  vim.api.nvim_set_current_line(new_line)
end, 'surround curline with tag')

map('v', '<leader>wt', function()
  update_lines(function (lines, tag, sc, ec)
    return s.surround_lines(lines, tag, true, sc, ec)
  end)
end, 'surround lines with tag inline')

map('v', '<leader>wT', function()
  update_lines(function (lines, tag, sc, ec)
    return s.surround_lines(lines, tag, false, sc, ec)
  end)
end, 'surround lines with tag')

map('v', '<leader>wy', function()
  update_lines(function (lines, tag, _, _)
    return s.surround_block(lines, tag, false)
  end)
end, 'surround block with tag')

map('v', '<leader>wY', function()
  update_lines(function (lines, tag, _, _)
    return s.surround_block(lines, tag, true)
  end)
end, 'surround block with tag inline')
