local composer = require("composer")

--Скрыть статус бар
display.setStatusBar(display.HiddenStatusBar)

--Генератор рандомных чисел
math.randomseed(os.time())

--Резервирование канала 1 для фоновой музыки
audio.reserveChannels(1)

--Уменьщает громкость музыки на канале
audio.setVolume(0.1, {channel=1})

--Переход в меню
composer.gotoScene("menu")
