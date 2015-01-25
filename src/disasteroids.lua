--
-- this is where the logic for the disasteroids minigame will go.
--
local Class = require 'src.third_party.hump.class'
local Ship = require 'src.spaceship'
local Asteroid = require 'src.asteroid'
local AsteroidManager = require 'src.asteroid_manager'
local Stars = require 'src.stars'
local Vector = require 'src.third_party.hump.vector'
local BulletHandler = require 'src.bullets'
local Collider = require 'src.third_party.hardoncollider'

local Disasteroids = Class{}

function onCollision(dt, shape_one, shape_two)
    -- Collider callback function.
    print("bang!")
    -- TODO
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
    table.insert(self.asteroids, AsteroidManager:spawn(self.ship.body.pos))
    table.insert(self.asteroids, AsteroidManager:spawn(self.ship.body.pos))
    table.insert(self.asteroids, AsteroidManager:spawn(self.ship.body.pos))
    table.insert(self.asteroids, AsteroidManager:spawn(self.ship.body.pos))
    -- set up bullet handling.
    self.bullethandler = BulletHandler()
    self.newBulletAvailable = true
end

function Disasteroids:update(dt)
    -- Check for collisions.
    collider:update(dt)

    if self.ship.health < 1 then
        -- TODO
        print("YOU LOST SUCKER")
        return
    end

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
    for k,v in pairs(self.asteroids) do
      v:update(dt)
    end
end

function Disasteroids:draw()
    self.stars:draw()
    self.bullethandler:draw()
    self.ship:draw()
    for k,v in pairs(self.asteroids) do
      v:draw()
    end
end

return Disasteroids
