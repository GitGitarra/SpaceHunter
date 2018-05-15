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
            name = "bubble2",
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
            name = "bubble4",
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

local function dialog5()
        local sheetOptions = { width = 738, height = 324, numFrames = 77 }
            local speech_bubble = graphics.newImageSheet("resources/graphics/dialog5.png", sheetOptions)
            local sequences_speech = {
                {
                    name = "bubble5",
                    start = 1,
                    count = 77,
                    time = 3000,
                    loopCount = 1,
                    loopDirection = "forward"
                }
            }
            dialog5 = display.newSprite(speech_bubble, sequences_speech)
            dialog5.x = 250
            dialog5.y = 60
            dialog5:scale(0.25, 0.25)
            dialog5:play()
            
            timer.performWithDelay(4500, function(event)
                dialog5:removeSelf()
                dialog5 = nil
            end, 1)
end

local function dialog6()
            local sheetOptions = { width = 639, height = 180, numFrames = 23 }
                local speech_bubble = graphics.newImageSheet("resources/graphics/dialog6.png", sheetOptions)
                local sequences_speech = {
                    {
                        name = "bubble6",
                        start = 1,
                        count = 23,
                        time = 3000,
                        loopCount = 1,
                        loopDirection = "forward"
                    }
                }
                dialog6 = display.newSprite(speech_bubble, sequences_speech)
                dialog6.x = 250
                dialog6.y = 60
                dialog6:scale(0.25, 0.25)
                dialog6:play()
                
                timer.performWithDelay(4500, function(event)
                    dialog6:removeSelf()
                    dialog6 = nil
                end, 1)
end

local function dialog7()
    local sheetOptions = { width = 621, height = 180, numFrames = 20 }
    local speech_bubble = graphics.newImageSheet("resources/graphics/dialog7.png", sheetOptions)
    local sequences_speech = {
        {
            name = "bubble7",
            start = 1,
            count = 20,
            time = 3000,
            loopCount = 1,
            loopDirection = "forward",
            onEvent = bubbleListner
        }
    }
    local dialog7 = display.newSprite(speech_bubble, sequences_speech)
    dialog7.x = 160
    dialog7.y = 150
    dialog7:scale(0.25, 0.25)
    dialog7:play()

    timer.performWithDelay(4500, function(event)
        dialog7:removeSelf()
        dialog7 = nil
    end, 1)
end

local function dialog8()
    local sheetOptions = { width = 891, height = 225, numFrames = 59 }
    local speech_bubble = graphics.newImageSheet("resources/graphics/dialog8.png", sheetOptions)
    local sequences_speech = {
        {
            name = "bubble8",
            start = 1,
            count = 59,
            time = 3000,
            loopCount = 1,
            loopDirection = "forward",
            onEvent = bubbleListner
        }
    }
    local dialog8 = display.newSprite(speech_bubble, sequences_speech)
    dialog8.x = 160
    dialog8.y = 150
    dialog8:scale(0.25, 0.25)
    dialog8:play()

    timer.performWithDelay(4500, function(event)
        dialog8:removeSelf()
        dialog8 = nil
    end, 1)
end

local function dialog9()
    local sheetOptions = { width = 801, height = 180, numFrames = 27 }
        local speech_bubble = graphics.newImageSheet("resources/graphics/dialog9.png", sheetOptions)
        local sequences_speech = {
            {
                name = "bubble9",
                start = 1,
                count = 27,
                time = 3000,
                loopCount = 1,
                loopDirection = "forward"
            }
        }
        dialog9 = display.newSprite(speech_bubble, sequences_speech)
        dialog9.x = 250
        dialog9.y = 60
        dialog9:scale(0.25, 0.25)
        dialog9:play()
        
        timer.performWithDelay(4500, function(event)
            dialog9:removeSelf()
            dialog9 = nil
        end, 1)
end

local function dialog10()
    local sheetOptions = { width = 594, height = 225, numFrames = 37 }
    local speech_bubble = graphics.newImageSheet("resources/graphics/dialog10.png", sheetOptions)
    local sequences_speech = {
        {
            name = "bubble10",
            start = 1,
            count = 37,
            time = 3000,
            loopCount = 1,
            loopDirection = "forward",
            onEvent = bubbleListner
        }
    }
    local dialog10 = display.newSprite(speech_bubble, sequences_speech)
    dialog10.x = 160
    dialog10.y = 150
    dialog10:scale(0.25, 0.25)
    dialog10:play()

    timer.performWithDelay(4500, function(event)
        dialog10:removeSelf()
        dialog10 = nil
    end, 1)
end

function M.playDialog()
    timer.performWithDelay( 2000, dialog1)
    timer.performWithDelay(7000, dialog2)
    timer.performWithDelay(11000, dialog3)
    timer.performWithDelay(15000, dialog4)
    timer.performWithDelay(19000, dialog5)
    timer.performWithDelay(24000, dialog6)
    timer.performWithDelay(28000, dialog7)
    timer.performWithDelay(33000, dialog8)
    timer.performWithDelay(38000, dialog9)
    timer.performWithDelay(43000, dialog10)
end

return M