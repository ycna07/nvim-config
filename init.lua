-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.opt.shada = "!,'100,<50,s10,h,r/tmp/,r/private/"
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.laststatus = 0
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 0
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

vim.diagnostic.config({
  -- virtual_lines = { only_current_line = true },
  virtual_text = true,
})

vim.keymap.set("n", "gd", function()
  require("fzf-lua").lsp_definitions()
end, { desc = "Find definitions with fzf-lua" })
vim.keymap.set({ "n", "v" }, "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set({ "n", "v" }, "<leader>c", ":close<CR>", { desc = "Close buffer" })
vim.keymap.set({ "n", "v" }, "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
vim.keymap.set({ "n", "v" }, "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Next diagnostic" })
vim.keymap.set({ "n", "v" }, "]e", function()
  vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })

vim.keymap.set({ "n", "v" }, "]w", function()
  vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.WARN })
end, { desc = "Next warning" })

vim.keymap.set({ "n", "v" }, "[w", function()
  vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.WARN })
end, { desc = "Next warning" })

vim.keymap.set({ "n" }, "<leader>q", ":q<cr>", { desc = "Toggle comment line" })
vim.keymap.set({ "n" }, "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
vim.keymap.set({ "x" }, "<leader>/", "gc", { remap = true, desc = "Toggle comment" })

local function toggle_wrap()
  local new_wrap = not vim.opt.wrap:get()
  vim.opt.wrap = new_wrap
  -- 在底部状态栏显示当前状态
  -- print("Word Wrap is " .. (new_wrap and "ON" or "OFF"))
end

vim.keymap.set("n", "<leader>uw", toggle_wrap, { desc = "Toggle wrap" })
require("lazy_setup")
require("polish")
