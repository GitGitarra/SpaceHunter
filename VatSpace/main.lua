-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
asteroids = {}
money = 0 
moneyText = display.newText( 0, 0, 15, native.systemFont, 16 )
moneyText.anchorX = 0

local function tapAsteroid(event)
    if ( event.phase == "ended" ) then
        money = money + 1000
        moneyText.text = money
    end
    return true
end

local function randomizeFieldsFor(asteroid)
    asteroid.speed = math.random() + math.random(2, 5)
    asteroid.moneyAmount = math.random(1, 5)
    asteroid.body.x = math.random(display.contentWidth + 50, display.contentWidth + 200)
    asteroid.body.y = math.random(20, display.contentHeight-50)
end

local function moveAsteroid(asteroid)
    asteroid.body.x = asteroid.body.x - asteroid.speed    
end

local function createAsteroids()
    for i=1,10 do
        asteroid = { 
            body = display.newImage( "green.png"),        
            speed = 0,
            moneyAmount = 0
        }
        randomizeFieldsFor(asteroid)
        asteroid.body:scale(2, 2)
        asteroid.body:addEventListener( "touch", tapAsteroid )        
        asteroids[i] = asteroid
    end
end

local function mainListener( event )
    for i=1,#asteroids do
        a = asteroids[i]
        moveAsteroid(a)
        if a.body.x < -50 then
            randomizeFieldsFor(a)
        end
    end
end

local function run()
    createAsteroids()
    Runtime:addEventListener( "enterFrame", mainListener )
end

run()