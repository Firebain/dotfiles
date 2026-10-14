local mc = require 'multicursor-nvim'
mc.setup()

local set = vim.keymap.set

set({ 'n', 'x' }, '<up>', function() mc.lineAddCursor(-1) end, { desc = 'Add cursor above' })
set({ 'n', 'x' }, '<down>', function() mc.lineAddCursor(1) end, { desc = 'Add cursor below' })

set({ 'n', 'x' }, '<C-n>', function() mc.matchAddCursor(1) end, { desc = 'Add cursor by matching' })
set({ 'n', 'x' }, '<C-s>', function() mc.matchSkipCursor(1) end, { desc = 'Skip cursor by matching' })

set({ 'n', 'x' }, '<c-q>', mc.toggleCursor, { desc = 'Toggle cursor' })

mc.addKeymapLayer(function(layerSet)
  layerSet({ 'n', 'x' }, '<leader>x', mc.deleteCursor, { desc = 'Delete cursor' })

  layerSet('n', '<esc>', function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      mc.clearCursors()
    end
  end, { desc = 'Enable/clear cursor' })
end)
