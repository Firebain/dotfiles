return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  config = function()
    require('snacks').setup {
      picker = { enabled = true },
      indent = {},
    }

    vim.keymap.set('n', '<leader>ff', function()
      Snacks.picker.files {
        matcher = {
          history_bonus = true,
        },
        hidden = true,
      }
    end, { desc = 'Find Files' })

    vim.keymap.set('n', '<leader><space>', function()
      Snacks.picker.recent()
    end, { desc = 'Find Recent Files' })

    vim.keymap.set('n', '<leader>fg', function()
      Snacks.picker.grep()
    end, { desc = 'Find Grep' })

    vim.keymap.set('n', '<leader>ft', function()
      Snacks.picker.todo_comments()
    end, { desc = 'Find Todo' })

    vim.keymap.set('n', 'gd', function()
      Snacks.picker.lsp_definitions()
    end, { desc = 'Goto Definition' })

    vim.keymap.set('n', 'gD', function()
      Snacks.picker.lsp_declarations()
    end, { desc = 'Goto Declaration' })

    vim.keymap.set('n', 'gr', function()
      Snacks.picker.lsp_references()
    end, { desc = 'Goto Reference', nowait = true })

    vim.keymap.set('n', 'gi', function()
      Snacks.picker.lsp_implementations()
    end, { desc = 'Goto Imprelemtation' })

    vim.keymap.set('n', 'gy', function()
      Snacks.picker.lsp_type_definitions()
    end, { desc = 'Goto Type Definition' })

    vim.keymap.set('n', '<leader>fs', function()
      Snacks.picker.git_status()
    end, { desc = 'Git Status' })

    vim.keymap.set('n', '<leader>xx', function()
      Snacks.picker.diagnostics()
    end, { desc = 'Diagnostics' })

    vim.keymap.set('n', '<leader>xX', function()
      Snacks.picker.diagnostics_buffer()
    end, { desc = 'Buffer Diagnostics' })
  end,
}
