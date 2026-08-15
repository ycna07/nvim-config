return {
  {
    "neovim/nvim-lspconfig",
  },
  {
    "zbirenbaum/neodim",
    event = "LspAttach",

    config = function()
      require("neodim").setup(
        ---@type neodim.Options
        {
          disable = {
            "PKGBUILD",
          },
          alpha = 0.5,
        }
      )
    end,
  },
}
