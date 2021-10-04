
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- Установка переменных
local json = require("json") -- Загружает json

local scoresTable = {} -- Создает пустую таблицу

local filePath = system.pathForFile("scores.json", system.DocumentsDirectory) -- Создает переменную и присваивает ей путь до файла

local highScoreMusic
-- Функция файла с таблицей рекордов
local function loadScores()

	local file = io.open(filePath, "r") -- Проверяет, существует ли уже scores.json

	-- Если файл существует
	if file then
		local contents = file:read("*a") -- Читает файл
		io.close(file) -- Закрывает
		scoresTable = json.decode(contents) -- Передает содержимое в переменную декодируя в Lua
	end

	-- Если файл не существует
	if (scoresTable == nil or #scoresTable == 0) then
		scoresTable = { 10000, 7500, 5200, 4700, 3500, 3200, 1200, 1100, 800, 500 }
	end
end

-- Цикл сохранения рекордов
local function saveScores()
	for i = #scoresTable, 11, -1 do --если число элементов 11 удаляет 1
		table.remove(scoresTable, i)
	end
	local file = io.open(filePath, "w") -- Записывает новый скор

	if file then
		file:write(json.encode(scoresTable)) -- Если файл существует, то перезаписывается в него значения из таблицы преобразованные в JSON
		io.close(file)
	end
end
local function gotoMenu()
	composer.gotoScene("menu", {time=800, effect="crossFade"})
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

highScoreMusic = audio.loadSound("audio/boi_SG958v4.wav") -- Загрузка мызыки в таблицу рекордов
	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	--Загрузка текущего скора
	loadScores()

	--Загружаем значение score из последней игры и потмо обнуляем его
	table.insert(scoresTable, composer.getVariable("finalScore"))
	composer.setVariable("finalScore", 0)

	--Соритрует элементы таблицы от большего
	local function compare(a, b)
		return a > b
	end
	table.sort(scoresTable, compare)

	--Вызывает функцию сохранения таблицы очков
	saveScores()

	local background = display.newImageRect(sceneGroup, "background.png", 800, 1400)
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	local highScoresHeader = display.newText(sceneGroup, "ТОП РЕЗУЛЬТАТОВ", display.contentCenterX, 100, native.systemFontm, 44)

	for i = 1, 10 do
		if (scoresTable[i]) then
			local yPos = 150 + (i * 56)

			local rankNum = display.newText(sceneGroup, i .. ")", display.contentCenterX -100, yPos, native.systemFont, 36)
			rankNum:setFillColor(0.8)
			rankNum.anchorX = 1
			local thisScore = display.newText(sceneGroup, scoresTable[i], display.contentCenterX +100, yPos, native.systemFont, 36)
		end
	end
	local menuButton = display.newText(sceneGroup, "Меню", display.contentCenterX, 810, native.systemFont, 44)
	menuButton:setFillColor(0.75,0.81,1)
	menuButton:addEventListener("tap", gotoMenu)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		audio.play(highScoreMusic, {channel=1, loops=-1})
		audio.setVolume(0.8, {channel=1})
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
		composer.removeScene("highScores")
		audio.stop(1)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	audio.dispose = (highScoreMusic)
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
