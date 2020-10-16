-- gameRenderer.lua
-- created by Justtuchthat
-- first created on 10-08-2020
-- last edited on 16-10-2020
-- this is used to render the game

errorCellColor = {1, 1, 0}

function renderGame()
  love.graphics.translate(drawOffsetX, drawOffsetY)
  for y, xRow in ipairs(gameworld) do
    for x, cell in ipairs(xRow) do
      if knownTiles[cell.type].specialDrawFunction then
        knownTiles[cell.type].specialDrawFunction(newLocationObject(x, y))
      else
        color = knownTiles[cell.type].color or errorCellColor
        love.graphics.setColor(color)
        love.graphics.rectangle("fill", x*squareSize, y*squareSize, squareSize, squareSize)
      end
    end
  end
  love.graphics.translate(-drawOffsetX, -drawOffsetY)
end

function buildMenu()
  width, height, _ = love.window.getMode()
  text = love.graphics.newText(love.graphics.getFont(), "BuildMode")
  textWidth, textHeight = text:getDimensions()
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("fill", (width-textWidth)/2-2, 20, textWidth+4, textHeight, 2, 2)
  love.graphics.setColor(0, 0, 0)
  love.graphics.draw(text, (width-textWidth)/2, 20)
  love.graphics.setColor(0.7, 0.65, 0.35, 0.5)
  love.graphics.rectangle("fill", width - buildMenuBoxWidth, 0, buildMenuBoxWidth, height)
end

function drawPoolEdge(location)

  x = location.x
  y = location.y

  local n = false
  local e = false
  local s = false
  local w = false

  local ne = false
  local nw = false
  local se = false
  local sw = false

  if isInBounds(newLocationObject(x-1, y)) then
    w = gameworld[y][x-1].type == "pool" or gameworld[y][x-1].type == "poolEdge"
  end
  if isInBounds(newLocationObject(x+1, y)) then
    e = gameworld[y][x+1].type == "pool" or gameworld[y][x+1].type == "poolEdge"
  end
  if isInBounds(newLocationObject(x, y-1)) then
    n = gameworld[y-1][x].type == "pool" or gameworld[y-1][x].type == "poolEdge"
  end
  if isInBounds(newLocationObject(x, y+1)) then
    s = gameworld[y+1][x].type == "pool" or gameworld[y+1][x].type == "poolEdge"
  end

  if isInBounds(newLocationObject(x-1, y-1)) then
    nw = gameworld[y-1][x-1].type == "pool" or gameworld[y-1][x-1].type == "poolEdge"
  end
  if isInBounds(newLocationObject(x+1, y-1)) then
    ne = gameworld[y-1][x+1].type == "pool" or gameworld[y-1][x+1].type == "poolEdge"
  end
  if isInBounds(newLocationObject(x-1, y+1)) then
    sw = gameworld[y+1][x-1].type == "pool" or gameworld[y+1][x-1].type == "poolEdge"
  end
  if isInBounds(newLocationObject(x+1, y+1)) then
    se = gameworld[y+1][x+1].type == "pool" or gameworld[y+1][x+1].type == "poolEdge"
  end

  love.graphics.setColor(knownTiles.pool.color)
  love.graphics.rectangle("fill", x*squareSize, y*squareSize, squareSize, squareSize)

  -- drawing the sides
  love.graphics.setColor(knownTiles.poolEdge.color)

  if not nw then
    love.graphics.rectangle("fill", x*squareSize, y*squareSize, 2, 2)
  end
  if not ne then
    love.graphics.rectangle("fill", x*squareSize+6, y*squareSize, 2, 2)
  end
  if not sw then
    love.graphics.rectangle("fill", x*squareSize, y*squareSize+6, 2, 2)
  end
  if not se then
    love.graphics.rectangle("fill", x*squareSize+6, y*squareSize+6, 2, 2)
  end

  if not n then
    love.graphics.rectangle("fill", x*squareSize, y*squareSize, squareSize, 2)
  end
  if not e then
    love.graphics.rectangle("fill", x*squareSize+6, y*squareSize, 2, squareSize)
  end
  if not s then
    love.graphics.rectangle("fill", x*squareSize, y*squareSize+6, squareSize, 2)
  end
  if not w then
    love.graphics.rectangle("fill", x*squareSize, y*squareSize, 2, squareSize)
  end
end
