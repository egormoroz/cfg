return {
  setup_global = function()
    require 'mappings.telescope'
    require 'mappings.html'
    require 'mappings.stuff'
    require 'mappings.lsp'
    require 'mappings.tabs'
  end,
  blink = require 'mappings.blink',
}
