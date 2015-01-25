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

function asteroidImg(size)
    --get quad and picture for the asteroid
    if size == 2 then
        return AsteroidLargePic, AsteroidLargeQuad
    end
    if size == 1 then
        return AsteroidMedPic, AsteroidMedQuad
    end
    if size == 0 then
        return AsteroidSmallPic, AsteroidSmallQuad
    end
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
    local padding = radius(self.size)
    self.body:wrap(-padding, love.graphics.getWidth()+padding, -padding, love.graphics.getHeight()+padding)
    self.collision:moveTo(self.body.pos.x, self.body.pos.y)
end

-- Draw code
function Asteroid:draw()
    local pic
    local quad
    pic, quad = asteroidImg(self.size)
    if disasterManager:is("sensors") then
        --scale alpha if we are having sensor issues
        local alpha = 300 - minigame.ship.body.pos:dist(self.body.pos) / 2
        if alpha < 0 then alpha = 0 elseif alpha > 255 then alpha = 255 end
        love.graphics.setColor(alpha,alpha,255,alpha)
    end
    love.graphics.draw(pic, quad, self.body.pos.x, self.body.pos.y,
                       self.body.angle+math.pi/2, 1, 1, radius(self.size), radius(self.size))
    love.graphics.reset()
end
return Asteroid
