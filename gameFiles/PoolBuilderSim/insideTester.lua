-- insideTester.lua
-- created by Justtuchthat
-- first created on 18-10-2020
-- last edited on 18-10-2020
-- this is used for checking which tiles are inside and which tiles are outside

local tilesToDo = {}
local visitedTiles = {}

local function addTile(loc)
  table.insert(tilesToDo, loc)
end

local function removeTile()
  returnLoc = tilesToDo[1]
  for i = 2, #tilesToDo do
    tilesToDo[i-1] = tilesToDo[i]
  end
  tilesToDo[#tilesToDo] = nil
  return returnLoc
end

local function isInInsideTestBounds(loc)
  if loc.x < 0 or loc.x > gameworldSize + 1 then return false end
  if loc.y < 0 or loc.y > gameworldSize + 1 then return false end
  return true
end

local function isBusyOrDone(tileLoc)
  for i, visitedTile in ipairs(tilesToDo) do
    if visitedTile.x == tileLoc.x and visitedTile.y == tileLoc.y then
      return true
    end
  end
  return visitedTiles[tileLoc.x][tileLoc.y]
end

local function addNeigbourTiles(tileLoc, gameworld)
  up = newLocationObject(tileLoc.x, tileLoc.y - 1)
  down = newLocationObject(tileLoc.x, tileLoc.y + 1)
  left = newLocationObject(tileLoc.x - 1, tileLoc.y)
  right = newLocationObject(tileLoc.x + 1, tileLoc.y)

  if isInInsideTestBounds(up) and not isBusyOrDone(up) then
    if isInBounds(up) then
      if not knownTiles[gameworld[up.x][up.y].type].insideSeparator then
        addTile(up)
      end
    else
      addTile(up)
    end
  end
  if isInInsideTestBounds(down) and not isBusyOrDone(down) then
    if isInBounds(down) then
      if not knownTiles[gameworld[down.x][down.y].type].insideSeparator then
        addTile(down)
      end
    else
      addTile(down)
    end
  end
  if isInInsideTestBounds(left) and not isBusyOrDone(left) then
    if isInBounds(left) then
      if not knownTiles[gameworld[left.x][left.y].type].insideSeparator then
        addTile(left)
      end
    else
      addTile(left)
    end
  end
  if isInInsideTestBounds(right) and not isBusyOrDone(right) then
    if isInBounds(right) then
      if not knownTiles[gameworld[right.x][right.y].type].insideSeparator then
        addTile(right)
      end
    else
      addTile(right)
    end
  end
end

local function resetVisited()
  visitedTiles = {}
  for x = 0, gameworldSize + 1 do
    visitedTiles[x] = {}
    for y = 0, gameworldSize + 1 do
      visitedTiles[x][y] = false
    end
  end
end

local function setVisited(tileLoc)
  visitedTiles[tileLoc.x][tileLoc.y] = true
end

function insideTest(gameworld)
  for y, xRow in ipairs(gameworld) do
    for x, gameCell in ipairs(xRow) do
      gameCell.inside = true
    end
  end
  print("test")
  resetVisited()
  addTile(newLocationObject(0, 0))
  repeat
    currentTile = removeTile()
    setVisited(currentTile)
    addNeigbourTiles(currentTile, gameworld)
    if isInBounds(currentTile) then
      gameworld[currentTile.x][currentTile.y].inside = false
    end
  until #tilesToDo == 0
end
