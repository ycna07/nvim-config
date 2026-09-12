-- Heirline (statusline/tabline/winbar) lives in the config itself:
-- `lua/heirline`, `lua/heirline-components` and the `lua/statusline.lua` entry
-- point. Nothing to manage here anymore.
return {
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
