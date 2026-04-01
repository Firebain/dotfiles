local harpoon = require 'harpoon'

harpoon:setup()

vim.keymap.set('n', '<leader>m', function() harpoon:list():add() end, { desc = 'Create Harpoon Mark' })

vim.keymap.set('n', '<leader>l', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'List of Harpoon Marks' })

vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end, { desc = 'Jump to 1 Harpoon Mark' })

vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end, { desc = 'Jump to 2 Harpoon Mark' })

vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end, { desc = 'Jump to 3 Harpoon Mark' })

vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end, { desc = 'Jump to 4 Harpoon Mark' })
