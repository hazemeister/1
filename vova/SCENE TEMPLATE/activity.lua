local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")
local data = require("scenes.data")

function scene:show( event )
  local sceneGroup = self.view

end

scene:addEventListener( "show", scene )
return scene
