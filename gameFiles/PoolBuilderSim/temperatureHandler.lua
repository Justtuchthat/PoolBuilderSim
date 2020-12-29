-- temperatureHandler.lua
-- created by Justtuchthat
-- created on 29-12-2020
-- last updated on 29-12-2020
-- this is used for temperature handling

function getTemperature()
  monthTemp = (-math.cos(currentDay*math.pi/6)*10)+5
  dayTemp = (-math.cos(currentTime*math.pi/timePerDay*2)*2.5)+2.5
  print("month temp = " .. monthTemp)
  print("day temp = " .. dayTemp)
  return 13 + monthTemp + dayTemp
end
