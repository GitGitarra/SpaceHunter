-- asteroids module
local coins = require( "coins" )
local sounds = require( "sounds" )
local ui = require( "ui" )
local gv = require( "gamevariables" )

local M = {}

M.asteroids = {}

local function moveAsteroid(asteroid)
    asteroid.x = asteroid.x - asteroid.speed
end

local function tapAsteroid(event)
    if ( event.phase == "ended" ) then
        asteroid = event.target
        if asteroid.moneyAmount > 0 then
            asteroid.moneyAmount = asteroid.moneyAmount - 1
            gv.money = gv.money + 1000
            gv.total_gold = gv.total_gold + 1000
            sounds.playCoinSound()
            coins.create(asteroid.x, asteroid.y - 25)
            ui.progressView:setProgress( gv.money/gv.goal )
        else
            sounds.playFailClickSound()
        end
    end
    return true
end

local function tapSaintAsteroid(event)
    if ( event.phase == "ended" ) then
        if gv.money >= 1 then
            gv.money = gv.money - 1000
        end
            sounds.playFailClickSound()
            ui.progressView:setProgress( gv.money/gv.goal )
    end
    return true
end

local function randomizeFieldsFor(asteroid)
    asteroid.speed = math.random() + math.random(2, 5)
    asteroid.moneyAmount = math.random(1, 5)
    asteroid.x = math.random(display.contentWidth + 50, display.contentWidth + 350)
    asteroid.y = math.random(50, display.contentHeight-60)
end

local function createCoinAsteroids()
    local asteroidsImages = {
        "resources/graphics/asteroid1factory.png", 
        "resources/graphics/asteroid2factory.png",
        "resources/graphics/asteroid3factory.png"}

    for i=#M.asteroids,#M.asteroids+5 do
        asteroid = display.newImage( asteroidsImages[math.random(#asteroidsImages)] )
        asteroid.speed = 0
        asteroid.moneyAmount = 0
        randomizeFieldsFor(asteroid)
        scaleRandom = math.random(10, 16) / 100
        asteroid:scale(scaleRandom, scaleRandom)
        asteroid.fill.effect = "filter.pixelate"
        asteroid.fill.effect.numPixels = 20
        asteroid:addEventListener( "touch", tapAsteroid )
        M.asteroids[i] = asteroid
    end
end

local function createSaintAsteroids()
    for i=#M.asteroids,#M.asteroids+2 do
        church_asteroid = display.newImage( "resources/graphics/church1.png" )
        church_asteroid.speed = 0
        church_asteroid.moneyAmount = 0
        randomizeFieldsFor(church_asteroid)
        scaleRandom = math.random(15, 25) / 100
        church_asteroid:scale(scaleRandom, scaleRandom)
        church_asteroid.fill.effect = "filter.pixelate"
        church_asteroid.fill.effect.numPixels = 15
        church_asteroid:addEventListener( "touch", tapSaintAsteroid )
        M.asteroids[i] =church_asteroid
    end
end

local function createAsteroids()
    local asteroidsImages = {
        "resources/graphics/asteroid1.png", 
        "resources/graphics/asteroid2.png", 
        "resources/graphics/asteroid3.png", 
        "resources/graphics/asteroid4.png"}

    for i=1,20 do
        asteroid = display.newImage( asteroidsImages[math.random(#asteroidsImages)] )   
        asteroid.speed = 0
        asteroid.moneyAmount = 0
        randomizeFieldsFor(asteroid)
        scaleRandom = math.random(8, 14) / 100
        asteroid:scale(scaleRandom, scaleRandom)
        asteroid.fill.effect = "filter.pixelate"
        asteroid.fill.effect.numPixels = 20
        M.asteroids[i] = asteroid
    end
end

function M.move()
    for i=1,#M.asteroids do
        a = M.asteroids[i]
        moveAsteroid(a)
        if a.x < -50 then
            randomizeFieldsFor(a)
        end
    end
end

function M.create(g)
    createAsteroids()
    createCoinAsteroids()
    createSaintAsteroids()
end

function M.destroy()
    for i=1,#M.asteroids do
        M.asteroids[i]:removeSelf()
        M.asteroids[i] = nil
    end
end

return M