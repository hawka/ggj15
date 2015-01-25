--
-- SPACESHIP LOGIC
--
local Class = require 'src.third_party.hump.class'
local Vector = require 'src.third_party.hump.vector'
local Movable =  require 'src.movable'
local Collider = require 'src.third_party.hardoncollider'
local Timer = require 'src.third_party.hump.timer'
local Spaceship = Class { ACL = 1.5 }
require 'src.third_party.TEsound'

function Spaceship:init(x, y)
    self.body = Movable(x, y)
    self.thrustersOn = false
    self.shooting = false
    self.health = 3
    self.invincible = false
    self.invincibleTimer = Timer.new()
    self.collision = collider:addRectangle(x-32, y-23, 40, 54)
    self.collision.name = "ship"
    self.collision.owner = self
end

function Spaceship:hurt()
    TEsound.play(DeathSound)
    if self.invincible then
        return --safe for now!
    end

    -- Hurt the ship. TODO--add sound
    self.health = self.health - 1
    if self.health > 0 then
        self:makeInvincible(3)
    end
end

function Spaceship:makeInvincible(sec)
    -- make spaceship invincible for "sec" amount of time
    self.invincible = true
    self.invincibleTimer.clear() --in case we have one set already, override it
    self.invincibleTimer.add(sec, function() self.invincible = false end)
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
    self.body.speed = self.body.speed + Vector(Spaceship.ACL,0):rotated(self.body.angle)
end

function Spaceship:decelerate()
    -- when the user presses 's' the spaceship loses speed up down to 0.
    self.body.speed = self.body.speed + Vector(Spaceship.ACL,0):rotated(self.body.angle+math.pi)
end

function Spaceship:update(dt)
    --updates the ship's speed * the time delta
    self.body.pos = self.body.pos + self.body.speed * dt
    local padding = 25
    self.body:wrap(-padding, love.graphics.getWidth()+padding, -padding, love.graphics.getHeight()+padding)
    self.invincibleTimer.update(dt)
    -- updates the collision object.
    self.collision:moveTo(self.body.pos.x, self.body.pos.y)
    self.collision:setRotation(self.body.angle)
end

function Spaceship:location()
    -- return xpos, ypos, angle, speed for rendering purposes.
    return self.body.pos.x, self.body.pos.y, self.body.angle, self.body.speed
end

--
-- Rendering functions
--
function Spaceship:draw()
    -- Deal with ship destruction rendering.
    if self.health < 1 then
        if self.health <= 0 and self.health > -4 then
            love.graphics.draw(ShipExplode1Pic, ShipExplodeQuad, self.body.pos.x, self.body.pos.y,
                               self.body.angle+math.pi/2, 1, 1, 40, 30)
        elseif self.health <= -4 and self.health > -8 then
            love.graphics.draw(ShipExplode2Pic, ShipExplodeQuad, self.body.pos.x, self.body.pos.y,
                               self.body.angle+math.pi/2, 1, 1, 40, 30)
        elseif self.health <= -8 and self.health > -12 then
            love.graphics.draw(ShipExplode3Pic, ShipExplodeQuad, self.body.pos.x, self.body.pos.y,
                               self.body.angle+math.pi/2, 1, 1, 40, 30)
        elseif self.health <= -12 then
            love.graphics.draw(ShipExplode4Pic, ShipExplodeQuad, self.body.pos.x, self.body.pos.y,
                               self.body.angle+math.pi/2, 1, 1, 40, 30)
            minigame:launchCutscene("dead")
            return
        end
        self.health = self.health - 0.3 --HACK THE PLANET XXX
        return
    end

    -- Deal with normal ship rendering.
    if self.invincible then
        love.graphics.setColor(255,200,200,150) --to show an invincible state (TODO?)
    end
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
    --reset color
    love.graphics.setColor(255,255,255,255)
end

return Spaceship
