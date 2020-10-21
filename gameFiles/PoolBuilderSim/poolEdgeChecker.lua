-- poolEdgeChecker.lua
-- created by Justtuchthat
-- first created on 13-08-2020
-- last edited on 21-10-2020
-- this is used to create the pool edges

local function hasNonPoolNeighbours(x, y)
  for xOff = -1, 1 do
    for yOff = -1, 1 do
      temp = newLocationObject(x+xOff, y+yOff)
      if isInBounds(temp) then
        if getTileType(temp) ~= "pool" and getTileType(temp) ~= "poolEdge" then
          return true
        end
      else
        return true
      end
    end
  end
  return false
end

function checkPoolEdges()
  for x, yRow in ipairs(getItterableGameworld()) do
    for y, cell in ipairs(yRow) do
      tempLoc = newLocationObject(x, y)
      if cell.type == "pool" or cell.type == "poolEdge" then
        setTileType(tempLoc, "pool")
        if hasNonPoolNeighbours(x, y) then
          setTileType(tempLoc, "poolEdge")
        end
      end
    end
  end
end
