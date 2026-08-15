-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")


-- Ctrl+HJKL as arrow keys. Uses the down/up split from Omarchy's own
-- bindings/clipboard.lua, since a plain send_shortcut can leave synthetic
-- key state stuck/repeating: https://github.com/hyprwm/Hyprland/discussions/14099
local function send_key_once(key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = "", key = key, state = "down" }))

    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = "", key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

local function send_shortcut_once(mods, key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))

    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

-- Apps with their own native SUPER+<key> binding (Ghostty/Sublime, configured
-- in config/ghostty and sublime/) get the raw SUPER+<key> forwarded to them
-- unchanged, via the "activewindow" window target so it's delivered directly
-- to that surface rather than re-entering Hyprland's own bind matching.
-- Every other app gets CTRL+<key> sent instead.
local NATIVE_SUPER_KEY_APPS = { "com.mitchellh.ghostty", "sublime_text" }

local function forward_native_or_send_ctrl(key)
  return function()
    local window = hl.get_active_window()
    local class = window and window.class
    local is_native = false
    for _, app_class in ipairs(NATIVE_SUPER_KEY_APPS) do
      if class == app_class then
        is_native = true
        break
      end
    end

    local mods = is_native and "SUPER" or "CTRL"
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down", window = "activewindow" }))

    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up", window = "activewindow" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

o.bind("CTRL + H", "Left arrow", send_key_once("Left"), { repeating = true })
o.bind("CTRL + J", "Down arrow", send_key_once("Down"), { repeating = true })
o.bind("CTRL + K", "Up arrow", send_key_once("Up"), { repeating = true })
o.bind("CTRL + L", "Right arrow", send_key_once("Right"), { repeating = true })

-- Free up SUPER+T for a Ghostty new-tab binding; move floating-toggle
-- (default: bindings/tiling.lua) to SUPER+Y instead.
hl.unbind("SUPER + T")
o.bind("SUPER + Y", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))
o.bind("SUPER + T", "New tab (native) / Send Ctrl+T", forward_native_or_send_ctrl("T"))

-- Disable webapp shortcuts (default: bindings/applications.lua) and lazydocker.
-- Generic Browser / Browser (private) bindings are left intact.
hl.unbind("SUPER + SHIFT + A")         -- ChatGPT
hl.unbind("SUPER + SHIFT + ALT + A")   -- Grok
hl.unbind("SUPER + SHIFT + C")         -- Calendar (HEY)
hl.unbind("SUPER + SHIFT + E")         -- Email (HEY)
hl.unbind("SUPER + SHIFT + ALT + E")   -- New email (HEY)
hl.unbind("SUPER + SHIFT + Y")         -- YouTube
hl.unbind("SUPER + SHIFT + ALT + G")   -- WhatsApp
hl.unbind("SUPER + SHIFT + CTRL + G")  -- Google Messages
hl.unbind("SUPER + SHIFT + P")         -- Google Photos
hl.unbind("SUPER + SHIFT + S")         -- Google Maps
hl.unbind("SUPER + SHIFT + X")         -- X
hl.unbind("SUPER + SHIFT + ALT + X")   -- X Post
hl.unbind("SUPER + SHIFT + D")         -- Docker (lazydocker)

-- Same dispatcher Omarchy's own ALT+TAB uses (bindings/tiling.lua), just on
-- different keys. Logical SUPER resolves post-XKB-swap to the physical Alt key.
o.bind("SUPER + bracketright", "Focus on next window", hl.dsp.window.cycle_next())
o.bind("SUPER + bracketleft", "Focus on previous window", hl.dsp.window.cycle_next({ next = false }))

dofile(os.getenv("HOME") .. "/.config/omarchy/plugins/io.github.pablo-merino.altswitch/altswitch.lua")

