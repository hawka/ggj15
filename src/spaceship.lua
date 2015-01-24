--
-- SPACESHIP LOGIC
--
local Class = require 'src.third_party.hump.class'
local Vector = require 'src.third_party.hump.vector'
local Movable =  require 'src.movable'
local Spaceship = Class {}

function Spaceship:init(x, y)
    self.body = Movable(x, y)
    self.thrustersOn = false
    self.shooting = false
end

function Spaceship:turn(direction)
    -- calculate new angle and update xpos, ypos.
    if direction == 'left' then
        self.body.angle = (self.body.angle - .1) % (math.pi * 2)
    elseif direction == 'right' then
        self.body.angle = (self.body.angle + .1) % (math.pi * 2)
    else
        print('error: ship cannot turn in direction ' + direction)
    end
end

function Spaceship:accelerate()
    -- when the user presses 'w' the spaceship gains speed up to maxSpeed.
    self.body.speed = self.body.speed + Vector(1,0):rotated(self.body.angle)
end

function Spaceship:decelerate()
    -- when the user presses 's' the spaceship loses speed up down to 0.
    self.body.speed = self.body.speed + Vector(1,0):rotated(self.body.angle+math.pi)
end

function Spaceship:update(dt)
    --updates the ship's speed * the time delta
    self.body.pos = self.body.pos + self.body.speed * dt
    local padding = 25
    self.body:wrap(-padding, love.graphics.getWidth()+padding, -padding,  love.graphics.getHeight()+padding)
end


function Spaceship:location()
    -- return xpos, ypos, angle for rendering purposes.
    return self.body.pos.x, self.body.pos.y, self.body.angle
end

--
-- Rendering functions
--
function Spaceship:draw()
    if self.thrustersOn then
        love.graphics.draw(ShipMovePic, ShipQuad, self.body.pos.x, self.body.pos.y,
                           self.body.angle+math.pi/2, 1, 1, 50, 50)
    elseif self.shooting then
        love.graphics.draw(ShipShootPic, ShipQuad, self.body.pos.x, self.body.pos.y,
                           self.body.angle+math.pi/2, 1, 1, 50, 50)
    else
        love.graphics.draw(ShipBasePic, ShipQuad, self.body.pos.x, self.body.pos.y,
                           self.body.angle+math.pi/2, 1, 1, 50, 50)
    end
end

return Spaceship
