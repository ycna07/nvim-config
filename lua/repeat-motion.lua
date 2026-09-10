-- Repeat the last motion: `;` replays it as-is, `,` replays it direction-inverted
-- (bracket motions and f/F/t/T only; others are skipped).
-- Built on the 0.13+ CmdAtom event (:h motion-repeat). Coexists with flash.nvim
-- (which owns f/F/t/T) and replaces demicolon.nvim.
--
-- NOTE: char motions (f/F/t/T) are replayed through the NATIVE motions with
-- noremap. Replaying them through flash's getchar-based mapping loses/leaks the
-- payload char when motion+char are fed in one batch (0.13 input regression).
local M = {}

---@type vim.event.cmdatom.data?
local last = nil

-- Second-char flip for bracket motions whose direction changes: ][ <-> [], ]) <-> [(, ...
local OPPOSITE = { ["["] = "]", ["]"] = "[", ["("] = ")", [")"] = "(", ["{"] = "}", ["}"] = "{" }
-- f/F/t/T flip for `,`.
local FLIP = { f = "F", F = "f", t = "T", T = "t" }

--- Replay source of an atom: the keysequence to feed and the feedkeys mode.
--- `keys` (resolved, native commands) -> 'n'; Lua mappings have no `keys` ->
--- their `lhs` with 'm' (remap). Char motions (flash) -> native replay with 'n'.
---@param atom vim.event.cmdatom.data
---@return string src
---@return string mode
---@return boolean is_char
local function atom_src(atom)
  local lhs = atom.lhs or ""
  if FLIP[lhs:sub(1, 1)] ~= nil and #lhs >= 2 then
    return lhs, "n", true
  end
  if atom.remap and lhs ~= "" then
    return (lhs:gsub("^%d+", "")), "m", false
  elseif (atom.keys or "") ~= "" then
    return (atom.keys:gsub("^%d+", "")), "n", false
  end
  return (lhs:gsub("^%d+", "")), "m", false
end

local function on_cmdatom(ev)
  local d = ev.data
  if d.changed then
    return
  end
  local t = d.type
  if t ~= "motion" and t ~= "mapping" and t ~= "excmd" then
    return
  end
  local lhs = d.lhs or ""
  -- Bracket/char motions are always recorded: API-driven jumps (vim.diagnostic.jump)
  -- report moved=false. Everything else needs moved=true (all-motions scope).
  local first = lhs:sub(1, 1)
  local is_bracket = first == "]" or first == "["
  local is_char = FLIP[first] ~= nil and #lhs >= 2
  if not is_bracket and not is_char and t ~= "motion" and not d.moved then
    return
  end
  if vim.fn.keytrans(lhs) == ";" or vim.fn.keytrans(lhs) == "," then
    return
  end
  if lhs == "" and (d.keys == nil or d.keys == "") then
    return
  end
  last = d
end

local function feed(count, keys, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(count .. keys, true, false, true), mode, false)
end

local function repeat_forward()
  local count = vim.v.count1
  -- CmdAtom is deferred: the atom of a motion typed right before `;` may not have
  -- arrived yet, so read `last` after the event loop settles.
  vim.schedule(function()
    local atom = last
    if not atom then
      return
    end
    local src, mode = atom_src(atom)
    if src ~= "" then
      feed(count, src, mode)
    end
  end)
end

local function repeat_backward()
  local count = vim.v.count1
  vim.schedule(function()
    local atom = last
    if not atom then
      return
    end
    local src, mode, is_char = atom_src(atom)
    local first, rest = src:sub(1, 1), src:sub(2)
    if is_char then
      feed(count, FLIP[first] .. rest, "n")
      return
    end
    if first == "]" or first == "[" then
      local other = first == "]" and "[" or "]"
      local second = rest:sub(1, 1)
      feed(count, other .. (OPPOSITE[second] or second) .. rest:sub(2), mode)
    end
  end)
end

function M.setup()
  if vim.fn.has("nvim-0.13") ~= 1 then
    return
  end
  vim.api.nvim_create_autocmd("CmdAtom", {
    group = vim.api.nvim_create_augroup("repeat-motion", { clear = true }),
    callback = on_cmdatom,
  })
  vim.keymap.set({ "n", "x", "o" }, ";", repeat_forward, { desc = "Repeat last motion" })
  vim.keymap.set({ "n", "x", "o" }, ",", repeat_backward, { desc = "Repeat last motion backwards" })
end

return M
