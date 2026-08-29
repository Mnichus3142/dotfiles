return {
	'numToStr/Comment.nvim',
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('Comment').setup()
        
        --vim.keymap.set('n', '<F5>', 'gcc', { desc = 'TEST: Komentuj linię (F5)' })
        --vim.keymap.set('v', '<F5>', '<ESC><Plug>(comment_toggle_visual)', { desc = 'TEST: Komentuj blok (F5)' })
    end,
}
