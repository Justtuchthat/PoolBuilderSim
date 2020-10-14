-- helperFunctions.lua
-- created by Justtuchthat
-- first created on 11-09-2020
-- last edited on 14-10-2020
-- this file contains all types of random functions

function newLocationObject(x, y)
  loc = {}
  loc.x = x
  loc.y = y
  return loc
end

function isInBounds(location)
  if location.x < 1 or location.x > gameworldSize then return false end
  if location.y < 1 or location.y > gameworldSize then return false end
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

function buildSquareBuilding(beginX, beginY, endX, endY, type)
  beginX, endX = minMax(beginX, endX)
  beginY, endY = minMax(beginY, endY)
  type = type or "grass"
	for x = beginX, endX do
		for y = beginY, endY do
			setCellType(x, y, type)
		end
	end
	checkPoolEdges(gameworld)
end

function screenToWorldSpace(location)
	location.x = location.x - drawOffsetX
	location.x = location.x - drawOffsetY
	loc = newLocationObject(math.floor(location.x/8), math.floor(location.y/8))
	return loc
end
