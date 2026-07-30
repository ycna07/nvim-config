-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:
-- local im_default_command
-- if vim.fn.has "win32" == 1 or vim.fn.has "win64" == 1 or vim.fn.has "wsl" == 1 then
--   im_default_command = "im-select.exe"
-- elseif vim.fn.has "mac" == 1 or vim.fn.has "macunix" == 1 then
--   im_default_command = "macism"
-- else
--   -- im_default_command = "fcitx5-remote"
--   im_default_command = "dbus-send"
-- end

---@type LazySpec
return {
  ---@module "neominimap.config.meta"
  {
    "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    lazy = false, -- NOTE: NO NEED to Lazy load
    -- Optional. You can also set your own keybindings
    keys = {
      -- Global Minimap Controls
      { "<leader>mm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle global minimap" },
      { "<leader>mo", "<cmd>Neominimap Enable<cr>", desc = "Enable global minimap" },
      { "<leader>mc", "<cmd>Neominimap Disable<cr>", desc = "Disable global minimap" },
      { "<leader>mr", "<cmd>Neominimap Refresh<cr>", desc = "Refresh global minimap" },

      -- Window-Specific Minimap Controls
      { "<leader>mwt", "<cmd>Neominimap WinToggle<cr>", desc = "Toggle minimap for current window" },
      { "<leader>mwr", "<cmd>Neominimap WinRefresh<cr>", desc = "Refresh minimap for current window" },
      { "<leader>mwo", "<cmd>Neominimap WinEnable<cr>", desc = "Enable minimap for current window" },
      { "<leader>mwc", "<cmd>Neominimap WinDisable<cr>", desc = "Disable minimap for current window" },

      -- Tab-Specific Minimap Controls
      { "<leader>mtt", "<cmd>Neominimap TabToggle<cr>", desc = "Toggle minimap for current tab" },
      { "<leader>mtr", "<cmd>Neominimap TabRefresh<cr>", desc = "Refresh minimap for current tab" },
      { "<leader>mto", "<cmd>Neominimap TabEnable<cr>", desc = "Enable minimap for current tab" },
      { "<leader>mtc", "<cmd>Neominimap TabDisable<cr>", desc = "Disable minimap for current tab" },

      -- Buffer-Specific Minimap Controls
      { "<leader>mbt", "<cmd>Neominimap BufToggle<cr>", desc = "Toggle minimap for current buffer" },
      { "<leader>mbr", "<cmd>Neominimap BufRefresh<cr>", desc = "Refresh minimap for current buffer" },
      { "<leader>mbo", "<cmd>Neominimap BufEnable<cr>", desc = "Enable minimap for current buffer" },
      { "<leader>mbc", "<cmd>Neominimap BufDisable<cr>", desc = "Disable minimap for current buffer" },

      ---Focus Comtrols
      { "<leader>mf", "<cmd>Neominimap Focus<cr>", desc = "Focus on minimap" },
      { "<leader>mu", "<cmd>Neominimap Unfocus<cr>", desc = "Unfocus minimap" },
      { "<leader>ms", "<cmd>Neominimap ToggleFocus<cr>", desc = "Switch focus on minimap" },
    },
    init = function()
      -- The following options are recommended when layout == "float"
      vim.opt.wrap = false
      vim.opt.sidescrolloff = 36 -- Set a large value

      --- Put your configuration here
      ---@type Neominimap.UserConfig
      vim.g.neominimap = {
        auto_enable = false,
      }
    end,
  },
  {
    "tnfru/nvim-venv-detector",
    ft = "python",
    event = "VimEnter",
    config = function() require("venv_detector").setup() end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    ft = "python",
  },
  {
    -- 性能上有缺陷，长按时圆点明显跟不上
    "petertriho/nvim-scrollbar",
    enabled = false,
    lazy = true,
    config = function()
      require("scrollbar").setup {
        show = true,
        show_in_active_only = false,
        set_highlights = true,
        folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
        max_lines = false, -- disables if no. of lines in buffer exceeds this
        hide_if_all_visible = false, -- Hides everything if all lines are visible
        throttle_ms = 100,
      }
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "yutkat/confirm-quit.nvim",
    event = "CmdlineEnter",
    opts = {},
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
  { "akinsho/toggleterm.nvim", opts = {
    hide_numbers = true,
    direction = "float",
  } },
  { "nvim-neo-tree/neo-tree.nvim", opts = {
    window = {
      position = "float",
    },
  } },
  {
    "Joakker/lua-json5",
    lazy = true,
    build = vim.fn.has "win32" == 1 and "powershell ./install.ps1" or "./install.sh",
  },
  {
    "Mythos-404/xmake.nvim",
    version = "^3",
    lazy = true,
    event = "BufReadPost",
    config = true,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,

    -- Completion for `blink.cmp`
    dependencies = { "saghen/blink.cmp" },
  },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = {
      "KittyScrollbackGenerateKittens",
      "KittyScrollbackCheckHealth",
      "KittyScrollbackGenerateCommandLineEditing",
    },
    event = { "User KittyScrollbackLaunch" },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    version = "^6.0.0", -- pin major version, include fixes and features that do not have breaking changes
    config = function() require("kitty-scrollback").setup() end,
  },
  {
    -- "keaising/im-select.nvim",
    "im-select.nvim",
    name = "im-select.nvim",
    dev = true,
    config = function()
      require("im_select").setup {
        -- IM will be set to `default_im_select` in `normal` mode
        -- For Windows/WSL, default: "1033", aka: English US Keyboard
        -- For macOS, default: "com.apple.keylayout.ABC", aka: US
        -- For Linux, default:
        --               "keyboard-us" for Fcitx5
        --               "1" for Fcitx
        --               "xkb:us::eng" for ibus
        -- You can use `im-select` or `fcitx5-remote -n` to get the IM's name
        default_im_select = "true",
        -- default_im_select = "keyboard-us",

        -- Can be binary's name, binary's full path, or a table, e.g. 'im-select',
        -- '/usr/local/bin/im-select' for binary without extra arguments,
        -- or { "AIMSwitcher.exe", "--imm" } for binary need extra arguments to work.
        -- For Windows/WSL, default: "im-select.exe"
        -- For macOS, default: "macism"
        -- For Linux, default: "fcitx5-remote" or "fcitx-remote" or "ibus"
        -- default_command = im_default_command,
        default_command = "rimectl",
        -- default_command = "fcitx5-remote",

        -- Restore the default input method state when the following events are triggered
        -- "VimEnter" and "FocusGained" were removed for causing problems, add it by your needs
        set_default_events = { "InsertLeave", "CmdlineLeave" },

        -- Restore the previous used input method state when the following events
        -- are triggered, if you don't want to restore previous used im in Insert mode,
        -- e.g. deprecated `disable_auto_restore = 1`, just let it empty
        -- as `set_previous_events = {}`
        set_previous_events = { "InsertEnter" },

        -- Show notification about how to install executable binary when binary missed
        keep_quiet_on_no_binary = false,

        -- Async run `default_command` to switch IM or not
        async_switch_im = true,
      }
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
    config = function()
      require("nvim-surround").setup {
        -- Put your configuration here
        -- keymaps = {
        --     insert          = '<C-g>z',
        --     insert_line     = 'gC-ggZ',
        --     normal          = 'gz',
        --     normal_cur      = 'gZ',
        --     normal_line     = 'gzgz',
        --     normal_cur_line = 'gZgZ',
        --     visual          = 'gz',
        --     visual_line     = 'gZ',
        --     delete          = 'gzd',
        --     change          = 'gzc',
        --   }
      }
    end,
  },
  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    opts = {
      alpha = 0.3, -- make the dimmed text even dimmer
    },
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  -- == Examples of Overriding Plugins ==
  -- customize dashboard options
  {
    "folke/snacks.nvim",
    -- priority = 100,
    ---@type snacks.Config
    opts = {
      input = { enabled = true },
      bigfile = { enabled = true },
      image = { doc = { enabled = true } },
      picker = {
        win = {
          input = {
            keys = {
              ["<Tab>"] = { "list_down", mode = { "i", "n" } },
              ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
              ["<c-k>"] = { "select_and_prev", mode = { "i", "n" } },
              ["<c-j>"] = { "select_and_next", mode = { "i", "n" } },
            },
          },
        },
        -- layout = {
        --   layout = {
        --     backdrop = false,
        --   },
        -- },
      },
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },

    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<leader>fS"] = {
                function() require("snacks.picker").grep { regex = false } end,
                desc = "Literal Grep",
              },
            },
          },
        },
      },
    },
  },
  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },
  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })

      -- include the default astronvim config that calls the setup call
      require "astronvim.plugins.configs.luasnip"(plugin, opts)
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
