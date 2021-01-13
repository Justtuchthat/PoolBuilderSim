-- saveLoad.lua
-- created by Justtuchthat
-- first created on 21-10-2020
-- last edited on 13-01-2020
-- this is used for saving and loading the game

local json = require("json")

function save(saveObj, fileName)
  local appdataPath = os.getenv('APPDATA')
  local saveFile = assert(io.open(appdataPath .. "\\.PoolBuilderSim\\saves\\" .. fileName, "w"))
  io.output(saveFile)
  io.write(json.encode(saveObj))
  io.close(saveFile)
end

function scanForDirsAndFiles(path)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('dir "'..path..'" /b /a')
  for filename in pfile:lines() do
    i = i + 1
    t[i] = filename
  end
  pfile:close()
  return t
end

function createPoolBuilderSimAppdataDir()
  local appdataPath = os.getenv('APPDATA')
  local currentDirsAndFiles = scanForDirsAndFiles(appdataPath)
  if not contains(currentDirsAndFiles, ".PoolBuilderSim") then
    local createPoolBuilderSimDir = "mkdir " .. appdataPath .. "\\.PoolBuilderSim"
    os.execute(createPoolBuilderSimDir)
  end
  appdataPath = appdataPath .. "\\.PoolBuilderSim"
  currentDirsAndFiles = scanForDirsAndFiles(appdataPath)
  if not contains(currentDirsAndFiles, "saves") then
    local createSavesDir = "mkdir " .. appdataPath .. "\\saves"
    os.execute(createSavesDir)
  end
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
  loadButtons:updateList(createLoadButtons())
end

function load(fileName)
  local appdataPath = os.getenv('APPDATA')
  local loadFile = assert(io.open(appdataPath .. "\\.PoolBuilderSim\\saves\\" .. fileName, "r"))
  io.input(loadFile)
  loadStr = io.read("*all")
  loadObj = json.decode(loadStr)
  io.close(loadFile)
  return loadObj
end

function loadGame(fileName)
  gameLoad = load(fileName)
  moneyText:update()
  if not gameLoad.version then
    love.errhand("previous version was loaded, unkowns set to 0. These unknows contain Time")
    setSaveableGameworld(gameLoad)
    return
  end
  if gameLoad.version >= 0.2 then
    testResult = checkMultiTileBuildings(gameLoad.game)
    if not testResult then
      love.errhand("One or more multi tile buildings have not been saved properly, or the save has been corrupted")
    end
  end
  setSaveableGameworld(gameLoad)
  setSaveableTimeObject(gameLoad.time)
end

-- returns true if all is fine, returns false if not
function checkMultiTileBuildings(gameworld)
  for y, xrow in ipairs(gameworld) do
    for x, tile in ipairs(xrow) do
      loc = newLocationObject(y, x)
      if knownTiles[getTileType(loc)].isMulti then
        if getTileMulti(loc) == 1 then
          result = checkMultiOneTile(loc)
        else
          result = checkIfMultiOneIsPresent(loc)
        end
        if not result then return false end
      end
    end
  end
  return true
end

function checkMultiOneTile(loc)
  local tileType = getTileType(loc)
  local tileID = getTileID(loc)
  for tileNum, buildLoc in ipairs(knownTiles[tileType]) do
    newTileLoc = {x = buildLoc.x + loc.x, y = buildLoc.y + loc.y}
    if not getTileID(newTileLoc) == tileID then
      return false
    end
    if not getTileMulti(newTileLoc) == tileNum then
      return false
    end
    if not getTileType(newTileLoc) == tileType then
      return false
    end
    print("ID: " .. getTileID(newTileLoc))
    print("tileNum: " .. getMultiTile())
  end
  return true
end

function checkIfMultiOneIsPresent(loc)
  local buildingID = getTileID(loc)
  local locsToCheck = {loc}
  while #locsToCheck > 0 do
    currLoc = locsToCheck[#locsToCheck]
    locsToCheck[#locsToCheck] = nil
    if getTileMulti(currLoc) then
      if getTileMulti(currLoc) == 1 then
        return true
      end
      if getTileMulti({x = currLoc.x, y = currLoc.y+1}) and buildingID == getTileID({x = currLoc.x, y = currLoc.y+1}) then
        table.insert(locsToCheck, {x = currLoc.x, y = currLoc.y+1})
      end
      if getTileMulti({x = currLoc.x, y = currLoc.y-1}) and buildingID == getTileID({x = currLoc.x, y = currLoc.y-1}) then
        table.insert(locsToCheck, {x = currLoc.x, y = currLoc.y-1})
      end
      if getTileMulti({x = currLoc.x+1, y = currLoc.y}) and buildingID == getTileID({x = currLoc.x+1, y = currLoc.y}) then
        table.insert(locsToCheck, {x = currLoc.x+1, y = currLoc.y})
      end
      if getTileMulti({x = currLoc.x-1, y = currLoc.y}) and buildingID == getTileID({x = currLoc.x-1, y = currLoc.y}) then
        table.insert(locsToCheck, {x = currLoc.x-1, y = currLoc.y})
      end
      setTileType(currLoc, "grass")
      setSingleTile(currLoc)
    end
  end
  return false
end

function createLoadButtons()
  loadButtons = {}
    local appdataPath = os.getenv('APPDATA')
  loadFileNames = scanForFiles(appdataPath .. "\\.PoolBuilderSim\\saves")
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
  addMode("loadMenu", true)
  width, height, _ = love.window.getMode()
  loadButtonArray = createLoadButtons()
  loadButtons = newScrollableButtonSelector(loadButtonArray, 10, newLocationObject(100, 100), "loadMenu")
end
