vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-i>', '<C-i>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')

vim.keymap.set('n', '<C-e>', vim.cmd.Ex)

vim.keymap.set('v', '<leader>p', '"_dP')
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>x', '"_x')
vim.keymap.set('v', '<leader>y', '"+y')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', '<leader>o', 'o<Esc>')
vim.keymap.set('n', '<leader>O', 'O<Esc>')

vim.keymap.set('n', '<C-a>', 'ggVG')

vim.keymap.set('n', '<leader>bj', vim.cmd.bnext)
vim.keymap.set('n', '<leader>bk', vim.cmd.bprev)
