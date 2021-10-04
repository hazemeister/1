local composer = require( "composer" )
local scene = composer.newScene()

function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

		local widget = require "widget"
		local weightGroup = display.newGroup()
		display.newCircle(weightGroup, display.contentCenterX, 74, 60):setFillColor(244/255)
		display.newRoundedRect(weightGroup, display.contentCenterX, 110, w, 100, 15):setFillColor(244/255)
		display.newText(weightGroup, "введи свой вес", display.contentCenterX, 92, "fonts/obelix", 22)

		--

		local myWeight = display.newText({
			parent = weightGroup,
			fontSize = 48,
			text = "60",
			x = display.contentCenterX,
			y = 45,
			font = "fonts/suez"
		})
		myWeight:setFillColor(49/255, 181/255, 174/255)

		--

		local optionSlider = {
			frames = {
				{x=0, y=0, width=15, height=45},    --левый кусочек с заливкой
				{x=16, y=0, width=130, height=45},  --средний кусочек без заливки
				{x=332, y=0, width=15, height=45},  --правый кусочек без заливки
				{x=153, y=0, width=15, height=45},  --залитый кусочек
				{x=353, y=0, width=47, height=47},  --ползунок (на 2 пикселя больше?)
			},
			sheetContentWidth = 400, --общая ширина
			sheetContentHeight = 45  --общая высота
		}
		--

		--
		weightSlider = widget.newSlider { --создание слайдера, изображение и опции
		sheet = graphics.newImageSheet("img/slider.png", optionSlider),
		leftFrame = 1,   --левый кусочек
		middleFrame = 2, --средний
		rightFrame = 3,  --правый
		fillFrame = 4,   --заполненый
		handleFrame = 5, --ползунок
		frameWidth = 15, --ширина кусочков ползунка
		frameHeight = 45,--высота кусочков ползунка
		handleWidth = 45, --ширина ползунка
		handleHeight = 45,--высота ползунка
		top = 110,        --положение y
		left = 91,        --положение x
		width = 360,      --ширина общая
		height = 47,      --высота общая
		orientation = "horizontal", --ориентация
		value = 100 * (weight - weightMin) / (weightMax - weightMin), --какие он может принимать значения(100 дефлт)
		listener = function(event) --функция отслеживания события для значения ползунка
			weight = math.round(weightMin +(weightMax - weightMin) * event.value / 100) -- только целые числа
			myWeight.text = weight --установка текста для переменной текста
		end
	}
	--
	weightGroup:insert(weightSlider)
	--
	weightMinusButton = widget.newButton { --добавляем кнопку -1
	shape = 'RoundedRect', --тип кнопки
	radius = 5, --радиус закругления углов у прямоугольника
	width = 48, height = 48, --ширина и высота
	left = 25, top = 85, --отступ по x и y
	fontSize = 40,
	fillColor = {default={76/255}, over={150/255}},
	labelColor = {default={1}, over={0}},
	label = "-",
	onPress = function(event) -- функция ждет события при нажатии на кнопку
		if weight > weightMin then --проверка, не опустилось ли значение до минимального
			weight = weight - 1
			myWeight.text = weight
			weightSlider:setValue(100 * (weight - weightMin) / (weightMax - weightMin))
		end
	end
}
weightPlusButton = widget.newButton { --обратная предыдущей кнопа
shape = 'RoundedRect',
radius = 5,
width = 48, height = 48,
left = 468, top = 85,
fontSize = 40,
fillColor = {default={76/255}, over={150/255}},
labelColor = {default={1}, over={0}},
label = "+",
onPress = function(event)
	if weight < weightMax then
		weight = weight + 1
		myWeight.text = weight
		weightSlider:setValue(100 * (weight - weightMin) / (weightMax - weightMin))
	end
end
}

weightGroup:insert(weightMinusButton)
weightGroup:insert(weightPlusButton)

--ВОЗРАСТ-----------------------------------------------------------------------

local ageGroup = display.newGroup()
display.newCircle(ageGroup, display.contentCenterX, 374, 60):setFillColor(244/255)
display.newRoundedRect(ageGroup, display.contentCenterX, 410, w, 100, 15):setFillColor(244/255)
display.newText(ageGroup, "Укажите Ваш возраст", display.contentCenterX, 390, "fonts/obelix", 22)

