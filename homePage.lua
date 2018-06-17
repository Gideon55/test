-- homepage.lua
local widget = require "widget";
local composer = require( "composer" )
local scene = composer.newScene()
local webView
local function displayWebPage()
	webView = native.newWebView( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	webView:request( "index.html", system.ResourceDirectory )
end

local background = widget.newButton{
	onPress = backToMenu
}

local function backToMenu(self, event)
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "title", "slideRight" )
		
		return true	-- indicates successful touch
	end
end


function scene:create( event )
	local sceneGroup = self.view
	-- display a background image
	background = display.newImageRect( sceneGroup, "voting_informed_logo.png", 760, 200 )	
	background.anchorX = 0
	background.anchorY = 201
	background.x, background.y = 0, 0
	sceneGroup:insert( background )
	--print("Step 1 created")
	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	--print("Step 1 shown")
	--
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
		displayWebPage()
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		
		background.touch = backToMenu
		background:addEventListener( "touch", background )
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)

		-- remove event listener from background

		background:removeEventListener( "touch", background )
		if webView and webView.removeSelf then
            		webView:removeSelf()
            		webView = nil
		end
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene