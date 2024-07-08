require 'plugin'
local M = require('mappings')
require('lsp').setup(M)


local opt = vim.opt
opt.clipboard = 'unnamed,unnamedplus'
opt.shiftwidth = 4
opt.tabstop = 4
opt.number = true
opt.expandtab = true

-- currently sometimes neovim causes THE WHOLE FUCKING DE TO HANG FOREVER
-- It happens on KDE, different ubuntu versions, different kernels versions
-- Current suspects: LSP and swap. The LSP is more likely, but I don't want to turn it off :-(
-- So for now let's try to rule out the swap file
-- UPDATE: no issues thus far, seems to werk
vim.opt.swapfile = false

opt.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.cmd[[
    colorscheme gruvbox
]]


for _, m in pairs(M.mappings) do
    local mode = M.opts.mode
    if m.mode ~= nil then
        mode = m.mode
    end
    vim.keymap.set(mode, m.key, m.mapping, { silent = M.opts.silent })
end

print('config load3d')

