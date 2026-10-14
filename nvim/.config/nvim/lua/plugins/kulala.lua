require('kulala').setup()

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'http',
  callback = function()
    vim.keymap.set('n', '<leader>k', function() require('kulala').run() end, { buffer = true, desc = 'Send request' })
  end,
})
