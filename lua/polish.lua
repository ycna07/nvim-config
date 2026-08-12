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
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
  end,
})
vim.cmd.colorscheme("catppuccin-latte")
-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
