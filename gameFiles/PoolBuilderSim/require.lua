-- require.lua
-- created by Justtuchthat
-- first created on 05-10-2020
-- last edited on 28-12-2020
-- this is used to import all files in one require statement
-- this is done to clean up the main file

require("inputHelper")
require("textInputItem")
require("gameRenderer")
require("gameInit")
require("poolEdgechecker")
require("controlSetup")
require("settingsSetup")
require("buttonClass")
require("helperFunctions")
require("modeManager")
require("buildTool")
require("globalVariables")
require("startSetup")
require("resize")
require("tileHandler")
require("currencyHandler")
require("insideTester")
require("saveLoad")
require("scrollSelector")
require("escapeMenu")
require("saveMenu")
require("timeHandler")
if testPoolEdgeMode then
	require("testPoolEdge")
end
