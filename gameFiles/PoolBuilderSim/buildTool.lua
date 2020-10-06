-- buildTool.lua
-- created by Justtuchthat
-- first created on 05-10-2020
-- last edited on 06-10-2020
-- this is used to build pools

local currentBuildTile = "grass"

function buildPoolStart(_, mouse)
	width, height, _ = love.window.getMode()
	if currentMode == "build" and (mouse.x < width - 200) then
		buildLocStart = getLocFromMouse(mouse.x, mouse.y)
	end
end

function buildPoolFinish(_, mouse)
	if currentMode == "build" and buildLocStart.x and buildLocStart.y then
		loc = {}
		loc.x, loc.y = getLocFromMouse(mouse.x, mouse.y)
		buildSquareBuilding(buildLocStart.x, buildLocStart.y, loc.x, loc.y, currentBuildTile)
		buildLocStart.x = nil
		buildLocStart.y = nil
	end
end

function setBuildTilePool()
	currentBuildTile = "pool"
end

function setBuildTileGrass()
	currentBuildTile = "grass"
end

function enterBuildMode()
  changeMode("build")
end

function exitBuildMode()
	if currentMode == "build" then
		changeMode("play")
	end
end

function drawGridLines()
  love.graphics.translate(drawOffsetX, drawOffsetY)
  love.graphics.setColor({0, 0, 0, 0.2})
	for x = 1, gameworldSize do
    love.graphics.line(x*squareSize, 0, x*squareSize, (gameworldSize+1)*squareSize)
  end
  for y = 1, gameworldSize do
    love.graphics.line(0, y*squareSize, (gameworldSize+1)*squareSize, y*squareSize)
  end
  love.graphics.translate(-drawOffsetX, -drawOffsetY)
end

function drawSquareOverlay(startLoc, endLoc)
  startX, endX = minMax(startLoc.x, endLoc.x)
  startY, endY = minMax(startLoc.y, endLoc.y)
  love.graphics.translate(drawOffsetX, drawOffsetY)
  for x = startX, endX do
    for y = startY, endY do
      love.graphics.setColor(0.8, 0.8, 0.1, 0.65)
      love.graphics.rectangle("fill", x*squareSize, y*squareSize, squareSize, squareSize)
    end
  end
  love.graphics.translate(-drawOffsetX, -drawOffsetY)
end

function drawBuildSelectionBox()
  if buildLocStart.x and buildLocStart.y then
    loc = getLocFromMouse(mouse.x, mouse.y)
    drawSquareOverlay(buildLocStart, loc)
  end
end

function setupBuildMode()
  addMode("build")

  modes.build.draw:addFunction(renderGame)
  modes.build.draw:addFunction(drawGridLines)
  modes.build.draw:addFunction(drawBuildSelectionBox)
  modes.build.draw:addFunction(buildMenu)

	mouse.button[1].pressAction:addFunction(buildPoolStart)
	mouse.button[1].releaseAction:addFunction(buildPoolFinish)

  Keyboard:addKeyListener('escape')
  Keyboard.escape.lastPressActions:addFunction(exitBuildMode)

  buildButton = newButton("text", newLocationObject(20, 20), "build pool", {1, 1, 1}, {1, 1, 0})
  buildButton.pressAction:addFunction(enterBuildMode)
  modes.play.buttons:addButton(buildButton)

	width, height, _ = love.window.getMode()

	grassButton = newButton("text", newLocationObject(width-30, 20), "grass", {1, 1, 1}, {1, 1, 0})
	poolButton = newButton("text", newLocationObject(width-30, 40), "pool", {1, 1, 1}, {1, 1, 0})
	grassButton.pressAction:addFunction(setBuildTileGrass)
	poolButton.pressAction:addFunction(setBuildTilePool)
	modes.build.buttons:addButton(grassButton)
	modes.build.buttons:addButton(poolButton)
end
