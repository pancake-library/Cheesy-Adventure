pancake =  require "pancake"
function love.load()
	math.randomseed(os.time())
	love.graphics.setBackgroundColor(0.1,0.1,0.1,1) --So it won't merge with pancake's background!!!
	pancake.init({window = {pixelSize = love.graphics.getHeight()/96, width = 96, height = 96}}) --Initiating pancake and setting pixelSize, so that the pancake display will be the height of the window! pixelSize is how many pixels every pancake pixel should take
	pancake.loadAnimation = nil
	pancake.paused = false
	pancake.smoothRender = true
	--pancake.debugMode = true
	loadAssets()
	text = 4
	level = 2
	pancake.background.image = pancake.images.background
	left = pancake.addButton({key = "a", name="left",x = 1*pancake.window.pixelSize, y = love.graphics.getHeight()-16*pancake.window.pixelSize, width = 14, height = 14, scale = pancake.window.pixelSize})
	right = pancake.addButton({key = "d", name="right",x = 17*pancake.window.pixelSize, y = love.graphics.getHeight()-16*pancake.window.pixelSize, width = 14, height = 14, scale = pancake.window.pixelSize})
	up = pancake.addButton({key = "w", name="up",x = love.graphics.getWidth()-15*pancake.window.pixelSize, y = love.graphics.getHeight()-16*pancake.window.pixelSize, width = 14, height = 14, scale = pancake.window.pixelSize})
	down = pancake.addButton({key = "s", name="down",x = love.graphics.getWidth()-31*pancake.window.pixelSize, y = love.graphics.getHeight()-16*pancake.window.pixelSize, width = 14, height = 14, scale = pancake.window.pixelSize})
	center = pancake.addButton({func = centerPressed, key = "j", name="center",x = love.graphics.getWidth()-15*pancake.window.pixelSize, y = love.graphics.getHeight()-31*pancake.window.pixelSize, width = 14, height = 14, scale = pancake.window.pixelSize})
end

