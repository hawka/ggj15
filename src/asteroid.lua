--
-- ASTEROID LOGIC
--

local Class = require 'src.third_party.hump.class'
local Vector = require 'src.third_party.hump.vector'
local Movable =  require 'src.movable'
local Collider = require 'src.third_party.hardoncollider'

local Asteroid = Class{}

function radius(size)
    --get the proper padding for the asteroid size
    if size == 2 then return 77/2 end
    if size == 1 then return 56/2 end
    if size == 0 then return 42/2 end
end

function Asteroid:init(size, x, y, linearVelocity, angularVelocity)
    self.alive = true
    self.size = size -- tracks how many times it can be split: 2, 1, 0
    self.body = Movable(x,y)
    self.body.speed = linearVelocity
    self.angularVelocity = angularVelocity -- rad/sec
    self.collision = collider:addCircle(x, y, radius(self.size))
    self.collision.name = "asteroid"
    self.collision.owner = self
end

function Asteroid:update(dt)
    -- updates the position and angle of the asteroid
    self.body.angle = self.body.angle + self.angularVelocity * dt
    self.body.pos = self.body.pos + self.body.speed * dt
    local padding = 2 * radius(self.size)
    self.body:wrap(-padding, love.graphics.getWidth()+padding, -padding, love.graphics.getHeight()+padding)
    self.collision:moveTo(self.body.pos.x, self.body.pos.y)
end

-- Draw code
function Asteroid:draw()
    love.graphics.draw(AsteroidLargePic, AsteroidLargeQuad, self.body.pos.x, self.body.pos.y,
                       self.body.angle+math.pi/2, 1, 1, radius(self.size), radius(self.size))
    self.collision:draw("line") -- TODO
end
return Asteroid
