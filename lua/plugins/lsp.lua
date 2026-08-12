vim.lsp.config["lua_ls"] = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  -- Specific settings to send to the server. The schema is server-defined.
  -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
    },
  },
}
vim.lsp.enable "lua_ls"
vim.lsp.enable "rust-analyzer"

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
