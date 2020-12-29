-- escapeMenu.lua
-- created by Justtuchthat
-- first created on 19-11-2020
-- last edited on 29-12-2020
-- used for creating the escape menu

saveButtonMode = {}

local function drawEscapeOverlay()
  width, height, _ = love.window.getMode()
  love.graphics.setColor(0, 0, 0, 0.5)
  love.graphics.rectangle("fill", 0, 0, width, height)
end

local function saveButtonFunction()
  changeMode('saveMenu')
end

local function exitButtonFunction()
  changeMode('mainMenu')
end

local function resizeButtonReplacement(newWidth, newHeight)
  saveButton.loc.x = newWidth/2
  exitButton.loc.x = newWidth/2
end

function setupEscapeMenu()
	addMode("escapeMenu", true)
  modes.escapeMenu.draw:addFunction(renderGame)
  modes.escapeMenu.draw:addFunction(drawEscapeOverlay)
  width, height, _ = love.window.getMode()
  newResizeFunction(resizeButtonReplacement)
  saveButton = newButton('text', newLocationObject(width/2, 100), 'Save game', {1, 1, 1}, {0.2, 0.8, 0.2})
  exitButton = newButton('text', newLocationObject(width/2, 120), 'Exit to main menu', {1,1,1}, {0.2, 0.8, 0.2})
  saveButton.pressAction:addFunction(saveButtonFunction)
  exitButton.pressAction:addFunction(exitButtonFunction)
  modes.escapeMenu.menuItems:addMenuItem(saveButton)
  modes.escapeMenu.menuItems:addMenuItem(exitButton)
end
