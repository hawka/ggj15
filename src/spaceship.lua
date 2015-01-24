--
-- SPACESHIP LOGIC
--
local Class = require 'src.third_party.hump.class'
local Vector = require 'src.third_party.hump.vector'
local Spaceship = Class {}

function Spaceship:init(x, y)
    self.angle = 0
    self.speed = Vector(0,0)
    self.pos = Vector(x,y)
end

function Spaceship:turn(direction)
    -- calculate new angle and update xpos, ypos.
    if direction == 'left' then
        self.angle = (self.angle - .1) 
    elseif direction == 'right' then
        self.angle = (self.angle + .1) --TODO limit by pi
    else
        print('error: ship cannot turn in direction ' + direction)
    end
end

function Spaceship:accelerate()
    -- when the user presses 'w' the spaceship gains speed up to maxSpeed.
    local maxSpeed = 5 -- remember that speed degrades each move.
    local speedUp = 1
    self.speed = self.speed + Vector(1,0):rotated(self.angle)
end

function Spaceship:decelerate()
    -- when the user presses 's' the spaceship loses speed up down to 0.
    local slowDown = 1 -- remember that speed degrades each move.
    self.speed = math.max(self.speed - slowDown, 0)
end


function Spaceship:move()
    -- calculate new position based on speed, angle, xpos, ypos.
    -- update speed, xpos, ypos as appropriate.

    -- TODO ship should move: update x and y coordinates.
    self.speed = math.max(self.speed - 1, 0) -- speed degrades each move until zero.
end

function Spaceship:update(dt)
    --updates the ship's speed * the time delta
    self.pos = self.pos + self.speed * dt
end


function Spaceship:location()
    -- return xpos, ypos, angle for rendering purposes.
    return self.pos.x, self.pos.y, self.angle
end

--
-- Rendering functions
--
function Spaceship:draw()
    print(self.pos)
    love.graphics.draw(ShipPic, ShipQuad, self.pos.x, self.pos.y, self.angle+math.pi/2, 1,1, 50, 50)
end

return Spaceship
