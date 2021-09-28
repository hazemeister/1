-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local physics = require ("physics")
physics.start()

local background = display.newRect(160, 250, 350, 550)
background:setFillColor(0.4,0.4,0.4)

local hx = 160
local hy = 0
for i=1, 27 do
  local myGrid = display.newRect(hx, hy, 350, 2)
  myGrid:setFillColor(0.5,0.5,0.5)
  hy = hy + 20
end

local vx = 20
local vy = 250
for i=1, 16 do
  local myGrid = display.newRect(vx, vy, 2, 550)
  myGrid:setFillColor(0.5,0.5,0.5)
  vx = vx + 20
end

local block_1 = display.newRect(280, 390, 40, 280)
local block_2 = display.newRect(280, 50, 40, 150)

local block_3 = display.newRect(400, 430, 40, 280)
local block_4 = display.newRect(400, 70, 40, 190)

local block_5 = display.newRect(520, 470, 40, 280)
local block_6 = display.newRect(520, 100, 40, 250)

local block_7 = display.newRect(640, 510, 40, 280)
local block_8 = display.newRect(640, 120, 40, 290)

local bird = display.newRect(40, 200, 20, 20)
bird:setFillColor(0.5, 0.7, 0.9)

physics.addBody(bird)
bird.gravityScale = 0
bird.isFixedRotation = false
bird.isSensor = true

physics.addBody(block_1, "static")
physics.addBody(block_2, "static")
physics.addBody(block_3, "static")
physics.addBody(block_4, "static")
physics.addBody(block_5, "static")
physics.addBody(block_6, "static")
physics.addBody(block_7, "static")
physics.addBody(block_8, "static")

bird.ID = "Bird"
block_1.ID = "Crash"
block_2.ID = "Crash"
block_3.ID = "Crash"
block_4.ID = "Crash"
block_5.ID = "Crash"
block_6.ID = "Crash"
block_7.ID = "Crash"
block_8.ID = "Crash"

local moveDown = 4
local moveUp = 0
local function flapBird (event)
  if(event.phase == "began") then
    moveUp = 13
  end
end

local speed = 1
local function onUpdate (event)
  block_1.x = block_1.x - speed
  block_2.x = block_1.x - speed

  block_3.x = block_3.x - speed
  block_4.x = block_3.x - speed

  block_5.x = block_5.x - speed
  block_6.x = block_5.x - speed

  block_7.x = block_7.x - speed
  block_8.x = block_7.x - speed

  if(block_1.x <= -20) then
    block_1.x = block_7.x + 120
  elseif(block_3.x <= -20) then
    block_3.x = block_1.x + 120
  elseif(block_5.x <= -20) then
    block_5.x = block_3.x + 120
  elseif(block_7.x <= -20) then
    block_7.x = block_5.x + 120
  end
  if(moveUp > 0) then
    bird.y = bird.y - moveUp
    moveUp = moveUp - 0.8
  end
  bird.y = bird.y + moveDown

  if(bird.y < 0) then
    endGame()
  elseif(bird.y > 520) then
    endGame()
  end
end

local function onLocalCollision (self, event)
  if(event.phase == "began") then
    if(self.ID == "Bird" and event.other.ID == "Crash") then
      endGame()
    end
  end
end

function endGame ()
  bird:removeEventListener("collision", bird)
  Runtime:removeEventListener("enterFrame", onUpdate)
  background:removeEventListener("touch", flapBird)
  local text = display.newText("У тебя рука в говне", 160, 100, font, 32)
  text:setFillColor(0,0,0)
end

bird.collision = onLocalCollision
bird:addEventListener("collision", bird)

Runtime:addEventListener("enterFrame", onUpdate)
background:addEventListener("touch", flapBird)
