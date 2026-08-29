
-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>p', builtin.find_files, { desc = 'Telescope find files', noremap = true, silent = true })
vim.keymap.set('n', '<C-S-p>p', builtin.live_grep, { desc = 'Telescope live grep', noremap = true, silent = true })
vim.keymap.set('n', '<leader>st', ":TodoTelescope<CR>", { desc = 'Search TODOs', noremap = true, silent = true })

-- Neotree
vim.keymap.set('n', '<C-b>', ':Neotree filesystem reveal right<CR>', { noremap = true, silent = true, desc = "Toggle Explorer" })

-- Barbecue
vim.keymap.set('n', '<leader>bt', function() require("barbecue.ui").toggle() end, { desc = "Toggle Barbecue", noremap = true, silent = true })

-- Comments (standardize for more terminals)
vim.keymap.set('n', '<C-/>', ':lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Komentuj/Odkomentuj linię' })
vim.keymap.set('n', '<C-_>', ':lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Komentuj/Odkomentuj linię (fallback)' })

vim.keymap.set('v', '<C-/>', ":'<,'>lua require('Comment.api').toggle.blockwise()<CR>", { desc = 'Komentuj/Odkomentuj blok' })
vim.keymap.set('v', '<C-_>', ":'<,'>lua require('Comment.api').toggle.blockwise()<CR>", { desc = 'Komentuj/Odkomentuj blok (fallback)' })

-- Buffer navigation
vim.keymap.set('n', '<Tab>', ':bn<CR>', { desc = "Next Buffer" })
vim.keymap.set('n', '<S-Tab>', ':bp<CR>', { desc = "Previous Buffer" })

-- Word deletion (Ctrl + Backspace / Ctrl + Delete)
vim.keymap.set('i', '<C-BS>', '<C-w>', { desc = "Delete Word Backwards" })
vim.keymap.set('i', '<C-Del>', '<C-o>dw', { desc = "Delete Word Forwards" })
vim.keymap.set('n', '<C-Del>', 'dw', { desc = "Delete Word" })

-- Delete Line (Shift + Delete equivalent)
vim.keymap.set({ 'n', 'i' }, '<S-Del>', '<Esc>dd', { desc = "Delete Line", noremap = true, silent = true })
vim.keymap.set('v', '<S-Del>', 'd', { desc = "Delete Selection", noremap = true, silent = true })
