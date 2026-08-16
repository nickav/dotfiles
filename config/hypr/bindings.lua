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

-- Sends a chain of shortcuts in sequence, each waiting for the previous
-- key's up-event before starting. Used for compound edits that don't have a
-- single dispatcher, like "select to beginning of line, then delete".
local function send_shortcut_chain(steps)
  return function()
    local function run(i)
      if i > #steps then return end
      local mods, key = steps[i][1], steps[i][2]
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))
      hl.timer(function()
        hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
        hl.timer(function() run(i + 1) end, { timeout = 20, type = "oneshot" })
      end, { timeout = 50, type = "oneshot" })
    end
    run(1)
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

o.bind("CTRL + SHIFT + ESCAPE", "Task manager", "xdg-terminal-exec btop")

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

-- Recover left/right window-swapping here (bindings/tiling.lua's SUPER+SHIFT+
-- LEFT/RIGHT was freed above for macOS-style text navigation).
o.bind("SUPER + SHIFT + bracketright", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))
o.bind("SUPER + SHIFT + bracketleft", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))

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

-- Move "Lock system" off SUPER+CTRL+L (was colliding with the workspace
-- layout toggle we want there) onto SUPER+ALT+L. (The power button can't be
-- used: systemd-logind grabs it directly, so Hyprland never sees the key.)
hl.unbind("SUPER + CTRL + L") -- was: Lock system
o.bind("SUPER + ALT + L", "Lock system", "omarchy-system-lock")

-- SUPER+CTRL+L toggles the active workspace between dwindle and the
-- niri-like scrolling layout.
o.bind("SUPER + CTRL + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")

-- SUPER+F11 also toggles fullscreen, same as SUPER+F.
o.bind("SUPER + F11", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
o.bind("ALT + F11", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

-- Every other free SUPER+<letter> sends Ctrl+<letter> to the focused
-- window. Excludes SUPER+T and SUPER+W, which have their own conditional
-- forward_native_or_send_ctrl bindings above, and SUPER+D, which launches
-- a copy of the focused app instead (see below).
for _, letter in ipairs({ "A", "B", "E", "H", "I", "K", "M", "N", "P", "R", "U", "Z" }) do
  o.bind("SUPER + " .. letter, "Send Ctrl+" .. letter, send_shortcut_once("CTRL", letter))
end

-- SUPER+SHIFT+Z sends Ctrl+Shift+Z (redo), matching SUPER+Z (undo) above.
o.bind("SUPER + SHIFT + Z", "Send Ctrl+Shift+Z (redo)", send_shortcut_once("CTRL SHIFT", "Z"))

-- SUPER+D launches a new copy of the focused app, via its own .desktop
-- "New Window" action (see bin/omarchy-launch-focused-app-copy) if it
-- declares one, otherwise a new terminal. This takes over Ghostty's/
-- Sublime's own native SUPER+D (new split / clone file).
o.bind("SUPER + D", "Launch a copy of the focused app (default: terminal)", function()
  local window = hl.get_active_window()
  local class = window and window.class or ""

  hl.dispatch(hl.dsp.exec_cmd("omarchy-launch-focused-app-copy " .. class))
end)

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

-- macOS-style text navigation.
--
-- SUPER+arrows was window focus (bindings/tiling.lua) and SUPER+SHIFT+arrows
-- was window swap; both are given up here in favor of Cmd-style line/document
-- navigation. (SUPER+bracketleft/bracketright still cycle focus.)
-- SUPER+CTRL+arrows (grouped-window focus) and SUPER+ALT+arrows (move into
-- group / move workspace to monitor) are unaffected: different combos.
hl.unbind("SUPER + LEFT")
hl.unbind("SUPER + RIGHT")
hl.unbind("SUPER + UP")
hl.unbind("SUPER + DOWN")
hl.unbind("SUPER + SHIFT + LEFT")
hl.unbind("SUPER + SHIFT + RIGHT")
hl.unbind("SUPER + SHIFT + UP")
hl.unbind("SUPER + SHIFT + DOWN")

o.bind("SUPER + LEFT", "Send Home (beginning of line)", send_shortcut_once("", "Home"))
o.bind("SUPER + RIGHT", "Send End (end of line)", send_shortcut_once("", "End"))
o.bind("SUPER + UP", "Send Ctrl+Home (beginning of document)", send_shortcut_once("CTRL", "Home"))
o.bind("SUPER + DOWN", "Send Ctrl+End (end of document)", send_shortcut_once("CTRL", "End"))
o.bind("SUPER + SHIFT + LEFT", "Send Shift+Home (select to beginning of line)", send_shortcut_once("SHIFT", "Home"))
o.bind("SUPER + SHIFT + RIGHT", "Send Shift+End (select to end of line)", send_shortcut_once("SHIFT", "End"))
o.bind("SUPER + SHIFT + UP", "Send Ctrl+Shift+Home (select to beginning of document)", send_shortcut_once("CTRL SHIFT", "Home"))
o.bind("SUPER + SHIFT + DOWN", "Send Ctrl+Shift+End (select to end of document)", send_shortcut_once("CTRL SHIFT", "End"))

-- SUPER+BACKSPACE was "Toggle window transparency" (bindings/utilities.lua);
-- freed here for delete-to-beginning-of-line, to match the SUPER+LEFT (go to
-- beginning of line) binding above. SUPER+DELETE mirrors it forward.
hl.unbind("SUPER + BACKSPACE")
o.bind("SUPER + BACKSPACE", "Delete to beginning of line", send_shortcut_chain({ { "SHIFT", "Home" }, { "", "BackSpace" } }))
o.bind("SUPER + DELETE", "Delete to end of line", send_shortcut_chain({ { "SHIFT", "End" }, { "", "Delete" } }))

-- CTRL+Left/Right (move by word) is already unbound by Hyprland/Omarchy, so
-- it already passes through untouched to whatever the focused app does with
-- it (word navigation, by default, in virtually everything). ALT+Left/Right
-- gets the same word-navigation treatment here for apps that don't already
-- give Alt that meaning themselves; this does take over Alt+Left/Right as
-- Back/Forward history navigation in browsers like Brave.
o.bind("ALT + LEFT", "Send Ctrl+Left (word left)", send_shortcut_once("CTRL", "Left"))
o.bind("ALT + RIGHT", "Send Ctrl+Right (word right)", send_shortcut_once("CTRL", "Right"))
o.bind("ALT + SHIFT + LEFT", "Send Ctrl+Shift+Left (select word left)", send_shortcut_once("CTRL SHIFT", "Left"))
o.bind("ALT + SHIFT + RIGHT", "Send Ctrl+Shift+Right (select word right)", send_shortcut_once("CTRL SHIFT", "Right"))

-- ALT+Backspace/Delete delete a whole word, same pairing as ALT+Left/Right
-- above (Ctrl+Backspace/Delete is the underlying Linux word-delete already
-- native to most apps; ALT+Backspace/Delete themselves are unbound/inert).
o.bind("ALT + BACKSPACE", "Send Ctrl+Backspace (delete word left)", send_shortcut_once("CTRL", "BackSpace"))
o.bind("ALT + DELETE", "Send Ctrl+Delete (delete word right)", send_shortcut_once("CTRL", "Delete"))

