--
-- Handles UI elements such as stats tracking.
--

local Class = require 'src.third_party.hump.class'

local UIHandler = Class {}

function UIHandler:init(game)
    self.owner = game
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

    love.graphics.print("Hull Integrity:  "..health, 10, love.graphics.getHeight() - 60)
    love.graphics.print("Asteroids Destroyed:  "..score, 10, love.graphics.getHeight() - 40)
end

return UIHandler
