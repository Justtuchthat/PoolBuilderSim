-- testPoolEdge.lua
-- created by Justtuchthat
-- first created on 10-09-2020
-- last edited on 104-10-2020
-- this is used to test all pool edges

local previousCellType = "grassCell"
local cellLoc = {}
cellLoc.x = 0
cellLoc.y = 0

function mouseReleaseCellEdit()
	gameworld[cellLoc.y][cellLoc.x].type = previousCellType
	previousCellType = "grassCell"
	checkPoolEdges(gameworld)
end

function mouseMoveCellEdit(_, mouse)
	if not mouse.button[1].pressed then return end
	loc = getLocFromMouse(mouse.y, mouse.x)
	if not (loc.x == cellLoc.x and loc.y == cellLoc.y) then
		mouseReleaseCellEdit()
		mouseDownCellEdit(_, mouse)
	end
end

function mouseDownCellEdit(_, mouse)
	loc = getLocFromMouse(mouse.y, mouse.x)
	previousCellType = gameworld[loc.x][loc.y].type
	gameworld[loc.x][loc.y].type = "newCell"
	cellLoc.x = loc.y
	cellLoc.y = loc.x
	checkPoolEdges(gameworld)
end

function setupMouseCodeTestPoolEdge()
  mouse.button[1].pressAction:addFunction(mouseDownCellEdit)
  mouse.button[1].releaseAction:addFunction(mouseReleaseCellEdit)
  mouse.moveAction:addFunction(mouseMoveCellEdit)
end
