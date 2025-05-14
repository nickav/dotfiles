local function runApplescript(script)
	return function()
    hs.osascript.applescript(script)
    end
end

function open(name)
    return function()
        hs.application.launchOrFocus(name)
    end
end

local function remap(mods, key, pressFn)
	hs.hotkey.bind(mods, key, pressFn, nil, nil)
end

remap({'ctrl'}, '2', open("Sublime Text"))

remap({'ctrl'}, '3', runApplescript([[
tell application "iTerm2"
	reopen
	activate
end tell
]]))


remap({'ctrl'}, '4', runApplescript([[
tell application "Brave"
	reopen
	activate
end tell
]]))