function loadLevel(stage)
	level = stage
	if level == 1 then
		level = 1
		loadShipLevel()
		pancake.addObject({image = "earth", x = 1990, y = 43, width = 10, height = 10, layer = 2, name = "earth"})
		pancake.paused = true
		text = 0
	elseif level == 2 then
		level = 2
		loadGroundLevel()
		alien.pages = 0
		pancake.paused = false
		pancake.addObject({name = "ship", image = "ship", x = 0, y = 66, width = 14, height = 10})
		rectangle(-8*8, 10*8, 20, 5)
		rectangle(4*8, 18*8, 40, 3)
		rectangle(-8*8, 15*8, 8, 10)
		rectangle(-8*8, 25*8, 22, 6)
		pancake.addObject({name = "ground", image = "ground", x = 8, y = 150, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "ground", image = "ground", x = 32, y = 165, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "ground", image = "ground", x = 8, y = 180, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "ground", image = "ground", x = 16, y = 195, width = 8, height = 8, colliding = true})
		spike(120,241,22)
		rectangle(3*8, 31*8, 40, 6)
		pancake.addObject({name = "safePlace", x = 100, y = 191, width = 8, height = 8})
		pancake.addObject({name = "ground", image = "ground", x = 150, y = 205, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "ground", image = "ground", x = 180, y = 195, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "ground", image = "ground", x = 185, y = 210, width = 8, height = 8, colliding = true})
		rectangle(37*8,21*8,6,6)
		rectangle(43*8,8*8,20,40)
		spike(297,168,6, "left")
		local page1 = pancake.addObject({name = "page", x = 341, y = 239, width = 8, height = 8})
		pancake.changeAnimation(page1, "idle")
		spike(55,137,4)
		pancake.addObject({name = "safePlace", x = 40, y = 135, width = 8, height = 8})
		pancake.addObject({name = "safePlace", x = 96, y = 135, width = 8, height = 8})
		pancake.addObject({name = "ground", image = "ground", x = 118, y = 137, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "ground", image = "ground", x = 100, y = 120, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "ground", image = "ground", x = 140, y = 107, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "ground", image = "ground", x = 104, y = 90, width = 8, height = 8, colliding = true})
		rock1 = pancake.applyPhysics(pancake.addObject({name = "rock1", image = "ground", x = 148, y = 107, width = 8, height = 8, colliding = true}))
		rock1.mass = 999999999
		rock1.velocityX = 10
		pancake.addForce(rock1, {time = "infinite",  y = -pancake.physics.gravityY, relativeToMass = true})
		pancake.addObject({name = "ground", image = "ground", x = 330, y = 117, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "ground", image = "ground", x = 347, y = 96, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "ground", image = "ground", x = 322, y = 85, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "ground", image = "ground", x = 347, y = 74, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "jump_pad", image = "jump_pad", x = 479, y = 63, width = 16, height = 4})
		rectangle(32,0,11,6)
		pancake.addObject({name = "ground", image = "ground", x = 140, y = 62, width = 8, height = 8, colliding = true})
		rectangle(32+16*8,-40,4,5)
		rectangle(32+20*8,0,8,2)
		rectangle(64 + 12*8, 0, 5, 5)
		pancake.addObject({name = "ground", image = "ground", x = 160, y = 48, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "ground", image = "ground", x = 168, y = 48, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "ground", image = "ground", x = 168, y = 40, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "ground", image = "ground", x = 128, y = 29, width = 8, height = 8, colliding = true})
		pancake.addObject({name = "ground", image = "ground", x = 160, y = 17, width = 8, height = 8, colliding = true})
		pancake.applyPhysics(pancake.addObject({name = "spike1", image = "spike_down", x = 150, y = -30, width = 7, height = 7, colliding = true})).velocityY = 20
		spike(58,-7,7)
		local page2 = pancake.addObject({name = "page", x = 45, y = -9, width = 8, height = 8})
		pancake.changeAnimation(page2, "idle")
		pancake.addObject({name = "esater_egg", image = "easter_egg", x = 233, y = -30, width = 8, height = 8})
		rectangle(63*8,-8*8,20,60)
		rectangle(66*8,-16*8,10,8)
		local page3 = pancake.addObject({name = "page", x = 65*8, y = -9*8-3, width = 8, height = 8})
		pancake.changeAnimation(page3, "idle")
		pancake.addObject({name = "safePlace", x = 140, y = 53, width = 8, height = 8})
		pancake.addObject({name = "fake_ground", image = "ground", x = 200, y = -40, width = 8*8, height = 5*8, textured = true, texture = {width = 8, height = 8}})
	elseif level == 3 then
		level = 3
		loadGroundLevel()
		alien.safePlace = {x = -15, y = -10}
		alien.timeStopper = true
		alien.x = -15
		alien.y = -10

		--alien.x = -480
		--alien.y = -205

		local red_laser = pancake.applyPhysics(pancake.addObject({name = "red_laser", image = "red_laser", x = -496, y = -190, width = 48, height = 1, offsetY = -1}))
		pancake.addForce(red_laser, {time = "infinite", x = 0,  y = -0.2*12*pancake.meter, relativeToMass = true})
		pancake.addObject({name = "laser_down", x = -456, y = -190, width = 6, height = 1})
		red_laser.goingDown = true
		pancake.addObject({name = "laser_up", x = -456, y = -32, width = 6, height = 1})
		alien.flippedX = true
		pancake.addObject({name = "ship", image = "ship", x = -10, y = -14, width = 14, height = 10})
		rectangle(-560,0,78,6)
		pancake.changeAnimation(pancake.addObject({name = "astronaut", image = "ship", x = -70, y = -12, width = 30, height = 12, offsetY = -1}), "idle")
		pancake.changeAnimation(pancake.addObject({name = "astronaut", image = "ship", x = -120, y = -12, width = 30, height = 12, offsetY = -1}), "idle")
		pancake.changeAnimation(pancake.addObject({name = "astronaut", image = "ship", x = -157, y = -12, width = 30, height = 12, offsetY = -1}), "idle")
		rectangle(-300, -8, 8, 1, "steel")
		pancake.addObject({name = "door", image = "door", x = -252, y = -24, width = 30, height = 15, offsetX = 12})
		rectangle(-300, -32, 8, 1, "steel")
		pancake.addObject({name = "door", image = "door", x = -300, y = -24, width = 30, height = 15, offsetX = 12})
		local rock2 = pancake.applyPhysics(pancake.addObject({name = "rock2", image = "ground", x = -312, y = -100, width = 8, height = 8, colliding = true}))
		rock2.velocityY = 30
		rectangle(-340, -56, 1, 4, "steel")
		rectangle(-340-9*8, -8, 11, 1, "steel")
		pancake.addObject({name = "closed_door", image = "door", x = -331, y = -24, width = 6, height = 16,colliding = true})
		rectangle(-300, -94, 9, 1, "steel")
		rectangle(-300+5*8, -94-8*8, 4, 8, "steel")
		pancake.addObject({image = "code",x = -244, y = -136, width = 1, height = 1})
		pancake.addObject({name = "passcard",image = "passcard",x = -275, y = -110, width = 7, height = 11})
		rectangle(-340-64, -56, 2, 1, "steel")
		rectangle(-340-64+24, -56, 5, 1, "steel")
		rectangle(-340-64, -56+24, 7, 1, "steel")
		pancake.addObject({name = "terminal",image = "terminal",x = -365, y = -42, width = 5, height = 10})
		pancake.addObject({name = "closed_door",image = "door",x = -345, y = -48, width = 6, height = 16,colliding = true})
		pancake.changeAnimation(pancake.addObject({name = "astronaut", image = "ship", x = -270, y = -20, width = 30, height = 12, offsetY = -1}), "idle")
		pancake.changeAnimation(pancake.addObject({name = "astronaut", image = "ship", x = -396, y = -44, width = 30, height = 12, offsetY = -1}), "idle")
		rectangle(-340-72, -56-8*8, 1, 12, "steel")
		pancake.addObject({name = "button3",image = "button3",x = -355, y = -28, width = 7, height = 7})
		pancake.addObject({name = "button2",image = "button2",x = -370, y = -28, width = 7, height = 7})
		pancake.addObject({name = "button1",image = "button1",x = -385, y = -28, width = 7, height = 7})
		pancake.addObject({name = "closed_door2",image = "door",x = -402, y = -24, width = 6, height = 16,colliding = true})
		rectangle(-456,-200, 1, 22, "steel")
		rectangle(-496,-200, 1, 25, "steel")
		for i = 0, 9 do
			if i%2==0 then
				rectangle(-488,-16-i*20, 1, 1, "steel")
			else
				rectangle(-488+24,-16-i*20, 1, 1, "steel")
			end
		end
		rectangle(-456,-200-32, 1, 4, "steel")
		rectangle(-456-10*8,-200-32, 10, 1, "steel")
		rectangle(-456-10*8,-200, 5, 1, "steel")
		rectangle(-456-11*8,-200-32, 1, 5, "steel")
		pancake.addObject({name = "safePlace", x = -454, y = -205, width = 8, height = 8})
		pancake.changeAnimation(pancake.addObject({name = "page", x = -527, y = -209, width = 8, height = 8}), "idle")
		pancake.changeAnimation(pancake.addObject({name = "astronaut", image = "ship", x = -517, y = -212, width = 30, height = 12, offsetY = -1}), "idle")
		pancake.addObject({name = "safePlace", x = -390, y = -17, width = 8, height = 8})
	end
