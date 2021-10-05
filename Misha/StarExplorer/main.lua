-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local physics = require("physics")
physics.start()
physics.setGravity(0, 0)

--Generator sluch 4isel
math.randomseed(os.time())

--config listov izobrajeniy
local sheetOptions =
{
    frames = {

    { -- asteroid 1
                x = 0,
                y = 0,
                width = 102,
                height = 85
    },
    {
        --asteroid 2
        x = 0,
        y = 85,
        width = 90,
        height = 83
    },
    {
        --asteroid 3
        x = 0,
        y = 168,
        width = 100,
        height = 97
    },
    {
        --ship
        x = 0,
        y = 265,
        width = 98,
        height = 79
    },
    {
        --laser
        x = 98,
        y = 265,
        width = 14,
        height = 40
    },
  },
}
local objectSheet = graphics.newImageSheet( "gameObjects.png", sheetOptions)

--inicializaciya peremennih
local lives = 3
local score = 0
local died = false
local asteroidsTable = {}

local ship
local gameLoopTimer
local livesText
local scoreText

--gruppi otobrajeniya
local backGroup = display.newGroup()    -- gruppa fona
local mainGroup = display.newGroup()    --gruppa asteroidov lasera i koroblya
local uiGroup = display.newGroup()      --gruppa tekstovoy informacii
-- zagruzka fona
local background = display.newImageRect( backGroup, "background.png", 800, 1400)
background.x = display.contentCenterX
background.y = display.contentCenterY

ship = display.newImageRect(mainGroup, objectSheet, 4, 98, 79)
ship.x = display.contentCenterX
ship.y = display.contentHeight - 100
physics.addBody(ship, {radius=30, isSensor=true})
ship.myName = "ship"
--s4et jizney i o4kov
livesText = display.newText(uiGroup, "Lives: " .. lives,200,80, native.systemFont, 36)
scoreText = display.newText(uiGroup, "Score: " .. score,400,80, native.systemFont, 36)

local function updateText()
    livesText.text = "Lives: " .. lives
    scoreText.text = "Score: " .. score
end

--asteroidi
local function createAsteroid()
  local newAsteroid = display.newImageRect(mainGroup, objectSheet, 1, 99, 135)
  table.insert(asteroidTable, newAsteroid)
  physics.addBody(newAsteroid, "dynamic", {radius=45, bounce=0.8})
  newAsteroid.myName = "asteroid"

    local whereFrom = math.random( 3 )
    if (whereFrom == 1) then
            --sleva
        newAsteroid.x = -60
        newAsteroid.y = math.random(500)
        newAsteroid:setLinearVelocity(math.random(40,120), math.random (20,60))
    elseif ( whereFrom == 2 ) then
        -- From the top
        newAsteroid.x = math.random( display.contentWidth )
        newAsteroid.y = -60
        newAsteroid:setLinearVelocity( math.random( -40,40 ), math.random( 40,120 ) )
    elseif ( whereFrom == 3 ) then
        -- From the right
        newAsteroid.x = display.contentWidth + 60
        newAsteroid.y = math.random( 500 )
        newAsteroid:setLinearVelocity( math.random( -120,-40 ), math.random( 20,60 ) )
    end
        newAsteroid:applyTorque(math.random(-6,6))
end

--laser
local function fireLaser()
    local newLaser = display.newImageRect(mainGroup, objectSheet, 5, 14, 40)
    physics.addBody(newLaser, "dynamic", {isSensor=true})
    newLaser.isBullet = true
    newLaser.myName = "laser"
    newLaser.x = ship.x
    newLaser.y = ship.y
    newLaser:toBack()
    transition.to (newLaser, {y=-40, time=500,
            onComplete = function() display.remove (newLaser) end})
end
ship:addEventListener("tap", fireLaser)

--peretyagivaniye koroblya
local function dragShip (event)
    local ship = event.target
    local phase = event.phase
    if ("began" == phase) then
        --pri kasanii focus na korable
        display.currentStage:setFocus (ship)
        ship.touchOffsetX = event.x - ship.x

    elseif ("moved" == phase) then
        --peremeshenie korablya
        ship.x = event.x - ship.touchOffsetX
    elseif ("ended" == phase or "cancelled" == phase) then
        --otmena ksaniya
        display.currentStage:setFocus (nil)
    end
    return true -- komanda kasaniya imenno na etom obyekte
end
ship:addEventListener("touch", dragShip)

--igrovoy cikl
local function gameLoop()
    --vizov asteroidov
    createAsteroid()
    --udalenie astroidov
    for i = #asteroidsTable, 1, -1 do
        local thisAsteroid = asteroidsTable[i]

        if (thisAsteroid.x < -100 or
            thisAsteroid.x > display.contentWidth +100 or
            thisAsteroid.y < -100 or
            thisAsteroid.y > display.contentHeight +100)
            then
                display.remove(thisAsteroid)
                table.remov(asteroidsTable, i)
            end
    end
end
--timer igri
gameLoopTimer = timer.performWithDelay(500, gameLoop, 0)

local function restoreShip()
    ship.isBodyActive = false
    ship.x = display.contentCenterX
    ship.y = display.contentHeight -100

    transition.to(ship, {alpha=1, time = 4000,
            onComplete = function()
                ship.isBodyActive = true
                died = false
            end})
        end

        --funkciuya stolknoveniya
local function onCollision (event)
    if (event.phase == "began") then
        local obj1 = event.object1
        local obj2 = event.object2

        if ((obj1.myName == "laser" and obj2.myName == "asteroid") or
                (obj1.myName == "asteroid" and obj2.myName == "laser"))
                then
                    --udalenie lasera i asteroida
                    display.remove(obj1)
                    display.remove(obj2)

                    for i = #asteroidsTable, 1, -1 do
                        if (asteroidsTable[i] == obj1 or asteroidsTable[i] == obj2) then
                            table.remove(asteroidsTable, i)
                            break
                        end
                end
                --uvelichenie scheta
                score = score + 100
                scoreText.text = "Score: " .. score

            elseif ( ( obj1.myName == "ship" and obj2.myName == "asteroid" ) or
            ( obj1.myName == "asteroid" and obj2.myName == "ship" ) )
             then
                if (died == false) then
                    died = true
                    --obnovlenie jizney
                    lives = lives -1
                    livesText.text = "lives: " .. lives

                    if (lives == 0) then
                        display.remove (ship)
                    else
                        ship.alpha = 0
                        timer.performWithDelay(1000, restoreShip)
                    end
                end
            end
    end
end

Runtime:addEventListener("collision", onCollision)
