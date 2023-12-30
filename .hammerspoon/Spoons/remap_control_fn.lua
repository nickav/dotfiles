local function sendSystemKey(key)
    hs.eventtap.event.newSystemKeyEvent(key, true):post()
    hs.eventtap.event.newSystemKeyEvent(key, false):post()
end

local function system(key)
    return function()
        sendSystemKey(key)
    end
end

hs.hotkey.bind({'ctrl'}, "F1", system("BRIGHTNESS_DOWN"))
hs.hotkey.bind({'ctrl'}, "F2", system("BRIGHTNESS_UP"))
hs.hotkey.bind({'ctrl'}, "F3", system("LAUNCH_PANEL"))
hs.hotkey.bind({'ctrl'}, "F4", system("HELP"))
--hs.hotkey.bind({'ctrl'}, "F5", system("HELP"))
hs.hotkey.bind({'ctrl'}, "F6", system("POWER"))
hs.hotkey.bind({'ctrl'}, "F7", system("PREVIOUS"))
hs.hotkey.bind({'ctrl'}, "F8", system("PLAY"))
hs.hotkey.bind({'ctrl'}, "F9", system("NEXT"))
hs.hotkey.bind({'ctrl'}, "F10", system("MUTE"))
hs.hotkey.bind({'ctrl'}, "F11", system("SOUND_DOWN"), nil, system("SOUND_DOWN"))
hs.hotkey.bind({'ctrl'}, "F12", system("SOUND_UP"), nil, system("SOUND_UP"))