--

local myAge = display.newText({
	parent = ageGroup,
	fontSize = 48,
	text = age,
	x = display.contentCenterX,
	y = 343,
	font = "fonts/suez"
})
myAge:setFillColor(49/255, 181/255, 174/255)

--

ageSlider = widget.newSlider { --создание слайдера, изображение и опции
sheet = graphics.newImageSheet("img/slider.png", optionSlider),
leftFrame = 1,   --левый кусочек
middleFrame = 2, --средний
rightFrame = 3,  --правый
fillFrame = 4,   --заполненый
handleFrame = 5, --ползунок
frameWidth = 15, --ширина кусочков ползунка
frameHeight = 45,--высота кусочков ползунка
handleWidth = 45, --ширина ползунка
handleHeight = 45,--высота ползунка
top = 405,        --положение y
left = 91,        --положение x
width = 360,      --ширина общая
height = 47,      --высота общая
orientation = "horizontal", --ориентация
value = 100 * (age - ageMin) / (ageMax - ageMin), --какие он может принимать значения(100 дефлт)
listener = function(event) --функция отслеживания события для значения ползунка
	age = math.round(ageMin +(ageMax - ageMin) * event.value / 100) -- только целые числа
	myAge.text = age --установка текста для переменной текста
end
}

--
ageGroup:insert(ageSlider)
--

ageMinusButton = widget.newButton { --добавляем кнопку -1
shape = 'RoundedRect', --тип кнопки
radius = 5, --радиус закругления углов у прямоугольника
width = 48, height = 48, --ширина и высота
left = 25, top = 390, --отступ по x и y
fontSize = 40,
fillColor = {default={76/255}, over={150/255}},
labelColor = {default={1}, over={0}},
label = "-",
onPress = function(event) -- функция ждет события при нажатии на кнопку
	if age > ageMin then --проверка, не опустилось ли значение до минимального
		age = age - 1
		myAge.text = age
		ageSlider:setValue(100 * (age - ageMin) / (ageMax - ageMin))
	end
end
}
agePlusButton = widget.newButton { --обратная предыдущей кнопа
shape = 'RoundedRect',
radius = 5,
width = 48, height = 48,
left = 462, top = 390,
fontSize = 40,
fillColor = {default={76/255}, over={150/255}},
labelColor = {default={1}, over={0}},
label = "+",
onPress = function(event)
	if age < ageMax then
		age = age + 1
		myAge.text = age
		ageSlider:setValue(100 * (age - ageMin) / (ageMax - ageMin))
	end
end
}

ageGroup:insert(ageMinusButton)
ageGroup:insert(agePlusButton)

--Рост--------------------------------------------------------------------------

local rostGroup = display.newGroup()
display.newCircle(rostGroup, display.contentCenterX, 224, 60):setFillColor(244/255)
display.newRoundedRect(rostGroup, display.contentCenterX, 260, w, 100, 15):setFillColor(244/255)
display.newText(rostGroup, "Укажите рост", display.contentCenterX, 240, "fonts/obelix", 22)

--

local myRost = display.newText({
	parent = rostGroup,
	fontSize = 48,
	text = rost,
	x = display.contentCenterX,
	y = 193,
	font = "fonts/suez"
})
myRost:setFillColor(49/255, 181/255, 174/255)

--

rostSlider = widget.newSlider { --создание слайдера, изображение и опции
sheet = graphics.newImageSheet("img/slider.png", optionSlider),
leftFrame = 1,   --левый кусочек
middleFrame = 2, --средний
rightFrame = 3,  --правый
fillFrame = 4,   --заполненый
handleFrame = 5, --ползунок
frameWidth = 15, --ширина кусочков ползунка
frameHeight = 45,--высота кусочков ползунка
handleWidth = 45, --ширина ползунка
handleHeight = 45,--высота ползунка
top = 250,        --положение y
left = 91,        --положение x
width = 360,      --ширина общая
height = 47,      --высота общая
orientation = "horizontal", --ориентация
value = 100 * (rost - rostMin) / (rostMax - rostMin), --какие он может принимать значения(100 дефлт)
listener = function(event) --функция отслеживания события для значения ползунка
	rost = math.round(rostMin +(rostMax - rostMin) * event.value / 100) -- только целые числа
	myRost.text = rost --установка текста для переменной текста
end
}

