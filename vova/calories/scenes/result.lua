local composer = require( "composer" ) --вызываем библиотеку composer
local widget = require("widget")       --вызываем библиотеку widget
local scene = composer.newScene()      --создаем новую сцену
local json = require("json")           --вызываем библиотеку json
function scene:create(event)           --функция для отображения данных из data.lua
  local sceneGroup = self.view

  display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY,
  display.contentWidth, display.contentHeight):setFillColor(37/255, 39/255, 46/255, 0.7)

  --кнопка подсчета калорий
  display.newRoundedRect(sceneGroup, display.contentCenterX, 490, 460, 620, 15):setFillColor(244/255)
  local okButton = widget.newButton {
    shape = 'roundedRect',
    radius = 5,
    width = 440, top = 720,
    left = 50, top = 720,
    font = "fonts/suez",
    fontSize = 32,
    fillColor = {default={0.2}, over={0, 149/255, 59/255}},
    labelColor = {default={1}, over={1}},
    label = "Ok, dude",
    onPress = function(event)
      composer.hideOverlay("fade", 400)
    end
  }

  sceneGroup:insert(okButton)

  --Функция подсчета калорий
  function calculator()

    local formula
    if(sex == "мужской") then
      formula = (10 * weight + 6.25 * rost - 5 * age + 5)
    elseif(sex == "женский") then
      formula = (10 * weight + 6.25 * rost - 5 * age + 161)
    end
    v = formula * activity_factor / 24
    res = math.round(v * time / 60)
    return res
  end

  display.newText(sceneGroup, "Результат", display.contentCenterX, 230, "fonts/obelix", 30)
  local penis = display.newImageRect(sceneGroup, "img/penis.png", 64, 64)
  penis.x = 105
  penis.y = 230
  calc = calculator()
  display.newText({
    parent = sceneGroup,
    text = activity_name,
    x = display.contentCenterX,
    y = 360,
    font = "fonts/suez",
    width = 420, --ограничивает ширину выводимого в форме текста
    align = "center"
  })

  display.newText(sceneGroup, "Время", display.contentCenterX, 430, "fonts/suez", 32)
  display.newText(sceneGroup, time.." мин", display.contentCenterX, 470, "fonts/suez", 32)
  display.newText(sceneGroup, "Сожгли калорий", display.contentCenterX, 530, "fonts/suez", 32)
  display.newText(sceneGroup, calc, display.contentCenterX, 580, "fonts/suez", 52):setFillColor(0, 165/255, 80/255)


  --Функция сохранения параметров(срабатывает только при вызове функции в которой находится)
  function saveSettings(t, fileName)
    	local path = system.pathForFile(fileName, system.ResoursDirectory) -- присваивает переменной путь к файлу
    	local file = io.open(path, "w") --открываем файл для записи
    	if(file) then --проверяем существует ли файл
        local contents = json.encode(t) --кодируем таблицу t в json
        file:write(contents) --запись в файл
        io.close(file) --закрываем файл(!)
        return true --если всё ок возвращаем true
      else
        return false --иначе фалс
    	end

    end

   -- Создаем таблицу и заполняем ее текущими значения даных, после чего вызываем функция сохранения
  settings = {}
  settings.weight = weight
  settings.rost = rost
  settings.age = age
  settings.time = time
  settings.sex = sex
  settings.activity_index = activity_index
  settings.activity_name = activity_name
  settings.activity_factor = activity_factor

  saveSettings(settings, "settings.json")

end

scene:addEventListener("create", scene )
return scene --возвращение сцены
