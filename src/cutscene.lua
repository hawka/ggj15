--
-- CUTSCENE LOGIC
--
local Class = require 'src.third_party.hump.class'
local Cutscene = Class {}
local CutsceneHandler = Class {}

function Cutscene:init(sceneType, disasterType)
    if sceneType = "Disaster" then
        -- TODO //
    elseif sceneType = "Asteroid" then
        -- TODO
    elseif sceneType = "Escaping" then
        -- TODO
    else
        print("Invalid cutscene type: " + sceneType)
    end
end

function CutsceneHandler:init(width, height, count)
    self.screenwidth = width
    self.screenheight = height

    self.scenes = {}
    self.scenes[0] = Cutscene("Asteroid", nil)
    self.scenes[1] = Cutscene("Disaster", ?)
    self.scenes[2] = Cutscene("Disaster", ?)
    self.scenes[3] = Cutscene("Escaping", nil)

    self.count = 0
end


