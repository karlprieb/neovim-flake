if vim.g.did_load_plugins_plugin then
  return
end
vim.g.did_load_plugins_plugin = true

require('which-key').setup {
  preset = 'modern',
}

require('mini.icons').setup()
require('mini.git').setup()
require('mini.diff').setup()
require('mini.statusline').setup()
require('mini.fuzzy').setup()
require('mini.pairs').setup()
require('mini.completion').setup()
require('mini.comment').setup()
require('mini.move').setup()
require('mini.bracketed').setup()
