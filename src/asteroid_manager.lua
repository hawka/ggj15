--
-- MANAGER FOR ASTEROIDS
--
local Class = require 'src.third_party.hump.class'
local Asteroid = require 'src.asteroid'
local Vector = require 'src.third_party.hump.vector'

local AsteroidManager = Class {}

function AsteroidManager:init() 
    self.asteroids = {}
end    

function AsteroidManager:spawn(pVec)
    local possiblePoint = nil 
    while true do
        possiblePoint = newPointOnEdge()
        if not pointIsTooClose(pVec, possiblePoint) then break end
    end
    speed = Vector(math.random(1,40), math.random(1,40))
    rotation = math.random() / 2
    return Asteroid(3, possiblePoint.x, possiblePoint.y, speed, rotation)
end

function randBool() 
    local array = {true, false}
    return array[math.random(1,2)]
end

function newPointOnEdge()
    -- this janky friggin function generates a random point
    -- along the edge of the screen
    local randomX = math.random(0, love.graphics.getWidth())
    local randomY = math.random(0, love.graphics.getHeight())
    local x = 0
    local y = 0

    if randBool() then -- push to top or bottom
        x = randomX
        if randBool then --top
            y = -30
        else --bottom
            y = love.graphics.getHeight() + 30
        end
    else
        y = randomY
        if randBool then --left
            x = -30
        else --right
            x = love.graphics.getWidth() + 30
        end
    end

    return Vector(x,y)
end

function pointIsTooClose(pVec, aVec)
    -- hacky function to prevent spawning an asteroid too close
    -- to the player
    local distanceFromPlayer = 50
    if pVec:dist(aVec) < distanceFromPlayer then
        return true
    elseif math.abs(pVec.x - aVec.x) < distanceFromPlayer then
        return true
    elseif math.abs(pVec.y - aVec.x) < distanceFromPlayer then
        return true
    end
    return false

end

return AsteroidManager