end

function rectangle(x, y, width, height, texture)
	local texture = texture or "ground"
	return pancake.addObject({name = "ground", image = texture, x = x+8, y = y, width = width*8, height = height*8, colliding = true, textured = true, texture = {width = 8, height = 8}})
end

function spike(x,y,length,type)
	local type = type or "up"
	if type == "up" then
			pancake.addObject({name = "spike", image = "spike_"..type, x = x, y = y, width = length*8, height = 7,textured = true, texture = {width = 8, height = 7}})
	elseif type == "left" then
			pancake.addObject({name = "spike", image = "spike_"..type, x = x, y = y, width = 7, height = length*8,textured = true, texture = {width = 7, height = 8}})
	end
end

function killAlien()
	alien.x = alien.safePlace.x
	alien.y = alien.safePlace.y
	alien.velocityX = 0
	alien.velocityY = 0
	pancake.playSound("death")
end

function loadAssets()
	--animations
	pancake.addAnimation("ship","idle","images/animations",180)
	pancake.addAnimation("ship","crash","images/animations",250)
	pancake.addAnimation("alien","idle","images/animations",180)
	pancake.addAnimation("alien","run","images/animations",150)
	pancake.addAnimation("page","idle","images/animations",200)
	pancake.addAnimation("astronaut","idle","images/animations",150)
	pancake.addAnimation("timewave","idle","images/animations",230)
	pancake.addAnimation("timewave","in","images/animations",230)
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
	pancake.addImage("ground", "images")
	pancake.addImage("ship", "images")
	pancake.addImage("spike_up", "images")
	pancake.addImage("spike_down", "images")
	pancake.addImage("spike_right", "images")
	pancake.addImage("spike_left", "images")
	pancake.addImage("jump_pad", "images")
	pancake.addImage("easter_egg", "images")
	pancake.addImage("page", "images")
	pancake.addImage("door", "images")
	pancake.addImage("steel", "images")
	pancake.addImage("blank", "images")
	pancake.addImage("code", "images")
	pancake.addImage("passcard", "images")
	pancake.addImage("terminal", "images")
	pancake.addImage("button1", "images")
	pancake.addImage("button2", "images")
	pancake.addImage("button3", "images")
	pancake.addImage("red_laser", "images")
	pancake.addImage("Gun", "images")
	--sounds
	pancake.addSound("laser")
	pancake.addSound("success")
	pancake.addSound("crash")
	pancake.addSound("boom")
	pancake.addSound("next")
	pancake.addSound("death")
	pancake.addSound("timestop")
	pancake.addSound("timestart")
	pancake.addSound("timecooldown")
	--music
	chapter1 = love.audio.newSource("music/chapter1.ogg", "stream")
	chapter1:setLooping(true)
	chapter1:setVolume(0.9)
	chapter2 = love.audio.newSource("music/chapter2.ogg", "stream")
	chapter2:setLooping(true)
	chapter2:setVolume(1.6)
	chapter3 = love.audio.newSource("music/chapter3.ogg", "stream")
	chapter3:setLooping(true)
	chapter3:setVolume(1.3)
end

