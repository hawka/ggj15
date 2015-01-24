--
-- SPACESHIP LOGIC
--
local Class = require 'src.third_party.hump.class'
local Vector = require 'src.third_party.hump.vector'
local Spaceship = Class {}

function Spaceship:init(x, y)
    self.angle = 0
    self.speed = Vector(0,0)
    self.pos = Vector(x,y)
    self.thrustersOn = false
    self.shooting = false
end

function Spaceship:turn(direction)
    -- calculate new angle and update xpos, ypos.
    if direction == 'left' then
        self.angle = (self.angle - .1) % (math.pi * 2)
    elseif direction == 'right' then
        self.angle = (self.angle + .1) % (math.pi * 2)
    else
        print('error: ship cannot turn in direction ' + direction)
    end
end

function Spaceship:accelerate()
    -- when the user presses 'w' the spaceship gains speed up to maxSpeed.
    self.speed = self.speed + Vector(1,0):rotated(self.angle)
end

function Spaceship:decelerate()
    -- when the user presses 's' the spaceship loses speed up down to 0.
    self.speed = self.speed + Vector(1,0):rotated(-self.angle)
end

function Spaceship:update(dt)
    --updates the ship's speed * the time delta
    self.pos = self.pos + self.speed * dt
end


function Spaceship:location()
    -- return xpos, ypos, angle for rendering purposes.
    return self.pos.x, self.pos.y, self.angle
end

--
-- Rendering functions
--
function Spaceship:draw()
    if self.thrustersOn then
        love.graphics.draw(ShipMovePic, ShipQuad, self.pos.x, self.pos.y,
                           self.angle+math.pi/2, 1, 1, 50, 50)
    elseif self.shooting then
        love.graphics.draw(ShipShootPic, ShipQuad, self.pos.x, self.pos.y,
                           self.angle+math.pi/2, 1, 1, 50, 50)
    else
        love.graphics.draw(ShipBasePic, ShipQuad, self.pos.x, self.pos.y,
                           self.angle+math.pi/2, 1, 1, 50, 50)
    end
end

return Spaceship
