return {
  ensure_installed = {
    'c', 'lua', 'cpp', 'python', 'go', 'vim', 'vimdoc', 'sql', 'proto'
  },

  highlight = {
    enable = true,
    use_languagetree = true,
    -- additional_vim_regex_highlighting = { "python" },
  },
  indent = {
    enable = true,
    disable = { 'proto' },
  },
}