function loadGroundLevel()
	pancake.objects = {}
	pancake.timers = {}
	levelType = "ground"
	pancake.physics.gravityY = 0.2*12*pancake.meter
	alien = pancake.applyPhysics(pancake.addObject({name = "alien", x = 15, y = 70, width = 5, height = 9, offsetX = -5, offsetY = -5, colliding = true}))
	--alien.x = 233
	--alien.y = -10
	alien.maxVelocityX = 40
	alien.maxVelocityY = 150
	pancake.changeAnimation(alien, "idle")
	pancake.cameraFollow = alien
	alien.safePlace = {x = 15, y = 70}
end

function loadShipLevel()--level is a number of the level. This function loads everything that is needed for the ship levels
	pancake.objects = {}
	pancake.timers = {}
	pancake.physics.gravityY = 0
	ship = pancake.applyPhysics(pancake.addObject({name = "ship", x = 0, y = 64, width = 14, height = 7, offsetX = -1, offsetY = -4}))
	pancake.changeAnimation(ship,"idle")
	levelType = "ship"-- This variable indicates what type of level are we in!
	pancake.cameraFollow = ship
	ship.maxVelocity = 100
	ship.lives = 3
	ship.fuel = 10
	ship.fuelTimer = pancake.addTimer(4000, "repetetive", decreaseFuel)
	for w = 2, 100 do
		for i = 1, 5 do
			pancake.applyForce(createAsteroid(math.random(w*25,w*25+25), math.random(0,80), math.random(1,2)),{x=-math.random(0,7), y = math.random(-4,4), relativeToMass = true},1)
		end
	end
	for i =1, 6 do
		pancake.addObject({name = "fuel", image = "fuel", x=i*350, y = math.random(0,80), width = 7, height = 9})
	end
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
		if ship.dead then
			loadLevel(level)
			if level == 1 then
				text = nil
				pancake.paused = false
			end
		end
	elseif level == 3 and not alien.timeStopped and text == nil and alien.timeStopper then
		alien.timeStopped = true
		local timeWave = pancake.addObject({name = "timewave",x = alien.x-6, y = alien.y-7,width = 10, height = 10})
		pancake.changeAnimation(timeWave, "idle")
		pancake.addTimer(900, "single",deleteTimeWave, timeWave)
		pancake.addTimer(2200, "single",startTime)
		pancake.playSound("timestop")
		pancake.addTimer(1300, "single",createStartWave)
		pancake.addTimer(2200+3000, "single",timerCooldown)
		alien.timeStopper = false
		for i = 1, #pancake.objects do
			if pancake.objects[i].name ~= "alien" then
				pancake.objects[i].physics = false
			end
		end
	end
	if text == 2 then
		loadLevel(1)
		text = nil
		pancake.paused = false
	elseif text == 0 then
		text = 1
		pancake.playSound("next")
	elseif text == 1 then
		text = 3
		pancake.playSound("next")
	elseif text == 3 then
		text = 2
		chapter1:play()
	elseif text == 4 then
		text = 5
		chapter2:play()
	elseif text == 5 then
		text = nil
		loadLevel(2)
	elseif text == 6 then
		text = nil
		pancake.paused = false
	elseif text == 7 then
		text = nil
		pancake.paused = false
	elseif text == 8 then
		text = 9
		pancake.playSound("next")
	elseif text == 9 then
		text = nil
		pancake.paused = false
	elseif text == 10 then
		text = 11
		chapter3:play()
		loadLevel(3)
	elseif text == 11 then
		text = nil
		pancake.paused = false
	elseif text == 12 then
		text = nil
		pancake.paused = false
	end
end

function timerCooldown()
	alien.timeStopper = true
	pancake.playSound("timecooldown")
end

function deleteTimeWave(object)
	pancake.trash(pancake.objects, object.ID, "ID")
end

function startTime()
	alien.timeStopped = false
	for i = 1, #pancake.objects do
		local object = pancake.objects[i]
		if object.name == "rock2" then
			object.physics = true
			object.velocityY = 30
		elseif object.name == "red_laser" then
			object.physics = true
			object.velocityY = 40*pancake.boolConversion(object.goingDown, 1, -1)
		end
	end
end
function createStartWave()
	local timeWave = pancake.addObject({name = "timewave",x = alien.x-6, y = alien.y-7,width = 10, height = 10})
	pancake.changeAnimation(timeWave, "in")
	pancake.addTimer(900, "single",deleteTimeWave, timeWave)
	pancake.playSound("timestart")
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

