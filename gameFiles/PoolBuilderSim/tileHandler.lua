-- tileHandler.lua
-- created by Justtuchthat
-- first created on 09-10-2020
-- last edited on 14-10-2020
-- this is used for managing all tiles

knownTiles = {}

buttonStartingY = 40

function newTile(name, color, buildPrice, canBuild)
  if contains(knownTiles, name) then return false end
  table.insert(knownTiles, name)
  knownTiles[name] = {}
  knownTiles[name].color = {}
  knownTiles[name].color = color
  knownTiles[name].buildCost = buildPrice

  -- creates the button if the player can build this tile type
  if canBuild then
    print("adding button")
    width, _, _ = love.window.getMode()
    tileButton = newButton("text", newLocationObject(width-100, buttonStartingY), name, {1, 1, 1}, {1, 1, 0})

    -- sets the current build tile
    tileButton.pressAction:addFunction(function()
      changeBuildTile(name)
      print("changed buildMode to " .. currentBuildTile)
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

function setCellType(x, y, newType)
  if x < 1 then return end
  if x > gameworldSize then return end
  if y < 1 then return end
  if y > gameworldSize then return end
  gameworld[y][x].type = newType
end

function tilePrice(x, y)
  tileType = gameworld[x][y].type
  return knownTiles[tileType].buildCost
end

function setupTiles()
  newTile("grass", {0.1, 0.5, 0.05}, 0, true)
  newTile("pool", {0, 0, 1}, 10, true)
  newTile("poolEdge", {0.4, 0.4, 0.4}, 10, false)
  newTile("foundation", {0.4, 0.4, 0.4}, 5, true)
  newTile("wall", {0.6, 0.2, 0.2}, 2, true)
end
