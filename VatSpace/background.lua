local M = {}

M.background = nil

function M.create()
    local sheetOptions =
    {
        width = 500,
        height = 281,
        numFrames = 18
    }
    local space_background = graphics.newImageSheet( "resources/graphics/space_bg.png", sheetOptions )
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
    M.background = display.newSprite( space_background, sequences_spaceStars )
    M.background.x = display.contentCenterX
    M.background.y = display.contentCenterY
    M.background:scale(1.15,1.15)
    M.background:play()
end

function M.destroy()
    M.background:removeSelf()
    M.background = nil
end

return M