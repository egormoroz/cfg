local bi = function () return require('telescope.builtin') end
local fb = function () return require('telescope').extensions.file_browser end

local bufdir = function() return vim.fn.expand('%:p:h') end
local mapn = function(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end

mapn('gi', function() bi().lsp_implementations() end, 'goto impl')

mapn('<leader>fG', function ()
  bi().live_grep()
end, 'telescope live grep')
mapn('<leader>fg', function()
  bi().live_grep { cwd = bufdir() }
end, 'telescope bufdir live grep')

mapn('<leader>fd', function ()
  bi().find_files()
end, 'telescope find files')
mapn('<leader>ff', function ()
  bi().find_files { cwd = bufdir() }
end, 'telescope bufdir find files')

mapn('<leader>fD', function ()
  bi().find_files { cwd = vim.fn.stdpath('config') }
end, 'telescope findfiles config')

mapn('<leader>fB', function ()
  bi().buffers { only_cwd = true }
end, 'telescope find buffers in cwd')
mapn('<leader>fb', function ()
  bi().buffers()
end, 'telescope find buffers')

mapn('<leader>f?', function () bi().oldfiles() end, 'telescope find oldfiles')
mapn('<leader>fs', function ()
  bi().current_buffer_fuzzy_find()
end, 'telescope search buffer')

mapn('<leader>cm', function ()
  local previewers = require('telescope.previewers')
  local delta = previewers.new_termopen_previewer {
    get_command = function(entry)
      if entry.status == '??' or 'A ' then
        return {'git', 'diff', entry.value}
      end
      return {'git', 'diff', entry.value .. '^!'}
    end
  }

  local opts = {}
  opts.previewer = {
    delta,
    previewers.git_commit_message.new(opts),
    previewers.git_commit_diff_as_was.new(opts),
  }

  bi().git_commits(opts)
end, 'telescope git commits')

mapn('<leader>cs', function()
  local previewers = require('telescope.previewers')
  bi().git_status {
    previewer = previewers.new_termopen_previewer {
      get_command = function(entry)
        return {'git', 'diff', entry.path}
      end
    }
  }
end, 'telescope git status')

mapn('<leader>n', function () fb().file_browser() end, 'telescope file browser')
mapn('<leader>m', function ()
  fb().file_browser { path = bufdir() }
end, 'telescope bufdir file browser')

mapn('<leader>ud', function () bi().lsp_definitions() end, 'telescope lsp defs')
mapn('<leader>ue', function () bi().diagnostics() end, 'telescope diagnostics')
mapn('<leader>ur', function () bi().lsp_references() end, 'telescope lsp references')
mapn('<leader>us', function ()
  bi().lsp_document_symbols()
end, 'telescope lsp doc symbols')

