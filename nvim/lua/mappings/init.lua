return {
  setup_global = function()
    require 'mappings.telescope'
    require 'mappings.html'
    require 'mappings.stuff'
    require 'mappings.lsp'
  end,
  blink = require 'mappings.blink',
}
