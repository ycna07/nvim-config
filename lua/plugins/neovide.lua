if not vim.g.neovide then
  return {} -- do nothing if not in a Neovide session
end

-- local function set_ime(args)
--   if args.event:match "Enter$" then
--     vim.g.neovide_input_ime = true
--   else
--     vim.g.neovide_input_ime = false
--   end
-- end
--
-- local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })
--
-- vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
--   group = ime_input,
--   pattern = "*",
--   callback = set_ime,
-- })
--
-- vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
--   group = ime_input,
--   pattern = "[/\\?]",
--   callback = set_ime,
-- })

vim.g.neovide_opacity = 0.95
vim.api.nvim_set_keymap(
  "n",
  "<C-=>",
  ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
  { silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<C-->",
  ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
  { silent = true }
)
vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })

-- Settings With Astro
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = { -- configure vim.opt options
        -- configure font
        guifont = "JetBrainsMono Nerd Font Mono",
        -- line spacing
        linespace = 0,
      },
      g = { -- configure vim.g variables
        -- configure scaling
        neovide_scale_factor = 1.3,
        -- configure padding
        neovide_padding_top = 0,
        neovide_padding_bottom = 0,
        neovide_padding_right = 0,
        neovide_padding_left = 0,
      },
    },
  },
}
