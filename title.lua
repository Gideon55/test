-----------------------------------------------------------------------------------------
--
-- title.lua
--
-----------------------------------------------------------------------------------------
local widget = require "widget";

local composer = require( "composer" )
local scene = composer.newScene()
local homePage = widget.newButton{
	onPress = goToHomePageEvent
}

local function goToHomePageEvent(self, event)
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "homePage", "slideLeft", 800 )
		
		return true	-- indicates successful touch
	end
end

local function backToMenu(self, event)
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "title", "slideRight" )
		
		return true	-- indicates successful touch
	end
end

local function goToAboutUs(self, event)
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "aboutUs", "slideLeft", 800 )
		
		return true	-- indicates successful touch
	end
end

local function goToStep1(self, event)
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "step1", "slideLeft", 800 )
		
		return true -- indicates successful touch
	end
end

local function goToStep2(self, event)
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "step2", "slideLeft", 800 )
		
		return true	-- indicates successful touch
	end
end

local function goToStep3(self, event)
	if event.phase == "ended" or event.phase == "cancelled" then
		composer.gotoScene( "step3", "slideLeft", 800 )
		
		return true	-- indicates successful touch
	end
end

local aboutUs = widget.newButton{}
local step1 = widget.newButton{}
local step2 = widget.newButton{}
local step3 = widget.newButton{}
--homePage:setLabel("HomePage")
--------------------------------------------

-- forward declaration
local background

-- Touch listener function for background object
local function onBackgroundTouch( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		-- go to homePage.lua scene
		composer.gotoScene( "homePage", "slideLeft", 800 )
		
		return true	-- indicates successful touch
	end
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	step3 = display.newText("Step 3", 150, 100, native.systemFont, 80)
        step3.anchorX = 0
	step3.anchorY = 0
	step3.x = 250
	step3.y = 300 --100

	step2 = display.newText("Step 2", 150, 100, native.systemFont, 80)
        step2.anchorX = 0
	step2.anchorY = 0
	step2.x = 250
	step2.y = 200 --100	

	step1 = display.newText("Step 1", 150, 100, native.systemFont, 80)
        step1.anchorX = 0
	step1.anchorY = 0
	step1.x = 250
	step1.y = 100 --100

	aboutUs = display.newText("About Us", 150, 100, native.systemFont, 80)
        aboutUs.anchorX = 0
	aboutUs.anchorY = 0
	aboutUs.x = 440
	aboutUs.y = 0 --100	

	homePage = display.newText("HomePage", 150, 100, native.systemFont, 80)
        homePage.anchorX = 0
	homePage.anchorY = 0
	homePage.x = 0
	homePage.y = 0	

	-- display a background image
	background = display.newImageRect( sceneGroup, "voting_informed_logo.png", 760, 200 )
	background.anchorX = 0
	background.anchorY = 201
	background.x, background.y = 0, 0
	
	-- Add more text
	local pageText = display.newText( "[ Touch a link to visit the respective webpages ]", 0, 0, native.systemFont, 18 )
	pageText.x = display.contentWidth * 0.5
	pageText.y = display.contentHeight - (display.contentHeight*0.1)	
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( pageText )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		
		background.touch = backToMenu
		background:addEventListener( "touch", background )
		
		homePage.touch = goToHomePageEvent
		homePage:addEventListener("touch", homePage)

		aboutUs.touch = goToAboutUs
		aboutUs:addEventListener("touch", aboutUs)

		step1.touch = goToStep1
		step1:addEventListener("touch", step1)

		step2.touch = goToStep2
		step2:addEventListener("touch", step2)

		step3.touch = goToStep3
		step3:addEventListener("touch", step3)
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
		homePage:removeEventListener("touch", homePage)
		aboutUs:removeEventListener( "touch", aboutUs )
		step1:removeEventListener("touch", step1)
		step2:removeEventListener("touch", step2)
		step3:removeEventListener("touch", step3)
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
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene

