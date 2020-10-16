-- buildTool.lua
-- created by Justtuchthat
-- first created on 05-10-2020
-- last edited on 16-10-2020
-- this is used to build pools

buildMenuBoxWidth = 110

local currentBuildTile = "grass"
local currentBuildCost = 0
local lastMouseX = 0
local lastMouseY = 0

function setMouse(_, mouse)
	lastMouseX = mouse.x
	lastMouseY = mouse.y
end

function buildPoolStart(_, mouse)
	width, height, _ = love.window.getMode()
	if currentMode == "build" and (mouse.x < width - buildMenuBoxWidth) then
		buildLocStart = screenToWorldSpace(mouse)
		recalculateBuildCost(Keyboard, mouse)
	end
end

function buildPoolFinish(_, mouse)
	if currentMode == "build" and buildLocStart.x and buildLocStart.y then
		loc = screenToWorldSpace(mouse)
		if (canBuild(buildLocStart, loc)) then
			buildSquareBuilding(buildLocStart.x, buildLocStart.y, loc.x, loc.y, currentBuildTile, currentBuildCost)
		else
			print("could not build")
		end
		buildLocStart.x = nil
		buildLocStart.y = nil
	end
end

function canBuild(startLoc, endLoc)
	startX, endX = minMax(startLoc.x, endLoc.x)
	startY, endY = minMax(startLoc.y, endLoc.y)
	for x = startX, endX do
		for y = startY, endY do
			if not isInBounds(newLocationObject(x, y)) then return false end
		end
	end
	return currentBuildCost <= money
end

function setBuildTilePool()
	currentBuildTile = "pool"
end

function setBuildTileGrass()
	currentBuildTile = "grass"
end

function enterBuildMode()
  changeMode("build")
	resetColors()
	if knownTiles[currentBuildTile] and knownTiles[currentBuildTile].buildButton then
		knownTiles[currentBuildTile].buildButton.colorNormal = {0.2, 0.8, 0.1}
	end
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
	if canBuild(newLocationObject(startX, startY), newLocationObject(endX, endY)) then
		love.graphics.setColor(0.8, 0.8, 0.1, 0.65)
	else
		love.graphics.setColor(0.8, 0.1, 0.1, 0.65)
	end
  for x = startX, endX do
    for y = startY, endY do
      love.graphics.rectangle("fill", x*squareSize, y*squareSize, squareSize, squareSize)
    end
  end
  love.graphics.translate(-drawOffsetX, -drawOffsetY)
end

function drawBuildCost(start, End)
	startX, endX = minMax(start.x, End.x)
	startY, endY = minMax(start.y, End.y)
	love.graphics.setColor(0.8, 0.8, 0.1)
	buildCostText = love.graphics.newText(love.graphics.getFont(), "buildcost: " .. currentBuildCost)
	love.graphics.draw(buildCostText, mouse.x, mouse.y)
end

function recalculateBuildCost(_, mouse)
	if not buildLocStart.x or not buildLocStart.y then
		currentBuildCost = 0
		return
	end
	loc = screenToWorldSpace(mouse)
	startX, endX = minMax(buildLocStart.x, loc.x)
	startY, endY = minMax(buildLocStart.y, loc.y)
	currentBuildCost = calculateBuildingCost(startX, startY, endX, endY, currentBuildTile)
end

function drawBuildSelectionBox()
  if buildLocStart.x and buildLocStart.y then
    loc = screenToWorldSpace(mouse)
    drawSquareOverlay(buildLocStart, loc)
		drawBuildCost(buildLocStart, loc)
  end
end

function relocateButtons(newWidth, newHeight)
	exitBuildModeButton.loc.x = newWidth-100
end

function resetColors()
	for i, tileName in ipairs(knownTiles) do
		if knownTiles[tileName].buildButton then
			knownTiles[tileName].buildButton.colorNormal = {1,1,1}
		end
	end
end

function changeBuildTile(newTile)
	currentBuildTile = newTile
end

function setupBuildMode()
  addMode("build")

  modes.build.draw:addFunction(renderGame)
  modes.build.draw:addFunction(drawGridLines)
  modes.build.draw:addFunction(drawBuildSelectionBox)
  modes.build.draw:addFunction(buildMenu)

	mouse.button[1].pressAction:addFunction(buildPoolStart)
	mouse.button[1].releaseAction:addFunction(buildPoolFinish)
	mouse.moveAction:addFunction(recalculateBuildCost)

  width, height, _ = love.window.getMode()

	mouse.moveAction:addFunction(setMouse)

  buildButton = newButton("text", newLocationObject(width - 50, 20), "build", {1, 1, 1}, {1, 1, 0})
  buildButton.pressAction:addFunction(enterBuildMode)
  modes.play.buttons:addButton(buildButton)

	exitBuildModeButton = newButton("text", newLocationObject(width-100, 20), "exit buildmode", {1, 0.8, 0.8}, {1, 0.2, 0.2})
	exitBuildModeButton.pressAction:addFunction(exitBuildMode)
	modes.build.buttons:addButton(exitBuildModeButton)

	newResizeFunction(relocateButtons)
end
