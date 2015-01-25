--
-- Bullet-time logic :) Handles moving and updating the bullets.
--

local Class = require 'src.third_party.hump.class'
local Vector = require 'src.third_party.hump.vector'
local Movable =  require 'src.movable'
local Collider = require 'src.third_party.hardoncollider'

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
        if v and bullet.body:isOutsideBounds(-30, love.graphics.getWidth()+30,
                                             -30, love.graphics.getHeight()+30) then
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
    self.body.speed = speed + Vector(200, 0):rotated(self.body.angle)
    self.collision = collider:addPoint(self.body.pos.x, self.body.pos.y)
    self.collision.name = "bullet"
    self.collision.owner = self
end

function Bullet:update(dt)
    self.body.pos = self.body.pos + self.body.speed * dt
    self.collision:moveTo(self.body.pos.x, self.body.pos.y)
end

function Bullet:draw()
    love.graphics.setPointSize(3)
    love.graphics.setColor(255, 0, 0)
    love.graphics.point(self.body.pos.x, self.body.pos.y)
    love.graphics.reset()
end

function Bullet:remove()
    -- This is a hack. By moving the bullet outside of the play space,
    -- we ensure it will be removed from the BulletHandler's consideration
    -- on the next call to update. Make sure no asteroids ever go this far.
    self.body.pos = Vector(-500, -500)
    self.body.speed = Vector(0, 0)
end

return BulletHandler
