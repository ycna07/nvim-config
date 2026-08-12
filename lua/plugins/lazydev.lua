return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "lazy.nvim", words = { "Lazy" } },
      },
    },
    specs = {
      {
        "saghen/blink.cmp",
        optional = true,
        opts = {
          sources = {
            default = { "lazydev" },
            providers = {
              lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
            },
          },
        },
      },
    },
  },
  -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
}
