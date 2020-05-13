local keysPressed = {{}, {}, {}}
local mouse = {}

local keys = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '1', '2', '3',
'4', '5', '6', '7', '8', '9', '0', "return", "escape", "backspace", "tab",
"space", '-', '=', '[', ']', '\\', "nonus#", ';', "'", '`', ',', '.', '/',
"capslock"}

function emptyButtonList()
  list = {}
  for i, key in ipairs(keys) do
    list[key] = false
  end
  return list
end

function createButtonList()
  keysPressed[1] = emptyButtonList()
  keysPressed[2] = emptyButtonList()
  keysPressed[3] = emptyButtonList()
end

function moveList(list)
  listToEmpty = list[1]
  list[1] = emptyButtonList()
  list[3] = emptyButtonList()
  for i, key in ipairs(keys) do
    if listToEmpty[key] then
      list[2][key] = true
    end
  end
  listToEmpty = nil
  return list
end

function getInput()
  keysPressed = moveList(keysPressed)
  for i, key in ipairs(keys) do
    if love.keyboard.isScancodeDown(key) then
      if not keysPressed[2][key] then
        keysPressed[1][key] = true
      end
    else
      if keysPressed[2][key] then
        keysPressed[3][key] = true
        keysPressed[2][key] = false
      end
    end
  end
  return keysPressed
end
