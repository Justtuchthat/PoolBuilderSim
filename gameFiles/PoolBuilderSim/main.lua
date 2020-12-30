-- main.lua
-- created by Justtuchthat
-- first created on 10-8-2020
-- last edited on 30-12-2020
-- this is used to start the game

require("require")

function love.load()
	createPoolBuilderSimAppdataDir()
	startClasses()
end

function love.draw()
	modeDraw()
end

function love.update(dt)
	timeStep(dt)
end
