return {
  {
    'NMAC427/guess-indent.nvim',
    opts = {},
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      spec = {
        { 'gs', group = 'Surround' },
        { '<leader>c', group = 'Code' },
        { '<leader>f', group = 'Find' },
        { '<leader>g', group = 'Git' },
        { '<leader>x', group = 'Diagnostics' },
      },
    },
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
    },
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    config = function()
      require('flash').setup {}

      vim.keymap.set('n', 's', function()
        require('flash').jump()
      end, { desc = 'Flash jump' })
    end,
  },
}
