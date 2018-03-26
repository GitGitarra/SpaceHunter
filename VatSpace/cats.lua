-- cat module
local sounds = require("sounds")
local ui = require("ui")
local gv = require("gamevariables")

local M = {}

M.cat = nil

local function moveCat(cat)
    cat.x = cat.x - cat.speed
end

local function showExtraTime(x, y)
    local time = display.newText("+10s", x, y, "munro.ttf", 15)
    timer.performWithDelay(35, function(event)
        time.y = time.y - 1
        if event.count == 10 then
            time:removeSelf()
            time = nil
        end
    end, 10)
end

local function addExtraTime()
    local extraTime = 10
    if (gv.time + extraTime >= 60 ) then
        gv.time = 60
    else
        gv.time = gv.time + 10
    end
end

local function tapCatInSpace(event)
    if (event.phase == "ended") then
        cat = event.target
        if (cat.hasTime) then
            sounds.playCatMeow()
            showExtraTime(cat.x + 10, cat.y - 25)
            addExtraTime()
            cat.hasTime = false
        end
    end
    return true
end

local function createCatInSpace()
    cat = display.newImage("resources/graphics/cat.png")
    scaleRandom = math.random(1, 1.5)
    cat:scale(scaleRandom, scaleRandom)
    cat.speed = math.random() + math.random(2, 5)
    cat.hasTime = true
    cat.isVisible = math.random(1, 3) > 2 and true or false
    cat.x = math.random(display.contentWidth + 50, display.contentWidth + 350)
    cat.y = math.random(50, display.contentHeight - 60)
    cat:addEventListener("touch", tapCatInSpace)
    M.cat = cat
end

function M.move()
    ui.staticElementsToFront()
    a = M.cat
    moveCat(a)
    if a.x < -50 then
        M.destroy()
        createCatInSpace()
    end
end

function M.create(g)
    createCatInSpace()
end

function M.destroy()
    M.cat:removeSelf()
    M.cat = nil
end

return M
