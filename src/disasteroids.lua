-- this is where the logic for the disasteroids minigame will go.
local Class = require 'src.third_party.hump.class'
local Ship = require 'src.spaceship'

local Disasteroids = Class{}

function Disasteroids:init(midpointX, midpointY, isActive)
    self.isActive = isActive
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
        self.ship.thrustersOn = true
        self.ship:accelerate()
    elseif love.keyboard.isDown("s") then
        self.ship:decelerate()
    end

    if love.keyboard.isDown(" ") then
        self.ship.shooting = true
    else
        self.ship.shooting = false
    end

    self.ship:update(dt)
    return
end

function Disasteroids:draw()
    self.ship:draw()
end

return Disasteroids
