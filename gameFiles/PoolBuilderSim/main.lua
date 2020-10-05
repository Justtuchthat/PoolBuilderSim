-- main.lua
-- created by Justtuchthat
-- first created on 10-8-2020
-- last edited on 04-10-2020
-- this is used to start the game

testPoolEdgeMode = false

drawOffsetX = 0
drawOffsetY = 0
squareSize = 8
buildLocStart = {}
buildLocStart.x = nil
buildLocStart.y = nil

movementSpeed = 10

require("inputHelper")
require("gameRenderer")
require("gameInit")
require("poolEdgechecker")
require("controlSetup")
require("settingsSetup")
require("buttonClass")
require("helperFunctions")
require("modeManager")
if testPoolEdgeMode then
	require("testPoolEdge")
end

function buildPoolStart(_, mouse)
	if currentMode == "build" then
		buildLocStart = getLocFromMouse(mouse.x, mouse.y)
	end
end

function buildPoolFinish(_, mouse)
	if currentMode == "build" and buildLocStart.x and buildLocStart.y then
		loc = {}
		loc.x, loc.y = getLocFromMouse(mouse.x, mouse.y)
		addSquarePool(buildLocStart.x, buildLocStart.y, loc.x, loc.y)
		buildLocStart.x = nil
		buildLocStart.y = nil

	end
end

function testButton()
	print("Hello World!")
end

function setupModes()
  addMode("nothing")
  addMode("play")
	addMode("build")
  changeMode("play")
end

function love.load()
	gameworld = initGame(gameWorldSize)
	addSquarePool(20, 50, 50, 70)
	addSquarePool(30, 40, 40, 60)
	startMouse()
	startButtonClass()
	setupModes()
	modes.play.draw:addFunction(renderGame)
	modes.build.draw:addFunction(renderGame)
	modes.build.draw:addFunction(buildMenu)
	mouse.button[1].pressAction:addFunction(buildPoolStart)
	mouse.button[1].releaseAction:addFunction(buildPoolFinish)
	setupControls()
	windowSetup()

	if testPoolEdgeMode then
		setupMouseCodeTestPoolEdge()
	end
end

function love.draw()
	modeDraw()
end

function love.update()

end
