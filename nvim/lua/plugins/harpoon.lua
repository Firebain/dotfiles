-- local harpoon_source = {
--   finder = function()
--     local output = {}
--     for _, item in ipairs(require('harpoon'):list().items) do
--       if item and item.value:match '%S' then
--         table.insert(output, {
--           text = item.value,
--           file = item.value,
--           pos = { item.context.row, item.context.col },
--         })
--       end
--     end
--     return output
--   end,
--   filter = {
--     transform = function()
--       return true
--     end,
--   },
--   format = function(item)
--     return {
--       { item.text },
--       { ':', 'SnacksPickerDelim' },
--       { tostring(item.pos[1]), 'SnacksPickerRow' },
--       { ':', 'SnacksPickerDelim' },
--       { tostring(item.pos[2]), 'SnacksPickerCol' },
--     }
--   end,
--   preview = function(ctx)
--     if Snacks.picker.util.path(ctx.item) then
--       return Snacks.picker.preview.file(ctx)
--     else
--       return Snacks.picker.preview.none(ctx)
--     end
--   end,
--   confirm = 'jump',
-- }

return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      harpoon:setup()

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Create Harpoon Mark' })

      -- vim.keymap.set('n', '<leader>m', function()
      --   Snacks.picker.pick {
      --     source = 'harpoon',
      --     sources = {
      --       harpoon = harpoon_source,
      --     },
      --   }
      -- end, { desc = 'List of Harpoon Marks' })

      vim.keymap.set('n', '<leader>m', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'List of Harpoon Marks' })

      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end, { desc = 'Jump to 1 Harpoon Mark' })

      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end, { desc = 'Jump to 2 Harpoon Mark' })

      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end, { desc = 'Jump to 3 Harpoon Mark' })

      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end, { desc = 'Jump to 4 Harpoon Mark' })
    end,
  },
}
