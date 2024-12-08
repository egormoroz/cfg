return {
  theme = 'gruvbox',
  sections = {
    lualine_c = {
      function()
        local sig = require("lsp_signature").status_line(90)
        if not sig.label or sig.label:match("^%s*$") then
          local filename = vim.fn.expand('%:t')
          return filename ~= '' and filename or '[No Name]'
        end

        local label = sig.label
        if sig.range then
          -- Split the label into parts and insert highlighting
          local before = label:sub(1, sig.range.start-1)
          local arg = label:sub(sig.range.start, sig.range['end'])
          local after = label:sub(sig.range['end'] + 1)
          -- You might need to adjust the highlight groups based on your colorscheme
          label = before .. '%#LspSignatureActiveParameter#' .. arg .. '%#Normal#' .. after
        end
        return label
      end,
    }
  }
}
