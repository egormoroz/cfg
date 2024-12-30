local M = {}

local prepend = function(str, text, s)
  s = str:find('%S', s)
  if not s then return str end
  return str:sub(1, s-1) .. text .. str:sub(s)
end

local append = function(str, text, e)
  e = #str - (str:reverse():find('%S', #str - e + 1) or #str) + 1
  if e == 1 then return str end
  return str:sub(1, e) .. text .. str:sub(e + 1)
end

local indent_unit = function ()
  if vim.bo.expandtab then
    return string.rep(' ', vim.bo.shiftwidth)
  end
  return '\t'
end

M.surround = function(str, tag, s, e)
  local prep = prepend(str, '<' .. tag .. '>', s)
  return append(prep, '</' .. tag .. '>', e + #tag + 2)
end

M.surround_lines = function(lines, tag, inline, s_col, e_col)
  if inline then
    for i, line in ipairs(lines) do
      local e = e_col
      if e_col <= s_col or e_col > #line then e = #line end
      lines[i] = M.surround(line, tag, s_col, e)
    end
    return lines
  end

  local open, close = '<'..tag..'>', '</'..tag..'>'
  local extra = indent_unit()
  local res = {}
  for _, line in ipairs(lines) do
    if line:find('%S') then
      local indent = line:match('^%s*') or ''
      table.insert(res, indent..open)
      table.insert(res, extra..line)
      table.insert(res, indent..close)
    else
      table.insert(res, line)
    end
  end
  return res
end

M.surround_block = function(lines, tag, inline)
  local open, close = '<'..tag..'>', '</'..tag..'>'
  local first, indent = 1, nil
  for i, line in ipairs(lines) do
    if line:find('%S') then
      first, indent = i, line:match('^%s*')
      break
    end
  end

  if not indent then return lines end

  local last = #lines
  for i = #lines, 1, -1 do
    if lines[i]:find('%S') then
      last = i
      break
    end
  end

  if inline then
    lines[first] = prepend(lines[first], open, 1)
    lines[last] = append(lines[last], close, #lines[last])
    return lines
  end

  table.insert(lines, first, indent..open)
  table.insert(lines, last+2, indent..close)
  local extra = indent_unit()
  for i = first+1, last+1 do
    lines[i] = extra .. lines[i]
  end
  return lines
end

return M
