-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal filesystem left<CR>', desc = 'NeoTree reveal', silent = true },
  },
  config = function()
    require('neo-tree').setup {
      filesystem = {
        hijack_netrw_behavior = 'disabled', -- open_current
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
    }

    vim.keymap.set('n', '<leader>ef', '<Cmd>Neotree reveal filesystem current<CR>', { desc = 'Show file tree' })
    vim.keymap.set('n', '<leader>eg', '<Cmd>Neotree reveal git_status float<CR>', { desc = 'Show changed files' })
  end,
}
