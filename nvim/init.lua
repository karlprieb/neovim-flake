vim.loader.enable()

vim.cmd.colorscheme('catppuccin-mocha')

require('lsp')

vim.lsp.enable({'lua_ls', 'nixd'})

-- Native plugins
-- vim.cmd.filetype('plugin', 'indent', 'on')
-- vim.cmd.packadd('cfilter') -- Allows filtering the quickfix list with :cfdo
--
-- -- let sqlite.lua (which some plugins depend on) know where to find sqlite
-- vim.g.sqlite_clib_path = require('luv').os_getenv('LIBSQLITE')
