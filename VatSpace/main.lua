-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
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