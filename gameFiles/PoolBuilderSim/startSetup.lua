-- setupStart.lua
-- created by Justtuchthat
-- first created on 05-10-2020
-- last edited on 14-10-2020
-- this is used to start all classes

function startClasses()
  startMouse()
	startButtonClass()
	setupModes()
	modes.play.draw:addFunction(renderGame)
	setupControls()

  setupBuildMode()
  setupTiles()

	windowSetup()

	if testPoolEdgeMode then
		setupMouseCodeTestPoolEdge()
	end
end
