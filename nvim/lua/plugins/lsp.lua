local function format_virtual_text(diagnostic)
  local msg = diagnostic.message:gsub('[\r\n]+', ' ')
  msg = vim.trim(msg)

  local max_len = math.max(30, math.floor(vim.api.nvim_win_get_width(0) * 0.50))
  if vim.fn.strdisplaywidth(msg) > max_len then msg = vim.fn.strcharpart(msg, 0, max_len - 3) .. '...' end

  return msg
end

require('mason').setup {}
require('fidget').setup {}

require('mason-tool-installer').setup {
  ensure_installed = {
    'lua_ls',
    'stylua',

    'ts_ls',
    'prettier',

    'gopls',
  },
}

-- vim.diagnostic.config {
--   update_in_insert = false,
--   severity_sort = true,
--   float = { border = 'rounded', source = 'if_many' },
--   underline = { severity = { min = vim.diagnostic.severity.WARN } },
--
--   -- Can switch between these as you prefer
--   virtual_text = true, -- Text shows up at the end of the line
--   virtual_lines = false, -- Text shows up underneath the line, with virtual lines
--
--   -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
--   jump = { float = true },
-- }

vim.diagnostic.config {
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'if_many',
    max_width = math.max(40, math.floor(vim.o.columns * 0.6)),
  },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = format_virtual_text,
  },
}

local capabilities = require('blink.cmp').get_lsp_capabilities()

-- Typescript
vim.lsp.config('ts_ls', {
  capabilities = capabilities,
})

vim.lsp.enable 'ts_ls'

-- Lua
vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },
  },
})

vim.lsp.enable 'lua_ls'

-- Golang
vim.lsp.config('gopls', {
  capabilities = capabilities,
})

vim.lsp.enable 'gopls'
