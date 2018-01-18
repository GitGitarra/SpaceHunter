local widget = require( "widget" )
local gv = require( "gamevariables" )
local sounds = require( "sounds" )

local M = {}

M.progressView = nil
M.timeText = nil
M.moneyText = nil

local function createMoneyStatusBar()
    M.progressView = display.newImage("resources/graphics/statusbar.png", -20, 25)
    M.progressView.anchorX = 0
    M.progressView:scale(0.2, 0.2)
    M.progressView = display.newImage("resources/graphics/coin.png", -30, 25)
    M.progressView.anchorX = 0
    M.progressView:scale(0.35, 0.35)
    M.progressView = widget.newProgressView(
        {
            left = -5,
            top = 23,
            width = 103,
            isAnimated = true
        }
    )
    M.progressView:scale(1, 3)
    M.progressView:setProgress( 0 )
end

local function createGoalText()
    M.moneyText = {}
    M.moneyText[1] = display.newText( "Level: " .. gv.level, display.contentCenterX, 17, "Munro.ttf", 16 )
    M.moneyText[2] = display.newText( "Gain coins for 5000+ program", display.contentCenterX, 33, "Munro.ttf", 16 )
    M.timeText = display.newText( "0:60s", display.contentWidth, 25, "Munro.ttf", 16 )
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
        morawiecki_speech=nil
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
    local rect = display.newRect( nextLevelScreen, display.contentCenterX, display.contentCenterY, display.contentWidth + 100, display.contentHeight + 100)
    rect:setFillColor(0)
    rect.alpha = 0.7
    rect:addEventListener("touch", function() return true end)
    display.newText( nextLevelScreen, "Gold gathered, prepare for", display.contentCenterX, display.contentCenterY-70, "Munro.ttf", 30 )
    display.newText( nextLevelScreen, "level " .. gv.level .. "!", display.contentCenterX, display.contentCenterY-25, "Munro.ttf", 40 )
    display.newText( nextLevelScreen, "in...", display.contentCenterX, display.contentCenterY+15, "Munro.ttf", 30 )
    counterText = display.newText( nextLevelScreen, "5 seconds", display.contentCenterX, display.contentCenterY+50, "Munro.ttf", 30 )
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
    local rect = display.newRect( game_over_page_group, display.contentCenterX, display.contentCenterY, display.contentWidth + 100, display.contentHeight + 100)
    rect:setFillColor(0)
    -- rect.alpha = 0.7
    rect:addEventListener("touch", function() return true end)
    display.newText( game_over_page_group, "You loooose!", display.contentCenterX+100, display.contentCenterY-100, "Munro.ttf", 35 )
    display.newText( game_over_page_group, "Mr. Moravat is", display.contentCenterX+100, display.contentCenterY-50, "Munro.ttf", 35 )
    display.newText( game_over_page_group, "now really sad :(", display.contentCenterX+100, display.contentCenterY, "Munro.ttf", 35 )
    display.newText( game_over_page_group, "Gold gathered:", display.contentCenterX+100, display.contentCenterY+50, "Munro.ttf", 35 )
    display.newText( game_over_page_group, gv.total_gold, display.contentCenterX+100, display.contentCenterY+100, "Munro.ttf", 35 )
    local morawiecki = display.newImage(game_over_page_group, "resources/graphics/morawieckiPlacz2.png", -45, display.contentHeight)
    morawiecki.fill.effect = "filter.pixelate"
    morawiecki.fill.effect.numPixels = 8
    morawiecki.anchorX = 0
    morawiecki.anchorY = 1
    morawiecki:scale(0.35, 0.35)
    local function handleButtonEvent( event )
           if ( "ended" == event.phase ) then
             game_over_page_group:removeSelf()
             game_over_page_group = nil
             gv.game_state = 'RESTART'
           end
       end

    local function handleButtonEvent2( event )
        if ( "ended" == event.phase ) then
          game_over_page_group:removeSelf()
          game_over_page_group = nil
          gv.game_state = 'MENU'
        end
    end   
    local button1 = widget.newButton(
        {
            defaultFile = "resources/graphics/startbutton.png",
            overFile = "resources/graphics/startbutton_active.png",
            onEvent = handleButtonEvent
        }
    )
    local button2 = widget.newButton(
        {
            defaultFile = "resources/graphics/startbutton2.png",
            overFile = "resources/graphics/startbutton_active.png",
            onEvent = handleButtonEvent2
        }
    )
    game_over_page_group:insert(button1)
    button1.x = display.contentCenterX - 170
    button1.y = display.contentCenterY - 120
    button1:scale(0.3, 0.3)

    game_over_page_group:insert(button2)
    button2.x = display.contentCenterX - 170
    button2.y = display.contentCenterY - 70
    button2:scale(0.3, 0.3)

