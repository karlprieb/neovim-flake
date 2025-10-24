-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(event)
--     local bufmap = function(mode, rhs, lhs)
--       vim.keymap.set(mode, rhs, lhs, { buffer = event.buf })
--     end
--
--     bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
--     bufmap('n', 'grr', '<cmd>lua vim.lsp.buf.references()<cr>')
--     bufmap('n', 'gri', '<cmd>lua vim.lsp.buf.implementation()<cr>')
--     bufmap('n', 'grt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
--     bufmap('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<cr>')
--     bufmap('n', 'gra', '<cmd>lua vim.lsp.buf.code_action()<cr>')
--     bufmap('n', 'gO', '<cmd>lua vim.lsp.buf.document_symbol()<cr>')
--     bufmap({ 'i', 's' }, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
--   end,
-- })

local utils = require('utils')

local function set_global_keymaps(client, bufnr)
  utils.set_keymap {
    key = '<leader>cd',
    cmd = function()
      vim.lsp.buf.definition()
    end,
    desc = 'Go to definition',
    bufnr = bufnr,
  }

  utils.set_keymap {
    key = '<leader>ca',
    cmd = function()
      vim.lsp.buf.code_action()
    end,
    desc = 'Code actions',
    bufnr = bufnr,
  }

  utils.set_keymap {
    key = '<leader>cr',
    cmd = function()
      vim.lsp.buf.rename()
    end,
    desc = 'Rename',
    bufnr = bufnr,
  }

  utils.set_keymap {
    key = '<leader>ch',
    cmd = vim.lsp.buf.hover,
    desc = 'Hover',
    bufnr = bufnr,
  }

  if client:supports_method('textDocument/declaration') then
    -- Go to declaration
    utils.set_keymap {
      key = '<leader>cD',
      cmd = vim.lsp.buf.declaration,
      desc = 'Go to declaration',
      bufnr = bufnr,
    }
  end

  -- utils.set_keymap {
  --   key = '<leader>cf',
  --   cmd = function()
  --     vim.lsp.buf.format { async = true }
  --   end,
  --   desc = 'Format document',
  --   bufnr = bufnr,
  -- }
end

local function configure_diagnostics()
  local function prefix_diagnostic(prefix, diagnostic)
    return string.format(prefix .. ' %s', diagnostic.message)
  end

  vim.diagnostic.config {
    virtual_text = {
      prefix = '',
      format = function(diagnostic)
        local severity = diagnostic.severity
        if severity == vim.diagnostic.severity.ERROR then
          return prefix_diagnostic('󰅚', diagnostic)
        end
        if severity == vim.diagnostic.severity.WARN then
          return prefix_diagnostic('⚠', diagnostic)
        end
        if severity == vim.diagnostic.severity.INFO then
          return prefix_diagnostic('ⓘ', diagnostic)
        end
        if severity == vim.diagnostic.severity.HINT then
          return prefix_diagnostic('󰌶', diagnostic)
        end
        return prefix_diagnostic('■', diagnostic)
      end,
    },
    signs = {
      text = {
        -- Requires Nerd fonts
        [vim.diagnostic.severity.ERROR] = '󰅚',
        [vim.diagnostic.severity.WARN] = '⚠',
        [vim.diagnostic.severity.INFO] = 'ⓘ',
        [vim.diagnostic.severity.HINT] = '󰌶',
      },
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = 'if_many',
      header = '',
      prefix = '',
    },
  }
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('global.lsp', { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    vim.opt.completeopt = {'menu', 'menuone', 'noinsert', 'fuzzy', 'popup'}
    vim.lsp.completion.enable(true, client.id, bufnr, {autotrigger = true})
    vim.keymap.set('i', '<C-Space>', function() vim.lsp.completion.get() end)

    set_global_keymaps(client, bufnr)
    configure_diagnostics()
  end,
})

-- vim.lsp.config('*', {
--   capabilities = require('cmp_nvim_lsp').default_capabilities(),
-- })
