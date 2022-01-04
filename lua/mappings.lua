--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

vim.api.nvim_set_keymap('', '<C-n>', ':NERDTree<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<leader>r', ':NERDTreeFind<CR>', { noremap = true })

vim.api.nvim_set_keymap('', '<F2>', ':mksession! ~/.vim_session <CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<F3>', ':source ~/.vim_session <CR>', { noremap = true })

vim.cmd[[
    cd ~/
    aug CSV_Editing
    		au!
    		au BufRead,BufWritePost *.csv :%ArrangeColumn
    		au BufWritePre *.csv :%UnArrangeColumn
    aug end
    let g:csv_autocmd_arrange = 1
]]

