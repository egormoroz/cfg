return {
  preset = 'none',

  ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
  ['<C-e>'] = { 'hide' },
  ['<C-y>'] = { 'select_and_accept' },

  ['<C-k>'] = { 'select_prev', 'fallback' },
  ['<C-j>'] = { 'select_next', 'fallback' },

  ['<C-p>'] = { 'scroll_documentation_up', 'fallback' },
  ['<C-n>'] = { 'scroll_documentation_down', 'fallback' },

  ['<M-l>'] = { 'snippet_forward', 'fallback' },
  ['<M-h>'] = { 'snippet_backward', 'fallback' },

  ['<M-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
}
