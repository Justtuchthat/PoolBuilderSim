-- main.lua
-- created by Justtuchthat
-- first created on 10-8-2020
-- last edited on 12-09-2020
-- this is used to start the game

testPoolEdgeMode = true

drawOffsetX = 0
drawOffsetY = 0
squareSize = 8

movementSpeed = 10

require("inputHelper")
require("gameRenderer")
require("gameInit")
require("poolEdgechecker")
require("movementSetup")
require("settingsSetup")
require("buttonClass")
require("helperFunctions")
require("modeManager")
if testPoolEdgeMode then
	require("testPoolEdge")
end

function testButton()
	print("Hello World!")
end

function setupModes()
  addMode("nothing")
  addMode("play")
	addMode("test1")
	addMode("test2")
  changeMode("play")
end

button = newButton("text", newLocationObject(100, 100), "This is a test", {1, 1, 1})
button.pressAction:addFunction(testButton)
setupModes()
modes.play.buttons:addButton(button)
modes.play.draw:addFunction(renderGame)

function love.load()
	gameworld = initGame(gameWorldSize)
	addSquarePool(20, 50, 50, 70)
	addSquarePool(30, 40, 40, 60)
	startMouse()
	startButtonClass()
	mouse.button[1].pressAction:addFunction(mousePressTestButton)
	setupMovementKeys()

	windowSetup()

	if testPoolEdgeMode then
		setupMouseCode()
	end
end

function love.draw()
	modeDraw()
end

function love.update()

end
