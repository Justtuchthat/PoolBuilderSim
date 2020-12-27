-- escapeMenu.lua
-- created by Justtuchthat
-- first created on 19-11-2020
-- last edited on 22-12-2020
-- used for creating the escape menu

saveButtonMode = {}

local function drawEscapeOverlay()
  width, height, _ = love.window.getMode()
  love.graphics.setColor(0, 0, 0, 0.5)
  love.graphics.rectangle("fill", 0, 0, width, height)
end

local function saveButton()
  changeMode('saveMenu')
end

local function resizeButtonReplacement(newWidth, newHeight)
  saveButtonMode.loc = newLocationObject(newWidth/2, 100)
end

function setupEscapeMenu()
	addMode("escapeMenu")
  modes.escapeMenu.draw:addFunction(renderGame)
  modes.escapeMenu.draw:addFunction(drawEscapeOverlay)
  width, height, _ = love.window.getMode()
  saveButtonMode = newButton('text', newLocationObject(width/2, 100), 'Save game', {1, 1, 1}, {0.2, 0.8, 0.2})
  saveButtonMode.pressAction:addFunction(saveButton)
  modes.escapeMenu.menuItems:addMenuItem(saveButtonMode)



end
