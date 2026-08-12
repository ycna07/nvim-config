require("lazy").setup({
  { import = "plugins" },
} --[[@as LazySpec]], {
  -- Configure any other `lazy.nvim` configuration options here
  install = { colorscheme = { "catppuccin" } },
  ui = { backdrop = 60 },
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {},
    },
  },
  dev = {
    path = "~/Workspace/lua",
  },
} --[[@as LazyConfig]])
