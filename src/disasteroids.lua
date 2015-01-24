-- this is where the logic for the disasteroids minigame will go.
local Class = require 'src.third_party.hump.class'
local Ship = require 'src.spaceship'
local Asteroid = require 'src.asteroid'
local Stars = require 'src.stars'
local Vector = require 'src.third_party.hump.vector'
local BulletHandler = require 'src.bullets'

local Disasteroids = Class{}

function Disasteroids:init(midpointX, midpointY, isActive)
    self.isActive = isActive
    -- set up stars
    self.stars = Stars(100)
    -- start the spaceship in the center of the screen
    self.ship = Ship(midpointX, midpointY)
    -- set up asteroids
    self.asteroids = {}
    table.insert(self.asteroids, Asteroid(3, 500, 500, Vector(10,20), .2))
    -- set up bullet handling.
    self.bullethandler = BulletHandler()
    self.newBulletAvailable = true
end

function Disasteroids:update(dt)
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
    end

    -- Deal with shooting.
    if love.keyboard.isDown(" ") and self.newBulletAvailable then
        self.ship.shooting = 1
        self.bullethandler:addBullet(self.ship:location())
        self.newBulletAvailable = false
    elseif self.ship.shooting and self.ship.shooting < 3 then
        self.ship.shooting = self.ship.shooting + 1
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
    return
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