function pancake.onCollision(object1, object2, axis, direction, sc) --This function will be called whenever a physic object collides with a colliding object!
	if object1.name == "rock1" and axis == "x" then
		pancake.trash(pancake.objects, object1.ID, "ID")
		rock1 = pancake.applyPhysics(pancake.addObject({name = "rock1", image = "ground", x = 148, y = 107, width = 8, height = 8, colliding = true}))
		rock1.mass = 9999
		rock1.velocityX = 10
		pancake.addForce(rock1, {time = "infinite",  y = -pancake.physics.gravityY, relativeToMass = true})
	elseif object2.name == "rock1" and axis == "x" then
		pancake.trash(pancake.objects, object2.ID, "ID")
		rock1 = pancake.applyPhysics(pancake.addObject({name = "rock1", image = "ground", x = 148, y = 107, width = 8, height = 8, colliding = true}))
		rock1.mass = 9999
		rock1.velocityX = 10
		pancake.addForce(rock1, {time = "infinite",  y = -pancake.physics.gravityY, relativeToMass = true})
	elseif object1.name == "spike1" and axis == "y" then
		if axis == "y" then
			pancake.trash(pancake.objects, object1.ID, "ID")
			pancake.applyPhysics(pancake.addObject({name = "spike1", image = "spike_down", x = 150, y = -30, width = 7, height = 7, colliding = true})).velocityY = 20
		end
		if object2.name == "alien" then
			killAlien()
		end
	elseif object2.name == "spike1" and axis == "y" then
		if axis == "y" then
			pancake.trash(pancake.objects, object2.ID, "ID")
			pancake.applyPhysics(pancake.addObject({name = "spike1", image = "spike_down", x = 150, y = -30, width = 7, height = 7, colliding = true})).velocityY = 20
		end
		if object1.name == "alien" then
			killAlien()
		end
	elseif object1.name == "rock2" and not alien.timeStopped then
		pancake.trash(pancake.objects, object1.ID, "ID")
		local rock2 = pancake.applyPhysics(pancake.addObject({name = "rock2", image = "ground", x = -312, y = -100, width = 8, height = 8, colliding = true}))
		rock2.velocityY = 10
	elseif object2.name == "rock2"and not alien.timeStopped  then
		pancake.trash(pancake.objects, object2.ID, "ID")
		local rock2 = pancake.applyPhysics(pancake.addObject({name = "rock2", image = "ground", x = -312, y = -100, width = 8, height = 8, colliding = true}))
		rock2.velocityY = 10
	end
end

function pancake.onLoad() -- This function will be called when pancake start up is done (after the animation)
	pancake.pasue = true
	text = 15
end

