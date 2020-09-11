-- poolEdgeChecker.lua
-- created by Justtuchthat
-- first created on 13-08-2020
-- last edited on 11-09-2020
-- this is used to create the pool edges

local function isInBounds(x, y, gameworld)
  if x > 0 and x <= gameworld.size then
    return y > 0 and y <= gameworld.size
  end
end

local function hasGrassNeigbour(x, y, gameworld)
  for xOff = -1, 1 do
    for yOff = -1, 1 do
      if isInBounds(x + xOff, y + yOff, gameworld) then
        if gameworld[x+xOff][y+yOff].type == "pool" or gameworld[x+xOff][y+yOff].type == "poolEdge" then
        else
          return true
        end
      end
    end
  end
  return false
end

function checkPoolEdges(gameworld)
  for x, yRow in ipairs(gameworld) do
    for y, cell in ipairs(yRow) do
      newCell = {}
      if cell.type == "pool" or cell.type == "poolEdge" then
        newCell.type = "pool"
        if hasGrassNeigbour(x, y, gameworld) then
          newCell.type = "poolEdge"
        end
        gameworld[x][y] = newCell
      else

      end
    end
  end
  return gameworld
end
