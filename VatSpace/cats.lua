-- cats module
local sounds = require( "sounds" )
local ui = require( "ui" )
local gv = require( "gamevariables" )

local M = {}

M.cats = {}

local function moveCat(cat)
    cat.x = cat.x - cat.speed
end


local function tapCatInSpace(event)
    if ( event.phase == "ended" ) then
        if (event.target.hasTime) then
            gv.time = gv.time + 10
            event.target.hasTime = false
        end
    end
    return true
end

local function randomizeFieldsFor(cat)
    cat.speed = math.random() + math.random(2, 5)
    cat.moneyAmount = math.random(1, 5)
    cat.hasTime = true
    cat.x = math.random(display.contentWidth + 50, display.contentWidth + 350)
    cat.y = math.random(50, display.contentHeight-60)
end

local function createCatInSpace()
    for i=1,1 do
        cat = display.newImage("resources/graphics/cat.png")
        cat.speed = 10
        cat.hasTime = true
        scaleRandom = math.random(1, 1.5)
        cat:scale(scaleRandom, scaleRandom)
        cat.x = math.random(display.contentWidth + 50, display.contentWidth + 350)
        cat.y = math.random(50, display.contentHeight-60)
        cat:addEventListener( "touch", tapCatInSpace )
        cat.id = "cat"
        M.cats[i] = cat
    end
end

function M.move()
    for i=1,#M.cats do
        a = M.cats[i]
        moveCat(a)
        if a.x < -50 then
            randomizeFieldsFor(a)
        end
    end
end

function M.create(g)
    createCatInSpace()
end

function M.destroy()
    for i=1,#M.cats do
        M.cats[i]:removeSelf()
        M.cats[i] = nil
    end
end

return M
