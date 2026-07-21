-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.dart" },
  -- { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.recipes.vscode" },
  { import = "astrocommunity.recipes.picker-lsp-mappings" },
  -- { import = "astrocommunity.recipes.ai" },
  -- { import = "astrocommunity.ai.avante-nvim" },

  -- import/override with your plugins folder
}
