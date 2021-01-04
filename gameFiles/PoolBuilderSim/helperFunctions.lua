-- helperFunctions.lua
-- created by Justtuchthat
-- first created on 11-09-2020
-- last edited on 04-01-2021
-- this file contains all types of random functions

function newLocationObject(x, y)
  loc = {}
  loc.x = x
  loc.y = y
  return loc
end

function isInBounds(location)
  if location.x < 1 or location.x > getGameworldSize() then return false end
  if location.y < 1 or location.y > getGameworldSize() then return false end
  return true
end

function minMax(a, b)
  if a <= b then return a, b end
  return b, a
end

function contains(table, var)
  if not table then return false end
  for i, test in ipairs(table) do
    if test == var then
      return i
    end
  end
  return nil
end

function removeMultiBuilding(knownLocation)
  local buildingID = getTileID(knownLocation)
  local locsToCheck = {knownLocation}
  while #locsToCheck > 0 do
    currLoc = locsToCheck[#locsToCheck]
    locsToCheck[#locsToCheck] = nil
    if getTileMulti(currLoc) then
      if getTileMulti(currLoc) == 1 then
        addMoney(knownTiles[getTileType(currLoc)].buildCost)
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
end

function buildSquareBuilding(startLoc, endLoc, type, currentBuildCost)
  _ = (currentBuildCost <= 0 and addMoney(-currentBuildCost)) or removeMoney(currentBuildCost)
  beginX, endX = minMax(startLoc.x, endLoc.x)
  beginY, endY = minMax(startLoc.y, endLoc.y)
  type = type or "grass"
	for x = beginX, endX do
		for y = beginY, endY do
      loc = newLocationObject(y,x)
      if knownTiles[getTileType(loc)].isMulti then
        removeMultiBuilding(loc)
      end
      setTileType(loc, type)
      setSingleTile(loc)
		end
	end
	checkPoolEdges()
  insideTest()
end

local multiBuildingID = 0

function buildMultiBuilding(buildLoc, type, currentBuildCost)
  _ = (currentBuildCost <= 0 and addMoney(-currentBuildCost)) or removeMoney(currentBuildCost)
  multiBuildingID = multiBuildingID + 1
  for i, multiTile in ipairs(knownTiles[type].buildLocations) do
    loc = newLocationObject(buildLoc.y + multiTile.y, buildLoc.x + multiTile.x)
    if knownTiles[getTileType(loc)].isMulti then
      removeMultiBuilding(loc)
    end
    setTileType(loc, type)
    setMultiTile(loc, knownTiles[type].buildLocations[i].tileNum, multiBuildingID)
  end
  checkPoolEdges()
  insideTest()
end

function screenToWorldSpace(location)
	locationX = location.x - drawOffsetX
	locationY = location.y - drawOffsetY
	loc = newLocationObject(math.floor(locationX/8), math.floor(locationY/8))
	return loc
end
