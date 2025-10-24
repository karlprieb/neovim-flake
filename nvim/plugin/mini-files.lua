require('mini.files').setup({
  mappings = {
    close = '<ESC>',
  },
})
vim.keymap.set('n', '<leader>op', function() MiniFiles.open() end, { desc = 'File explorer' })
vim.keymap.set('n', '<leader>oP', function() MiniFiles.open(vim.api.nvim_buf_get_name(0), false) end, { desc = 'File explorer current path' })
