--
-- Bullet-time logic :) Handles moving and updating the bullets.
--

local Class = require 'src.third_party.hump.class'
local Vector = require 'src.third_party.hump.vector'
local Movable =  require 'src.movable'
local Bullet = Class {}
local BulletHandler = Class {}

--
-- BULLETHANDLER CLASS
--

function BulletHandler:init()
    self.bullets = {}
end

function BulletHandler:addBullet(x, y, angle, speed)
    -- this actually adds two bullets, one for each gun
    local vecA = Vector(30, -20):rotated(angle + math.pi/2);
    local vecB = Vector(-30, -20):rotated(angle + math.pi/2);
    bulletA = Bullet(x + vecA.x, y + vecA.y, angle, speed)
    bulletB = Bullet(x + vecB.x, y + vecB.y, angle, speed)
    self.bullets[bulletA] = true
    self.bullets[bulletB] = true
end

function BulletHandler:update(dt)
    for bullet,v in pairs(self.bullets) do
        if v and bullet.body:isOutsideBounds(0, love.graphics.getWidth(),
                                             0, love.graphics.getHeight()) then
            -- remove from tracked bullets
            self.bullets[bullet] = nil
        elseif v then
            bullet:update(dt)
        end
    end
end

function BulletHandler:draw()
    for bullet, v in pairs(self.bullets) do
        if v then
            bullet:draw()
        end
    end
end

--
-- BULLET CLASS
--

function Bullet:init(x, y, angle, speed)
    self.body = Movable(x, y)
    self.body.angle = angle -- to account for ship angle
    self.body.speed = speed + Vector(100, 0):rotated(self.body.angle)
end

function Bullet:update(dt)
    self.body.pos = self.body.pos + self.body.speed * dt
end

function Bullet:draw()
    love.graphics.setPointSize(2)
    love.graphics.setColor(255, 0, 0)
    love.graphics.point(self.body.pos.x, self.body.pos.y)
    love.graphics.reset()
end

return BulletHandler -- to account for ship angle
