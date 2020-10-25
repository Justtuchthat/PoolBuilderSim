-- setupStart.lua
-- created by Justtuchthat
-- first created on 05-10-2020
-- last edited on 25-10-2020
-- this is used to start all classes

function setupMainMenu()
  addMode("mainMenu")
  changeMode("mainMenu")
  width, height, _ = love.window.getMode()
  print(width .. " " .. height)
  playTestButton = newButton("text", newLocationObject(width/2, height/2), "playTest", {1, 1, 1}, {0.2, 0.8, 0.3})
  modes.mainMenu.buttons:addButton(playTestButton)
  newResizeFunction(function(newWidth, newHeight)
    playTestButton.loc.x = newWidth/2
    playTestButton.loc.y = neHeight/2
  end)
  playTestButton.pressAction:addFunction(function()
    changeMode("play")
  end)
end

function startClasses()
  startMouse()
	startButtonClass()
  addMode("play")
  setupMainMenu()
	modes.play.draw:addFunction(renderGame)
	setupControls()

  setupBuildMode()
  setupTiles()

	windowSetup()

	if testPoolEdgeMode then
		setupMouseCodeTestPoolEdge()
	end
end
