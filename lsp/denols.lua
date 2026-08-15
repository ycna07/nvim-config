--deno
local denols = {
  cmd = { "deno", "lsp" },
  filetypes = { "typescript" },
  root_markers = { { "deno.lock", "deno.json" }, ".git" },
}

return denols
