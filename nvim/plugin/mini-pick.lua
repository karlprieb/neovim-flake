require('mini.pick').setup({
  window = {
    config = {
      anchor = 'SW',
      height = math.floor(vim.o.lines / 3),
      width = vim.o.columns,
    }
  }
})

vim.keymap.set('n', '<leader>pf', ':Pick files<CR>', { desc = 'Files' })
vim.keymap.set('n', '<leader>ps', ':Pick grep_live<CR>', { desc = 'Search grep' })
vim.keymap.set('n', '<leader>ph', ':Pick help<CR>', { desc = 'Help' })
vim.keymap.set('n', '<leader>bb', ':Pick buffers<CR>', { desc = 'Buffers' })
