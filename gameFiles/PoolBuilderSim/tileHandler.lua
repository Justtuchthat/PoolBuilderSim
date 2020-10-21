-- tileHandler.lua
-- created by Justtuchthat
-- first created on 09-10-2020
-- last edited on 21-10-2020
-- this is used for managing all tiles

knownTiles = {}

buttonStartingY = 40

function newTile(name, color, buildPrice, canBuild, specialDrawFunction)
  if contains(knownTiles, name) then return false end
  if canBuild == nil then canBuild = true end
  table.insert(knownTiles, name)
  knownTiles[name] = {}
  knownTiles[name].color = {}
  knownTiles[name].color = color
  knownTiles[name].buildCost = buildPrice
  knownTiles[name].specialDrawFunction = specialDrawFunction
  knownTiles[name].insideSeparator = false

  -- creates the button if the player can build this tile type
  if canBuild then
    width, _, _ = love.window.getMode()
    tileButton = newButton("text", newLocationObject(width-100, buttonStartingY), name, {1, 1, 1}, {1, 1, 0})

    -- sets the current build tile
    tileButton.pressAction:addFunction(function()
      changeBuildTile(name)
    end)

    -- sets the color to green
    tileButton.pressAction:addFunction(resetColors)
    tileButton.pressAction:addFunction(function()
      knownTiles[name].buildButton.colorNormal = {0.2, 0.8, 0.1}
    end)

    -- adds the button to the build menu
    modes.build.buttons:addButton(tileButton)

    -- places the button at the right location after resizes
    newResizeFunction(function(newWidth, newHeight)
      knownTiles[name].loc.x = newWidth - 100
    end)
    knownTiles[name].buildButton = tileButton
    buttonStartingY = buttonStartingY + 20
  end
  return true
end

function tilePrice(x, y)
  tileType = gameworld[x][y].type
  return knownTiles[tileType].buildCost
end

function setTileType(loc, newTile)
  if isInBounds(loc) and contains(knownTiles, newTile) then
    gameworld[loc.x][loc.y].type = newTile
  end
end

function getTileType(loc)
  if isInBounds(loc) then
    return gameworld[loc.x][loc.y].type
  else
    return nil
  end
end

function setTileInside(loc, insideBool)
  if not isInBounds(loc) then return end
  assert(type(insideBool) == "boolean", "setTileInside requires a boolean parameter as second argument")
  gameworld[loc.x][loc.y].inside = insideBool
end

function getItterableGameworld()
  return gameworld
end

function getGameworldSize()
  return gameworldSize
end

function setupTiles()
  newTile("grass", {0.1, 0.5, 0.05}, 0)
  newTile("foundation", {0.4, 0.4, 0.4}, 5)
  newTile("pool", {0, 0, 1}, 10)
  newTile("poolEdge", {0.4, 0.4, 0.4}, 10, false, drawPoolEdge)
  newTile("wall", {0.6, 0.2, 0.2}, 2)
  knownTiles.wall.insideSeparator = true
end
