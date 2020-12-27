-- inputHelper.lua
-- created by Justtuchthat
-- last updated on 22-12-2020
-- this program should help with getting the input of keys on the keyboard

Keyboard = {}
mouse = {}

love.keyboard.setKeyRepeat(true)

function Keyboard:addKeyListener(key)
	if self[key] then return end
	self[key] = {}
	self[key].pressed = false
	self[key].isRepeat = false
	self[key].firstPressActions = {}
	self[key].firstPressActions.addFunction = function(self, actionFn)
		table.insert(self, actionFn)
	end
	self[key].continuePressActions = {}
	self[key].continuePressActions.addFunction = function(self, actionFn)
		table.insert(self, actionFn)
	end
	self[key].lastPressActions = {}
	self[key].lastPressActions.addFunction = function(self, actionFn)
		table.insert(self, actionFn)
	end
end

function startMouse(buttonAmount)
	buttonAmount = buttonAmount or 20
	mouse = {}
	mouse.wheel = {}
	mouse.wheel.x = 0
	mouse.wheel.y = 0
	mouse.x = 0
	mouse.y = 0
	mouse.dx = 0
	mouse.dy = 0
	mouse.button = {}
	for i = 1, buttonAmount do
		mouse.button[i] = {}
		mouse.button[i].presses = 0
		mouse.button[i].pressAction = {}
		mouse.button[i].pressAction.addFunction = function(self, actionFn)
			table.insert(self, actionFn)
		end
		mouse.button[i].releaseAction = {}
		mouse.button[i].releaseAction.addFunction = function(self, actionFn)
			table.insert(self, actionFn)
		end
	end
	mouse.moveAction = {}
	mouse.moveAction.addFunction = function(self, actionFn)
		table.insert(self, actionFn)
	end
	mouse.scrollAction = {}
	mouse.scrollAction.addFunction = function(self, actionFn)
		table.insert(self, actionFn)
	end
	mouse.istouch = false
	mouse.presses = 0
end

textInputItemBannedKeys = {'lshift','rshift','capslock','lalt','ralt','rctrl',
'lctrl','kp.','kp1','kp2','kp3','kp4','kp5','kp6','kp7','kp8','kp9','numlock',
'kp/','kp*','kp-','kp+','insert','home','pageup','delete','end','pagedown','f1',
'f2','f3','f4','f5','f6','f7','f8','f9','f10','f11','f12','printscreen',
'scrolllock','pause','escape','tab','up','down','left','right'}

textInputItemsShiftKeys = {{'a','A'},{'b','B'},{'c','C'},{'d','D'},{'e','E'},
{'f','F'},{'g','G'},{'h','H'},{'i','I'},{'j','J'},{'k','K'},{'l','L'},{'m','M'},
{'n','N'},{'o','O'},{'p','P'},{'q','Q'},{'r','R'},{'s','S'},{'t','T'},{'u','U'},
{'v','V'},{'w','W'},{'x','X'},{'y','Y'},{'z','Z'},{'1','!'},{'2','@'},{'3','#'},
{'4','$'},{'5','%'},{'6','^'},{'7','&'},{'8','*'},{'9','('},{'0',')'},{'-','_'},
{'=','+'},{'\\','|'},{'[','{'},{']','}'},{';',':'},{"'",'"'},{',','<'},{'.','>'},
{'/','?'},{'`','~'}}

function getShiftKey(key)
	for i, keyCode in ipairs(textInputItemsShiftKeys) do
		if key == keyCode[1] then
			key = keyCode[2]
		end
	end
	return key
end

function love.keypressed(key, scancode, isRepeat)
	for i, textInputItem in ipairs(textInputItems) do
		if not textInputItem.disabled then
			if key == 'return' or key == 'kpenter' then
				textInputItem.enterFunction(textInputItem)
			elseif key == 'space' then
				textInputItem:addLetter(' ')
			elseif key == 'backspace' then
				textInputItem:deleteLetter()
			elseif contains(textInputItemBannedKeys, key) then
				--skips all banned keys
			else
				if love.keyboard.isDown('lshift') or love.keyboard.isDown('lshift') then
					key = getShiftKey(key)
					textInputItem:addLetter(key)
				else
					textInputItem:addLetter(key)
				end
			end
		end
	end
	if not Keyboard[key] then return end
	Keyboard[key].pressed = true
	Keyboard[key].isRepeat = isRepeat
	if not isRepeat then
		for i, fn in ipairs(Keyboard[key].firstPressActions) do
			fn(KeyBoard, mouse)
		end
	else
		for i, fn in ipairs(Keyboard[key].continuePressActions) do
			fn(Keyboard, mouse)
		end
	end
end

function love.keyreleased(key, scancode)
	if not Keyboard[key] then return end
	Keyboard[key].pressed = false
	Keyboard[key].isRepeat = false
	for i, fn in ipairs(Keyboard[key].lastPressActions) do
		fn(Keyboard, mouse)
	end
end

function love.mousepressed(x, y, button, istouch, presses)
	if button>20 then return end
	if not mouse then return end
	mouse.x = x
	mouse.y = y
	mouse.button[button].pressed = true
	mouse.istouch = istouch
	mouse.presses = presses
	for i, fn in ipairs(mouse.button[button].pressAction) do
		fn(Keyboard, mouse)
	end
end

function love.mousereleased(x, y, button, istouch, presses)
	if button>20 then return end
	if not mouse then return end
	mouse.x = x
	mouse.y = y
	mouse.button[button].pressed = false
	mouse.istouch = istouch
	mouse.presses = presses
	for i, fn in ipairs(mouse.button[button].releaseAction) do
		fn(Keyboard, mouse)
	end
end

function love.mousemoved(x, y, dx, dy, istouch)
	if not mouse then return end
	mouse.x = x
	mouse.y = y
	mouse.dx = dx
	mouse.dy = dy
	mouse.istouch = istouch
	for i, fn in ipairs(mouse.moveAction) do
		fn(Keyboard, mouse)
	end
end

function love.wheelmoved(x, y)
	if not mouse then return end
	mouse.wheel.x = x
	mouse.wheel.y = y
	for i, fn in ipairs(mouse.scrollAction) do
		fn(Keyboard, mouse)
	end
end
