local function map(m, k, v)
   vim.keymap.set(m, k, v, { silent = true })
end

map('n', '<leader>z', '<cmd>Ex<CR>')

map('n', '<leader>f', '<cmd>Telescope find_files<CR>')
map('n', '<leader>g', '<cmd>Telescope live_grep<CR>')
-- map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
-- map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')

map('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')

-- Terminal
map('n', '<leader>td', '<cmd>:belowright split | terminal<CR>i') -- Split with terminal horizontally
map('n', '<leader>tr', '<cmd>:belowright vsplit | terminal<CR>i') -- Split with terminal vertically
map('t', '<Esc>', '<C-\\><C-n>') -- Make escape work in termnal
vim.api.nvim_exec([[ autocmd TermOpen * setlocal nonumber norelativenumber ]], false) -- Disable line numbers in terminal
