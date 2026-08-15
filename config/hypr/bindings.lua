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

o.bind("CTRL + H", "Left arrow", send_key_once("Left"), { repeating = true })
o.bind("CTRL + J", "Down arrow", send_key_once("Down"), { repeating = true })
o.bind("CTRL + K", "Up arrow", send_key_once("Up"), { repeating = true })
o.bind("CTRL + L", "Right arrow", send_key_once("Right"), { repeating = true })

-- Free up SUPER+T for a Ghostty new-tab binding; move floating-toggle
-- (default: bindings/tiling.lua) to SUPER+Y instead.
hl.unbind("SUPER + T")
o.bind("SUPER + Y", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))

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

