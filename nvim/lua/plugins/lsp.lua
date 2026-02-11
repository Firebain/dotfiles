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

    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local servers = {
      gopls = {},
      ts_ls = {},
      zls = {},
      astro = {},
      ['rust-analyzer'] = {},
      lua_ls = {},
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
      'prettier',
      'eslint',
    })

    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
    }

    vim.lsp.config('eslint', {
      handlers = {
        ['textDocument/diagnostic'] = function(err, result, ctx)
          if result and result.items then
            for _, diagnostic in ipairs(result.items) do
              diagnostic.severity = vim.diagnostic.severity.HINT
            end
          end
          return vim.lsp.diagnostic.on_diagnostic(err, result, ctx)
        end,
      },
    })

    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}

          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
