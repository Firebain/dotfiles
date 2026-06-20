vim.g.compile_mode = {
  input_word_completion = true,
  baleia_setup = true,

  error_regexp_table = {
    typescript = {
      -- TypeScript errors take the form
      -- "path/to/error-file.ts(13,23): error TS22: etc."
      regex = '^\\(.\\+\\)(\\([1-9][0-9]*\\),\\([1-9][0-9]*\\)): error TS[1-9][0-9]*:',
      filename = 1,
      row = 2,
      col = 3,
    },
  },
}

vim.keymap.set('n', '<leader>R', '<CMD>Compile<CR>', { desc = 'Compile' })
vim.keymap.set('n', '<leader>r', '<CMD>Recompile<CR>', { desc = 'Recompile' })
vim.keymap.set('n', '[e', '<CMD>PrevError<CR>', { desc = 'Previous Error' })
vim.keymap.set('n', ']e', '<CMD>NextError<CR>', { desc = 'Previous Error' })
