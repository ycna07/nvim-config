return {
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
  },
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      -- Only one of these is needed.
      -- "sindrets/diffview.nvim",        -- optional
      "esmuellert/codediff.nvim", -- optional

      -- For a custom log pager
      "m00qek/baleia.nvim", -- optional

      -- Only one of these is needed.
      -- "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua",              -- optional
      -- "nvim-mini/mini.pick",           -- optional
      "folke/snacks.nvim", -- optional
    },
    cmd = "Neogit",
    specs = {
      {

        "AstroNvim/astrocore",

        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>gg"] = { "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
        end,
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      -- require("scrollbar.handlers.gitsigns").setup()
    end,
    specs = {
      {

        "AstroNvim/astrocore",

        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>gl"] = { function() require("gitsigns").blame_line() end, desc = "Git blame" }
        end,
      },
    },
  },
}
