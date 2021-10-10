-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")

--hide status bar
display.setStatusBar(display.HiddenStatusBar)

--seed the random number generation
math.randomseed(os.time())

--go to the menu screen
composer.gotoScene ("menu")