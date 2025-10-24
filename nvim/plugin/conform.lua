vim.api.nvim_create_autocmd('BufWritePre', {
  once = true,
  callback = function()
    require('conform').setup {
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        nix = { 'nixfmt' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
      },
    }
  end,
})

vim.keymap.set('n', '<leader>cF', function()
  vim.b.disable_autoformat = not vim.b.disable_autoformat
  vim.g.disable_autoformat = not vim.b.disable_autoformat
end, { desc = 'Toggle autoformat' })
vim.keymap.set('n', '<leader>cf', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = 'Format' })
