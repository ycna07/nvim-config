return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        -- command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    keys = {
      {
        "<leader>fn",
        "<cmd>NoiceFzf<cr>",
        desc = "Find notifications",
      },
    },
  },
  {
    "rmagatti/auto-session",
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      -- log_level = 'debug',
    },
  },
  {
    "nmac427/guess-indent.nvim", --auto setup tab indent
    opts = {
      auto_cmd = true,
    },
  },
  -- { "https://gitlab.com/HiPhish/rainbow-delimiters.nvim" },
  {
    "rainbow-delimiters.nvim",
    dev = true,
  },
  {
    "saghen/blink.indent",
    --- @module 'blink.indent'
    --- @type blink.indent.Config
    opts = {
      static = {
        -- char = "│",
      },
      scope = {
        -- char = "│",
        highlights = { -- sync with rainbow-delimiters
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      },
    },
  },
  -- {
  --   "ycna07/indent-blankline.nvim",
  --   main = "ibl",
  --   config = function()
  --     local highlight = {
  --       "RainbowRed",
  --       "RainbowYellow",
  --       "RainbowBlue",
  --       "RainbowOrange",
  --       "RainbowGreen",
  --       "RainbowViolet",
  --       "RainbowCyan",
  --     }
  --
  --     --  注册 HIGHLIGHT_SETUP 钩子，在 colorscheme 变化时重新定义颜色
  --     local hooks = require "ibl.hooks"
  --     hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  --       vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  --       vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  --       vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  --       vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  --       vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  --       vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  --       vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  --     end)
  --
  --     --  设置全局变量（可能用于其他插件，如 rainbow-delimiters）
  --     vim.g.rainbow_delimiters = { highlight = highlight }
  --
  --     --  调用 ibl.setup，并配置 scope 高亮
  --     require("ibl").setup {
  --       scope = { highlight = highlight },
  --     }
  --
  --     --  注册 SCOPE_HIGHLIGHT 钩子，使用内置的 extmark 高亮
  --     hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  --   end,
  -- },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end,
  },
  { "akinsho/toggleterm.nvim", opts = {
    hide_numbers = true,
    direction = "float",
  } },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  --lint
  {
    "https://codeberg.org/mfussenegger/nvim-lint",
  },
  -- format
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { lsp_format = "fallback" },
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "stevearc/aerial.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
