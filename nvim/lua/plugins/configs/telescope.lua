local tel = require 'telescope'
local actions = require('telescope.actions')

tel.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-p>'] = actions.delete_buffer,
        ['<C-d>'] = actions.preview_scrolling_down,
        ['<C-u>'] = actions.preview_scrolling_up,
        ['<C-[>'] = actions.preview_scrolling_left,
        ['<C-]>'] = actions.preview_scrolling_right,
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
