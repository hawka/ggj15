--
-- this is where the logic for the disasteroids minigame will go.
--
local Class = require 'src.third_party.hump.class'
local Ship = require 'src.spaceship'
local Asteroid = require 'src.asteroid'
local AsteroidManager = require 'src.asteroid_manager'
local Stars = require 'src.stars'
local Vector = require 'src.third_party.hump.vector'
local Timer = require 'src.third_party.hump.timer'
local BulletHandler = require 'src.bullets'
local Collider = require 'src.third_party.hardoncollider'

local Disasteroids = Class{}

function onCollision(dt, shape_one, shape_two)
    -- Collider callback function.
    if shape_one.name == "bullet" then
        if shape_two.name == "asteroid" then
            shape_one.owner:remove()
            minigame.asteroidManager:destroyOrSplit(shape_two.owner)
            collider:remove(shape_one)
            collider:remove(shape_two)
        end
    elseif shape_one.name == "ship" then
        if shape_two.name == "asteroid" then
            shape_one.owner.health = shape_one.owner.health - 1
            -- TODO get rid of asteroid
        end
    elseif shape_one.name == "asteroid" then
        if shape_two.name == "ship" then
            shape_two.owner.health = shape_two.owner.health - 1
            -- TODO get rid of asteroid
        elseif shape_two == "bullet" then
            shape_two.owner:remove()
            minigame.asteroidManager:destroyOrSplit(shape_one.owner)
            collider:remove(shape_one)
            collider:remove(shape_two)
        end
    else
        print("unknown collision type: " + shape_one.name)
    end
end

function Disasteroids:init(midpointX, midpointY, isActive)
    self.isActive = isActive
    -- set up collider
    collider = Collider(100, onCollision)
    -- set up stars
    self.stars = Stars(100)
    -- start the spaceship in the center of the screen
    self.ship = Ship(midpointX, midpointY)
    -- set up asteroids
    self.asteroids = {}
    self.asteroidManager = AsteroidManager()
    self.asteroidManager:spawn(self.ship.body.pos)
    self.asteroidManager:spawn(self.ship.body.pos)
    self.asteroidManager:spawn(self.ship.body.pos)
    self.asteroidManager:spawn(self.ship.body.pos)
    self.asteroidManager:spawn(self.ship.body.pos)
    -- set up bullet handling.
    self.bullethandler = BulletHandler()
    self.newBulletAvailable = true
    self.timer = Timer.new()
    self.timer.addPeriodic(1, function() self.asteroidManager:spawn(self.ship.body.pos) end)
end

function Disasteroids:update(dt)
    -- Check for death.
    if self.ship.health < 1 then
        return
    end

    --update timer functions
    self.timer.update(dt)

    -- Check for collisions.
    collider:update(dt)

    -- Deal with turning.
    if love.keyboard.isDown( "a" ) then
        self.ship:turn("left")
    elseif love.keyboard.isDown( "d" ) then
        self.ship:turn("right")
    end

    -- Deal with acceleration.
    if love.keyboard.isDown("w") then
        if not self.ship.thrustersOn or self.ship.thrustersOn == 3 then
            self.ship.thrustersOn = 1
        else
            self.ship.thrustersOn = self.ship.thrustersOn + 1
        end
        self.ship:accelerate()
    elseif love.keyboard.isDown("s") then
        self.ship:decelerate()
        self.ship.thrustersOn = false
    else
        self.ship.thrustersOn = false
    end

    -- Deal with shooting.
    if love.keyboard.isDown(" ") and self.newBulletAvailable then
        self.ship.shooting = true
        self.bullethandler:addBullet(self.ship:location())
        self.newBulletAvailable = false
    elseif not love.keyboard.isDown(" ") then
        self.ship.shooting = false
        self.newBulletAvailable = true
    else
        self.ship.shooting = false
    end

    --update the bg
    self.stars:update(dt)
    --update the bullets
    self.bullethandler:update(dt)
    --update the player
    self.ship:update(dt)
    --update other entities
    self.asteroidManager:update(dt)

    return
end

function Disasteroids:draw()
    self.stars:draw()
    self.bullethandler:draw()
    self.asteroidManager:draw()
    self.ship:draw()
end

return Disasteroids
