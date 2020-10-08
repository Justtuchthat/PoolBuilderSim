-- resize.lua
-- created by Justtuchthat
-- first created on 08-10-2020
-- last edited on 08-10-2020
-- this is used for handling window resizes

resizeFunctions = {}

function newResizeFunction(func)
  table.insert(resizeFunctions, func)
end

function love.resize(newWidth, newHeight)
  for i, fn in ipairs(resizeFunctions) do
    fn(newWidth, newHeight)
  end
end
