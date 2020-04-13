pancake =  require "pancake"
function love.load()
	love.graphics.setBackgroundColor(0.1,0.1,0.1,1) --So it won't merge with pancake's background!!!
	pancake.init({window = {pixelSize = love.graphics.getHeight()/96, width = 96, height = 96}}) --Initiating pancake and setting pixelSize, so that the pancake display will be the height of the window! pixelSize is how many pixels every pancake pixel should take
	pancake.loadAnimation = nil
	pancake.paused = false
	--pancake.debugMode = true
	loadAssets()
	loadLevel(1)
	pancake.background.image = pancake.images.background
	left = pancake.addButton({key = "a", name="left",x = 1*pancake.window.pixelSize, y = love.graphics.getHeight()-16*pancake.window.pixelSize, width = 14, height = 14, scale = pancake.window.pixelSize})
	right = pancake.addButton({key = "d", name="right",x = 17*pancake.window.pixelSize, y = love.graphics.getHeight()-16*pancake.window.pixelSize, width = 14, height = 14, scale = pancake.window.pixelSize})
	up = pancake.addButton({key = "w", name="up",x = love.graphics.getWidth()-15*pancake.window.pixelSize, y = love.graphics.getHeight()-16*pancake.window.pixelSize, width = 14, height = 14, scale = pancake.window.pixelSize})
	down = pancake.addButton({key = "s", name="down",x = love.graphics.getWidth()-31*pancake.window.pixelSize, y = love.graphics.getHeight()-16*pancake.window.pixelSize, width = 14, height = 14, scale = pancake.window.pixelSize})
	center = pancake.addButton({func = centerPressed, key = "j", name="center",x = love.graphics.getWidth()-15*pancake.window.pixelSize, y = love.graphics.getHeight()-31*pancake.window.pixelSize, width = 14, height = 14, scale = pancake.window.pixelSize})
end

function loadLevel(level)
	if level == 1 then
		loadShipLevel()
		pancake.addObject({image = "earth", x = 1020, y = 43, width = 1, height = 1, layer = 2})
		pancake.paused = true
		text = 0
	end
end

function loadAssets()
	--Adding buttons
	pancake.addImage("right", "images/ui")
	pancake.addImage("right_clicked", "images/ui")
	pancake.addImage("left", "images/ui")
	pancake.addImage("left_clicked", "images/ui")
	pancake.addImage("up", "images/ui")
	pancake.addImage("up_clicked", "images/ui")
	pancake.addImage("down", "images/ui")
	pancake.addImage("down_clicked", "images/ui")
	pancake.addImage("center", "images/ui")
	pancake.addImage("center_clicked", "images/ui")
	--Adding background (it will be more detailed later xD)
	pancake.addImage("background", "images")
	--Adding asteroids
	pancake.addImage("asteroid1", "images")
	pancake.addImage("asteroid2", "images")
	--Adding everything else
	pancake.addImage("laser", "images")
	pancake.addImage("fuel", "images")
	pancake.addImage("fuel_ui", "images")
	pancake.addImage("earth", "images")
	pancake.addImage("pizza", "images")
	--sounds
	pancake.addSound("laser")
	pancake.addSound("success")
end

function loadShipLevel(level)--level is a number of the level. This function loads everything that is needed for the ship levels
	pancake.objects = {}
	pancake.timers = {}
	pancake.physics.gravityY = 0
	ship = pancake.applyPhysics(pancake.addObject({name = "ship", x = 0, y = 64, width = 14, height = 7, offsetX = -1, offsetY = -4}))
	pancake.addAnimation("ship","idle","images/animations",180)
	pancake.addAnimation("ship","crash","images/animations",250)
	pancake.changeAnimation(ship,"idle")
	levelType = "ship"-- This variable indicates what type of level are we in!
	pancake.cameraFollow = ship
	ship.maxVelocity = 100
	ship.lives = 3
	ship.fuel = 10
	ship.fuelTimer = pancake.addTimer(30000, "repetetive", decreaseFuel)
	for w = 2, 40 do
		for i = 1, 5 do
			pancake.applyForce(createAsteroid(math.random(w*25,w*25+25), math.random(0,80), math.random(1,2)),{x=-math.random(0,7), y = math.random(-4,4), relativeToMass = true},1)
		end
	end
	createAsteroid(40, 40, 2)
end

function decreaseFuel()
	ship.fuel = ship.fuel - 1
	if ship.fuel <= 0 then
		ship.fuel = 0
	end
end

function centerPressed()
	if levelType == "ship" and text == nil then
			shoot()
	end
	if text == 2 then
		text = nil
		pancake.paused = false
	elseif text == 0 then
		text = 1
	elseif text == 1 then
		text = 2
	end
end

function createAsteroid(x,y,number)
	local ret
	if number == 1 then
		return pancake.applyPhysics(pancake.addObject({image = "asteroid1", name = "asteroid", x = x, y = y, width = 13, height = 13, offsetX = -2, offsetY = -1,layer = 2}))
	elseif number == 2 then
		return pancake.applyPhysics(pancake.addObject({image = "asteroid2", name = "asteroid", x = x, y = y, width = 10, height = 8, offsetX = -3, offsetY = -4,layer = 2}))
	end
end

function shoot()
	if not ship.dead and not ship.laserTimer then
		local laser = pancake.applyPhysics(pancake.addObject({name = "laser", x = ship.x + pancake.boolConversion(ship.flippedX, 0, 10), y = ship.y+2, height = 3, width = 8, image = "laser"}))
		pancake.applyForce(laser, {x = pancake.boolConversion(ship.flippedX, -1, 1)*200, relativeToMass = true}, 1)
		pancake.addTimer(600,"single",deleteLaser, laser)
		pancake.playSound("laser")
		ship.laserTimer = pancake.addTimer(2000,"single", resetLaserTimer)
	end
end

function resetLaserTimer()
	ship.laserTimer = nil
end

function deleteLaser(laser)
	pancake.trash(pancake.objects, laser.ID, "ID")
end

function pancake.onCollision() --This function will be called whenever a physic object collides with a colliding object!
	--Insert your amazing code here!
end

function pancake.onLoad() -- This function will be called when pancake start up is done (after the animation)
	--Insert your amazing code here!
end

function pancake.onOverlap(object1, object2, dt) -- This function will be called every time object "collides" with a non colliding object! Parameters: object1, object2 - objects of collision, dt - time of collision
	if object1.name == "ship" and object2.name == "asteroid" then
		if not ship.invulnerable then
			ship.invulnerable = true
			ship.lives = ship.lives - 1
			if ship.lives <= 0 then
				ship.animation = nil
				ship.image = nil
				ship.dead = true
				ship.velocityX = 0
				ship.velocityY = 0
			else
				pancake.changeAnimation(ship, "crash")
				pancake.addTimer(2000, "single", idleShip)
			end
		end
	elseif object1.name == "laser" and object2.name == "asteroid" then
		pancake.trash(pancake.objects, object1.ID, "ID")
		pancake.trash(pancake.objects, object2.ID, "ID")
	end
end

function idleShip()
	if ship.animation then
		pancake.changeAnimation(ship, "idle")
	end
	ship.invulnerable = false
end

function love.draw()
	local x = pancake.window.x
	local y = pancake.window.y
	local scale = pancake.window.pixelSize
	pancake.draw() --Sets the canvas right! If pancake.autoDraw is set to true (which is its default state) the canvas will be automatically drawn on the window x and y
	if levelType == "ship" and text == nil then
		pancake.print(pancake.round(1000 - ship.x) .. "m", pancake.window.x, pancake.window.y, pancake.window.pixelSize)
		love.graphics.rectangle("fill" , x + 90*scale, y + 84*scale, 3*scale, 10*scale)
		love.graphics.setColor(1, 0, 0, 1)
		love.graphics.rectangle("fill" , x + 90*scale, y + (94 - ship.fuel)*scale, 3*scale, 10*scale)
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(pancake.images.fuel_ui, x + 80*scale, y + 80*scale, 0, scale)
	end
	drawText()
end

function drawText()
	if text then
		local scale = pancake.window.pixelSize
		local x = pancake.window.x
		local y = pancake.window.y
		love.graphics.setColor(0,0,0,1)
		love.graphics.rectangle("fill", pancake.window.x , pancake.window.y , 96*scale, 96*scale)
		love.graphics.setColor(1,1,1,1)
		if text == 2 then
			pancake.print("Chapter 1", x+16*scale, y + 26*scale, scale*2)
			pancake.print("Through the galaxy", x+16*scale, y + 50*scale, scale)
		elseif text == 0 then
			pancake.print("Introduction", x+23*scale, y + 6*scale, scale)
			pancake.print("A long time ago in a galaxy", x+4*scale, y + 16*scale, scale)
			pancake.print("far,far away... there was a ", x+scale, y + 23*scale, scale)
			pancake.print("family named Hutt. It was", x+scale, y + 30*scale, scale)
			pancake.print("one of the richest families", x+scale, y + 37*scale, scale)
			pancake.print("because they were known", x+scale, y + 44*scale, scale)
			pancake.print("for their best restaurant", x+scale, y + 51*scale, scale)
			pancake.print("in the universe that was", x+scale, y + 58*scale, scale)
			pancake.print("selling pizza: Pizza Hutt.", x+scale, y + 65*scale, scale)
			pancake.print("Vesuvius Hutt, the owner", x+scale, y + 72*scale, scale)
			pancake.print("of the restaurant, was the", x+scale, y + 79*scale, scale)
			pancake.print("only known person who", x+scale, y + 86*scale, scale)
			pancake.addObject({image = "pizza", x = 46, y = 20, width = 1, height = 1, layer = 2})
		elseif text == 1 then
			pancake.print("1", x+23*scale, y + 6*scale, scale)
			pancake.print("2", x+4*scale, y + 16*scale, scale)
			pancake.print("3", x+scale, y + 23*scale, scale)
			pancake.print("4", x+scale, y + 30*scale, scale)
			pancake.print("5", x+scale, y + 37*scale, scale)
			pancake.print("6", x+scale, y + 44*scale, scale)
			pancake.print("7", x+scale, y + 51*scale, scale)
			pancake.print("8", x+scale, y + 58*scale, scale)
			pancake.print("9", x+scale, y + 65*scale, scale)
			pancake.print("10", x+scale, y + 72*scale, scale)
			pancake.print("11", x+scale, y + 79*scale, scale)
			pancake.print("12", x+scale, y + 86*scale, scale)
		end
	end
end

function love.update(dt)
	pancake.update(dt) --Passing time between frames to pancake!
	pancake.window.offsetY = 0 --So that our ship is followed only on x coordinate!
	pancake.window.offsetX = pancake.window.offsetX + 24
	if levelType == "ship" then
		if pancake.isButtonClicked(left) and not ship.dead and ship.fuel > 0 then
			pancake.applyForce(ship, {x = -40, relativeToMass = true})
			ship.flippedX = true
		end
		if pancake.isButtonClicked(right) and not ship.dead and ship.fuel > 0  then
			pancake.applyForce(ship, {x = 40, relativeToMass = true})
			ship.flippedX = false
		end
		if pancake.isButtonClicked(up) and not ship.dead and ship.fuel > 0  then
			pancake.applyForce(ship, {y = -40, relativeToMass = true})
		end
		if pancake.isButtonClicked(down) and not ship.dead and ship.fuel > 0  then
			pancake.applyForce(ship, {y = 40, relativeToMass = true})
		end
		if ship.y < 2 then
			ship.y = 2
			ship.velocityY = 0
		elseif ship.y > 86 then
			ship.y = 86
			ship.velocityY = 0
		end
		if ship.x < 0 then
			ship.x = 0
			ship.velocityX = 0
		end
	end
end

function love.mousepressed(x,y,button)
	pancake.mousepressed(x,y,button) -- Passing your presses to pancake!
end

function love.keypressed(key)
	pancake.keypressed(key)
end
