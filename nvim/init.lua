require 'options'
require 'keymaps'

vim.api.nvim_create_autocmd('PackChanged', {
  desc = 'Run post-install/update build hooks',
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    -- local path = ev.data.path

    print 'Running build hooks'

    if kind ~= 'install' and kind ~= 'update' then return end

    if name == 'blink.cmp' then require('blink.cmp').build():pwait() end
  end,
})

vim.pack.add {
  { src = 'https://github.com/mofiqul/vscode.nvim' },

  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },

  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/mfussenegger/nvim-lint' },
  { src = 'https://github.com/saghen/blink.lib' },
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
  { src = 'https://github.com/ej-shafran/compile-mode.nvim' },
  { src = 'https://github.com/m00qek/baleia.nvim' },

  { src = 'https://github.com/NMAC427/guess-indent.nvim' },
  { src = 'https://github.com/folke/which-key.nvim' },
  { src = 'https://github.com/folke/todo-comments.nvim' },
  { src = 'https://github.com/folke/flash.nvim' },
  { src = 'https://github.com/mistweaverco/kulala.nvim' },
}

vim.cmd.colorscheme 'vscode'

require 'commands'

require 'plugins.oil'
require 'plugins.mini'
require 'plugins.snippets'
require 'plugins.blink'
require 'plugins.snacks'
require 'plugins.treesitter'
require 'plugins.lsp'
require 'plugins.lint'
require 'plugins.compilemode'
require 'plugins.git'
require 'plugins.conform'
require 'plugins.harpoon'
require 'plugins.multicursor'
require 'plugins.utils'
require 'plugins.kulala'
