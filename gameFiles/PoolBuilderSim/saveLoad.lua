-- saveLoad.lua
-- created by Justtuchthat
-- first created on 21-10-2020
-- last edited on 28-12-2020
-- this is used for saving and loading the game

local json = require("json")

function save(saveObj, fileName)
  local saveFile = assert(io.open("saves/" .. fileName, "w"))
  io.output(saveFile)
  io.write(json.encode(saveObj))
  io.close(saveFile)
end

function scanForFiles(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('dir "'..directory..'" /b /a-d')
  for filename in pfile:lines() do
    i = i + 1
    t[i] = filename
  end
  pfile:close()
  return t
end

function saveGame(fileName)
  local gameSave = getSaveableGameworld()
  gameSave.time = getSaveableTimeObject()
  gameSave.version = saveVersion
  save(gameSave, fileName)
end

function load(fileName)
  local loadFile = assert(io.open("saves/" .. fileName, "r"))
  io.input(loadFile)
  loadStr = io.read("*all")
  loadObj = json.decode(loadStr)
  return loadObj
end

function loadGame(fileName)
  gameLoad = load(fileName)
  if not saveVersion == gameLoad.saveVersion then
    assert(false)
  end
  setSaveableGameworld(gameLoad)
  setSaveableTimeObject(gameLoad.time)
end

function createLoadButtons()
  loadButtons = {}
  loadFileNames = scanForFiles("saves/")
  for i, fileName in ipairs(loadFileNames) do
    loadButtons[i] = {}
    loadButtons[i].name = fileName:sub(1,-6)
    loadButtons[i].pressAction = function()
      loadGame(fileName)
      changeMode("play")
    end
  end
  return loadButtons
end

function setupLoadMenu()
  addMode("loadMenu")
  width, height, _ = love.window.getMode()
  loadButtonArray = createLoadButtons()
  newScrollableButtonSelector(loadButtonArray, 10, newLocationObject(100, 100), "loadMenu")
end
