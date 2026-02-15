vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

local function toggle_terminal()
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    local buffer_name = vim.api.nvim_buf_get_name(buffer)
    if string.sub(buffer_name, 1, 7) == 'term://' then
      vim.api.nvim_win_set_buf(0, buffer)
      return
    end
  end
  vim.api.nvim_command ':terminal'
end
vim.keymap.set('n', '<leader>t', toggle_terminal, { desc = 'Toggle Terminal' })
vim.keymap.set('n', '<leader>T', '<cmd>terminal<CR>', { desc = 'New Terminal' })

vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from clipboard' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Action' })
vim.keymap.set({ 'n', 'x' }, '<leader>d', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
