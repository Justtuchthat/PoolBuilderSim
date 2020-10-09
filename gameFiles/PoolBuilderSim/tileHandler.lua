-- tileHandler.lua
-- created by Justtuchthat
-- first created on 09-10-2020
-- last edited on 09-10-2020
-- this is used for managing all tiles

knownTiles = {}

function newTile(name, color, buildPrice)
  if contains(knownTiles, name) then return false end
  table.insert(knownTiles, name)
  knownTiles[name] = {}
  knownTiles[name].color = {}
  knownTiles[name].color = color
  knownTiles[name].buildCost = buildPrice
  return true
end

function setCellType(x, y, newType)
  if x < 1 then return end
  if x > gameworldSize then return end
  if y < 1 then return end
  if y > gameworldSize then return end
  gameworld[y][x].type = newType
end

function setupTiles()
  newTile("grass", {0.1, 0.5, 0.05}, 0)
  newTile("pool", {0, 0, 1}, 10)
  newTile("poolEdge", {0.4, 0.4, 0.4}, 10)
end
