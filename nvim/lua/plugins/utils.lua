require('guess-indent').setup {}

require('which-key').setup {
  preset = 'helix',
  spec = {
    { 'gs', group = 'Surround' },
    { '<leader>c', group = 'Code' },
    { '<leader>f', group = 'Find' },
    { '<leader>g', group = 'Git' },
    { '<leader>x', group = 'Diagnostics' },
  },
}

require('todo-comments').setup {
  signs = false,
}

require('flash').setup {}

vim.keymap.set('n', 's', function() require('flash').jump() end, { desc = 'Flash jump' })