--
rostGroup:insert(rostSlider)
--

rostMinusButton = widget.newButton { --добавляем кнопку -1
shape = 'RoundedRect', --тип кнопки
radius = 5, --радиус закругления углов у прямоугольника
width = 48, height = 48, --ширина и высота
left = 25, top = 240, --отступ по x и y
fontSize = 40,
fillColor = {default={76/255}, over={150/255}},
labelColor = {default={1}, over={0}},
label = "-",
onPress = function(event) -- функция ждет события при нажатии на кнопку
	if rost > rostMin then --проверка, не опустилось ли значение до минимального
		rost = rost - 1
		myRost.text = rost
		rostSlider:setValue(100 * (rost - rostMin) / (rostMax - rostMin))
	end
end
}
rostPlusButton = widget.newButton { --обратная предыдущей кнопа
shape = 'RoundedRect',
radius = 5,
width = 48, height = 48,
left = 462, top = 240,
fontSize = 40,
fillColor = {default={76/255}, over={150/255}},
labelColor = {default={1}, over={0}},
label = "+",
onPress = function(event)
	if rost < rostMax then
		rost = rost + 1
		myRost.text = rost
		rostSlider:setValue(100 * (rost - rostMin) / (rostMax - rostMin))
	end
end
}

rostGroup:insert(rostMinusButton)
rostGroup:insert(rostPlusButton)

--ВРЕМЯ-------------------------------------------------------------------------

local timeGroup = display.newGroup()
display.newCircle(timeGroup, display.contentCenterX, 524, 60):setFillColor(244/255)
display.newRoundedRect(timeGroup, display.contentCenterX, 560, w, 100, 15):setFillColor(244/255)
display.newText(timeGroup, "Укажите время в минутах", display.contentCenterX, 540, "fonts/obelix", 22)

--

local myTime = display.newText({
	parent = timeGroup,
	fontSize = 48,
	text = time,
	x = display.contentCenterX,
	y = 493,
	font = "fonts/suez"
})
myTime:setFillColor(49/255, 181/255, 174/255)

--

timeSlider = widget.newSlider { --создание слайдера, изображение и опции
sheet = graphics.newImageSheet("img/slider.png", optionSlider),
leftFrame = 1,   --левый кусочек
middleFrame = 2, --средний
rightFrame = 3,  --правый
fillFrame = 4,   --заполненый
handleFrame = 5, --ползунок
frameWidth = 15, --ширина кусочков ползунка
frameHeight = 45,--высота кусочков ползунка
handleWidth = 45, --ширина ползунка
handleHeight = 45,--высота ползунка
top = 550,        --положение y
left = 91,        --положение x
width = 360,      --ширина общая
height = 47,      --высота общая
orientation = "horizontal", --ориентация
value = 100 * (time - timeMin) / (timeMax - timeMin), --какие он может принимать значения(100 дефлт)
listener = function(event) --функция отслеживания события для значения ползунка
	time = math.round(timeMin +(timeMax - timeMin) * event.value / 100) -- только целые числа
	myTime.text = time --установка текста для переменной текста
end
}

--
timeGroup:insert(timeSlider)
--

timeMinusButton = widget.newButton { --добавляем кнопку -1
shape = 'RoundedRect', --тип кнопки
radius = 5, --радиус закругления углов у прямоугольника
width = 48, height = 48, --ширина и высота
left = 25, top = 540, --отступ по x и y
fontSize = 40,
fillColor = {default={76/255}, over={150/255}},
labelColor = {default={1}, over={0}},
label = "-",
onPress = function(event) -- функция ждет события при нажатии на кнопку
	if time > timeMin then --проверка, не опустилось ли значение до минимального
		time = time - 1
		myTime.text = time
		timeSlider:setValue(100 * (time - timeMin) / (timeMax - timeMin))
	end
end
}
timePlusButton = widget.newButton { --обратная предыдущей кнопа
shape = 'RoundedRect',
radius = 5,
width = 48, height = 48,
left = 462, top = 540,
fontSize = 40,
fillColor = {default={76/255}, over={150/255}},
labelColor = {default={1}, over={0}},
label = "+",
onPress = function(event)
	if time < timeMax then
		time = time + 1
		myTime.text = time
		timeSlider:setValue(100 * (time - timeMin) / (timeMax - timeMin))
	end
end
}

