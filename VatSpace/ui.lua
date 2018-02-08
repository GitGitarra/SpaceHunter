local widget = require("widget")
local gv = require("gamevariables")
local sounds = require("sounds")
local background = require( "background" )

local M = {}

M.progressView = nil
M.timeText = nil
M.moneyText = nil

local function createMoneyStatusBar()
    M.progressView = display.newImage("resources/graphics/statusbar.png", -20, 25)
    M.progressView.anchorX = 0
    M.progressView:scale(0.2, 0.2)
    M.progressView = display.newImage("resources/graphics/coin.png", -33, 25)
    M.progressView.anchorX = 0
    M.progressView:scale(0.5, 0.5)
    M.progressView = widget.newProgressView(
        {
            left = -5,
            top = 23,
            width = 103,
            isAnimated = true
        }
    )
    M.progressView:scale(1, 3)
    M.progressView:setProgress(0)
end

local function createGoalText()
    M.moneyText = {}
    M.moneyText[1] = display.newText("Level: " .. gv.level, display.contentCenterX, 17, "Munro.ttf", 16)
    M.moneyText[2] = display.newText("Gain coins for 5000+ program", display.contentCenterX, 33, "Munro.ttf", 16)
    M.timeText = display.newText("0:60s", display.contentWidth, 25, "Munro.ttf", 16)
end

local function createSpeechForSpaceman()
    local sheetOptions =
        {
            width = 621,
            height = 180,
            numFrames = 23
        }
    local speech_bubble = graphics.newImageSheet("resources/graphics/speech1.png", sheetOptions)
    local sequences_speech = {
        {
            name = "bubble1",
            start = 1,
            count = 23,
            time = 2000,
            loopCount = 1,
            loopDirection = "forward"
        }
    }
    local morawiecki_speech = display.newSprite(speech_bubble, sequences_speech)
    morawiecki_speech.x = 100
    morawiecki_speech.y = 160
    morawiecki_speech:scale(0.35, 0.35)
    morawiecki_speech:play()
    timer.performWithDelay(2500, function(event)
        morawiecki_speech:removeSelf()
        morawiecki_speech = nil
    end, 1)
end

local function createSpaceman()
    local morawiecki = display.newImage("resources/graphics/morawiecki.png", 10, 250)
    morawiecki:scale(0.1, 0.1)
    morawiecki.fill.effect = "filter.pixelate"
    morawiecki.fill.effect.numPixels = 15
    morawiecki:addEventListener("touch", createSpeechForSpaceman)
end

function M.showNextLevelScreen()
    nextLevelScreen = display.newGroup()
    local rect = display.newRect(nextLevelScreen, display.contentCenterX, display.contentCenterY, display.contentWidth + 100, display.contentHeight + 100)
    rect:setFillColor(0)
    rect.alpha = 0.7
    rect:addEventListener("touch", function() return true end)
    display.newText(nextLevelScreen, "Gold gathered, prepare for", display.contentCenterX, display.contentCenterY - 70, "Munro.ttf", 30)
    display.newText(nextLevelScreen, "level " .. gv.level .. "!", display.contentCenterX, display.contentCenterY - 25, "Munro.ttf", 40)
    display.newText(nextLevelScreen, "in...", display.contentCenterX, display.contentCenterY + 15, "Munro.ttf", 30)
    counterText = display.newText(nextLevelScreen, "5 seconds", display.contentCenterX, display.contentCenterY + 50, "Munro.ttf", 30)
    timer.performWithDelay(1000, function(event)
        counterText.text = tostring(5 - event.count) .. " seconds"
        if event.count >= 5 then
            nextLevelScreen:removeSelf()
            nextLevelScreen = nil
        end
    end, 5)
end

