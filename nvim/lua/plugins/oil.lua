-- TODO: Maybe add this https://github.com/folke/snacks.nvim/blob/main/docs/rename.md#oilnvim
-- TODO: And try this https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-files.md

return {
  'stevearc/oil.nvim',
  lazy = false,
  keys = {
    { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  dependencies = {
    { 'nvim-mini/mini.icons', opts = {} },
  },
}
