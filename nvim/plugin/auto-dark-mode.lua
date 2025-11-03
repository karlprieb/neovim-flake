require('auto-dark-mode').setup {
  update_interval = 1000,
  set_dark_mode = function()
    vim.o.background = 'dark'
    vim.cmd('colorscheme duskfox')
  end,
  set_light_mode = function()
    vim.o.background = 'light'
    vim.cmd('colorscheme dawnfox')
  end,
}
