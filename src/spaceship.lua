--
-- SPACESHIP LOGIC
--
local Class = require 'src.third_party.hump.class'
local Vector = require 'src.third_party.hump.vector'
local Movable =  require 'src.movable'
local Spaceship = Class {Acl = 1.5}

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
    self.body.speed = self.body.speed + Vector(Spaceship.Acl,0):rotated(self.body.angle)
end

function Spaceship:decelerate()
    -- when the user presses 's' the spaceship loses speed up down to 0.
    self.body.speed = self.body.speed + Vector(Spaceship.Acl,0):rotated(self.body.angle+math.pi)
end

function Spaceship:update(dt)
    --updates the ship's speed * the time delta
    self.body.pos = self.body.pos + self.body.speed * dt
    local padding = 25
    self.body:wrap(-padding, love.graphics.getWidth()+padding, -padding, love.graphics.getHeight()+padding)
end


function Spaceship:location()
    -- return xpos, ypos, angle, speed for rendering purposes.
    return self.body.pos.x, self.body.pos.y, self.body.angle, self.body.speed
end

--
-- Rendering functions
--
function Spaceship:draw()
    if self.thrustersOn == 1 and self.shooting then
        love.graphics.draw(ShipMoveShoot1Pic, ShipQuad, self.body.pos.x, self.body.pos.y,
                           self.body.angle+math.pi/2, 1, 1, 33, 30)
    elseif self.thrustersOn == 2 and self.shooting then
        love.graphics.draw(ShipMoveShoot2Pic, ShipQuad, self.body.pos.x, self.body.pos.y,
                           self.body.angle+math.pi/2, 1, 1, 33, 30)
    elseif self.thrustersOn == 3 and self.shooting then
        love.graphics.draw(ShipMoveShoot3Pic, ShipQuad, self.body.pos.x, self.body.pos.y,
                           self.body.angle+math.pi/2, 1, 1, 33, 30)
    elseif self.shooting then
        love.graphics.draw(ShipShootPic, ShipQuad, self.body.pos.x, self.body.pos.y,
                           self.body.angle+math.pi/2, 1, 1, 33, 30)
    elseif self.thrustersOn == 1 then
        love.graphics.draw(ShipMove1Pic, ShipQuad, self.body.pos.x, self.body.pos.y,
                           self.body.angle+math.pi/2, 1, 1, 33, 30)
    elseif self.thrustersOn == 2 then
        love.graphics.draw(ShipMove2Pic, ShipQuad, self.body.pos.x, self.body.pos.y,
                           self.body.angle+math.pi/2, 1, 1, 33, 30)
    elseif self.thrustersOn == 3 then
        love.graphics.draw(ShipMove3Pic, ShipQuad, self.body.pos.x, self.body.pos.y,
                           self.body.angle+math.pi/2, 1, 1, 33, 30)
    else
        love.graphics.draw(ShipBasePic, ShipQuad, self.body.pos.x, self.body.pos.y,
                           self.body.angle+math.pi/2, 1, 1, 33, 30)
    end
end

return Spaceship
