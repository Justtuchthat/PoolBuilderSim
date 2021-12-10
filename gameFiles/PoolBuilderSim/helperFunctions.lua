-- helperFunctions.lua
-- created by Justtuchthat
-- first created on 11-09-2020
-- last edited on 10-12-2021
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
		end
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
