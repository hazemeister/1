local composer = require "composer" -- загрузка модуля для сцен

weightMin = 40
weightMax = 140
weight = 60

ageMin  = 18
ageMax = 98
age = ageMin

rostMin = 100
rostMax = 200
rost = rostMin

timeMin = 1
timeMax = 120
time = timeMin

sex = "мужской" --создаем глобальную переменную пол

display.setStatusBar(display.HiddenStatusBar) --скрыть статус бар
display.setDefault("background", 37/255, 39/255, 46/255) -- устанвока цвета фона
display.setDefault("fillColor", 76/255) --установка цвета для текста и других элментов
w = display.contentWidth - 20 -- задаем переменную w которая на 20 меньше ширины экрана

activity_name = "Ходьба 4 км/ч"
activity_factor = 3
activity_index = 147

composer.gotoScene("scenes.calc") -- иницируем переход к сцене calc (ТОЧКА вместо /)
