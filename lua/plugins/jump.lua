---@type LazySpec
return {
  {
    "mawkler/demicolon.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {},
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    url = "https://codeberg.org/andyg/leap.nvim.git",
    dependencies = {
      "tpope/vim-repeat",
    },
    enabled = false,
    opts = {
      preview = function(ch0, ch1, ch2)
        return not (ch1:match "%s" or (ch0:match "%a" and ch1:match "%a" and ch2:match "%a"))
      end,
      equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" },
    },
    keys = {

      {
        "s",
        mode = { "n", "x", "o" },
        "<Plug>(leap)",
        desc = "leap",
      },
      {
        "S",
        mode = { "n" },
        "<Plug>(leap-from-window)",
      },
      {
        "R",
        mode = { "x", "o" },
        function()
          require("leap.treesitter").select {
            opts = require("leap.user").with_traversal_keys("R", "r"),
          }
        end,
      },
    },
  },
}
