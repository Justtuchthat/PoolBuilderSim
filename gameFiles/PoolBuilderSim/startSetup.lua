-- setupStart.lua
-- created by Justtuchthat
-- first created on 05-10-2020
-- last edited on 02-01-2021
-- this is used to start all classes

function updateMoneyText(moneyText)
  print("setting new money")
  moneyText.text = "Currency: " .. money
end

function setupMainMenu()
  addMode("mainMenu", true)
  changeMode("mainMenu")
  width, height, _ = love.window.getMode()
  loadButton = newButton("text", newLocationObject(width/2, height/2 - 10), "load", {1, 1, 1}, {0.2, 0.8, 0.3})
  newGameButton = newButton("text", newLocationObject(width/2, height/2 + 10), "new game", {1, 1, 1}, {0.2, 0.8, 0.3})
  moneyText = newTextMenuItem(updateMoneyText, {x=10,y=10}, {1, 0.875, 0}, "play")
  modes.build.menuItems:addMenuItem(moneyText)
  modes.mainMenu.menuItems:addMenuItem(loadButton)
  modes.mainMenu.menuItems:addMenuItem(newGameButton)
  newResizeFunction(function(newWidth, newHeight)
    loadButton.loc.x = newWidth/2
    loadButton.loc.y = newHeight/2 - 10
    newGameButton.loc.x = newWidth/2
    newGameButton.loc.y = newHeight/2 + 10
  end)
  loadButton.pressAction:addFunction(function()
    changeMode("loadMenu")
  end)
  newGameButton.pressAction:addFunction(function()
    resetGlobalVariables()
    moneyText:update()
    changeMode("play")
  end)
end

function startClasses()
  resetGlobalVariables()
  windowSetup()
  startMouse()
	startButtonClass()
  addMode("play", false)
	modes.play.draw:addFunction(renderGame)

  setupEscapeMenu()

	setupControls()

  setupBuildMode()
  setupTiles()

  setupMainMenu()
  setupLoadMenu()
  setupSaveMenu()

	if testPoolEdgeMode then
		setupMouseCodeTestPoolEdge()
	end
end
