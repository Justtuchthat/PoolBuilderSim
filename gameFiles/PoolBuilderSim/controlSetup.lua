-- movementSetup.lua
-- created by Justtuchthat
-- first created on 16-08-2020
-- last edited on 05-11-2020
-- this is used to setup all the keys for movement

local function mouseWheelMove(keyboard, mouse)
	if Keyboard.lshift.pressed then
		drawOffsetX = drawOffsetX + mouse.wheel.y*movementSpeed
	else
		drawOffsetY = drawOffsetY + mouse.wheel.y*movementSpeed
	end
end

local function moveLeft()
	drawOffsetX = drawOffsetX + movementSpeed
end

local function moveOnRightMouseButton(_, mouse)
	if mouse.button[2].pressed then
		drawOffsetX = drawOffsetX + mouse.dx
		drawOffsetY = drawOffsetY + mouse.dy
	end
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
