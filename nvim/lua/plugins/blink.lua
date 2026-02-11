return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = 'make install_jsregexp',
      config = function()
        local ls = require 'luasnip'
        local s = ls.snippet
        local t = ls.text_node

        ls.setup {}

        vim.keymap.set({ 'i' }, '<C-K>', function()
          ls.expand()
        end, { silent = true })
        vim.keymap.set({ 'i', 's' }, '<C-L>', function()
          ls.jump(1)
        end, { silent = true })
        vim.keymap.set({ 'i', 's' }, '<C-J>', function()
          ls.jump(-1)
        end, { silent = true })

        vim.keymap.set({ 'i', 's' }, '<C-E>', function()
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end, { silent = true })

        ls.add_snippets('go', {
          s('ife', {
            t { 'if err != nil' },
            t { ' {', '\t' },
            t { 'return nil' },
            t { '', '}' },
          }),
          s('ifp', {
            t { 'if err != nil' },
            t { ' {', '\t' },
            t { 'panic(err)' },
            t { '', '}' },
          }),
        })
      end,
    },
    'folke/lazydev.nvim',
  },
  opts = {
    keymap = {
      preset = 'enter',
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },

    sources = {
      default = {
        'lsp',
        'path',
        'snippets',
        'lazydev',
      },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },

    snippets = { preset = 'luasnip' },

    fuzzy = { implementation = 'lua' },

    signature = { enabled = true },
  },
}
