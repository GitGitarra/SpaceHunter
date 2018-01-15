-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local widget = require( "widget" )
local background = require( "background" )
local asteroids = require( "asteroids" )
local ui = require( "ui" )
local gv = require( "gamevariables" )
display.setStatusBar( display.HiddenStatusBar )

local gameTimer = nil

local function startTimer()
    gameTimer = timer.performWithDelay(1000, function(event)
        gv.time = gv.time - 1
        if gv.time < 10 then
            ui.timeText.text = "0:0" .. tostring(gv.time) .. "s"            
        else
            ui.timeText.text = "0:" .. tostring(gv.time) .. "s" 
        end
    end, gv.time)
end

local function stopTimer()
    if gameTimer then 
        timer.cancel(gameTimer)
        gameTimer = nil
    end
end

local function restartGameForNextLevel()
    if gameTimer then
        stopTimer()        
        gv.setVariablesForNextLevel()
        ui.moneyText[1].text = "Level: " .. gv.level
        ui.progressView:setProgress( gv.money/gv.goal )
        ui.showNextLevelScreen()
        timer.performWithDelay(5000, function(event)
            startTimer() 
        end, 1)
    end
end

local function gameOver()
    gv.game_state = 'GAME_OVER'
    stopTimer()
    asteroids.destroy()
    ui.showGameOverScreen()
end

local function restartGame()
    gv.setVariablesToStartValues()
    asteroids.create()
    ui.restartUI()
    startTimer()
    gv.game_state = 'PLAYING'
end

local function startGame()
    gv.setVariablesToStartValues()
    background.create()
    asteroids.create()
    ui.create()
    startTimer()
    gv.game_state = 'PLAYING'
end

local function mainListener( event )
    if gv.game_state == 'PLAY' then
        startGame()
    elseif gv.game_state == 'RESTART' then
        restartGame()
    elseif gv.game_state == 'MENU' then
        ui.showMenu()
    elseif gv.game_state == 'HELP' then
        ui.showHelp()
    elseif gv.time <= 0 and gv.game_state == 'PLAYING' then
        gameOver()
    elseif gv.money >= gv.goal and gv.game_state == 'PLAYING' then
        restartGameForNextLevel()  
    elseif gameTimer and gv.game_state == 'PLAYING' then
        asteroids.move()
    end
end

local function run()
    gv.game_state = 'MENU'
    Runtime:addEventListener( "enterFrame", mainListener )    
end

run()

