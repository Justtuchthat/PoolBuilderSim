-- main.lua
-- created by Justtuchthat
-- first created on 10-8-2020
-- last edited on 05-10-2020
-- this is used to start the game

require("require")

function setupModes()
  addMode("nothing")
  addMode("play")
  changeMode("play")
end

function love.load()
	startClasses()
end

function love.draw()
	modeDraw()
end

function love.update()

end
