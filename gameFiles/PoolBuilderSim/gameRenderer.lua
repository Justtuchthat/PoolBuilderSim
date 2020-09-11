-- gameRenderer.lua
-- created by Justtuchthat
-- first created on 10-8-2020
-- last edited on 12-8-2020
-- this is used to render the game

colorPicker = {}
colorPicker.grassCell = {0.1, 0.5, 0.05}
colorPicker.errorCell = {1, 1, 0}
colorPicker.pool = {0, 0, 1}
colorPicker.poolEdge = {0.4, 0.4, 0.4}
colorPicker.newCell = {1, 0, 0}

function renderGame(xOffset, yOffset, squareSize, gameStoreVar)
  love.graphics.translate(xOffset, yOffset)
  for y, xRow in ipairs(gameStoreVar) do
    for x, cell in ipairs(xRow) do
      color = colorPicker[cell.type]
      color = color or colorPicker.errorCell
      love.graphics.setColor(color)
      love.graphics.rectangle("fill", x*squareSize, y*squareSize, squareSize, squareSize)
    end
  end
  love.graphics.translate(-xOffset, -yOffset)
end