function pancake.onOverlap(object1, object2, dt) -- This function will be called every time object "collides" with a non colliding object! Parameters: object1, object2 - objects of collision, dt - time of collision
	if levelType == "ship" then
		if object1.name == "ship" and object2.name == "asteroid" then
			if not ship.invulnerable then
				ship.invulnerable = true
				ship.lives = ship.lives - 1
				pancake.shakeScreen(10, 4)
				pancake.playSound("crash")
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
			pancake.playSound("boom")
		elseif object1.name == "ship" and object2.name == "fuel" then
			ship.fuel = 11
			pancake.trash(pancake.objects, object2.ID, "ID")
			pancake.playSound("success")
		elseif object1.name == "ship" and object2.name == "earth" then
			pancake.timers = {}
			pancake.objects = {}
			text = 4
			if chapter1 then
				chapter1:pause()
				chapter1 = nil
			end
			pancake.paused = true
		end
	elseif levelType == "ground" then
		if object1.name == "alien" and object2.name == "spike" then
			killAlien()
		elseif object1.name == "alien" and object2.name == "safePlace" then
			alien.safePlace.x = object2.x
			alien.safePlace.y = object2.y
		elseif object1.name == "alien" and object2.name == "page" then
			pancake.playSound("success")
			pancake.trash(pancake.objects, object2.ID, "ID")
			if level == 2 then
				alien.pages = alien.pages + 1
				if alien.pages == 1 then
					pancake.paused = true
					text = 6
				elseif alien.pages == 2 then
					pancake.paused = true
					text = 7
				elseif alien.pages == 3 then
					pancake.paused = true
					text = 8
				end
			elseif level == 3 then
				pancake.paused = true
				text = 12
				alien.recipe = true
			end
		elseif object1.name == "alien" and object2.name == "jump_pad" then
			alien.y = alien.y - 1
			alien.velocityY = -80
		elseif object1.name == "alien" and object2.name == "fake_ground" then
			pancake.trash(pancake.objects, object2.ID, "ID")
		elseif object1.name == "alien" and object2.name == "ship" then
			if level == 2 and alien.pages == 3 then
				pancake.paused = true
				text = 10
				if chapter2 then
					chapter2:pause()
					chapter2 = nil
				end
			elseif level == 3 and alien.recipe then
				pancake.paused = true
				text = 13
				if chapter3 then
					chapter3:pause()
					chapter3 = nil
				end
			end
		elseif object1.name == "alien" and object2.name == "astronaut" then
			if not alien.timeStopped then
				killAlien()
			end
		elseif object1.name == "alien" and object2.name == "door" and object2.image ~= "blank" then
			object2.image = "blank"
			pancake.playSound("next")
		elseif object1.name == "alien" and object2.name == "passcard" then
			pancake.trash(pancake.objects, object2.ID, "ID")
			pancake.playSound("success")
			alien.passcard = true
		elseif object1.name == "alien" and object2.name == "terminal" and alien.passcard then
			pancake.trash(pancake.objects, "closed_door", "name")
			pancake.trash(pancake.objects, "closed_door", "name")
			pancake.playSound("next")
			alien.passcard = false
		elseif object1.name == "alien" and object2.name == "button3" then
			alien.button3 = true
		elseif object1.name == "alien" and object2.name == "button1" then
			if alien.button3 then
				alien.button1 = true
			else
				alien.button3 = nil
				killAlien()
			end
		elseif object1.name == "alien" and object2.name == "button2" then
			if alien.button3 and alien.button1 then
				alien.button2 = true
				pancake.trash(pancake.objects, "closed_door2", "name")
			else
				alien.button3 = nil
				alien.button1 = nil
				killAlien()
			end
		elseif object1.name == "red_laser" and object2.name == "laser_down" then
			object1.goingDown = true
			object1.velocityY = 40
		elseif object1.name == "red_laser" and object2.name == "laser_up" then
			object1.velocityY = -40
			object1.goingDown = false
		elseif object1.name == "alien" and object2.name == "red_laser" and not alien.timeStopped then
			killAlien()
		end
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
		pancake.print(pancake.round(2000 - ship.x) .. "m", pancake.window.x, pancake.window.y, scale)
		love.graphics.rectangle("fill" , x + 90*scale, y + 84*scale, 3*scale, 10*scale)
		love.graphics.setColor(1, 0, 0, 1)
		love.graphics.rectangle("fill" , x + 90*scale, y + (94 - ship.fuel)*scale, 3*scale, 12*scale)
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(pancake.images.fuel_ui, x + 80*scale, y + 80*scale, 0, scale)
		if ship.dead then
			pancake.print("Press", x + 30*scale, y + 24*scale, 2*scale)
			pancake.print("J", x + 44*scale, y + 44*scale, 2*scale)
			pancake.print("to restart", x + 14*scale, y + 64*scale, 2*scale)
		end
	elseif levelType == "ground" and text == nil then
		if alien.pages and not pancake.debugMode then
			love.graphics.setColor(0, 0, 0, 1)
			love.graphics.rectangle("fill" , x, y, 40*scale, 10*scale)
			love.graphics.setColor(1, 1, 1, 1)
			pancake.print(alien.pages .. "/3 pages", pancake.window.x + 3*scale, pancake.window.y+3*scale, pancake.window.pixelSize)
		end
	end
	drawText()
	love.graphics.setColor(1, 1, 1, 1)
	--pancake.print("AaBbCcDdEeFfGgHhIiJjKkLl",0,0,scale)
	--pancake.print("MmNnOoPpRrSsTtUuVvWwXxYyZz123467890!.",0, 7*scale,scale)
	if pancake.debugMode then
		love.graphics.setColor(1, 1, 1, 1)
		pancake.print(love.timer.getFPS().. "FPS",0,0,2*scale)
	end
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
			pancake.print("far,far away... there was a ", x+2*scale, y + 23*scale, scale)
			pancake.print("family named Hutt. It was", x+4*scale, y + 30*scale, scale)
			pancake.print("one of the richest families", x+2*scale, y + 37*scale, scale)
			pancake.print("because they were known", x+4*scale, y + 44*scale, scale)
			pancake.print("for their best restaurant", x+3*scale, y + 51*scale, scale)
			pancake.print("in the universe that was", x+5*scale, y + 58*scale, scale)
			pancake.print("selling pizza: Pizza Hutt.", x+5*scale, y + 65*scale, scale)
			pancake.print("Vesuvius Hutt, the owner", x+5*scale, y + 72*scale, scale)
			pancake.print("of the restaurant, was the", x+scale, y + 79*scale, scale)
			pancake.print("only known person who", x+8*scale, y + 86*scale, scale)
		elseif text == 1 then
			pancake.print("knew how to make pizza in", x+2*scale, y + 1*scale, scale)
			pancake.print("the entire universe!", x+12*scale, y + 8*scale, scale)
			love.graphics.draw(pancake.images.pizza,x+40*scale, y + 18*scale, 0, scale)
			pancake.print("That is because only he", x+8*scale, y + 40*scale, scale)
			pancake.print("knew how to make cheese. ", x+4*scale, y + 47*scale, scale)
			pancake.print("He was known throughout", x+4*scale, y + 54*scale, scale)
			pancake.print("the galaxy for his special", x+4*scale, y + 61*scale, scale)
			pancake.print("cheese. Grown on the moons", x+0*scale, y + 68*scale, scale)
			pancake.print(" of planets over a long", x+8*scale, y + 75*scale, scale)
			pancake.print("long period of time.", x+10*scale, y + 82*scale, scale)
		elseif text == 3 then
			pancake.print("However, Mr. Hutt died", x+8*scale, y + 3*scale, scale)
			pancake.print("many years ago and the", x+8*scale, y + 10*scale, scale)
			pancake.print("only thing he left was a", x+7*scale, y + 17*scale, scale)
			pancake.print("legend that somewhere in", x+4*scale, y + 24*scale, scale)
			pancake.print("the universe, the last", x+10*scale, y + 31*scale, scale)
			pancake.print("cheese planet is still", x+11*scale, y + 38*scale, scale)
			pancake.print("existing with all the", x+12*scale, y + 45*scale, scale)
			pancake.print("knowledge and only", x+13*scale, y + 52*scale, scale)
			pancake.print("possibility to recover", x+10*scale, y + 59*scale, scale)
			pancake.print("cheese recipe!", x+22*scale, y + 66*scale, scale)
			pancake.print("THIS PLANET IS              ...", x+1*scale, y + 83*scale, scale)
			love.graphics.setColor(0, 1, 0, 1)
			pancake.print("EARTH", x+65*scale, y + 83*scale, scale)
		elseif text == 4 then
			pancake.print("I think... I think this might", x+2*scale, y + 11*scale, scale)
			pancake.print("be it -said our hero- I have", x+1*scale, y + 18*scale, scale)
			pancake.print("to check if this is really", x+7*scale, y + 25*scale, scale)
			love.graphics.setColor(0, 1, 0, 1)
			pancake.print("EARTH.", x+36*scale, y + 32*scale, scale)
			love.graphics.setColor(1, 1, 1, 1)
			pancake.print("And so the alien landed on", x+3*scale, y + 42*scale, scale)
			pancake.print("the moon...", x+32*scale, y + 49*scale, scale)
			pancake.print("Little did he know, he was", x+4*scale, y + 56*scale, scale)
			pancake.print("about to discover one of ", x+5*scale, y + 63*scale, scale)
			pancake.print("the biggest mysteries in", x+7*scale, y + 70*scale, scale)
			pancake.print("the whole universe.", x+18*scale, y + 77*scale, scale)
		elseif text == 5 then
			pancake.print("Chapter 2", x+16*scale, y + 26*scale, scale*2)
			pancake.print("Rumours were true", x+16*scale, y + 50*scale, scale)
		elseif text == 6 then
			love.graphics.draw(pancake.images.page, x, y, 0, scale)
			love.graphics.setColor(0.4, 0.3, 0.2, 1)
			pancake.print("This is Vesuvius Hutt, it all", x+1*scale, y + 2*scale, scale)
			pancake.print("went wrong! This cheese is", x+3*scale, y + 9*scale, scale)
			pancake.print("EXPIRED! It seems that a", x+2*scale, y + 16*scale, scale)
			pancake.print("part of the moon with ", x+7*scale, y + 23*scale, scale)
			pancake.print("bacteria on it landed on", x+4*scale, y + 30*scale, scale)
			pancake.print("the planet. This caused an", x+3*scale, y + 37*scale, scale)
			pancake.print("evolution. These animals", x+4*scale, y + 44*scale, scale)
			pancake.print("went back on moon. They", x+3*scale, y + 51*scale, scale)
			pancake.print("call themselves HUMANS.", x+3*scale, y + 58*scale, scale)
			pancake.print("I have to watch out, they", x+5*scale, y + 65*scale, scale)
			pancake.print("look dangerous. Before", x+6*scale, y + 72*scale, scale)
			pancake.print("I got back to my ship, they", x+2*scale, y + 80*scale, scale)
			pancake.print("found it and destroyed it!", x+3*scale, y + 87*scale, scale)
		elseif text == 7 then
			love.graphics.draw(pancake.images.page, x, y, 0, scale)
			love.graphics.setColor(0.4, 0.3, 0.2, 1)
			pancake.print("Hutt again, today I have ", x+4*scale, y + 2*scale, scale)
			pancake.print("noticed that humans have", x+3*scale, y + 9*scale, scale)
			pancake.print("their own way to make", x+10*scale, y + 16*scale, scale)
			pancake.print("cheese. How ironic. Anyway,", x+0*scale, y + 23*scale, scale)
			pancake.print("I named this galaxy Milky", x+4*scale, y + 30*scale, scale)
			pancake.print(" Way for a reason and it", x+3*scale, y + 37*scale, scale)
			pancake.print("was supposed to be the ", x+4*scale, y + 44*scale, scale)
			pancake.print("biggest cheese warehouse", x+3*scale, y + 51*scale, scale)
			pancake.print("in the entire universe, but", x+3*scale, y + 58*scale, scale)
			pancake.print("it seems like all my hope is", x+2*scale, y + 65*scale, scale)
			pancake.print("lost, I am stuck here", x+6*scale, y + 72*scale, scale)
			pancake.print("forever. There is a human", x+2*scale, y + 80*scale, scale)
			pancake.print("base on the west though!", x+3*scale, y + 87*scale, scale)
		elseif text == 8 then
			love.graphics.draw(pancake.images.page, x, y, 0, scale)
			love.graphics.setColor(0.4, 0.3, 0.2, 1)
			pancake.print("I am about starve to death. ", x+0*scale, y + 2*scale, scale)
			pancake.print("Funny, considering I am on", x+3*scale, y + 9*scale, scale)
			pancake.print("something that is huge and", x+2*scale, y + 16*scale, scale)
			pancake.print("was suppose to be food... I", x+3*scale, y + 23*scale, scale)
			pancake.print("want the universe to know", x+2*scale, y + 30*scale, scale)
			pancake.print("HOW TO CRAFT CHEESE and", x+2*scale, y + 37*scale, scale)
			pancake.print("only I know how to do it  ", x+2*scale, y + 44*scale, scale)
			pancake.print("for now. Well, humans too.", x+3*scale, y + 51*scale, scale)
			pancake.print("If I die here, go and seek", x+4*scale, y + 58*scale, scale)
			pancake.print("for their base on the west", x+3*scale, y + 65*scale, scale)
			pancake.print("side of this moon.", x+18*scale, y + 72*scale, scale)
			pancake.print("P.S. I am dying, you are", x+8*scale, y + 80*scale, scale)
			pancake.print("the only hope for cheese!", x+3*scale, y + 87*scale, scale)
		elseif text == 9 then
			pancake.print("I have to get back to my", x+5*scale, y + 30*scale, scale)
			pancake.print("ship! - said our hero -", x+8*scale, y + 37*scale, scale)
			pancake.print("I can finally get the", x+10*scale, y + 44*scale, scale)
			pancake.print("cheese recipe!", x+20*scale, y + 51*scale, scale)
		elseif text == 11 then
			pancake.print("Chapter 3", x+16*scale, y + 26*scale, scale*2)
			pancake.print("Recipe hunger", x+24*scale, y + 50*scale, scale)
		elseif text == 10 then
			pancake.print("After returning to his", x+8*scale, y + 27*scale, scale)
			pancake.print("ship, he grabbed his trusty", x+2*scale, y + 34*scale, scale)
			pancake.print("pocket time stopper.", x+10*scale, y + 41*scale, scale)
			pancake.print("Press J to stop time!", x+12*scale, y + 60*scale, scale)
		elseif text == 12 then
			love.graphics.draw(pancake.images.page, x, y, 0, scale)
			love.graphics.setColor(0.4, 0.3, 0.2, 1)
			pancake.print("Cheese:", x+24*scale, y + 12*scale, 2*scale)
			pancake.print("To craft a cheese you take", x+2*scale, y + 30*scale, scale)
			pancake.print("some milk and then do", x+12*scale, y + 37*scale, scale)
			pancake.print("stuff with it...", x+22*scale, y + 44*scale, scale)
			pancake.print("Milk is a liquid that", x+16*scale, y + 51*scale, scale)
			pancake.print("comes out of cow. Cow", x+12*scale, y + 58*scale, scale)
			pancake.print("is an animal from Earth.", x+9*scale, y + 65*scale, scale)
		end
	end
