
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoGame()
	composer.gotoScene("game", { time=800, effect="crossFade" })
end

local function gotoHighScores()
	composer.gotoScene("highScores", { time=800, effect="crossFade" })
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Этот код запускается когда сцена первый раз создана, но еще не появилась на экране

	-- Загружает и размещает обои
	local background = display.newImageRect(sceneGroup, "background.png", 800, 1400)
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- Загружает и размещает название
	local title = display.newImageRect(sceneGroup, "title.png", 500, 80)
	title.x = display.contentCenterX
	title.y = 200

	-- Размещает текстовые кнопки
	local playButton = display.newText(sceneGroup, "Играть", display.contentCenterX, 700, native.systemFont, 44)
	playButton:setFillColor(0.82, 0.86, 1)

	local highScoresButton = display.newText(sceneGroup, "Рекорды", display.contentCenterX, 810, native.systemFont, 44)
	playButton:setFillColor(0.75, 0.78, 1)

	playButton:addEventListener("tap", gotoGame)
	highScoresButton:addEventListener("tap", gotoHighScores)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
