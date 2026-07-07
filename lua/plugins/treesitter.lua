if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter
-- --------------------
-- Treesitter customizations are handled with AstroCore
-- as nvim-treesitter simply provides a download utility for parsers

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    treesitter = {
      highlight = true, -- enable/disable treesitter based highlighting
      indent = true, -- enable/disable treesitter based indentation
      auto_install = true, -- enable/disable automatic installation of detected languages
      ensure_installed = {
        "lua",
        "vim",
        -- add more arguments for adding more treesitter parsers
      },
      textobjects = {
        select = {
          select_textobject = {
            ["af"] = { query = "@function.outer", desc = "around function" },
            ["if"] = { query = "@function.inner", desc = "around function" },
          },
        },
        move = {
          goto_next_start = {
            ["]f"] = { query = "@function.outer", desc = "Next function start" },
          },
          goto_next_end = {
            ["]F"] = { query = "@function.outer", desc = "Next function end" },
          },
          goto_previous_start = {
            ["[f"] = {
              query = "@function.outer",
              desc = "Previous function start",
            },
          },
          goto_previous_end = {
            ["[F"] = {
              query = "@function.outer",
              desc = "Previous function end",
            },
          },
        },
        swap = {
          swap_next = {
            [">F"] = { query = "@function.outer", desc = "Swap next function" },
          },
          swap_previous = {
            ["<F"] = {
              query = "@function.outer",
              desc = "Swap previous function",
            },
          },
        },
      },
    },
  },
}
