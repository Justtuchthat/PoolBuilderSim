-- temperatureHandler.lua
-- created by Justtuchthat
-- created on 29-12-2020
-- last updated on 02-01-2021
-- this is used for temperature handling

function getTemperature()
  monthTemp = (-math.cos(currentDay*math.pi/6)*10)+5
  dayTemp = (-math.cos(currentTime*math.pi/timePerDay*2)*2.5)+2.5
  return 13 + monthTemp + dayTemp
end
