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
  extensions = {
    file_browser = {
      respect_gitignore = false,
    },
  },
}
tel.load_extension('fzf')
