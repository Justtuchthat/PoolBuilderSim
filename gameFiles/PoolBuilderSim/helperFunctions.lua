-- helperFunctions.lua
-- created by Justtuchthat
-- first created on 11-09-2020
-- last edited on 05-10-2020
-- this file contains all types of random functions

function newLocationObject(x, y)
  loc = {}
  loc.x = x
  loc.y = y
  return loc
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

function addSquarePool(beginX, beginY, endX, endY)
	poolCell = newGameCell()
	poolCell.type = "pool"
  beginX, endX = minMax(beginX, endX)
  beginY, endY = minMax(beginY, endY)
	for x = beginX, endX do
		for y = beginY, endY do
			gameworld[y][x] = poolCell
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
