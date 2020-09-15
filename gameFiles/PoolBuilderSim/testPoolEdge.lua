-- testPoolEdge.lua
-- created by Justtuchthat
-- first created on 10-09-2020
-- last edited on 15-09-2020
-- this is used to test all pool edges

local previousCellType = "grassCell"
local cellLoc = {}
cellLoc.x = 0
cellLoc.y = 0

function mouseReleaseCellEdit()
	gameworld[cellLoc.x][cellLoc.y].type = previousCellType
	previousCellType = "grassCell"
	gameworld = checkPoolEdges(gameworld)
end

function mouseMoveCellEdit(_, mouse)
	if not mouse.button[1].pressed then return end
	loc = getLocFromMouse(mouse.x, mouse.y)
	if not (loc.x == cellLoc.x and loc.y == cellLoc.y) then
		mouseReleaseCellEdit()
		mouseDownCellEdit(_, mouse)
	end
end

function mouseDownCellEdit(_, mouse)
	loc = getLocFromMouse(mouse.x, mouse.y)
	previousCellType = gameworld[loc.x][loc.y].type
	gameworld[loc.x][loc.y].type = "newCell"
	cellLoc.x = loc.x
	cellLoc.y = loc.y
	gameworld = checkPoolEdges(gameworld)
end

function setupMouseCodeTestPoolEdge()
  mouse.button[1].pressAction:addFunction(mouseDownCellEdit)
  mouse.button[1].releaseAction:addFunction(mouseReleaseCellEdit)
  mouse.moveAction:addFunction(mouseMoveCellEdit)
end
