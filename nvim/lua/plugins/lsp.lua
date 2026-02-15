local function setup_diagnostic()
  local function format_virtual_text(diagnostic)
    local msg = diagnostic.message:gsub('[\r\n]+', ' ')
    msg = vim.trim(msg)

    local max_len = math.max(30, math.floor(vim.api.nvim_win_get_width(0) * 0.50))
    if vim.fn.strdisplaywidth(msg) > max_len then
      msg = vim.fn.strcharpart(msg, 0, max_len - 3) .. '...'
    end

    return msg
  end

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
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    { 'j-hui/fidget.nvim', opts = {} },

    'saghen/blink.cmp',
  },
  config = function()
    require('mason-tool-installer').setup {
      ensure_installed = {
        'lua_ls',
        'stylua',

        'ts_ls',
        'prettier',

        'gopls',
      },
    }

    setup_diagnostic()

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
  end,
}
