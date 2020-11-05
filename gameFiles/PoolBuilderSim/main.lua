-- main.lua
-- created by Justtuchthat
-- first created on 10-8-2020
-- last edited on 05-11-2020
-- this is used to start the game

require("require")

function love.load()
	startClasses()
	buttonList = {{name = "test1", pressAction = function()
		print("test1")
	end},
	{name = "test2", pressAction = function()
		print("test2")
	end},
	{name = "test3", pressAction = function()
		print("test3")
	end},
	{name = "test4", pressAction = function()
		print("test4")
	end},
	{name = "test5", pressAction = function()
		print("test5")
	end},
	{name = "test6", pressAction = function()
		print("test6")
	end}}
	scrollObject = newScrollableButtonSelector(buttonList, 2, newLocationObject(100,100), "mainMenu")
end

function love.draw()
	modeDraw()
	scrollObject:draw()
end

function love.update()

end
