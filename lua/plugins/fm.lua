---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    -- "nvim-mini/mini.icons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    window = {
      position = "float",
    },
  },
  -- config = function()
  --   require("neo-tree").setup({})
  -- end,
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" },
  },
}
