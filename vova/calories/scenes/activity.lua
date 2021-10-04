local composer = require( "composer" ) --вызываем библиотеку composer
local scene = composer.newScene()      --создаем новую сцену
local widget = require("widget")       --вызываем библиотеку widget
local data = require("scenes.data")    --подключаем файл data из папки scenes
function scene:create(event)           --функция для отображения данных из data.lua
  local sceneGroup = self.view
  --создаем всплывающие окно
  display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY,
  display.contentWidth, display.contentHeight):setFillColor(37/255, 39/255, 46/255, 0.7)

  function onRowRender(event) -- рисует список, ждет событие
    local row = event.row --ряд который поступил обработчику событий
    local id = row.index -- переменная id принимает индекс конкретного ряда
    row.activityText = display.newText(data[id].name, 24, 24, "fonts/te", 24) -- выводит значение name и тешучей строки data.lua
    row.activityText.anchorX = 0 --выравнивает значение по левому краю, задает точку начала
    if(data[id].category == 1) then --если параметр категория для текущей строки дата равенг 1, то это название категории
      row.activityText:setFillColor(1) --используем белый цвет текста
    else
      row.activityText:setFillColor(0) --иначе черный
    end
    row:insert(row.activityText) --каждый проход цикла добовляем новый ряд
    return true --чтобы функция обрабатывалась корректно
  end

  function onRowTouch(event) -- задаем функцию которая принимает событие
    local row = event.row --ряд который поступил обработчику событий
    if(event.phase == "tap") then --событие отпустил палец с элемента
      activity_index = row.index --устанавливает в переменную номер текущего ряда
      activity_name = data[activity_index].name -- устанавливает в переменную значение name по текущему номеру
      activity_factor = data[activity_index].factor  --устанавливает в переменную значение factor по текущему номеру
      activityText.text = activity_name --устанавливает в переменную тектовые данные из activity_name
      composer.hideOverlay() --закрываем всплывающие окно
    end
  end

  local activityList = widget.newTableView { --создаем таблицу из widget
  top = 70, left = 40,
  width = 460, height = 850,
  onRowRender = onRowRender,  --слушает отрисовку новых строк, для вывода списка
  onRowTouch = onRowTouch  --отвечает за выбор элемента в списке
}

sceneGroup:insert(activityList)

for i = 1, #data do --от одного до всех элементов в файле дата
  if(data[i].category == 1) then isCategory = true --если элемент категория таблицы дата равна 1, то устанавливаем переменную тру
  else isCategory = false --если нет - фалс
  end
  if(isCategory == true) then --если категория тру
    rowColor = {default = {237/255, 103/255, 57/255}} --передаем переменной красный  цвет
  else
    rowColor = {default = {1}} --белый
  end
  activityList:insertRow { --добавляем новый ряд в активити лист
    rowHeight = 50, --высота
    isCategory = isCategory, --?
    rowColor = rowColor, --?
  }
end
if(activity_index > 1) then -- если activity_index больше 1, то
  activityList:scrollToY({y = -(activity_index - 2) * 50}) -- функция, которая будет проскроливать таблицу
end

close = display.newImage(sceneGroup, "img/corona_close.png", 500, 76)
close:addEventListener("touch", function(event)
	if(event.phase == "ended") then
		composer.hideOverlay("fade", 400)
	end
end
)
end

scene:addEventListener("create", scene )
return scene --возвращение сцены
