local function runApplescript(script)
	return function()
    hs.osascript.applescript(script)
  end
end

local function remap(mods, key, pressFn)
	hs.hotkey.bind(mods, key, pressFn, nil, nil)
	hs.hotkey.bind({'cmd'}, key, pressFn, nil, nil)
end

-- prev (f7)
remap({'alt'}, 'f7', runApplescript([[
on is_running(appName)
	tell application "System Events" to (name of processes) contains appName
end is_running

if is_running("Spotify") then
	tell application "Spotify" to previous track
else if is_running("iTunes") then
	tell application "iTunes" to previous track
end if
]]))
-- play/pause (f8)
remap({'alt'}, 'f8', runApplescript([[
on is_running(appName)
	tell application "System Events" to (name of processes) contains appName
end is_running

if is_running("Spotify") then
	tell application "Spotify" to playpause
else if is_running("iTunes") then
	tell application "iTunes" to playpause
end if
]]))
-- next (f9)
remap({'alt'}, 'f9', runApplescript([[
on is_running(appName)
	tell application "System Events" to (name of processes) contains appName
end is_running

if is_running("Spotify") then
	tell application "Spotify" to next track
else if is_running("iTunes") then
	tell application "iTunes" to next track
end if
]]))
-- toggle mute (f10)
remap({'alt'}, 'f10', runApplescript([[
if output muted of (get volume settings) then
	set volume without output muted
else
	set volume with output muted
end if
]]))
-- volume down (f11)
remap({'alt'}, 'f11', runApplescript([[
set volume output volume ((output volume of (get volume settings)) - 5)
]]))
-- volume up (f12)
remap({'alt'}, 'f12', runApplescript([[
set volume output volume ((output volume of (get volume settings)) + 5)
]]))
