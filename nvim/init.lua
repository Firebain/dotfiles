require 'options'
require 'keymaps'

vim.pack.add {
  { src = 'https://github.com/mofiqul/vscode.nvim' },

  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },

  { src = 'https://github.com/j-hui/fidget.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/saghen/blink.cmp' },
  { src = 'https://github.com/L3MON4D3/LuaSnip' },

  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/folke/snacks.nvim' },

  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/esmuellert/codediff.nvim' },
  { src = 'https://github.com/NeogitOrg/neogit' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
  { src = 'https://github.com/jake-stewart/multicursor.nvim' },

  { src = 'https://github.com/NMAC427/guess-indent.nvim' },
  { src = 'https://github.com/folke/which-key.nvim' },
  { src = 'https://github.com/folke/todo-comments.nvim' },
  { src = 'https://github.com/folke/flash.nvim' },
}

vim.cmd.colorscheme 'vscode'

require 'plugins.oil'
require 'plugins.mini'
require 'plugins.snippets'
require 'plugins.blink'
require 'plugins.snacks'
require 'plugins.treesitter'
require 'plugins.lsp'
require 'plugins.git'
require 'plugins.conform'
require 'plugins.harpoon'
require 'plugins.multicursor'
require 'plugins.utils'
