-- this is where the logic for the disasteroids minigame will go.
local Class = require 'src.third_party.hump.class'
local Ship = require 'src.spaceship'
local Asteroid = require 'src.asteroid'
local Stars = require 'src.stars'
local Vector = require 'src.third_party.hump.vector'

local Disasteroids = Class{}

function Disasteroids:init(midpointX, midpointY, isActive)
    self.isActive = isActive
    self.asteroids = {}
    self.stars = Stars(100)
    table.insert(self.asteroids, Asteroid(3, 500, 500, Vector(10,20), .2))
    -- start the spaceship in the center of the screen
    self.ship = Ship(midpointX, midpointY)
end

function Disasteroids:update(dt)
    self.ship.thrustersOn = false

    if love.keyboard.isDown( "a" ) then
        self.ship:turn("left")
    elseif love.keyboard.isDown( "d" ) then
        self.ship:turn("right")
    end

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

    if love.keyboard.isDown(" ") then
        self.ship.shooting = true
    else
        self.ship.shooting = false
    end

    --update the bg
    self.stars:update(dt)
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
    self.ship:draw()
    for k,v in pairs(self.asteroids) do
      v:draw()
    end
end

return Disasteroids
