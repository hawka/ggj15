--
-- SPACESHIP LOGIC
--
Class = require 'src.third_party.HardonCollider.class'

Spaceship = Class {
    init = function(x, y)
        self.angle = 0
        self.speed = 0
        self.xpos = x
        self.ypos = y
    end
}

function Spaceship:turn(direction)
    -- calculate new angle and update xpos, ypos.
    if direction == 'left' then
        self.angle = (self.angle - 2) % 360
    elseif direction == 'right' then
        self.angle = (self.angle + 2) % 360
    else
        print('error: ship cannot turn in direction ' + direction)
    end
end

function Spaceship:accelerate()
    -- when the user presses 'w' the spaceship gains speed up to maxSpeed.
    local maxSpeed = 5 -- remember that speed degrades each move.
    local speedUp = 1
    self.speed = math.min(self.speed + speedUp, maxSpeed)
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

function Spaceship:location()
    -- return xpos, ypos, angle for rendering purposes.
    return self.xpos, self.ypos, self.angle
end
