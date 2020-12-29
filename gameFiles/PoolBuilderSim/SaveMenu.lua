-- saveMenu.lua
-- created by Justtuchthat
-- first created on 22-12-2020
-- last edited on 29-12-2020
-- this is the saving menu

saveNameInput = {}
saveText = {}
cancelText = {}

function saveGameAfterEnter(textMenuObject)
  saveGame(textMenuObject.currentText .. '.json')
  returnFromSaveMenu()
end

local function drawSaveMenuOverlay()
  width, height, _ = love.window.getMode()
  love.graphics.setColor(0, 0, 0, 0.5)
  love.graphics.rectangle("fill", 0, 0, width, height)
end

local function saveResize(newWidth, newHeight)
  saveNameInput.loc.x = newWith/2
  saveText.loc.x = newWidth/2
  cancelText.loc.x = newWidth/2
end

function returnFromSaveMenu(Keyboard, mouse)
  if currentMode == 'saveMenu' then
    changeMode('escapeMenu')
  end
end

local function setupEscKeybind()
  Keyboard:addKeyListener('escape')

  Keyboard.escape.lastPressActions:addFunction(returnFromSaveMenu)
end

function setupSaveMenu()
  setupEscKeybind()

  addMode('saveMenu', true)
  modes.saveMenu.draw:addFunction(renderGame)
  modes.saveMenu.draw:addFunction(drawSaveMenuOverlay)

  width, height, _ = love.window.getMode()
  saveNameInput = newTextInputMenuItem(newLocationObject(width/2,100),saveGameAfterEnter)
  saveText = newButton('text', {x = width/2, y = 120}, 'Press return/enter to save', {1,1,1}, {1,1,1})
  cancelText = newButton('text', {x = width/2, y = 140}, 'Press escape to return', {1,1,1}, {1,1,1})

  modes.saveMenu.menuItems:addMenuItem(saveNameInput)
  modes.saveMenu.menuItems:addMenuItem(saveText)
  modes.saveMenu.menuItems:addMenuItem(cancelText)
end
