-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:
local im_default_command
if vim.fn.has "win32" == 1 or vim.fn.has "win64" == 1 or vim.fn.has "wsl" == 1 then
  im_default_command = "im-select.exe"
elseif vim.fn.has "mac" == 1 or vim.fn.has "macunix" == 1 then
  im_default_command = "macism"
else
  im_default_command = "fcitx5-remote"
end

---@type LazySpec
return {
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

  -- {
  --   "aurora0x27/popup.nvim",
  --   event = { "UIEnter" },
  --   opts = {
  --     views = {
  --
  --       cmdline = {
  --         width = 0.35,
  --         col = 0.5,
  --         row = 0.35,
  --         relative = "editor",
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "chrisgrieser/nvim-rip-substitute",
  --   cmd = "RipSubstitute",
  --   opts = {},
  --   keys = {
  --     {
  --       "<leader>rs",
  --       function() require("rip-substitute").sub() end,
  --       mode = { "n", "x" },
  --       desc = " rip substitute",
  --     },
  --   },
  -- },
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
    "keaising/im-select.nvim",
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
        default_im_select = "keyboard-us",

        -- Can be binary's name, binary's full path, or a table, e.g. 'im-select',
        -- '/usr/local/bin/im-select' for binary without extra arguments,
        -- or { "AIMSwitcher.exe", "--imm" } for binary need extra arguments to work.
        -- For Windows/WSL, default: "im-select.exe"
        -- For macOS, default: "macism"
        -- For Linux, default: "fcitx5-remote" or "fcitx-remote" or "ibus"
        default_command = im_default_command,

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
    url = "https://codeberg.org/andyg/leap.nvim.git",
    dependencies = {
      "tpope/vim-repeat",
    },
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
  -- == Examples of Adding Plugins ==
  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  -- == Examples of Overriding Plugins ==
  -- customize dashboard options
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
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
      input = { enabled = true },
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
  { "max397574/better-escape.nvim", enabled = true },
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
