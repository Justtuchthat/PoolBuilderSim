-- movementSetup.lua
-- created by Justtuchthat
-- first created on 16-08-2020
-- last edited on 15-09-2020
-- this is used to setup all the keys for movement

local function mouseWheelMove(keyboard, mouse)
	if Keyboard.lshift.pressed then
		drawOffsetX = drawOffsetX + mouse.wheel.y*movementSpeed
	else
		drawOffsetY = drawOffsetY + mouse.wheel.y*movementSpeed
	end
	mouse.wheel.y = 0
end

local function moveLeft()
	drawOffsetX = drawOffsetX + movementSpeed
end

local function moveRight()
	drawOffsetX = drawOffsetX - movementSpeed
end

local function moveUp()
	drawOffsetY = drawOffsetY + movementSpeed
end

local function moveDown()
	drawOffsetY = drawOffsetY - movementSpeed
end

function enterBuildMode()
	changeMode("build")
end

function exitBuildMode()
	if currentMode == "build" then
		changeMode("play")
	end
end

local function addKeyListeners()
	Keyboard:addKeyListener('w')
	Keyboard:addKeyListener('a')
	Keyboard:addKeyListener('s')
	Keyboard:addKeyListener('d')
	Keyboard:addKeyListener('up')
	Keyboard:addKeyListener('left')
	Keyboard:addKeyListener('down')
	Keyboard:addKeyListener('right')
	Keyboard:addKeyListener('lshift')
	Keyboard:addKeyListener('escape')
end

local function connectKeysWithFunctions()
	Keyboard.w.firstPressActions:addFunction(moveUp)
	Keyboard.w.continuePressActions:addFunction(moveUp)
	Keyboard.a.firstPressActions:addFunction(moveLeft)
	Keyboard.a.continuePressActions:addFunction(moveLeft)
	Keyboard.s.firstPressActions:addFunction(moveDown)
	Keyboard.s.continuePressActions:addFunction(moveDown)
	Keyboard.d.firstPressActions:addFunction(moveRight)
	Keyboard.d.continuePressActions:addFunction(moveRight)
	Keyboard.up.firstPressActions:addFunction(moveUp)
	Keyboard.up.continuePressActions:addFunction(moveUp)
	Keyboard.left.firstPressActions:addFunction(moveLeft)
	Keyboard.left.continuePressActions:addFunction(moveLeft)
	Keyboard.down.firstPressActions:addFunction(moveDown)
	Keyboard.down.continuePressActions:addFunction(moveDown)
	Keyboard.right.firstPressActions:addFunction(moveRight)
	Keyboard.right.continuePressActions:addFunction(moveRight)
	Keyboard.escape.lastPressActions:addFunction(exitBuildMode)
end

local function addMouseScrolling()
	mouse.scrollAction:addFunction(mouseWheelMove)
end

local function setupBuildModeButton()
	buildButton = newButton("text", newLocationObject(20, 20), "build pool", {1, 1, 1})
	buildButton.pressAction:addFunction(enterBuildMode)
	modes.play.buttons:addButton(buildButton)
end

local function buttonsSetup()
	setupBuildModeButton()
end

function setupControls()
  	addKeyListeners()
		connectKeysWithFunctions()
		buttonsSetup()

		addMouseScrolling()
end
