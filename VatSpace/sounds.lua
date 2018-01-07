local M = {}

local coin_sound = audio.loadSound( "resources/sounds/coin-drop-1.wav" )
local end_game_sound = audio.loadSound( "resources/sounds/endgame_sound.wav" )
local fail_click = audio.loadSound( "resources/sounds/beep17.wav" )

function M.playCoinSound()
    audio.play(coin_sound)
end

function M.playEndGameSound()
    audio.play(end_game_sound)
end

function M.playFailClickSound()
    audio.play(fail_click)
end

return M
