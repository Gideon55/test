-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"

-- load title screen
composer.gotoScene( "title", "fade" )

function scene:create( event )

end

function scene:show( event )

end

function scene:hide( event )
	if webView and webView.removeSelf then
            		webView:removeSelf()
            		webView = nil
		end
end

function scene:destroy( event )

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene