--
-- Handles UI elements such as stats tracking.
--

local Class = require 'src.third_party.hump.class'

local UIHandler = Class {}

function UIHandler:init(game)
    self.owner = game
    self.text = {}
    self.text["nofuel"] = "Fuel Line Rerouted"
    self.text["noslow"] = "Reverse Thrusters Repaired"
    self.text["turnleft"] = "Left Engine Overhauled"
    self.text["turnright"] = "Right Engine Retuned"
    self.text["controlswap"] = "Life Support Restored"
    self.text["gunproblem"] = "Cannon Malfunction Fixed"
    self.text["sensors"] = "Sensors Back Online"
end

function UIHandler:draw()
    love.graphics.setFont(SmallFont)

    local health = "Destroyed"
    if self.owner.ship.health == 3 then
        health = "Undamaged"
    elseif self.owner.ship.health == 2 then
        health = "Breach in Sector 3"
    elseif self.owner.ship.health == 1 then
        health = "Multiple Hull Breaches"
    end

    love.graphics.print("Hull Integrity:  "..health, 10, love.graphics.getHeight() - 150)

    love.graphics.print("Asteroids Destroyed:  "..score, 10, love.graphics.getHeight() - 130)

    local numDisasters = 0
    for disaster,status in pairs(self.owner.disasters) do
        if status then
            love.graphics.print("ETA til "..self.text[disaster]..":  "..status.."s",
                                10, love.graphics.getHeight() - 110 - numDisasters*20)
            numDisasters = numDisasters + 1
        end
    end
end

return UIHandler
