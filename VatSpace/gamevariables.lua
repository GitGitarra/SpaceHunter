local M = {}

M.loadsave = require("loadsave")
gpgs = require( "plugin.gpgs" )

local licensing = require( "licensing" )
licensing.init( "google" )

local gpgsData = M.loadsave.loadTable( "gpgsData.json" )
local gameSettings = M.loadsave.loadTable( "gameSettings.json" )

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
-- 'HELP' - show help paage
-- 'CREDITS' - show credits page
-- 'TRY_AGAIN' - restart game command

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

function M.submitScore()
    if ( gpgs ) then
        gpgs.leaderboards.submit( {leaderboardId = "" , score = M.money } )
    end
end

function M.showLeaderboards()
    if ( gpgs ) then
        gpgs.leaderboards.show( "" )
    end
end

function M.initGooglePlayServices()
    if ( gpgsData  == nil ) then
      gpgsData  = {}
      gpgsData.userPref = "logged out" 
      gpgsData.firstTime = true
      gpgsData.firstCheck = true
      M.loadsave.saveTable( gpgsData, "gpgsData.json" )
    end

    if ( gameSettings  == nil ) then
      gameSettings  = {}
      gameSettings.googLicensed = false
      M.loadsave.saveTable( gameSettings, "gameSettings.json" )
    end

    local function gpgsLoginListener( event )
      gpgsData.userPref = event.phase
      M.loadsave.saveTable( gpgsData, "gpgsData.json" )    
    end

    local function gpgsInitListener( event )
      if not event.isError then
        if (gpgsData.firstTime == true ) then
          gpgs.login( { userInitiated = true, listener = gpgsLoginListener } )
          gpgsData.firstTime = false
          M.loadsave.saveTable( gpgsData, "gpgsData.json" )
        else
          if (gpgsData.userPref == "logged in" ) then
            gpgs.login( { listener = gpgsLoginListener } )         
          end
        end
      end
    end

    local function licensingListener( event )

      if not ( event.isVerified ) then
        gameSettings.googLicensed = false
        M.loadsave.saveTable( gameSettings, "gameSettings.json" )

        if (gpgs.isConnected()) then
          gpgs.logout()
          gpgsData.userPref = "logged out"
          M.loadsave.saveTable( gpgsData, "gpgsData.json" )
        end

      else
        gameSettings.googLicensed = true
        M.loadsave.saveTable( gameSettings, "gameSettings.json" )
        gpgs.init( gpgsInitListener )
      end
    end

    if (gameSettings.googLicensed == false or gameSettings.googLicensed == nil) then
      licensing.verify( licensingListener )  
    else
      gpgs.init( gpgsInitListener )
    end
end


return M