end

function love.update(dt)
	pancake.update(dt) --Passing time between frames to pancake!
	if levelType == "ship" then
		pancake.window.offsetY = 0 --So that our ship is followed only on x coordinate!
		pancake.window.offsetX = pancake.window.offsetX + 24
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
		elseif ship.x > 2020 then
			ship.x = 2020
			ship.velocityX = 0
		end

	--GROUND
	elseif levelType == "ground" then
		if pancake.isButtonClicked(left) then
			pancake.applyForce(alien, {x = -70, relativeToMass = true})
			alien.flippedX = true
		end
		if pancake.isButtonClicked(right) then
			pancake.applyForce(alien, {x = 70, relativeToMass = true})
			alien.flippedX = false
		end
		if pancake.isButtonClicked(up) and pancake.facing(alien).down then
			pancake.applyForce(alien, {y = -32, relativeToMass = true},1)
		end
		if not pancake.facing(alien).down then
			alien.image = pancake.animations.alien.run[1]
		else
			if pancake.isButtonClicked(right) or pancake.isButtonClicked(left) then
				pancake.changeAnimation(alien, "run")
			else
				if alien.velocityX ~= 0 then
					alien.image = pancake.animations.alien.idle[1]
				else
					pancake.changeAnimation(alien, "idle")
				end
			end
		end
		if alien.x < 0 and level == 2 then
			alien.x = 0
			alien.velocityX = 0
		elseif alien.x > 0 and level == 3 then
			alien.x = 0
			alien.velocityX = 0
		end
		if level == 3 then
			if alien.timeStopped then
				for i = 1, #pancake.objects do
					if pancake.objects[i].name == "astronaut" then
						pancake.objects[i].image = "astronaut_idle1"
					end
				end
			end
		end
	end
end

function love.mousepressed(x,y,button)
	pancake.mousepressed(x,y,button) -- Passing your presses to pancake!
end

function love.keypressed(key)
	pancake.keypressed(key)
end
