-- movementSetup.lua
-- created by Justtuchthat
-- first created on 16-08-2020
-- last edited on 06-09-2021
-- this is used to setup all the keys for movement

local function mouseWheelMove(keyboard, mouse)
	if currentMode == "play" or currentMode == "build" then
		if Keyboard.lshift.pressed then
			drawOffsetX = drawOffsetX - mouse.wheel.y*movementSpeed
		else
			drawOffsetX = drawOffsetX - mouse.wheel.x*movementSpeed
			drawOffsetY = drawOffsetY + mouse.wheel.y*movementSpeed
		end
	end
end

local function moveLeft()
	if currentMode == "play" or currentMode == "build" then
		drawOffsetX = drawOffsetX - movementSpeed
	end
end

local function moveOnRightMouseButton(_, mouse)
	if currentMode == "play" or currentMode == "build" then
		if mouse.button[2].pressed then
			drawOffsetX = drawOffsetX + mouse.dx
			drawOffsetY = drawOffsetY + mouse.dy
		end
	end
end

local function moveRight()
	if currentMode == "play" or currentMode == "build" then
		drawOffsetX = drawOffsetX + movementSpeed
	end
end

local function moveUp()
	if currentMode == "play" or currentMode == "build" then
		drawOffsetY = drawOffsetY - movementSpeed
	end
end

local function moveDown()
	if currentMode == "play" or currentMode == "build" then
		drawOffsetY = drawOffsetY + movementSpeed
	end
end

local function enterBuildModeWhenBPressed()
	if currentMode == "play" then
		enterBuildMode()
	end
end

local function openEscapeMenu()
	if currentMode == "play" then
		changeMode("escapeMenu")
	elseif currentMode == "build" then
		changeMode("play")
	elseif currentMode == "escapeMenu" then
		changeMode("play")
	elseif currentMode == "mainMenu" then
		love.event.quit(0)
	end
end

local function addKeyListeners()
	Keyboard:addKeyListener('w')
	Keyboard:addKeyListener('a')
	Keyboard:addKeyListener('s')
	Keyboard:addKeyListener('d')
	Keyboard:addKeyListener('b')
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
	Keyboard.b.firstPressActions:addFunction(enterBuildModeWhenBPressed)
	Keyboard.up.firstPressActions:addFunction(moveUp)
	Keyboard.up.continuePressActions:addFunction(moveUp)
	Keyboard.left.firstPressActions:addFunction(moveLeft)
	Keyboard.left.continuePressActions:addFunction(moveLeft)
	Keyboard.down.firstPressActions:addFunction(moveDown)
	Keyboard.down.continuePressActions:addFunction(moveDown)
	Keyboard.right.firstPressActions:addFunction(moveRight)
	Keyboard.right.continuePressActions:addFunction(moveRight)
	Keyboard.escape.lastPressActions:addFunction(openEscapeMenu)
end

local function addMouseScrolling()
	mouse.scrollAction:addFunction(mouseWheelMove)
end

local function buttonsSetup()

end

function setupControls()
  addKeyListeners()
	connectKeysWithFunctions()
	buttonsSetup()

	addMouseScrolling()
	mouse.moveAction:addFunction(moveOnRightMouseButton)
end
