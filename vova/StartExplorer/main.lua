local composer = require("composer")

--Скрыть статус бар
display.setStatusBar(display.HiddenStatusBar)

--Генератор рандомных чисел
math.randomseed(os.time())

--Переход в меню
composer.gotoScene("menu")
