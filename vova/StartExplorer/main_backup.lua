-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local physics = require("physics")
physics.start()
physics.setGravity(0,0)

-- Установка генератора случайный чисел
math.randomseed(os.time())

-- Конфигурация листа изображений
local sheetOptions =
{
  frames = {

      {
          -- 1stone
          x=0,
          y=0,
          width=125,
          height=115,

          sourceX = 4,
          sourceY = 0,
          sourceWidth = 135,
          sourceHeight = 135
      },
      {
          -- 2stone
          x=0,
          y=115,
          width=123,
          height=130,

      },
      {
          -- 3stone
          x=0,
          y=245,
          width=123,
          height=130,

      },
      {
          -- beam
          x=0,
          y=375,
          width=126,
          height=121,

      },
      {
          -- ship
          x=0,
          y=496,
          width=128,
          height=128,

      },
  },
  sheetContentWidth = 128,
  sheetContentHeight = 624
}
local objectSheet = graphics.newImageSheet("12.png", sheetOptions)

-- Определение переменных
local lives = 3
local score = 0
local died = false

local asteroidTable = {}

local ship
local gameLoopTimer
local livesText
local scoreText

--error test
-- Установка групп отображения
local backGroup = display.newGroup() -- Группа отображения для задников
local mainGroup = display.newGroup() -- Группа отображения основных объектов
local uiGroup = display.newGroup() -- Группа отображения для интерфейса

-- Установка заднего фона
local background = display.newImageRect(backGroup, "background.png", 800, 1400)
background.x = display.contentCenterX
background.y = display.contentCenterY

-- Установка корабля
ship = display.newImageRect(mainGroup, objectSheet, 5, 128, 128)
ship.x = display.contentCenterX
ship.y = display.contentHeight - 100
physics.addBody(ship, {radius=30, isSensor=true})
ship.myName="ship"

-- Отображение жизень и очков
livesText = display.newText(uiGroup, "Жизни: " .. lives, 240, 80, native.systemFont, 36)
scoreText = display.newText(uiGroup, "Счет: " .. score, 400, 80, native.systemFont, 36)

-- Функция для обновления переменных liveText и scoreText
local function updateText()
  livesText.text = "Жизни: " .. lives
  scoreText.text = "Счет: " .. score
end

-- Функция для генерации астероидов
local function createAsteroid()
  local newAsteroid = display.newImageRect(mainGroup, objectSheet, 1, 125, 115)
  table.insert(asteroidTable, newAsteroid)
  physics.addBody(newAsteroid, "dynamic", {radius=45, bounce=0.8})
  newAsteroid.myName = "asteroid"
-- Функция спавна астероидов
  local whereFrom = math.random(3)

  if(whereFrom == 1) then
    -- Слева
      newAsteroid.x = -60
      newAsteroid.y = math.random(500)
      newAsteroid:setLinearVelocity(math.random(40,120), math.random(20,60))
  elseif(whereFrom == 2) then
    -- Сверху
      newAsteroid.x = math.random(display.contentWidth)
      newAsteroid.y = -60
      newAsteroid:setLinearVelocity(math.random(-40,40), math.random(40,120))
  elseif(whereFrom == 3) then
    -- Справа
      newAsteroid.x = display.contentWidth + 60
      newAsteroid.y = math.random(500)
      newAsteroid:setLinearVelocity(math.random(-120,-40), math.random(20,60))
  end
  -- Вращение
  newAsteroid:applyTorque(math.random(-6,6))
end

-- Функция лазера
local function fireLaser()
  local newLaser = display.newImageRect(mainGroup, objectSheet, 4, 126, 121)
  physics.addBody(newLaser, "dynamic", {isSensor=true})
  newLaser.isBullet = true
  newLaser.myName = "laser"
  newLaser.rotation = 270
  newLaser.x = ship.x
  newLaser.y = ship.y
  newLaser:toBack()

  transition.to(newLaser, {y=-40, time=500,
    onComplete = function() display.remove(newLaser) end
    })
end

-- Вызов функции стрельбы
ship:addEventListener("tap", fireLaser)

-- Функция перемещения корабля
local function dragShip (event)
  local ship = event.target
  local phase = event.phase
  -- Установка действия по фазам события касания
  if ("began" == phase) then
    -- Установка фокуса касания на корабле
    display.currentStage:setFocus(ship)
    -- Сохраняем начальную позицию смещения
    ship.touchOffsetX = event.x - ship.x
  elseif ("moved" == phase) then
    -- Переместить корабль в место нового касания
    ship.x = event.x - ship.touchOffsetX
  elseif ("ended" == phase or "cancelled" == phase) then
    --Освобождает фокус касания с корабля
    display.currentStage:setFocus(nil)
  end
  return true -- Предотвращает касания нежелательных объектов, важно если много объектов
end

ship:addEventListener("touch", dragShip) -- При косании вызывает функцию перетаскивания корабля

-- Функция игрового цикла
local function gameLoop()
  --Создание нового астероида
  createAsteroid()

  --Удаление астероидов, улетевших за край экрана
  for i = #asteroidTable, 1, -1 do
    local thisAsteroid = asteroidTable[i] -- для каждой итерации обновляем ссылку на конкретный астероид
    -- Набор условий, когда астероид вышел за пределы экрана
    if (thisAsteroid.x < -100 or
        thisAsteroid.x > display.contentWidth + 100 or
        thisAsteroid.y < -100 or
        thisAsteroid.y > display.contentHeight +100)
    then
        display.remove(thisAsteroid)  -- Удаление астероида с экрана
        table.remove(asteroidTable, i) -- Удаление астероида из таблицы
    end
  end
end

gameLoopTimer = timer.performWithDelay(500, gameLoop, 0)

-- Функция восстановление корабля
local function restoreShip()
  ship.isBodyActive = false --Отключает симуляцию физики для корабля
  ship.x = display.contentCenterX
  ship.y = display.contentHeight - 100

  --Мерцание корабля
  transition.to(ship, {alpha=1, time=4000, --Становится непрозрачным через 4с
      onComplete = function()
        ship.isBodyActive = true --Возвращение физики для корабля
        died = false --Отмена смерти после возрожения
      end
    })
end

local function onCollision(event)

  if (event.phase == "began") then

    local obj1 = event.object1
    local obj2 = event.object2

    if (( obj1.myName == "laser" and obj2.myName == "asteroid") or
        ( obj1.myName == "asteroid" and obj2.myName == "laser"))
    then
      -- Удаляет столкнувшиеся астероид и лазер
      display.remove(obj1)
      display.remove(obj2)

      for i = #asteroidTable, 1, -1 do
        if (asteroidTable[i] == obj1 or asteroidTable[i] == obj2) then
          table.remove (asteroidTable, i)
          break
        end
      end
      -- Увеличивает очки
      score = score + 1
      scoreText.text = "Счет: " .. score

    elseif ((obj1.myName == "ship" and obj2.myName == "asteroid") or
            (obj1.myName == "asteroid" and obj2.myName == "ship"))
    then
      if (died == false) then
        died = true

        -- Уменьщает жизни при смерти
        lives = lives - 1
        livesText.text = "Жизни: " .. lives
        -- Проверка оставшихся жизней
        if (lives == 0) then
          display.remove(ship)
        else
          ship.alpha = 0
          timer.performWithDelay(1000, restoreShip)
        end
      end
    end
  end
end

Runtime:addEventListener("collision", onCollision) -- запуск функции при событии collision

-- Скрыть статус бар
display.setStatusBar(display.HiddenStatusBar)
