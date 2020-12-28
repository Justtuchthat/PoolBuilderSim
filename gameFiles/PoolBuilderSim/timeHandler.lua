-- timeHandler.lua
-- created by Justtuchthat
-- first created on 28-12-2020
-- last edited on 28-12-2020
-- this is used to handle the time (duh)

function timeStep(dt)
  if modes[currentMode].pausesGame then return end
  currentTime = currentTime + dt*1000
  if currentTime >= timePerDay then
    currentTime = currentTime - timePerDay
    currentDay = currentDay + 1
    if currentDay >= daysPerSeason * 4 then
      currentYear = currentYear + 1
      currentSeason = 0
    elseif currentDay >= daysPerSeason * 3 then
      currentSeason = 3
    elseif currentDay >= daysPerSeason * 2 then
      currentSeason = 2
    elseif currentDay >= daysPerSeason then
      currentSeason = 1
    end
  end
  printTime()
end

function printTime()
  print("The current time is " .. currentTime)
  print("It is day " .. currentDay .. " in year " .. currentYear)
  print("This makes it season " .. currentSeason)
end

function getSaveableTimeObject()
  return {currentTime, timePerDay, currentDay, daysPerSeason, currentSeason, currentYear}
end

function setSaveableTimeObject(timeObject)
  currentTime = timeObject[1]
  timePerDay = timeObject[2]
  currentDay = timeObject[3]
  daysPerSeason = timeObject[4]
  currentSeason = timeObject[5]
  currentYear = timeObject[6]
end