-- Move "Keybindings" (default: bindings/applications.lua, was SUPER + K)
-- to SUPER + SHIFT + SLASH. That combo was previously "Passwords"
-- (1Password); overridden here since Keybindings help takes priority.
hl.unbind("SUPER + K")
hl.unbind("SUPER + SHIFT + SLASH") -- was: Passwords (1Password)
o.bind("SUPER + SHIFT + SLASH", "Keybindings", "omarchy-menu-keybindings")
hl.unbind("SUPER + SLASH") -- was: Monitor scaling up

-- Disable a default binding without replacing it.
hl.unbind("SUPER + P") -- was: Pseudo window (toggle pseudo-tiling)
hl.unbind("SUPER + O") -- was: Pop window out (float & pin)

-- Move "Toggle scratchpad" (default: bindings/tiling.lua) from SUPER+S to
-- SUPER+grave, freeing SUPER+S to send Ctrl+S (save) to the focused window.
hl.unbind("SUPER + S")
o.bind("SUPER + GRAVE", "Toggle scratchpad", hl.dsp.workspace.toggle_special("scratchpad"))
o.bind("SUPER + S", "Send Ctrl+S", send_shortcut_once("CTRL", "S"))

-- Swap "Close window" (default: bindings/tiling.lua) from SUPER+W to
-- SUPER+SHIFT+W, freeing SUPER+W for apps' own "close tab" bindings
-- (Ghostty/Sublime, configured separately). SUPER+SHIFT+W was previously
-- "Omawrite".
hl.unbind("SUPER + W")
hl.unbind("SUPER + SHIFT + W") -- was: Omawrite
o.bind("SUPER + SHIFT + W", "Close window", hl.dsp.window.close())
o.bind("SUPER + W", "Close tab (native) / Send Ctrl+W", forward_native_or_send_ctrl("W"))

-- SUPER+O / SUPER+SHIFT+O send Ctrl+O / Ctrl+Shift+O to the focused window
-- (Open File / Open Folder in most apps, incl. Sublime's own defaults).
-- SUPER+SHIFT+O was previously "Obsidian".
hl.unbind("SUPER + SHIFT + O") -- was: Obsidian
o.bind("SUPER + O", "Send Ctrl+O", send_shortcut_once("CTRL", "O"))
o.bind("SUPER + SHIFT + O", "Send Ctrl+Shift+O", send_shortcut_once("CTRL SHIFT", "O"))

-- SUPER+L sends Ctrl+L to the focused window. Was "Toggle workspace layout".
-- Distinct from the plain CTRL+L arrow-key remap above (different modifier).
hl.unbind("SUPER + L") -- was: Toggle workspace layout
o.bind("SUPER + L", "Send Ctrl+L", send_shortcut_once("CTRL", "L"))

o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

-- Every other free SUPER+<letter> sends Ctrl+<letter> to the focused
-- window. Excludes SUPER+T and SUPER+W, which have their own conditional
-- forward_native_or_send_ctrl bindings above, and SUPER+D, which is left
-- unbound so Ghostty's/Sublime's own native split bindings (configured in
-- config/ghostty and sublime/) receive the raw keypress instead.
for _, letter in ipairs({ "A", "B", "E", "H", "I", "K", "M", "N", "P", "R", "U", "Z" }) do
  o.bind("SUPER + " .. letter, "Send Ctrl+" .. letter, send_shortcut_once("CTRL", letter))
end

-- Guard "Toggle window split" (default: bindings/tiling.lua): togglesplit is
-- a dwindle-only layoutmsg, so it throws a Lua runtime error ("no such
-- layoutmsg for scrolling") when the active workspace is using the
-- scrolling layout (SUPER + L) instead of dwindle.
hl.unbind("SUPER + J")
o.bind("SUPER + J", "Toggle window split", function()
  local workspace = hl.get_active_workspace()
  if workspace and workspace.tiled_layout == "dwindle" then
    hl.dispatch(hl.dsp.layout("togglesplit"))
  end
end)

