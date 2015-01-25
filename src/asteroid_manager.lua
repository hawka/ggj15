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

function AsteroidManager:spawn(playerPos)
    local a = AsteroidManager:new(playerPos)
    self.asteroids[a] = a -- hack??
end

function AsteroidManager:destroyOrSplit(asteroid)
    -- destroy an asteroid and create 2 smaller ones, if possible
    local body = asteroid.body
    local oldSize = asteroid.size
    self.asteroids[asteroid] = nil
    print(oldSize, body.pos)
    if oldSize == 0 then
        score = score + 1
        return
    end

    -- else, we can split!
    local newSize = oldSize - 1
    -- TODO awful magic numbers
    local newSpeed1 =  Vector(math.random(-body.speed.x,body.speed.x), math.random(-body.speed.x,body.speed.x))
    local newSpeed2 = body.speed - newSpeed1
    local magic = oldSize*10
    new1 = Asteroid(newSize,
        body.pos.x + math.random(-magic,magic),
        body.pos.y + math.random(-magic,magic),
        newSpeed1, rotation + math.random())
    self.asteroids[new1] = new1
    new2 = Asteroid(newSize,
        body.pos.x + math.random(-magic,magic),
        body.pos.y + math.random(-magic,magic),
        newSpeed2, rotation + math.random())
    self.asteroids[new2] = new2 
end

function AsteroidManager:update(dt)
    for k,v in pairs(self.asteroids) do
      v:update(dt)
    end
end

function AsteroidManager:draw()
    for k,v in pairs(self.asteroids) do
        v:draw()
    end
end

function AsteroidManager:new(pVec)
    -- return an asteroid at a nice location
    local possiblePoint = nil
    while true do
        possiblePoint = newPointOnEdge()
        if not pointIsTooClose(pVec, possiblePoint) then break end
    end
    speed = Vector(math.random(-40,40), math.random(-40,40))
    rotation = math.random() / 2
    return Asteroid(2, possiblePoint.x, possiblePoint.y, speed, rotation)
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
            y = love.graphics.getHeight() + 20
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


function AsteroidManager:debugSplit()
--TODO this is a DEBUG function for splitting a single asteroid
for k,v in pairs(self.asteroids) do
    self:destroyOrSplit(v)
    break
end
end

return AsteroidManager
