--
-- ASTEROID LOGIC
--

local Class = require 'src.third_party.hump.class'
local Vector = require 'src.third_party.hump.vector'
local Movable =  require 'src.movable'

local Asteroid = Class{}

function Asteroid:init(size,x,y, linearVelocity, angularVelocity)
    self.alive = true
    self.size = size -- tracks how many times it can be split
    self.body = Movable(x,y)
    self.body.speed = linearVelocity
    self.angularVelocity = angularVelocity -- rad/sec
end

function Asteroid:update(dt)
    -- updates the position and angle of the asteroid
    self.body.angle = self.body.angle + self.angularVelocity * dt
    self.body.pos = self.body.pos + self.body.speed * dt
    local padding = 20 * self.size
    self.body:wrap(-padding, love.graphics.getWidth()+padding, -padding,  love.graphics.getHeight()+padding)
end


-- Draw code
function Asteroid:draw()
        love.graphics.draw(AsteroidLargePic, AsteroidQuad, self.body.pos.x, self.body.pos.y,
                           self.body.angle+math.pi/2, 1, 1, 33, 30)
end




return Asteroid


