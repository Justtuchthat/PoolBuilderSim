-- buildTool.lua
-- created by Justtuchthat
-- first created on 05-10-2020
-- last edited on 14-10-2020
-- this is used to build pools

buildMenuBoxWidth = 110

local currentBuildTile = "grass"
local currentBuildCost = 0

function buildPoolStart(_, mouse)
	width, height, _ = love.window.getMode()
	if currentMode == "build" and (mouse.x < width - buildMenuBoxWidth) then
		buildLocStart = screenToWorldSpace(mouse)
	end
end

function buildPoolFinish(_, mouse)
	if currentMode == "build" and buildLocStart.x and buildLocStart.y then
		loc = {}
		loc.x, loc.y = screenToWorldSpace(mouse)
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
	resetColors()
	if currentBuildTile == "grass" then
		setGrassButtonColor()
	end
	if currentBuildTile == "pool" then
		setPoolButtonColor()
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
  for x = startX, endX do
    for y = startY, endY do
      love.graphics.setColor(0.8, 0.8, 0.1, 0.65)
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
	poolButton.loc.x = newWidth-100
	grassButton.loc.x = newWidth-100
	buildButton.loc.x = newWidth-100
end

function resetColors()
	grassButton.colorNormal = {1, 1, 1}
	poolButton.colorNormal = {1, 1, 1}
end

function setPoolButtonColor()
	poolButton.colorNormal = {0.2, 0.8, 0.1}
end

function setGrassButtonColor()
	grassButton.colorNormal = {0.2, 0.8, 0.1}
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

  buildButton = newButton("text", newLocationObject(width - 50, 20), "build", {1, 1, 1}, {1, 1, 0})
  buildButton.pressAction:addFunction(enterBuildMode)
  modes.play.buttons:addButton(buildButton)

	exitBuildModeButton = newButton("text", newLocationObject(width-100, 20), "exit buildmode", {1, 0.8, 0.8}, {1, 0.2, 0.2})
	grassButton = newButton("text", newLocationObject(width-100, 40), "grass", {1, 1, 1}, {1, 1, 0})
	poolButton = newButton("text", newLocationObject(width-100, 60), "pool", {1, 1, 1}, {1, 1, 0})
	exitBuildModeButton.pressAction:addFunction(exitBuildMode)
	grassButton.pressAction:addFunction(setBuildTileGrass)
	poolButton.pressAction:addFunction(setBuildTilePool)
	grassButton.pressAction:addFunction(resetColors)
	poolButton.pressAction:addFunction(resetColors)
	grassButton.pressAction:addFunction(setGrassButtonColor)
	poolButton.pressAction:addFunction(setPoolButtonColor)
	modes.build.buttons:addButton(exitBuildModeButton)
	modes.build.buttons:addButton(grassButton)
	modes.build.buttons:addButton(poolButton)

	newResizeFunction(relocateButtons)
end
