return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    dependencies = { "nvim-mini/mini.icons" },
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostic disable: missing-fields
    opts = {
      winopts = {
        border = "rounded",
        backdrop = 100,
        fullscreen = true,
      },
      keymap = {
        fzf = {
          true,
          ["tab"] = "down",
          ["btab"] = "up",
        },
      },
    },
    ---@diagnostic enable: missing-fields
    keys = {
      {
        "<leader>f<enter>",
        function()
          require("fzf-lua").resume()
        end,
        desc = "resume last search",
      },
      {
        "<leader>ff",
        function()
          require("fzf-lua").files()
        end,
        desc = "Find files",
      },

      {
        "<leader>fo",
        "<cmd>FzfLua nvim_options<cr>",
        desc = "Find nvim options",
      },
      {
        "<leader>ft",
        "<cmd>FzfLua colorschemes<cr>",
        desc = "Find colorschemes",
      },
      {
        "<leader>fu",
        "<cmd>FzfLua undotree<cr>",
        desc = "Find undo history",
      },
      {
        "<leader>fj",
        "<cmd>FzfLua jumps<cr>",
        desc = "Find jump",
      },
      {
        "<leader>fr",
        "<cmd>FzfLua registers<cr>",
        desc = "Find registers",
      },
      {
        "<leader>fw",
        function()
          require("fzf-lua").live_grep()
        end,
        desc = "Live grep",
      },
      {
        "<leader>fb",
        function()
          require("fzf-lua").buffers()
        end,
        desc = "Find buffers",
      }, -- 查找缓冲区
      {
        "<leader>fh",
        function()
          require("fzf-lua").help_tags()
        end,
        desc = "Help tags",
      }, -- 查找帮助标签
      {
        "<leader>fk",
        function()
          require("fzf-lua").keymaps()
        end,
        desc = "Help tags",
      }, -- 查找帮助标签
      {
        "<leader>fg",
        function()
          require("fzf-lua").git_files()
        end,
        desc = "Git files",
      }, -- 查找 Git 文件
      { "<leader>lD", "<cmd>FzfLua diagnostics_workspace<CR>", desc = "Workspace Diagnostics" },
      { "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Document Symbols" } },
    },
  },
}
