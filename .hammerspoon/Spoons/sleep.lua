local function runCommand(cmd)
	return function() hs.execute(cmd) end
end

local function remap(mods, key, pressFn)
	hs.hotkey.bind(mods, key, pressFn, nil, nil)
end

-- sleep command
remap({'alt', 'cmd'}, 'f15', runCommand("pmset sleepnow"))
remap({'alt', 'cmd'}, 'f12', runCommand("pmset sleepnow"))