function M.showGameOverScreen()
    gv.game_state = 'IN_MENU'
    sounds.playEndGameSound()
    local game_over_page_group = display.newGroup()
    local rect = display.newRect(game_over_page_group, display.contentCenterX, display.contentCenterY, display.contentWidth + 100, display.contentHeight + 100)
    rect:setFillColor(0)
    -- rect.alpha = 0.7
    rect:addEventListener("touch", function() return true end)
    display.newText(game_over_page_group, "You loooose!", display.contentCenterX + 100, display.contentCenterY - 100, "Munro.ttf", 35)
    display.newText(game_over_page_group, "Mr. Moravat is", display.contentCenterX + 100, display.contentCenterY - 50, "Munro.ttf", 35)
    display.newText(game_over_page_group, "now really sad :(", display.contentCenterX + 100, display.contentCenterY, "Munro.ttf", 35)
    display.newText(game_over_page_group, "Gold gathered:", display.contentCenterX + 100, display.contentCenterY + 50, "Munro.ttf", 35)
    display.newText(game_over_page_group, gv.total_gold, display.contentCenterX + 100, display.contentCenterY + 100, "Munro.ttf", 35)
    local morawiecki = display.newImage(game_over_page_group, "resources/graphics/morawieckiPlacz2.png", -45, display.contentHeight)
    morawiecki.fill.effect = "filter.pixelate"
    morawiecki.fill.effect.numPixels = 8
    morawiecki.anchorX = 0
    morawiecki.anchorY = 1
    morawiecki:scale(0.35, 0.35)
    local function handleButtonEvent(event)
        if ("ended" == event.phase and event.target.id == "restart") then
            game_over_page_group:removeSelf()
            game_over_page_group = nil
            gv.game_state = 'RESTART'
        elseif ("ended" == event.phase and event.target.id == "menu") then
            game_over_page_group:removeSelf()
            game_over_page_group = nil
            gv.game_state = 'MENU'
        end
    end
    
    local button_restart = widget.newButton(
        {
            defaultFile = "resources/graphics/btn_try_again.png",
            overFile = "resources/graphics/btn_try_again_onclick.png",
            id = "restart",
            onEvent = handleButtonEvent
        }
    )
    local button_back_to_menu = widget.newButton(
        {
            defaultFile = "resources/graphics/btn_menu.png",
            overFile = "resources/graphics/btn_menu_onclick.png",
            id = "menu",
            onEvent = handleButtonEvent
        }
    )
    game_over_page_group:insert(button_restart)
    button_restart.x = display.contentCenterX - 170
    button_restart.y = display.contentCenterY - 120
    button_restart:scale(1, 1)
    
    game_over_page_group:insert(button_back_to_menu)
    button_back_to_menu.x = display.contentCenterX - 170
    button_back_to_menu.y = display.contentCenterY - 70
    button_back_to_menu:scale(1, 1)

end

function M.showMenu()
    gv.game_state = 'IN_MENU'
    background.create()
    local menu_page_group = display.newGroup()
    local menuFrame = display.newImage(menu_page_group, "resources/graphics/menu_window_frame.png", 
    display.contentCenterX, display.contentCenterY - 1)    
    menuFrame:scale(1.2,1.2)
    local function handleButtonEvent(event)
        if ("ended" == event.phase and event.target.id == "play") then
            menu_page_group:removeSelf()
            menu_page_group = nil
            gv.game_state = 'PLAY'
        elseif ("ended" == event.phase and event.target.id == "help") then
            menu_page_group:removeSelf()
            menu_page_group = nil
            gv.game_state = 'HELP'
        elseif ("ended" == event.phase and event.target.id == "credits") then
            menu_page_group:removeSelf()
            menu_page_group = nil
            gv.game_state = 'CREDITS'
        end
    end
    local button_play = widget.newButton(
        {
            defaultFile = "resources/graphics/btn_play.png",
            overFile = "resources/graphics/btn_play_onclick.png",
            id = "play",
            onEvent = handleButtonEvent
        }
    )
    menu_page_group:insert(button_play)
    button_play.x = display.contentCenterX
    button_play.y = display.contentCenterY - 32
    button_play:scale(1.2, 1.2)
    
    local button_help = widget.newButton(
        {
            defaultFile = "resources/graphics/btn_help.png",
            overFile = "resources/graphics/btn_help_onclick.png",
            id = "help",
            onEvent = handleButtonEvent
        }
    )
    menu_page_group:insert(button_help)
    button_help.x = display.contentCenterX
    button_help.y = display.contentCenterY + 5
    button_help:scale(1.2, 1.2)
    
    local button_credits = widget.newButton(
        {
            defaultFile = "resources/graphics/btn_credits.png",
            overFile = "resources/graphics/btn_credits_onclick.png",
            id = "credits",
            onEvent = handleButtonEvent
        }
    )
    menu_page_group:insert(button_credits)
    button_credits.x = display.contentCenterX
    button_credits.y = display.contentCenterY + 42
    button_credits:scale(1.2, 1.2)

end

