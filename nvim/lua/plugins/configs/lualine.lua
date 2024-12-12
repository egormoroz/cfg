local sigline = ''
local hidesig = function ()
  return #sigline == 0
end

local get_sigline = function()
  local sig = require("lsp_signature").status_line(85)
  if not sig.label or not sig.range or sig.label:match("^%s*$") then
    return ''
  end

  local label = sig.label
  local before = label:sub(1, sig.range.start-1)
  local cur = label:sub(sig.range.start, sig.range['end'])
  local after = label:sub(sig.range['end'] + 1)
  return table.concat({
    '%#Normal#' .. before,
    '%#Special#' .. cur,
    '%#Normal#' .. after,
  })
end

local subsec = function(name)
  return { name, cond = hidesig }
end

return {
  theme = 'gruvbox',
  sections = {
    lualine_a = { subsec 'mode' },
    lualine_b = { subsec'branch', subsec'diff', subsec'diagnostics' },
    lualine_c = {
      subsec'filename',
      {
        function()
          return sigline
        end,
        cond = function ()
          sigline = get_sigline()
          return #sigline > 0
        end
      },
    },
    lualine_x = { subsec'encoding', subsec'fileformat', subsec'filetype' },
    lualine_y = {subsec'progress'},
    lualine_z = {subsec'location'},
  },
  winbar = {
    lualine_c = {
      {
        'navic',
        color_correction = nil,
      }
    }
  }
}
