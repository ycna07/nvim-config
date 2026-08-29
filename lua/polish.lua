require("luasnip.loaders.from_vscode").lazy_load()
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    require("lint").try_lint()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  -- pattern = { "lua", "typescript", "json", "jsonc", "rust" },
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
  end,
})
vim.cmd.colorscheme("catppuccin-latte")

-- auto start lsp
vim.lsp.enable({
  -- "ts_ls",
  "vtsls",
  "gopls",
  "scheme-langserver",
  "zls",
  "pyrefly",
  "bashls",
  "tombi",
  "lua_ls",
  "clangd",
  "rust_analyzer",
  "denols",
  "jsonls",
})
-- local configs = vim.lsp.get_config() --enable all lsp
-- for name, _ in pairs(configs) do
--     vim.lsp.enable(name)
-- end
-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
