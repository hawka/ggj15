-- this is where the logic for the disasteroids minigame will go.
Class = require 'src.third_party.HardonCollider.class'
require 'src.spaceship'

Disasteroids = Class {
    init = function(midpointX, midpointY, isActive)
        self.isActive = isActive
        -- start the spaceship in the center of the screen
        self.ship = Spaceship(midpointX, midpointY)
    end
}
