return {
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    opts = {},
  },
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "esmuellert/codediff.nvim",
      "m00qek/baleia.nvim",
      "ibhagwan/fzf-lua",
    },
    cmd = "Neogit",
    keys = {
      {
        "<leader>gG",
        mode = { "n", "v", "x" },
        "<cmd>Neogit<cr>",
        desc = "Show Neogit UI",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
    keys = {
      {
        "<leader>gl",
        mode = { "n", "v" },
        function()
          require("gitsigns").blame_line()
        end,
        desc = "Git blame",
      },
      {
        "]c",
        mode = { "n", "v" },
        function()
          require("gitsigns").nav_hunk("next")
        end,
        desc = "Next git hunk",
      },
      {
        "[c",
        mode = { "n", "v" },
        function()
          require("gitsigns").nav_hunk("prev")
        end,
        desc = "Next git hunk",
      },
    },
  },
}
