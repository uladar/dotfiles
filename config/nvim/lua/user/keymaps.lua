local map = vim.keymap.set

vim.g.mapleader = ','
vim.g.maplocalleader = ','

local silent = { silent = true }

-- Keep the familiar Russian keyboard layout for normal, visual and operator-pending modes.
local movement = {
  ['р'] = 'h', ['Р'] = 'h',
  ['о'] = 'j', ['О'] = 'j',
  ['л'] = 'k', ['Л'] = 'k',
  ['д'] = 'l', ['Д'] = 'l',
  ['ц'] = 'w', ['Ц'] = 'w',
  ['и'] = 'b', ['И'] = 'b',
  ['у'] = 'e', ['У'] = 'e',
}

for lhs, rhs in pairs(movement) do
  map({ 'n', 'x', 'o' }, lhs, rhs)
end

-- Common editing commands while staying on the Russian layout.
local editing = {
  ['ш'] = 'i', ['Ш'] = 'i',
  ['ф'] = 'a', ['Ф'] = 'a',
  ['щ'] = 'o', ['Щ'] = 'o',
  ['в'] = 'd', ['В'] = 'd',
  ['с'] = 'c', ['С'] = 'c',
  ['м'] = 'v', ['М'] = 'v',
  ['н'] = 'y', ['Н'] = 'y',
  ['з'] = 'p', ['З'] = 'p',
  ['ч'] = 'x', ['Ч'] = 'x',
}

for lhs, rhs in pairs(editing) do
  map('n', lhs, rhs)
end

-- Search, files and navigation.
map('n', '<leader>a', ':Ack!<Space>')
map('n', '<leader>A', ':Ack! -Q<Space>')
map('n', '<leader>n', ':Neotree toggle right reveal<CR>', silent)
map('n', '<C-p>', ':GFiles<CR>')
map('n', '<C-0>', ':Files<CR>')
map('n', '<leader>l', ':set list!<CR>')
map('n', '<leader><Space>', ':nohlsearch<CR>')
map('n', '<leader>evrc', ':tabedit $MYVIMRC<CR>')
map('n', '<leader>scs', ':tabedit $HOME/.vim-cheatsheet<CR>')

-- LSP diagnostics.
map('n', '<leader>e', vim.diagnostic.open_float, silent)
map('n', '[d', vim.diagnostic.goto_prev, silent)
map('n', ']d', vim.diagnostic.goto_next, silent)
map('n', '<leader>q', vim.diagnostic.setloclist, silent)
