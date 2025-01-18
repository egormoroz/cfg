local tel = require 'telescope'
local actions = require('telescope.actions')

tel.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-u>'] = actions.delete_buffer,
        ['<C-n>'] = actions.preview_scrolling_down,
        ['<C-p>'] = actions.preview_scrolling_up,
        ['<C-h>'] = actions.preview_scrolling_left,
        ['<C-l>'] = actions.preview_scrolling_right,
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
