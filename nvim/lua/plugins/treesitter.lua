return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'lua',
      'luadoc',
      'javascript',
      'rust',
      'typescript',
      'python',
      'json',
      'tsx',
      'go',
      'gomod',
      'gosum',
      'prisma',
      'astro',
      'zig',
    },
    auto_install = false,
    highlight = {
      enable = true,
    },
    indent = { enable = true },
  },
}
