local lint = require 'lint'
local linting = true

lint.linters_by_ft = {
  javascript = { 'eslint' },
  javascriptreact = { 'eslint' },
  ['javascript.jsx'] = { 'eslint' },
  typescript = { 'eslint' },
  typescriptreact = { 'eslint' },
  ['typescript.tsx'] = { 'eslint' },
}

local toggle_lint = function()
  linting = not linting
  if linting then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end

vim.keymap.set({ 'n' }, '<leader>ul', toggle_lint, { noremap = true, desc = 'Toggle Linting' })

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    if vim.bo.modifiable and linting then lint.try_lint() end
  end,
})
