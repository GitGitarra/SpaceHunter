local M = {}

local function dialog1()
    local sheetOptions = { width = 972, height = 180, numFrames = 37 }
    local speech_bubble = graphics.newImageSheet("resources/graphics/dialog1.png", sheetOptions)
    local sequences_speech = {
        {
            name = "bubble1",
            start = 1,
            count = 37,
            time = 3000,
            loopCount = 1,
            loopDirection = "forward",
            onEvent = bubbleListner
        }
    }
    local dialog1 = display.newSprite(speech_bubble, sequences_speech)
    dialog1.x = 160
    dialog1.y = 150
    dialog1:scale(0.25, 0.25)
    dialog1:play()

    timer.performWithDelay(4500, function(event)
        dialog1:removeSelf()
        dialog1 = nil
    end, 1)
end

local function dialog2()
    local sheetOptions = { width = 954, height = 225, numFrames = 54 }
    local speech_bubble = graphics.newImageSheet("resources/graphics/dialog2.png", sheetOptions)
    local sequences_speech = {
        {
            name = "bubble1",
            start = 1,
            count = 54,
            time = 3000,
            loopCount = 1,
            loopDirection = "forward"
        }
    }
    dialog2 = display.newSprite(speech_bubble, sequences_speech)
    dialog2.x = 160
    dialog2.y = 150
    dialog2:scale(0.25, 0.25)
    dialog2:play()
    
    timer.performWithDelay(4500, function(event)
        dialog2:removeSelf()
        dialog2 = nil
    end, 1)
end

local function dialog3()
local sheetOptions = { width = 927, height = 225, numFrames = 53 }
    local speech_bubble = graphics.newImageSheet("resources/graphics/dialog3.png", sheetOptions)
    local sequences_speech = {
        {
            name = "bubble3",
            start = 1,
            count = 53,
            time = 3000,
            loopCount = 1,
            loopDirection = "forward"
        }
    }
    dialog3 = display.newSprite(speech_bubble, sequences_speech)
    dialog3.x = 250
    dialog3.y = 60
    dialog3:scale(0.25, 0.25)
    dialog3:play()
    
    timer.performWithDelay(4500, function(event)
        dialog3:removeSelf()
        dialog3 = nil
    end, 1)
end

local function dialog4()
    local sheetOptions = { width = 927, height = 180, numFrames = 32 }
    local speech_bubble = graphics.newImageSheet("resources/graphics/dialog4.png", sheetOptions)
    local sequences_speech = {
        {
            name = "bubble1",
            start = 1,
            count = 32,
            time = 3000,
            loopCount = 1,
            loopDirection = "forward",
            onEvent = bubbleListner
        }
    }
    local dialog4 = display.newSprite(speech_bubble, sequences_speech)
    dialog4.x = 160
    dialog4.y = 150
    dialog4:scale(0.25, 0.25)
    dialog4:play()

    timer.performWithDelay(4500, function(event)
        dialog4:removeSelf()
        dialog4 = nil
    end, 1)
end

function M.playDialog()
    timer.performWithDelay( 2000, dialog1)
    timer.performWithDelay(7000, dialog2)
    timer.performWithDelay(11000, dialog3)
    timer.performWithDelay(15000, dialog4)
end

return M