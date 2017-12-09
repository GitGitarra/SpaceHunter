-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local widget = require( "widget" )

asteroids = {}
money = 1
goal = 50000
time = 60
local coin_sound = audio.loadSound( "coin-drop-1.wav" )
local end_game_sound = audio.loadSound( "endgame_sound.wav" )
local fail_click = audio.loadSound( "beep17.wav" )

local function createCoin(x, y)
    local coin = display.newImage("coin.png", x, y)
    coin:scale(0.2, 0.2)
    timer.performWithDelay(35, function(event)
        coin.y = coin.y - 1
        if event.count == 10 then
            coin:removeSelf()
            coin=nil
        end
    end, 10)
end

local function tapAsteroid(event)
    if ( event.phase == "ended" ) then
        asteroid = event.target
        if asteroid.moneyAmount > 0 then
            asteroid.moneyAmount = asteroid.moneyAmount - 1
            money = money + 1000
            audio.play(coin_sound)
            createCoin(asteroid.x, asteroid.y - 25)
            progressView:setProgress( money/goal )
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
    asteroid.y = math.random(50, display.contentHeight-60)
end

local function moveAsteroid(asteroid)
    asteroid.x = asteroid.x - asteroid.speed
end

local function createCoinAsteroids()
    local asteroidsImages = {"asteroid1factory.png", "asteroid2factory.png", "asteroid3factory.png"}

    for i=#asteroids,#asteroids+5 do
        asteroid = display.newImage( asteroidsImages[math.random(#asteroidsImages)] )
        asteroid.speed = 0
        asteroid.moneyAmount = 0
        randomizeFieldsFor(asteroid)
        scaleRandom = math.random(10, 16) / 100
        asteroid:scale(scaleRandom, scaleRandom)
        asteroid.fill.effect = "filter.pixelate"
        asteroid.fill.effect.numPixels = 20
        asteroid:addEventListener( "touch", tapAsteroid )
        asteroids[i] = asteroid
    end
end

local function createAsteroids()
    local asteroidsImages = {"asteroid1.png", "asteroid2.png", "asteroid3.png", "asteroid4.png"}

    for i=1,20 do
        asteroid = display.newImage( asteroidsImages[math.random(#asteroidsImages)] )   
        asteroid.speed = 0
        asteroid.moneyAmount = 0
        randomizeFieldsFor(asteroid)
        scaleRandom = math.random(8, 14) / 100
        asteroid:scale(scaleRandom, scaleRandom)
        asteroid.fill.effect = "filter.pixelate"
        asteroid.fill.effect.numPixels = 20
        asteroids[i] = asteroid
    end
end

local function createBackground()
    local sheetOptions =
    {
        width = 500,
        height = 281,
        numFrames = 18
    }
    local space_background = graphics.newImageSheet( "space.png", sheetOptions )
    local sequences_spaceStars = {
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

local function createMoneyStatusBar()
    progressView = display.newImage("statusbar.png", -20, 25)
    progressView.anchorX = 0
    progressView:scale(0.2, 0.2)
    progressView = display.newImage("coin.png", -30, 25)
    progressView.anchorX = 0
    progressView:scale(0.35, 0.35)
    progressView = widget.newProgressView(
        {
            left = -5,
            top = 23,
            width = 103,
            isAnimated = true
        }
    )
    progressView:scale(1, 3)
    progressView:setProgress( 0 )
    -- progressView
end

local function createGoalText()
    moneyText = display.newText( "Gain coins for 5000+ goverment program", 130, 25, "Munro.ttf", 16 )
    moneyText.anchorX = 0
    timeText = display.newText( "0:60s", display.contentWidth, 25, "Munro.ttf", 16 )
    -- timeText.anchorX = 1
end

local function startTimer()
    timer.performWithDelay(1000, function(event)
        time = time - 1
        if time < 10 then
            timeText.text = "0:0" .. tostring(time) .. "s"            
        else
            timeText.text = "0:" .. tostring(time) .. "s" 
        end
    end, 60)
end

local function nextLevel()
    time = 60
    goal = goal * 1.2
    money = 0
    startTimer()
end

local function gameLoss()
    return false
end

local function checkGameStatus()
    if time <= 0 then
        gameLoss()
    elseif money >= goal then
        nextLevel()
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
    checkGameStatus()
end

local function speech()
    local sheetOptions =
    {
        width = 621,
        height = 180,
        numFrames = 23
    }
    speech_bubble = graphics.newImageSheet("speech1.png", sheetOptions)
    local sequences_speech = {
        {
            name = "bubble1",
            start = 1,
            count = 23,
            time = 2000,
            loopCount = 1,
            loopDirection = "forward"
        }
    }
    local morawiecki_speech = display.newSprite(speech_bubble, sequences_speech)
        morawiecki_speech.x = 100
        morawiecki_speech.y = 160
        morawiecki_speech:scale(0.35, 0.35)
        morawiecki_speech:play()
        timer.performWithDelay(2500, function(event)
        morawiecki_speech:removeSelf()
        morawiecki_speech=nil
    end, 1)
end

local function spaceman()
    morawiecki = display.newImage("morawiecki.png", 10, 250)
    morawiecki:scale(0.1, 0.1)
    morawiecki.fill.effect = "filter.pixelate"
    morawiecki.fill.effect.numPixels = 15
    morawiecki:addEventListener("touch", speech)
end

local function startGame()
    createBackground()
    createAsteroids()
    createCoinAsteroids()
    createGoalText()
    createMoneyStatusBar()
    spaceman()
    startTimer()
end

local function run()
    startGame()
    Runtime:addEventListener( "enterFrame", mainListener )
end

run()

