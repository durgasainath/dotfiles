local hyper = {"cmd", "alt", "ctrl","shift"}

-- Config change and reload
function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.new({title="Hammerspoon", informativeText="Hammerspoon Config Reloaded", withdrawAfter=2}):send()

hs.hotkey.bind(hyper, "R", function()
hs.reload()
end)

-- Defeating paste blocking
hs.hotkey.bind(hyper, "V", function()
hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

-- FnMate
hs.loadSpoon("FnMate")

-- MicMute
hs.loadSpoon("MicMute")
spoon.MicMute:bindHotkeys({toggle = {hyper, "M"}})

-- MiroWindowsManager
hs.loadSpoon("MiroWindowsManager")
hs.window.animationDuration = 0
spoon.MiroWindowsManager.fullScreenSizes = {1, 10/9}
spoon.MiroWindowsManager:bindHotkeys({
  left = {hyper, "h"},
  down = {hyper, "j"},
  up = {hyper, "k"},
  right = {hyper, "l"},
  fullscreen = {hyper, "f"}
})

-- MoveToScreen
function moveToNextScreen()
  local app = hs.window.focusedWindow()
  app:moveToScreen(app:screen():next())
  app:maximize()
end

hs.hotkey.bind(hyper, 'N', moveToNextScreen)

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

hs.hotkey.bind(hyper, 'G', function() toggleApp('Google Chrome') end)
hs.hotkey.bind(hyper, 'I', function() toggleApp('iTerm', 'iTerm2') end)
hs.hotkey.bind(hyper, 'T', function() toggleApp('Sublime Text') end)
hs.hotkey.bind(hyper, 'C', function() toggleApp('Visual Studio Code','Code') end)
hs.hotkey.bind(hyper, 'X', function() toggleApp('Firefox') end)

-- END