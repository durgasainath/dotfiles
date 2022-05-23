-- local hyper = {"cmd", "alt", "ctrl","shift"}
-- A global variable for the Hyper Mode
local hyper = hs.hotkey.modal.new({}, "F17")

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
function enterHyperMode()
    hyper.triggered = false
    hyper:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
-- send ESCAPE if no other keys are pressed.
function exitHyperMode()
    hyper:exit()
    if not hyper.triggered then
        hs.eventtap.keyStroke({}, "ESCAPE")
    end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, "F18", enterHyperMode, exitHyperMode)

-- Config change and reload
function reloadConfig(files)
    doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.new({title = "Hammerspoon", informativeText = "Hammerspoon Config Reloaded", withdrawAfter = 2}):send()

hyper:bind(
    {},
    "R",
    function()
        hs.reload()
    end
)

-- Defeating paste blocking
hyper:bind(
    {},
    "V",
    function()
        hs.eventtap.keyStrokes(hs.pasteboard.getContents())
    end
)

-- Toggle Window Units
hyper_h = false
hyper_j = false
hyper_k = false
hyper_l = false
hyper_f = false
hs.window.animationDuration = 0

-- Left
hyper:bind(
    {},
    "H",
    function()
        if hyper_h == false then
            hs.window.focusedWindow():moveToUnit({0, 0, 0.5, 1})
            hyper_h = true
        else
            hs.window.focusedWindow():moveToUnit({0, 0, 1, 1})
            hyper_h = false
        end
    end
)

-- Down
hyper:bind(
    {},
    "J",
    function()
        if hyper_j == false then
            hs.window.focusedWindow():moveToUnit({0, 0.5, 1, 0.5})
            hyper_j = true
        else
            hs.window.focusedWindow():moveToUnit({0, 0, 1, 1})
            hyper_j = false
        end
    end
)

-- Up
hyper:bind(
    {},
    "K",
    function()
        if hyper_k == false then
            hs.window.focusedWindow():moveToUnit({0, 0, 1, 0.5})
            hyper_k = true
        else
            hs.window.focusedWindow():moveToUnit({0, 0, 1, 1})
            hyper_k = false
        end
    end
)

-- Right
hyper:bind(
    {},
    "L",
    function()
        if hyper_l == false then
            hs.window.focusedWindow():moveToUnit({0.5, 0, 0.5, 1})
            hyper_l = true
        else
            hs.window.focusedWindow():moveToUnit({0, 0, 1, 1})
            hyper_l = false
        end
    end
)

-- Fullscreen
hyper:bind(
    {},
    "F",
    function()
        if hyper_f == false then
            hs.window.focusedWindow():moveToUnit({0.05, 0.05, 0.9, 0.9})
            hyper_f = true
        else
            hs.window.focusedWindow():moveToUnit({0, 0, 1, 1})
            hyper_f = false
        end
    end
)

-- Toggle Mouse to Screen Center
hyper:bind(
    {},
    "M",
    function()
        -- local focused = hs.window.focusedWindow()
        -- focused:minimize()
        local screen = hs.mouse.getCurrentScreen()
        local nextScreen = screen:previous()
        local rect = nextScreen:fullFrame()
        local center = hs.geometry.rectMidPoint(rect)
        hs.mouse.absolutePosition(center)
    end
)

-- Toggle Window Screens
MACBOOK_MONITOR = "Built%-in Retina Display"

function moveToNextScreen(name, pos)
    local focused = hs.window.focusedWindow()
    if name then
        focused:moveToScreen(name)
        if pos == "UP" then
            focused:moveToUnit({0, 0, 1, 0.5})()
        elseif pos == "DOWN" then
            focused:moveToUnit({0, 0.5, 1, 0.5})()
        else
            focused:maximize()
        end
    else
        focused:moveToScreen(focused:screen():next())
        focused:maximize()
    end
end

hyper:bind(
    {},
    "N",
    function()
        moveToNextScreen()
    end
)

-- Toggle Apps
function toggleApp(name, alias)
    focused = hs.window.focusedWindow()
    if focused then
        app = focused:application()
        -- hs.alert.show(app:title())
        if app:title() == name or app:title() == alias then
            app:hide()
            return
        end
    end
    hs.application.launchOrFocus(name)
end

hyper:bind(
    {},
    "D",
    function()
        toggleApp("Finder")
    end
)
hyper:bind(
    {},
    "G",
    function()
        toggleApp("Google Chrome")
    end
)
hyper:bind(
    {},
    "I",
    function()
        toggleApp("iTerm", "iTerm2")
    end
)
hyper:bind(
    {},
    "T",
    function()
        toggleApp("Sublime Text")
    end
)
hyper:bind(
    {},
    "C",
    function()
        toggleApp("Visual Studio Code", "Code")
    end
)
hyper:bind(
    {},
    "X",
    function()
        toggleApp("Firefox")
    end
)
hyper:bind(
    {},
    "S",
    function()
        toggleApp("Slack")
    end
)
hyper:bind(
    {},
    "W",
    function()
        toggleApp("WhatsApp")
    end
)

-- END
