--- Statusline / tabline / winbar for this config.
---
--- Heirline is vendored into this config (`lua/heirline`, `lua/heirline-components`)
--- instead of being installed by lazy.nvim, so the UI code shares the config's
--- lifecycle and is loaded before the first UI attaches. This module is the
--- single entry point for that UI; `init.lua` calls `setup()` as the last step
--- of startup, after the colorscheme is applied.

local M = {}

local heirline = require("heirline")
local lib = require("heirline-components.all")

--- Heirline components for the three bars. Shared by `setup()`.
local function bars()
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
end

function M.setup()
  -- Subscribes to ColorScheme (reloads the colors below) and to the buffer
  -- events that keep `vim.t.bufs` in sync with the tab bar. Registered here,
  -- during startup, so the buffer-seeding UIEnter autocmd it installs still
  -- gets a chance to fire for the first UI.
  lib.init.subscribe_to_events()
  heirline.load_colors(lib.hl.get_colors())
  heirline.setup(bars())

  vim.opt.showtabline = 2 -- always show the tab bar

  -- Toggle keymaps
  vim.keymap.set("n", "<leader>ut", function()
    vim.o.showtabline = vim.o.showtabline == 2 and 0 or 2
    vim.cmd("redraw")
  end, { desc = "Toggle tab bar" })
  vim.keymap.set("n", "<leader>un", function()
    vim.g.enable_navbar = vim.g.enable_navbar == false
    vim.cmd("redraw")
  end, { desc = "Toggle nav bar" })
  -- Pick a buffer from the tabline: a letter is shown on each buffer,
  -- press it to switch.
  vim.keymap.set("n", "<leader>bb", function()
    lib.heirline.buffer_picker(function(bufnr)
      vim.api.nvim_set_current_buf(bufnr)
    end)
  end, { desc = "Pick buffer from tabline" })
end

return M
