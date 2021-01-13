-- globalVariables.lua
-- created by Justtuchthat
-- first created on 05-10-2020
-- last edited on 13-01-2020
-- this is used to import all global variables
-- this is done to clean up the main file

money = 0

testPoolEdgeMode = false
cheatingMode = false

gameworldSize = 100

drawOffsetX = 0
drawOffsetY = 0
squareSize = 8
buildLocStart = {}
buildLocStart.x = nil
buildLocStart.y = nil

saveVersion = 0.2

currentTime = 0
currentDay = 0
currentSeason = 0
currentYear = 0
timePerDay = 10000
daysPerSeason = 3
-- since there are 4 seasons per year there is no necesity for days per year

movementSpeed = 10

gameworld = initGame(gameworldSize)

function resetGlobalVariables()
  testPoolEdgeMode = false
  cheatingMode = false

  gameworldSize = 100

  drawOffsetX = 0
  drawOffsetY = 0
  squareSize = 8
  buildLocStart = {}
  buildLocStart.x = nil
  buildLocStart.y = nil

  saveVersion = 0.2

  currentTime = 0
  currentDay = 0
  currentSeason = 0
  currentYear = 0
  timePerDay = 10000
  daysPerSeason = 3
  -- since there are 4 seasons per year there is no necesity for days per year

  movementSpeed = 10

  gameworld = initGame(gameworldSize)
  resetMoney()
end
