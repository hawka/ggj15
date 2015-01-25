--
-- STAR BACKGROUNDS
--
local Class = require 'src.third_party.hump.class'
local Vector = require 'src.third_party.hump.vector'
local Movable =  require 'src.movable'

local Starfield = Class {}
local Star = Class{}

--
-- individual star code
--
function Star:init(x, y, size, alpha)
    self.body = Movable(x,y)
    self.speed = math.random()
    self.size = size
    self.alpha = alpha
end

function Star:draw()
    love.graphics.setColor(255,255,255,self.alpha)
    love.graphics.setPointSize(self.size)
    love.graphics.point(self.body.pos.x, self.body.pos.y)
end

function Starfield:init(amount)
    self.stars = {}
    for i = 1,amount do
        local randomX = math.random(1, love.graphics.getWidth()-1)
        local randomY = math.random(1, love.graphics.getHeight()-1)
        table.insert(self.stars, Star(randomX, randomY, math.random(1,2), math.random(150,180)))
    end
end

function Starfield:update(dt)
    for k,v in pairs(self.stars) do
        v.body.pos.y = v.body.pos.y + v.speed
        v.body:wrap(0,love.graphics.getWidth(), 0, love.graphics.getHeight())
    end
end

function Starfield:draw()
    for k,v in pairs(self.stars) do
        v:draw()
    end
    love.graphics.setColor(255,255,255,255)
end

return Starfield
