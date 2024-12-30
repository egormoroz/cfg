local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

autocmd("BufWritePost", {
  pattern = "go",
  callback = function()
    vim.cmd("silent !go fmt %")
    vim.cmd("silent !goimports -w %")
  end
})

autocmd("FileType", {
  pattern = {"proto", 'javascript', 'javascriptreact'},
  callback = function()
    vim.opt_local.cindent = true
  end,
})
