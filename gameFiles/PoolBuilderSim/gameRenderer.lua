-- gameRenderer.lua
-- created by Justtuchthat
-- first created on 10-08-2020
-- last edited on 11-08-2020
-- this is used to render the game

colorPicker = {}
colorPicker.grassCell = {0.1, 0.5, 0.05}
colorPicker.errorCell = {1, 1, 0}
colorPicker.pool = {0, 0, 1}
colorPicker.poolEdge = {0.4, 0.4, 0.4}
colorPicker.newCell = {1, 0, 0}

function renderGame()
  love.graphics.translate(drawOffsetX, drawOffsetY)
  for y, xRow in ipairs(gameworld) do
    for x, cell in ipairs(xRow) do
      color = colorPicker[cell.type]
      color = color or colorPicker.errorCell
      love.graphics.setColor(color)
      love.graphics.rectangle("fill", x*squareSize, y*squareSize, squareSize, squareSize)
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
end
