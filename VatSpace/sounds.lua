local coin_sound = audio.loadSound( "coin-drop-1.wav" )
local end_game_sound = audio.loadSound( "endgame_sound.wav" )
local fail_click = audio.loadSound( "beep17.wav" )
local function tapListener( event )
       audio.play(fail_click)
       -- Code executed when the button is tapped
       print( "Object tapped: " .. tostring(event.target) )  -- "event.target" is the tapped object
       return true
end

local myButton = display.newRect( 100, 100, 200, 50 )
myButton:addEventListener( "tap", tapListener )
