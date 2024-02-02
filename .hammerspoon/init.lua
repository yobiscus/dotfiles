-- Supress sunmeko_lua warning "Undefined global `hs`."
local hs = hs

--
-- Settings
--

Settings = {
  windowResizeIncrement = 100,
}

--
-- Tiling Manager
--

hs.window.animationDuration = 0

WindowControl = {}
WindowControl.__index = WindowControl

function WindowControl:create(window)
  local wctrl = {}
  setmetatable(wctrl, WindowControl)
  wctrl.window = window
  wctrl.frame = window:frame()
  wctrl.where = "zoom"
  wctrl:reposition(wctrl.where)
  return wctrl
end

function WindowControl:reposition(where)
  local win = self.window
  local f = self.frame

  local screen = win:screen()
  local max = screen:frame()

  if where == "top" then
    if self.where == "zoom" or self.where:find(where) then
      f.x = max.x
      f.y = max.y
      f.w = max.w
      f.h = max.h / 2
      self.where = where
    elseif self.where == "left" or self.where == "right" then
      f.h = max.h / 2
      self.where = where .. self.where
    elseif self.where:find("bottom") then
      f.y = max.y
      self.where = self.where:gsub("bottom", where)
    end
  elseif where == "bottom" then
    if self.where == "zoom" or self.where:find(where) then
      f.x = max.x
      f.y = max.y + (max.h / 2)
      f.w = max.w
      f.h = max.h / 2
      self.where = where
    elseif self.where == "left" or self.where == "right" then
      f.y = max.y + (max.h / 2)
      f.h = max.h / 2
      self.where = where .. self.where
    elseif self.where:find("top") then
      f.y = max.x + max.h - f.h + 25
      self.where = self.where:gsub("top", where)
    end
  elseif where == "right" then
    if self.where == "zoom" or self.where:find(where) then
      f.x = max.x + (max.w / 2)
      f.y = max.y
      f.w = max.w / 2
      f.h = max.h
      self.where = where
    elseif self.where == "top" or self.where == "bottom" then
      f.x = max.x + (max.w / 2)
      f.w = max.w / 2
      self.where = self.where .. where
    elseif self.where:find("left") then
      f.x = max.x + max.w - f.w
      self.where = self.where:gsub("left", where)
    end
  elseif where == "left" then
    if self.where == "zoom" or self.where:find(where) then
      f.x = max.x
      f.y = max.y
      f.w = max.w / 2
      f.h = max.h
      self.where = where
    elseif self.where == "top" or self.where == "bottom" then
      f.w = max.w / 2
      self.where = self.where .. where
    elseif self.where:find("right") then
      f.x = max.x
      self.where = self.where:gsub("right", where)
    end
  elseif where == "zoom" then
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
    self.where = where
  end
end

function WindowControl:resize(direction, mod)
  local f = self.frame
  local where = self.where

  if mod == nil then
    if direction == "left" then
      -- shrink from right
      f.w = f.w - Settings.windowResizeIncrement
    elseif direction == "right" then
      -- shrink from left
      f.x = f.x + Settings.windowResizeIncrement
      f.w = f.w - Settings.windowResizeIncrement
    elseif direction == "up" then
      -- shrink from bottom
      f.h = f.h - Settings.windowResizeIncrement
    elseif direction == "down" then
      -- shrink from top
      f.y = f.y + Settings.windowResizeIncrement
      f.h = f.h - Settings.windowResizeIncrement
    end
  elseif mod == "shift" then
    -- emulate behaviour from different location so that the window shrinks
    if direction == "left" then
      -- grow to left
      f.x = f.x - Settings.windowResizeIncrement
      f.w = f.w + Settings.windowResizeIncrement
    elseif direction == "right" then
      -- grow to right
      f.w = f.w + Settings.windowResizeIncrement
    elseif direction == "up" then
      -- grow to top
      f.y = f.y - Settings.windowResizeIncrement
      f.h = f.h + Settings.windowResizeIncrement
    elseif direction == "down" then
      -- grow to bottom
      f.h = f.h + Settings.windowResizeIncrement
    end
  end
end

function WindowControl:updateFrame()
  self.window:setFrame(self.frame)
end

LastWctrl = nil
LastW = nil

local function positionWindow(where)
  local win = hs.window.focusedWindow()
  if LastWctrl == nil or LastWctrl.where == nil or LastWctrl.window:id() ~= win:id() then
    LastWctrl = WindowControl:create(win)
  end
  LastWctrl:reposition(where)
  LastWctrl:updateFrame()
end

local function resizeWindow(direction, mod)
  local win = hs.window.focusedWindow()
  if LastWctrl == nil or LastWctrl.where == nil or LastWctrl.window:id() ~= win:id() then
    return
  end

  LastWctrl:resize(direction, mod)
  LastWctrl:updateFrame()
end

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "H", function() positionWindow("left") end)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "L", function() positionWindow("right") end)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "K", function() positionWindow("top") end)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "J", function() positionWindow("bottom") end)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "space", function() positionWindow("zoom") end)

hs.hotkey.bind({ "alt", "ctrl" }, "H", function() resizeWindow("left") end)
hs.hotkey.bind({ "alt", "ctrl" }, "L", function() resizeWindow("right") end)
hs.hotkey.bind({ "alt", "ctrl" }, "K", function() resizeWindow("up") end)
hs.hotkey.bind({ "alt", "ctrl" }, "J", function() resizeWindow("down") end)
hs.hotkey.bind({ "alt", "ctrl", "shift" }, "H", function() resizeWindow("left", "shift") end)
hs.hotkey.bind({ "alt", "ctrl", "shift" }, "L", function() resizeWindow("right", "shift") end)
hs.hotkey.bind({ "alt", "ctrl", "shift" }, "K", function() resizeWindow("up", "shift") end)
hs.hotkey.bind({ "alt", "ctrl", "shift" }, "J", function() resizeWindow("down", "shift") end)

--
-- Automatic Configuration Loading
--

local function reloadConfig(files)
  local doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end

local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

-- url hook example for "hammerspoon://someAlert"
-- hs.urlevent.bind("someAlert", function(eventName, params)
--     hs.alert.show("Received someAlert")
-- end)

-- Supress sunmeko_lua warning "Undefined local ..."
myWatcher = myWatcher