function M.showHelp()
    gv.game_state = 'IN_MENU'
    background.create()
    local help_page_group = display.newGroup()
    local helpFrame = display.newImage(help_page_group, "resources/graphics/help__window_frame.png", 
                                       display.contentCenterX, display.contentCenterY - 3)    
    helpFrame:scale(1.2,1.2)
    local options = 
    {
        text = "To help Matt collect VAT tap ......... as long as they giving you money."..
                        " Avoid  .......  they are tax free and you will loose money."..
                         " This   .....   is here to help you, catch him to get extra time.".. 
                         " To reach next level you need collect enough money to fill progress bar before your time runs out.",    
        x = display.contentCenterX,
        y = display.contentCenterY + 10,
        width = 300,
        font = "Munro.ttf",   
        fontSize = 17,
        align = "center"
    }
    local helpText = display.newText( options )
    helpText:setFillColor(0.156, 0.133, 0.156)
    help_page_group:insert(helpText)

    local cat = display.newImage(help_page_group, "resources/graphics/cat.png",
                                display.contentCenterX - 100, display.contentCenterY + 10)
    cat:scale(0.7,0.7)
    
    local asteroid = display.newImage(help_page_group, "resources/graphics/factory_in_text.png",
    display.contentCenterX + 60, display.contentCenterY - 45)

    local church = display.newImage(help_page_group, "resources/graphics/church_in_text.png",
    display.contentCenterX + 85, display.contentCenterY - 30)

    local function handleButtonEvent(event)
        if ("ended" == event.phase) then
            background.destroy()
            help_page_group:removeSelf()
            help_page_group = nil
            gv.game_state = 'MENU'
        end
    end
    
    local button_back_to_menu = widget.newButton(
        {
            defaultFile = "resources/graphics/help_window_btn.png",
            overFile = "resources/graphics/help_window_btn_onclick.png",
            onEvent = handleButtonEvent
        }
    )
    help_page_group:insert(button_back_to_menu)
    button_back_to_menu.x = display.contentCenterX + 4
    button_back_to_menu.y = display.contentCenterY + 102
    button_back_to_menu:scale(1.2, 1.2)
end

function M.showCredits()
    gv.game_state = 'IN_MENU'
    background.create()
    local credits_page_group = display.newGroup()
    local creditsFrame = display.newImage(credits_page_group, "resources/graphics/credits_window_frame.png", 
                                            display.contentCenterX, display.contentCenterY - 3)    
    creditsFrame:scale(1.2,1.2)
    local text1 = display.newText(credits_page_group, "Design and Development", display.contentCenterX, display.contentCenterY - 60, "munro_small.ttf", 15)
    local text2 = display.newText(credits_page_group, "Stefan Kania   Monika Płocica", display.contentCenterX, display.contentCenterY - 40, "munro.ttf", 16)
    local text3 = display.newText(credits_page_group, "Graphic Designer", display.contentCenterX, display.contentCenterY - 20, "munro_small.ttf", 15)
    local text4 = display.newText(credits_page_group, "Olga Płocica", display.contentCenterX, display.contentCenterY, "munro.ttf", 16)
    local text5 = display.newText(credits_page_group, "Sounds and Music", display.contentCenterX, display.contentCenterY + 20, "munro_small.ttf", 15)
    local text6 = display.newText(credits_page_group, "licencje i takie tam", display.contentCenterX, display.contentCenterY + 40, "munro.ttf", 15)
    local text7 = display.newText(credits_page_group, "COTA GAMES", display.contentCenterX, display.contentCenterY + 65, "munro_small.ttf", 15)
    local text8 = display.newText(credits_page_group, "All rights reserved", display.contentCenterX, display.contentCenterY + 77, "munro.ttf", 10)
    text1:setFillColor(0.156, 0.133, 0.156)
    text2:setFillColor(0.156, 0.133, 0.156)
    text3:setFillColor(0.156, 0.133, 0.156)
    text4:setFillColor(0.156, 0.133, 0.156)
    text5:setFillColor(0.156, 0.133, 0.156)
    text6:setFillColor(0.156, 0.133, 0.156)
    text7:setFillColor(0.156, 0.133, 0.156)
    text8:setFillColor(0.156, 0.133, 0.156)
    
    local function handleButtonEvent(event)
        if ("ended" == event.phase) then
            background.destroy()
            credits_page_group:removeSelf()
            credits_page_group = nil
            gv.game_state = 'MENU'
        end
    end
    
    local button_back_to_menu = widget.newButton(
        {
            defaultFile = "resources/graphics/help_window_btn.png",
            overFile = "resources/graphics/help_window_btn_onclick.png",
            onEvent = handleButtonEvent
        }
    )
    credits_page_group:insert(button_back_to_menu)
    button_back_to_menu.x = display.contentCenterX + 4
    button_back_to_menu.y = display.contentCenterY + 102
    button_back_to_menu:scale(1.2, 1.2)
end


function M.restartUI()
    M.progressView:setProgress(0)
    M.timeText.text = "0:60s"
    M.moneyText[1].text = "Level: 1"
end

function M.create()
    createGoalText()
    createMoneyStatusBar()
    createSpaceman()
end

return M
