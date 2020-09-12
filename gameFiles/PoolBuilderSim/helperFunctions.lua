-- helperFunctions.lua
-- created by Justtuchthat
-- first created on 11-09-2020
-- last edited on 12-09-2020
-- this file contains all types of random functions

function newLocationObject(x, y)
  loc = {}
  loc.x = x
  loc.y = y
  return loc
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
	for x = beginX, endX do
		for y = beginY, endY do
			gameworld[y][x] = poolCell
		end
	end
	gameworld = checkPoolEdges(gameworld)
end
