return {
  'jake-stewart/multicursor.nvim',
  branch = '1.0',
  config = function()
    local mc = require 'multicursor-nvim'
    mc.setup()

    local set = vim.keymap.set

    set({ 'n', 'x' }, '<up>', function()
      mc.lineAddCursor(-1)
    end, { desc = 'Add cursor above' })
    set({ 'n', 'x' }, '<down>', function()
      mc.lineAddCursor(1)
    end, { desc = 'Add cursor below' })

    set({ 'n', 'x' }, '<C-n>', function()
      mc.matchAddCursor(1)
    end, { desc = 'Add cursor by matching' })
    set({ 'n', 'x' }, '<C-s>', function()
      mc.matchSkipCursor(1)
    end, { desc = 'Skip cursor by matching' })
    -- set({ 'n', 'x' }, '<leader>N', function()
    --   mc.matchAddCursor(-1)
    -- end, { desc = 'Add cursor by matching previous' })
    -- set({ 'n', 'x' }, '<leader>S', function()
    --   mc.matchSkipCursor(-1)
    -- end, { desc = 'Skip cursor by matching previous' })

    set({ 'n', 'x' }, '<c-q>', mc.toggleCursor, { desc = 'Toggle cursor' })

    mc.addKeymapLayer(function(layerSet)
      layerSet({ 'n', 'x' }, '<left>', mc.prevCursor, { desc = 'Previous cursor' })
      layerSet({ 'n', 'x' }, '<right>', mc.nextCursor, { desc = 'Next cursor' })

      layerSet({ 'n', 'x' }, '<leader>x', mc.deleteCursor, { desc = 'Delete cursor' })

      layerSet('n', '<esc>', function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end, { desc = 'Enable/clear cursor' })
    end)
  end,
}
