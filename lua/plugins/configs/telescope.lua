local tel = require 'telescope'
local actions = require('telescope.actions')

tel.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      }
    }
  },
  -- extensions = {
  --   file_browser = {
  --     mappings = {
  --       i = {
  --         ["<C-m>"] = current_bufr_dir
  --       },
  --     },
  --   },
  -- },
}
tel.load_extension('fzf')