timeGroup:insert(timeMinusButton)
timeGroup:insert(timePlusButton)

--ПОЛ---------------------------------------------------------------------------


local sexGroup = display.newGroup() --создаем новую группу

display.newRoundedRect(sexGroup, display.contentCenterX, 680, w, 120, 10):setFillColor(244/255) --прямоугольник
display.newText(sexGroup, "Укажите пол", 105, 660, "fonts/mac", 28) --текст

--добавляем переменную, которая отображает текущий пол
sexSelect = display.newText(sexGroup, sex, 105, 700, "fonts/mac", 36)
sexSelect:setFillColor(100/255)

--передача переменным картинок и спавн их
maleOn = display.newImage(sexGroup, "img/corona_male_active.png", 300, 680)
maleOff = display.newImage(sexGroup, "img/corona_male.png", 300, 680)
femaleOn = display.newImage(sexGroup, "img/corona_female_active.png", 440, 680)
femaleOff = display.newImage(sexGroup, "img/corona_female.png", 440, 680)

--отправляет в инвиз пикчи в зависимости от того, какой пол выбран
if (sex == "мужской") then
	maleOff.isVisible = false
	femaleOn.isVisible = false
else
	maleOn.isVisible = false
	femaleOff.isVisible = false
end

function selectMale(event) --функция выбора пола
	if (event.phase == "began") then --began означает что событие только началось
		sex = "мужской"  --меняет переменную, но не отображение
		sexSelect.text = sex --Меняет отображаемое текстовое значение
		maleOn.isVisible = true
		femaleOff.isVisible = true
		maleOff.isVisible = false
		femaleOn.isVisible = false
	end
	return true --??
end

function selectFemale(event) --функция выбора пола
	if(event.phase == "began") then --began означает что событие только началось
		sex = "женский"
		sexSelect.text = sex
		maleOn.isVisible = false
		femaleOff.isVisible = false
		maleOff.isVisible = true
		femaleOn.isVisible = true
	end
	return true --??
	--добавляем картике прослушивание прикосновения, в случае, когда оно происходит запускаем функцию
end
--Добавялем все гурппы в sceneGroup
maleOff:addEventListener("touch", selectMale)
femaleOff:addEventListener("touch", selectFemale)

local activityGroup = display.newGroup()

display.newRoundedRect(activityGroup, display.contentCenterX, 790, w, 60, 15):setFillColor(244/255)
display.newPolygon(activityGroup, 500, 790, {500, 452, 520, 452, 510, 466}):setFillColor(76/255)

activityText = display.newText(activityGroup, activity_name, display.contentCenterX, 790, "fonts/obelix", 22)
activityText:setFillColor(76/255)

--Обработчки собитий
activityGroup:addEventListener("touch", --при нажатии на активити груп вызывает обработчик событий
function(event)
	composer.showOverlay("scenes.activity", {  --при нажатии будет вызвано всплывающие окно которое на самом деле сцена
	isModal = true,                            --предотвращает нажатия кнопок за оверлеем
	effect = "flipFadeOutIn",
	time = 400,
})
end
)

local buttonCalk = widget.newButton{ --кнопка
	shape = 'roundedRect', --квадрат с закруглениями
	radius = 5,
	width = w,	height = 70,
	left = 10, top = 870,
	fontSize = 32,
	fillColor = {default={245/255, 77/255, 178/255}, over={0, 149/255, 59/255}},--вызывает сцену как оверлей
	labelColor = {default={1}, over={1}},
	label = "Считать калории",
	onPress = function(event)
		composer.showOverlay("svenes.result", {
			isModal = true,
			effect = "fade",
			time = 400,
		})
	end
}

	sceneGroup:insert(timeGroup)
	sceneGroup:insert(ageGroup)
	sceneGroup:insert(sexGroup)
	sceneGroup:insert(weightGroup)
	sceneGroup:insert(activityGroup)
	sceneGroup:insert(rostGroup)
	sceneGroup:insert(buttonCalk)

end

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "show", scene )
-- -----------------------------------------------------------------------------------

return scene
