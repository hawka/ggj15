-- 
-- base logic for all game entities
--
local Class = require 'src.third_party.hump.class'
local Vector = require 'src.third_party.hump.vector'

local Movable = Class{}

function Movable:init(x,y)
    -- sets basic values of angle, speed, and position
    self.angle = 0
    self.speed = Vector(0,0)
    self.pos = Vector(x,y)
end

function Movable:wrap(minX, maxX, minY, maxY) 
    -- wraps Movable around the screen when bounds are exceeded
    if self.pos.x < minX then
        self.pos.x = maxX - (minX - self.pos.x)
    elseif self.pos.x > maxX then
        self.pos.x = minX + (self.pos.x - maxX)
    end
    if self.pos.y < minY then
        self.pos.y = maxY - (minY - self.pos.y)
    elseif self.pos.y > maxY then
        self.pos.y = minY + (self.pos.y - maxY)
    end

end


return Movable
