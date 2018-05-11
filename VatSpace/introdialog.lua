local M = {}

function M.playDialog()
    local sheetOptions =
    {
        width = 972,
        height = 180,
        numFrames = 37
    }
    local speech_bubble = graphics.newImageSheet("resources/graphics/dialog1.png", sheetOptions)
    local sequences_speech = {
        {
            name = "bubble1",
            start = 1,
            count = 37,
            time = 3000,
            loopCount = 1,
            loopDirection = "forward"
        }
    }
    dialog1 = display.newSprite(speech_bubble, sequences_speech)
    dialog1.x = 150
    dialog1.y = 150
    dialog1:scale(0.25, 0.25)
    dialog1:play()
    timer.performWithDelay(4500, function(event)
    dialog1:removeSelf()
    dialog1 = nil
    end, 1)
end

return M