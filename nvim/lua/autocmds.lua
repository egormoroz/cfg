local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = {"go", "make"},
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

autocmd("FileType", {
  pattern = {"tsv"},
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 32
    vim.opt_local.softtabstop = 0
    vim.opt_local.shiftwidth = 32
  end,
})

autocmd("FileType", {
  pattern = {"proto", 'javascript', 'javascriptreact'},
  callback = function()
    vim.opt_local.cindent = true
  end,
})
