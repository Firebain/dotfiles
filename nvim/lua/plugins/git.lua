return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        vim.keymap.set('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git change' })

        vim.keymap.set('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git change' })

        vim.keymap.set('n', '<leader>gb', gitsigns.blame_line, { desc = 'Blame' })
        vim.keymap.set('n', '<leader>gB', gitsigns.blame, { desc = 'Toggle Blame' })

        vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { desc = 'Diff' })

        vim.keymap.set('n', '<leader>gr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Reset hunk' })

        vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk_inline, { desc = 'Preview hunk' })
      end,
    },
  },

  {
    'NeogitOrg/neogit',
    keys = {
      { '<leader>gg', '<CMD>Neogit<CR>', desc = 'Open Neogit' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'sindrets/diffview.nvim',
        dependencies = {
          'nvim-tree/nvim-web-devicons',
        },
      },

      'folke/snacks.nvim',
    },
  },
}
