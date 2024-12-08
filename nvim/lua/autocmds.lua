local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

autocmd("BufWritePost", {
  pattern = "*.go",
  callback = function()
  vim.cmd("silent !go fmt %")
  vim.cmd("silent !goimports -w %")
  end
})

autocmd("FileType", {
  pattern = {"proto", "lua"},
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})
