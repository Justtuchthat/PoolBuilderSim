-- inputHelper.lua
-- created by Justtuchthat
-- last updated on 14th of june 2020 with love2d version 11.3
-- this program should help with getting the input of keys on the keyboard

-- this list is the list that stated what keys to keep track of
-- I recommend to delete the keys you don't need
-- if you require aditional keys visit this site to see which keys are supported
-- https://love2d.org/wiki/Scancode

-- the keycode for us layout backslashes was being read correctly
-- however this could not be used since lua sees \ as the start of special chars

local keys = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '1', '2', '3',
'4', '5', '6', '7', '8', '9', '0', "return", "escape", "backspace", "tab",
"space", '-', '=', '[', ']', "nonus#", ';', "'", '`', ',', '.', '/',
"capslock"}

-- creates an empty button list
function emptyButtonList()
  list = {}
  for i, key in ipairs(keys) do
    list[key] = false
  end
  return list
end

-- creates an empty button list that can also keep track of time pressed
function emptyPressedButtonList ()
  list = {}
  for i, key in ipairs(keys) do
    list[key] = {}
    list[key].pressed = false
    list[key].pressTime = 0
  end
  return list
end


-- creates the buttonList variable that keeps track of any keyPress
function createButtonList(keyList)
  keyList = keyList or keys
  keysPressed = {}
  keysPressed.keyPressStarted = emptyButtonList()
  keysPressed.KPS = emptyButtonList()
  keysPressed.keyPressContinued = emptyPressedButtonList()
  keysPressed.KPC = emptyPressedButtonList()
  keysPressed.keyPressReleased = emptyButtonList()
  keysPressed.KPR = emptyButtonList()
  return keysPressed
end

-- used so that all keyPresses get moved from started to continued
function moveList(list)
  listToEmpty = list.keyPressStarted
  list.keyPressStarted = emptyButtonList()
  list.keyPressReleased = emptyButtonList()
  for i, key in ipairs(keys) do
    if listToEmpty[key] then
      list.keyPressContinued[key].pressed = true
    end
  end
  listToEmpty = nil
  return list
end

-- the actual method for updating the buttonList variable
function getInput(keysPressed)
  keysPressed = keysPressed or createButtonList()
  keysPressed = moveList(keysPressed)
  for i, key in ipairs(keys) do
    if love.keyboard.isScancodeDown(key) then
      if keysPressed.keyPressContinued[key].pressed then
        keysPressed.keyPressContinued[key].pressTime =
         keysPressed.keyPressContinued[key].pressTime + 1
      else
        keysPressed.keyPressStarted[key] = true
      end
    else
      if keysPressed.keyPressContinued[key] then
        keysPressed.keyPressReleased[key] = true
        keysPressed.keyPressContinued[key].pressed = false
        keysPressed.keyPressContinued[key].pressTime = 0
      end
    end
  end
  keysPressed.KPS = keysPressed.keyPressStarted
  keysPressed.KPC = keysPressed.keyPressContinued
  keysPressed.KPR = keysPressed.keyPressReleased
  return keysPressed
end
