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
end

function UIHandler:draw()
    love.graphics.setFont(SmallFont)
    love.graphics.print("Hull Integrity:  "..self.owner.ship.health, 10, love.graphics.getHeight() - 150)
    love.graphics.print("Asteroids Destroyed:  "..self.owner.score, 10, love.graphics.getHeight() - 130)
    local numDisasters = 0
    for disaster,status in pairs(self.owner.disasters) do
        if status then
            love.graphics.print("ETA for "..self.text[disaster]..":  "..status.."s",
                                10, love.graphics.getHeight() - 110 - numDisasters*20)
            numDisasters = numDisasters + 1
        end
    end
end

return UIHandler
