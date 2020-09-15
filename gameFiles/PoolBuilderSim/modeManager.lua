-- modeManager.lua
-- created by Justtuchthat
-- first created on 11-08-2020
-- last edited on 15-08-2020
-- this is used to manage all different modes

possibleModes = {}
modes = {}
currentMode = ""

function addMode(newMode)
  table.insert(possibleModes, newMode)
  modes[newMode] = {}
  modes[newMode].buttons = {}
  modes[newMode].buttons.addButton = function(self, btn)
    table.insert(self, btn)
    if modes[currentMode].buttons == self then
      btn.disabled = false
    end
  end
  modes[newMode].enable = function(self)
    for i = 1, #self.buttons do
      self.buttons[i].disabled = false
    end
  end
  modes[newMode].disable = function(self)
    for i = 1, #self.buttons do
      self.buttons[i].disabled = true
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
	for i, btn in ipairs(modes[currentMode].buttons) do
    btn:draw()
  end
end
