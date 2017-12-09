-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
asteroids = {}
money = 0
moneyText = display.newText( 0, 0, 15, native.systemFont, 16 )
moneyText.anchorX = 0
local coin_sound = audio.loadSound( "coin-drop-1.wav" )
local end_game_sound = audio.loadSound( "endgame_sound.wav" )
local fail_click = audio.loadSound( "beep17.wav" )

local function tapAsteroid(event)
    if ( event.phase == "ended" ) then
        asteroid = event.target
        if asteroid.moneyAmount > 0 then
            asteroid.moneyAmount = asteroid.moneyAmount - 1
            money = money + 1000
            moneyText.text = money
            audio.play(coin_sound)
        else
            audio.play(fail_click)
        end
    end
    return true
end

local function randomizeFieldsFor(asteroid)
    asteroid.speed = math.random() + math.random(2, 5)
    asteroid.moneyAmount = math.random(1, 5)
    asteroid.x = math.random(display.contentWidth + 50, display.contentWidth + 200)
    asteroid.y = math.random(20, display.contentHeight-50)
end

local function moveAsteroid(asteroid)
    asteroid.x = asteroid.x - asteroid.speed
end

local function createAsteroids()
    for i=1,10 do
        asteroid = display.newImage( "green.png")
        asteroid.speed = 0
        asteroid.moneyAmount = 0
        randomizeFieldsFor(asteroid)
        asteroid:scale(2, 2)
        asteroid:addEventListener( "touch", tapAsteroid )
        asteroids[i] = asteroid
    end
end

local function mainListener( event )
    for i=1,#asteroids do
        a = asteroids[i]
        moveAsteroid(a)
        if a.x < -50 then
            randomizeFieldsFor(a)
        end
    end
end


-- Your code here

local function createBackground()

    local sheetOptions =
    {
        width = 500,
        height = 281,
        numFrames = 18
    }
    local space_background = graphics.newImageSheet( "space.png", sheetOptions )

    -- sequences table
    local sequences_spaceStars = {
        -- consecutive frames sequence
        {
            name = "background",
            start = 1,
            count = 18,
            time = 2000,
            loopCount = 0,
            loopDirection = "bounce"
        }
    }

    local spaceStars = display.newSprite( space_background, sequences_spaceStars )

    spaceStars:scale(2.5,2.5)
    spaceStars:play()
end

local function run()
    createBackground()
    createAsteroids()
    Runtime:addEventListener( "enterFrame", mainListener )
end

run()
