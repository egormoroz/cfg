local bi = function () return require('telescope.builtin') end
local fb = function () return require('telescope').extensions.file_browser end

local bufdir = function() return vim.fn.expand('%:p:h') end
local mapn = function(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end

mapn('<leader>fG', function ()
  bi().live_grep()
end, 'telescope live grep')
mapn('<leader>fg', function()
  bi().live_grep { cwd = bufdir() }
end, 'telescope bufdir live grep')

mapn('<leader>fF', function ()
  bi().find_files()
end, 'telescope find files')
mapn('<leader>ff', function ()
  bi().find_files { cwd = bufdir() }
end, 'telescope bufdir find files')

mapn('<leader>fB', function ()
  bi().buffers { select_current = true, only_cwd = true }
end, 'telescope find buffers in cwd')
mapn('<leader>fb', function ()
  bi().buffers { select_current = true }
end, 'telescope find buffers')

mapn('<leader>f?', function () bi().oldfiles() end, 'telescope find oldfiles')
mapn('<leader>fs', function ()
  bi().current_buffer_fuzzy_find()
end, 'telescope search buffer')

mapn('<leader>cm', function () bi().git_commits() end, 'telescope git commits')
mapn('<leader>cs', function () bi().git_status() end, 'telescope git status')

mapn('<leader>n', function () fb() end, 'telescope file browser')
mapn('<leader>n', function ()
  fb().file_browser { path = bufdir() }
end, 'telescope bufdir file browser')

mapn('<leader>ud', function () bi().diagnostics() end, 'telescope diagnostics')
mapn('<leader>ur', function () bi().lsp_references() end, 'telescope lsp references')
mapn('<leader>us', function ()
  bi().lsp_document_symbols()
end, 'telescope lsp doc symbols')
