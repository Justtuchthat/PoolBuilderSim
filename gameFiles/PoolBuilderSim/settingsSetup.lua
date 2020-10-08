-- settingsSetup.lua
-- created by Justtuchthat
-- first created on 10-09-2020
-- last edited on 10-09-2020
-- this is used to setup window settings

function windowSetup()
  width, height, windowSettings = love.window.getMode()
  windowSettings.fullscreen = false
  windowSettings.fullscreentype = "desktop"
  windowSettings.vsync = true
  windowSettings.msaa = 0
  windowSettings.resizable = true
  windowSettings.borderless = false
  windowSettings.centered = false
  windowSettings.minwidth = 585
  windowSettings.minheight = 5
  windowSettings.highdpi = false
  love.window.setMode(width, height, windowSettings)
end
