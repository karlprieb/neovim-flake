require('auto-dark-mode').setup {
  update_interval = 1000,
  set_dark_mode = function()
    vim.o.background = 'dark'
    vim.cmd('colorscheme catppuccin-mocha')
  end,
  set_light_mode = function()
    vim.o.background = 'light'
    vim.cmd('colorscheme catppuccin-latte')
  end,
}
