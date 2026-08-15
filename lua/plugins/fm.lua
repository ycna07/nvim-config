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
    commands = {

      parent_or_close = function(state)
        local node = state.tree:get_node()
        if node:has_children() and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end,
      child_or_open = function(state)
        local node = state.tree:get_node()
        if node:has_children() then
          if not node:is_expanded() then -- if unexpanded, expand
            state.commands.toggle_node(state)
          else -- if expanded and has children, select the next child
            if node.type == "file" then
              state.commands.open(state)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          end
        else -- if has no children
          state.commands.open(state)
        end
      end,
    },
    window = {
      position = "float",
      mappings = {
        h = "parent_or_close",
        l = "child_or_open",
      },
    },
    filesystem = {
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = vim.fn.has("win32") ~= 1,
    },
  },
  -- config = function()
  --   require("neo-tree").setup({})
  -- end,
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" },
  },
}
