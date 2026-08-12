if not vim.g.neovide then
  return {} -- do nothing if not in a Neovide session
end

vim.g.neovide_opacity = 0.95
vim.g.neovide_guigont = "Maple Mono"
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
-- Ctrl+Shift+v paste
vim.keymap.set({ "n", "i", "v", "x" }, "<C-S-v>", function()
  vim.api.nvim_paste(vim.fn.getreg("+"), false, -1)
end)
