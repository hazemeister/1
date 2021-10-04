local composer = require( "composer" ) --вызываем библиотеку composer
local widget = require("widget")       --вызываем библиотеку widget
local scene = composer.newScene()      --создаем новую сцену
function scene:create(event)           --функция для отображения данных из data.lua
  local sceneGroup = self.view



end

scene:addEventListener("create", scene )
return scene --возвращение сцены
