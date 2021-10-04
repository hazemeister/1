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

    local newAsteroid = display.newImageRect(mainGroup, objectSheet, 1, 102, 85)
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