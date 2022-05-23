-- local hyper = {"cmd", "alt", "ctrl","shift"}
-- A global variable for the Hyper Mode
local hyper = hs.hotkey.modal.new({}, "F17")

hs.window.animationDuration = 0

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

-- Window sizing and movement
function resizeWindow(x, y, w, h)
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x + (max.w * x)
    f.y = max.y + (max.h * y)
    f.w = max.w * w
    f.h = max.h * h
    win:setFrame(f)
end

-- Full Screen
hyper:bind(
    {},
    "F",
    function()
        resizeWindow(0, 0, 1, 1)
    end
)

-- Left
hyper:bind(
    {},
    "H",
    function()
        resizeWindow(0, 0, 0.5, 1)
    end
)

-- Bottom
hyper:bind(
    {},
    "J",
    function()
        resizeWindow(0, 0.5, 1, 0.5)
    end
)

-- Top
hyper:bind(
    {},
    "K",
    function()
        resizeWindow(0, 0, 1, 0.5)
    end
)

-- Right
hyper:bind(
    {},
    "L",
    function()
        resizeWindow(0.5, 0, 0.5, 1)
    end
)

-- END
