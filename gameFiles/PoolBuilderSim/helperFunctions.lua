-- helperFunctions.lua
-- created by Justtuchthat
-- first created on 11-09-2020
-- last edited on 06-10-2020
-- this file contains all types of random functions

function newLocationObject(x, y)
  loc = {}
  loc.x = x
  loc.y = y
  return loc
end

function setCellType(x, y, newType)
  if x < 1 then return end
  if x > gameworldSize then return end
  if y < 1 then return end
  if y > gameworldSize then return end
  gameworld[y][x].type = newType
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

function getLocFromMouse(mouseX, mouseY)
	mouseX = mouseX - drawOffsetX
	mouseY = mouseY - drawOffsetY
	loc = newLocationObject(math.floor(mouseX/8), math.floor(mouseY/8))
	return loc
end
