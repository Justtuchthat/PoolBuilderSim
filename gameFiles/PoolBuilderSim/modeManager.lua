-- modeManager.lua
-- created by Justtuchthat
-- first created on 11-08-2020
-- last edited on 28-12-2020
-- this is used to manage all different modes

possibleModes = {}
modes = {}
currentMode = ""

function addMode(newMode, pausesGame)
  if contains(possibleModes, newMode) then
    love.errhand(newMode .. " is an already existing mode so it was not added")
    love.quit()
  end
  table.insert(possibleModes, newMode)
  modes[newMode] = {}
  modes[newMode].pausesGame = pausesGame
  modes[newMode].menuItems = {}
  modes[newMode].menuItems.addMenuItem = function(self, menuItem)
    table.insert(self, menuItem)
    if modes[currentMode] and modes[currentMode].menuItems == self then
      menuItem:enable()
    end
  end
  modes[newMode].enable = function(self)
    for i, menuItem in ipairs(self.menuItems) do
      menuItem:enable()
    end
  end
  modes[newMode].disable = function(self)
    for i, menuItem in ipairs(self.menuItems) do
      menuItem:disable()
    end
  end
  modes[newMode].draw = {}
  modes[newMode].draw.addFunction = function(self, fn)
    table.insert(self, fn)
  end
end

function changeMode(newMode)
  if not modes then setupModes() end
  if contains(possibleModes, newMode) then
    if contains(possibleModes, currentMode) then
      modes[currentMode]:disable()
    end
    currentMode = newMode
    modes[currentMode]:enable()
    print("changed to " .. newMode)
  else
    love.errhand(newMode .. " is not a supported mode")
  end
end

function modeDraw()
  width, height, _ = love.window.getMode()
  for i, fn in ipairs(modes[currentMode].draw) do
    fn()
  end
	for i, btn in ipairs(modes[currentMode].menuItems) do
    btn:draw()
  end
end
