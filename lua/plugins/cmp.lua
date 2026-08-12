---@type function?, function?
local icon_provider, hl_provider

local function get_kind_icon(CTX)
  -- Evaluate icon provider
  if not icon_provider then
    local _, mini_icons = pcall(require, "mini.icons")
    if _G.MiniIcons then
      icon_provider = function(ctx)
        local is_specific_color = ctx.kind_hl and ctx.kind_hl:match("^HexColor") ~= nil
        if ctx.item.source_name == "LSP" then
          local icon, hl = mini_icons.get("lsp", ctx.kind or "")
          if icon then
            ctx.kind_icon = icon
            if not is_specific_color then
              ctx.kind_hl = hl
            end
          end
        elseif ctx.item.source_name == "Path" then
          ctx.kind_icon, ctx.kind_hl = mini_icons.get(ctx.kind == "Folder" and "directory" or "file", ctx.label)
        elseif ctx.item.source_name == "Snippets" then
          ctx.kind_icon, ctx.kind_hl = mini_icons.get("lsp", "snippet")
        end
      end
    end
    if not icon_provider then
      local lspkind_avail, lspkind = pcall(require, "lspkind")
      if lspkind_avail then
        icon_provider = function(ctx)
          if ctx.item.source_name == "LSP" then
            local icon = lspkind.symbol_map[ctx.kind]
            if icon then
              ctx.kind_icon = icon
            end
          elseif ctx.item.source_name == "Snippets" then
            local icon = lspkind.symbol_map["Snippet"]
            if icon then
              ctx.kind_icon = icon
            end
          end
        end
      end
    end
    if not icon_provider then
      icon_provider = function() end
    end
  end
  -- Evaluate highlight provider
  if not hl_provider then
    local highlight_colors_avail, highlight_colors = pcall(require, "nvim-highlight-colors")
    if highlight_colors_avail then
      local kinds
      hl_provider = function(ctx)
        if not kinds then
          kinds = require("blink.cmp.types").CompletionItemKind
        end
        if ctx.item.kind == kinds.Color then
          local doc = vim.tbl_get(ctx, "item", "documentation")
          if doc then
            local color_item = highlight_colors.format(doc, { kind = kinds[kinds.Color] })
            if color_item and color_item.abbr_hl_group then
              if color_item.abbr then
                ctx.kind_icon = color_item.abbr
              end
              ctx.kind_hl = color_item.abbr_hl_group
            end
          end
        end
      end
    end
    if not hl_provider then
      hl_provider = function() end
    end
  end
  -- Call resolved providers
  icon_provider(CTX)
  hl_provider(CTX)
  -- Return text and highlight information
  return { text = CTX.kind_icon .. CTX.icon_gap, highlight = CTX.kind_hl }
end

local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  "saghen/blink.cmp",
  dependencies = { { "L3MON4D3/LuaSnip", version = "v2.*" } },

  version = "1.*",

  event = { "CmdlineEnter", "BufReadPre", "BufNewFile" },
  -- AND/OR build from source
  -- build = 'cargo build --release',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    enabled = function()
      return not vim.tbl_contains({ "csv" }, vim.bo.filetype)
    end,
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    keymap = {
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-N>"] = { "select_next", "show" },
      ["<C-P>"] = { "select_prev", "show" },
      ["<C-J>"] = { "select_next", "fallback" },
      ["<C-K>"] = { "select_prev", "fallback" },
      ["<C-U>"] = { "scroll_documentation_up", "fallback" },
      ["<C-D>"] = { "scroll_documentation_down", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        "select_next",
        "snippet_forward",
        function(cmp)
          if has_words_before() or vim.api.nvim_get_mode().mode == "c" then
            return cmp.show()
          end
        end,
        "fallback",
      },
      ["<S-Tab>"] = {
        "select_prev",
        "snippet_backward",
        function(cmp)
          if vim.api.nvim_get_mode().mode == "c" then
            return cmp.show()
          end
        end,
        "fallback",
      },
    },

    fuzzy = { implementation = "prefer_rust" },
    completion = {

      accept = {
        auto_brackets = { enabled = true },
      },
      list = { selection = { preselect = false, auto_insert = true } },
      trigger = {
        show_on_keyword = true,
        show_on_trigger_character = true,
        show_on_insert_on_trigger_character = true,
        show_on_x_blocked_trigger_characters = {
          "'",
          '"',
          "(",
          "{",
          "[",
        },
      },
      menu = {
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        border = "rounded",
        draw = {
          treesitter = { "lsp" },
          components = {
            kind_icon = {
              text = function(ctx)
                return get_kind_icon(ctx).text
              end,
              highlight = function(ctx)
                return get_kind_icon(ctx).highlight
              end,
            },
          },
        },
      },
      documentation = { auto_show = true },
    },

    cmdline = {
      completion = { menu = { auto_show = true } },
    },
    signature = {
      enabled = true,
      trigger = {
        -- Show the signature help automatically
        enabled = true,
        -- Show the signature help window after typing any of alphanumerics, `-` or `_`
        show_on_keyword = false,
        blocked_trigger_characters = {},
        blocked_retrigger_characters = {},
        -- Show the signature help window after typing a trigger character
        show_on_trigger_character = true,
        -- Show the signature help window when entering insert mode
        show_on_insert = false,
        -- Show the signature help window when the cursor comes after
        -- a trigger character when entering insert mode
        show_on_insert_on_trigger_character = true,
      },
      window = {
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
      },
    },
  },

  opts_extend = { "sources.default" },
  config = function(_, opts)
    require("blink.cmp").setup(opts)
  end,

  specs = {
    { -- disable blink icons if icons are disabled
      "saghen/blink.cmp",
      opts = function(_, opts)
        if vim.g.icons_enabled == false then
          if not opts.appearance then
            opts.appearance = {}
          end
          opts.appearance.kind_icons = {
            Text = "T",
            Method = "M",
            Function = "F",
            Constructor = "C",
            Field = "F",
            Variable = "V",
            Property = "P",
            Class = "C",
            Interface = "I",
            Struct = "S",
            Module = "M",
            Unit = "U",
            Value = "V",
            Enum = "E",
            EnumMember = "E",
            Keyword = "K",
            Constant = "C",
            Snippet = "S",
            Color = "C",
            File = "F",
            Reference = "R",
            Folder = "F",
            Event = "E",
            Operator = "O",
            TypeParameter = "T",
          }
        end
      end,
    },
  },
}
