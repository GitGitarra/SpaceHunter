local M = {}

local coin_sound = audio.loadSound( "resources/sounds/coin-drop-1.wav" )
local fail_click = audio.loadSound( "resources/sounds/beep17.wav" )
local cat_meow = audio.loadSound("resources/sounds/cat.wav" )
local click_sound = audio.loadSound("resources/sounds/click.wav" )

-- local menu_music = audio.loadStream( "resources/sounds/menu2.wav" )
local menu_music = audio.loadStream( "resources/sounds/menu.mp3" )
local background_music = audio.loadStream( "resources/sounds/background.mp3" )
local game_over_music = audio.loadStream( "resources/sounds/game_over.mp3" )


audio.reserveChannels( 1 ) -- menu
audio.reserveChannels( 2 ) -- inGame
audio.reserveChannels( 3 ) -- gameOver

audio.setVolume( 0.3, { channel=1 } )
audio.setVolume( 0.3, { channel=2 } )
audio.setVolume( 0.3, { channel=3 } )

function M.playCoinSound()
    audio.play(coin_sound)
end

function M.playEndGameSound()
    audio.play(end_game_sound)
end

function M.playFailClickSound()
    audio.play(fail_click)
end

function M.playCatMeow()
    audio.play(cat_meow)
end

function M.playClickSound()
    audio.play(click_sound)
end

function M.playMenuMusic()
    audio.stop( 1 )
    audio.play( menu_music, { channel=2, loops=-1, fadein = 3000, } )
end

function M.playBackgroundMusic()
    audio.stop( 2 )
    audio.play( background_music, { channel=1, loops=-1, fadein = 5000, } )
end

function M.playGameOverMusic()
    audio.stop( 1 )
    audio.play( game_over_music, { channel=1 } )
end

return M
