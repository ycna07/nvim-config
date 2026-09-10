return {
  {
    "rebelot/heirline.nvim",
    dependencies = { "Zeioth/heirline-components.nvim" },
    enabled = true,
    event = "UIEnter",
    opts = function()
      local lib = require("heirline-components.all")
      return {
        tabline = { -- Tab bar (buffer tabs at the top)
          hl = { bg = "tabline_bg" },
          lib.component.tabline_buffers(),
          lib.component.fill(),
          lib.component.tabline_tabpages(),
          lib.component.tabline_conditional_padding(),
        },
        winbar = { -- Nav bar (LSP breadcrumbs only)
          condition = function()
            return vim.g.enable_navbar ~= false
              and vim.bo.buftype == ""
              and not vim.tbl_contains({ "aerial", "neo-tree", "NvimTree" }, vim.bo.filetype)
          end,
          hl = { fg = "fg", bg = "winbar_bg" },
          lib.component.breadcrumbs({ padding = { left = 1 } }),
        },
        statusline = { -- UI statusbar
          hl = { fg = "fg", bg = "bg" },
          lib.component.mode(),
          lib.component.git_branch(),
          lib.component.file_info(),
          lib.component.git_diff(),
          lib.component.diagnostics(),
          lib.component.fill(),
          lib.component.cmd_info(),
          lib.component.fill(),
          lib.component.lsp(),
          lib.component.treesitter(),
          lib.component.compiler_state(),
          lib.component.virtual_env(),
          lib.component.nav(),
        },
      }
    end,

    config = function(_, opts)
      local heirline = require("heirline")
      local heirline_components = require("heirline-components.all")

      heirline_components.init.subscribe_to_events()
      heirline.load_colors(heirline_components.hl.get_colors())
      heirline.setup(opts)
      vim.opt.showtabline = 2 -- always show the tab bar

      -- Seed vim.t.bufs: heirline-components' own UIEnter autocmd is registered
      -- *during* UIEnter, so it never fires and the tab bar starts empty.
      if not vim.t.bufs or #vim.t.bufs == 0 then
        vim.t.bufs = vim.tbl_filter(function(b)
          return vim.api.nvim_buf_is_valid(b) and vim.bo[b].buflisted and vim.bo[b].buftype == ""
        end, vim.api.nvim_list_bufs())
      end

      -- Toggle keymaps
      vim.keymap.set("n", "<leader>ut", function()
        vim.o.showtabline = vim.o.showtabline == 2 and 0 or 2
        vim.cmd("redraw")
      end, { desc = "Toggle tab bar" })
      vim.keymap.set("n", "<leader>un", function()
        vim.g.enable_navbar = vim.g.enable_navbar == false
        vim.cmd("redraw")
      end, { desc = "Toggle nav bar" })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = false,
    event = "UIEnter",
    opts = {
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
}