end

function M.showMenu()
    gv.game_state = 'IN_MENU'
    local menu_page_group = display.newGroup()
    local rect = display.newRect( menu_page_group, display.contentCenterX, display.contentCenterY, display.contentWidth + 100, display.contentHeight + 100)
    local gameName = display.newImage( menu_page_group, "resources/graphics/The-Vat-Hunter.png",display.contentCenterX, display.contentCenterY - 75)
    rect:setFillColor(0)
    local function handleButtonEvent( event )
           if ( "ended" == event.phase ) then
             menu_page_group:removeSelf()
             menu_page_group = nil
             gv.game_state = 'PLAY'
           end
       end
    local button1 = widget.newButton(
        {
            defaultFile = "resources/graphics/startbutton.png",
            overFile = "resources/graphics/startbutton_active.png",
            onEvent = handleButtonEvent
        }
    )
    menu_page_group:insert(button1)
    button1.x = display.contentCenterX
    button1.y = display.contentCenterY - 20
    button1:scale(0.4, 0.4)

    local function handleButtonEvent2( event )
        if ( "ended" == event.phase ) then
          menu_page_group:removeSelf()
          menu_page_group = nil
          gv.game_state = 'HELP'
        end
    end
    local button2 = widget.newButton(
        {
            defaultFile = "resources/graphics/startbutton2.png",
            overFile = "resources/graphics/startbutton_active.png",
            onEvent = handleButtonEvent2
        }
    )
    menu_page_group:insert(button2)
    button2.x = display.contentCenterX
    button2.y = display.contentCenterY + 50
    button2:scale(0.4, 0.4)

    local function handleButtonEvent3( event )
        if ( "ended" == event.phase ) then
          menu_page_group:removeSelf()
          menu_page_group = nil
          gv.game_state = 'CREDITS'
        end
    end
    local button3 = widget.newButton(
        {
            defaultFile = "resources/graphics/startbutton2.png",
            overFile = "resources/graphics/startbutton_active.png",
            onEvent = handleButtonEvent3
        }
    )
    menu_page_group:insert(button3)
    button3.x = display.contentCenterX
    button3.y = display.contentCenterY + 120
    button3:scale(0.4, 0.4)

end

function M.showHelp()
    gv.game_state = 'HELP'
    local help_page_group = display.newGroup()
    local rect = display.newRect(help_page_group, display.contentCenterX, display.contentCenterY, display.contentWidth + 100, display.contentHeight + 100)
    rect:setFillColor(0.3)
    local myText = display.newText( help_page_group, "HELP", display.contentCenterX, display.contentCenterY - 100, "Munro.ttf", 50 )
    
    local function handleButtonEvent(event)
        if ( "ended" == event.phase ) then
            help_page_group:removeSelf()
            help_page_group = nil
            gv.game_state = 'MENU'
          end
    end

      local button = widget.newButton(
          {
            defaultFile = "resources/graphics/startbutton2.png",
            overFile = "resources/graphics/startbutton_active.png",
            onEvent = handleButtonEvent 
          }
      )
      help_page_group:insert(button)
      button.x = display.contentCenterX
      button.y = display.contentCenterY + 100
      button:scale(0.3, 0.3)
end

function M.showCredits()
    gv.game_state = 'CREDITS'
    local credits_page_group = display.newGroup()
    local rect = display.newRect(credits_page_group, display.contentCenterX, display.contentCenterY, display.contentWidth + 100, display.contentHeight + 100)
    rect:setFillColor(0.5)
    local myText = display.newText( credits_page_group, "HELP", display.contentCenterX, display.contentCenterY - 100, "Munro.ttf", 50 )
    
    local function handleButtonEvent(event)
        if ( "ended" == event.phase ) then
            credits_page_group:removeSelf()
            credits_page_group = nil
            gv.game_state = 'MENU'
          end
    end

      local button = widget.newButton(
          {
            defaultFile = "resources/graphics/startbutton2.png",
            overFile = "resources/graphics/startbutton_active.png",
            onEvent = handleButtonEvent 
          }
      )
      credits_page_group:insert(button)
      button.x = display.contentCenterX
      button.y = display.contentCenterY + 100
      button:scale(0.3, 0.3)
end


function M.restartUI()
    M.progressView:setProgress( 0 )
    M.timeText.text = "0:60s"
    M.moneyText[1].text = "Level: 1"
end

function M.create()
    createGoalText()
    createMoneyStatusBar()
    createSpaceman()
end

return M