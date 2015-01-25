--
-- DISASTER LOGIC
--

local Class = require 'src.third_party.hump.class'
local Timer = require 'src.third_party.hump.timer'

DisasterManager = Class{}

function DisasterManager:init()
    self.disaster = ""
    self.disasters = {"nofuel","noslow","turnleft","turnright","controlswap","gunproblem","sensors"}
    self.timer = Timer.new()
    self:queueDisaster()
    self.readyToChange = false
    self:startCountdown()
end

function DisasterManager:is(dtype)
    return dtype == self.disaster
end

function DisasterManager:queueDisaster()
    -- pick the next disaster to do
    self.nextDisaster = self.disasters[math.random(1, #self.disasters)]
    if self.nextDisaster == self.disaster then
        self:queueDisaster() --keep trying
    end
end

function DisasterManager:startCountdown()
    local timetil = math.random(30,60)
    print("new disaster in...", timetil)
    self.readyToChange = false
    self.timer.add(timetil, function() self.readyToChange = true end)
end

function DisasterManager:newDisaster()
    self.disaster = self.nextDisaster
    self:queueDisaster()
    self:startCountdown()
end


function DisasterManager:update(dt)
    self.timer.update(dt)
end

return DisasterManager
