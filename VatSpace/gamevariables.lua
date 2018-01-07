local M = {}

M.money = 0
M.goal = 0
M.time = 0
M.level = 0
M.total_gold = 0
M.game_state = 'START'
-- GAME STATES
-- 'START' - initial value
-- 'IN_MENU'
-- 'PLAY' - run game command
-- 'PLAYING'
-- 'GAME_OVER'
-- 'MENU' - show start menu screen
-- 'RESTART' - restart game command

function M.setVariablesToStartValues()
    M.money = 1
    M.goal = 25000
    M.time = 60
    M.level = 1
    M.total_gold = 0
end

function  M.setVariablesForNextLevel()
    M.time = 60
    M.goal = M.goal * 1.2
    M.money = 0
    M.level = M.level + 1
end


return M