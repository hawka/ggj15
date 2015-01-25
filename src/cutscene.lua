--
-- CUTSCENE LOGIC
--
local Class = require 'src.third_party.hump.class'
local Cutscene = Class {}

function Cutscene:init(game, disaster)
    self.owner = game
    self.active = 1
    self.charPicDraw = {}
    self.charQuadDraw = nil
    self.firstText = ""
    self.secondText = ""
    self.thirdText = ""
    self.responses = {}
    self.fourthText = ""

    if disaster == nil then
        -- TODO admiral?? self.charPicDraw[1] =
    elseif disaster == "nofuel" then
        self.charPicDraw[1] = Shark1Pic
        self.charPicDraw[2] = Shark2Pic
        self.charPicDraw[3] = Shark3Pic
        self.charQuadDraw = SharkQuad
        self.firstText = "PETTY OFFICER SPHYRNA:"
        self.secondText = "Sir! The fuel line has sprung a leak, we need to reroute it."
        self.thirdText = "Until this is complete, we cannot accelerate!"
        self.responses[1] = "What??? How do you expect us to avoid these asteroids?"
        self.responses[2] = "Very well, Petty Officer, do your best to fix it ASAP!"
        self.responses[3] = "As soon as we get out of this asteroid field, I'm THROWING YOU IN THE BRIG!"
        self.fourthText = "Good news, Sir! The fuel line has been rerouted."
    elseif disaster == "noslow" then
        self.charPicDraw[1] = Shark1Pic
        self.charPicDraw[2] = Shark2Pic
        self.charPicDraw[3] = Shark3Pic
        self.charQuadDraw = SharkQuad
        self.firstText = "PETTY OFFICER SPHYRNA:"
        self.secondText = "Sir! The reverse thrusters are malfunctioning: they need repairs."
        self.thirdText = "Until this is complete, we cannot slow down!"
        self.responses[1] = "I need a fix for this STAT! Use all available personnel."
        self.responses[2] = "Petty Officer, you are a disgrace to Her Majesty's Navy!"
        self.responses[3] = "Hold on, Sphyrna, this is going to be a rough ride."
        self.fourthText = "Sir! We have completed the repairs to the reverse thrusters."
    elseif disaster == "turnleft" then
        self.charPicDraw[1] = Cat1Pic
        self.charPicDraw[2] = Cat2Pic
        self.charPicDraw[3] = Cat3Pic
        self.charQuadDraw = CatQuad
        self.firstText = "ENGINEER MANX:"
        self.secondText = "Bad news, Captain. The right engine is on the fritz."
        self.thirdText = "Until we retune it, you won't be able to turn left."
        self.responses[1] = "Engineer Manx, you have ONE job. Pray that I don't find someone else to do it."
        self.responses[2] = "Please entreat your team to hurry: these asteroids are no joke."
        self.responses[3] = "Look here, you overblown hair ball ---"
        self.fourthText = "Captain, the engine is fully operational once more."
    elseif disaster == "turnright" then
        self.charPicDraw[1] = Cat1Pic
        self.charPicDraw[2] = Cat2Pic
        self.charPicDraw[3] = Cat3Pic
        self.charQuadDraw = CatQuad
        self.firstText = "ENGINEER MANX:"
        self.secondText = "Captain! A space cadet dropped his wrench in the left engine port."
        self.thirdText = "This ship can't turn right until we overhaul the engine!"
        self.responses[1] = "You leave me speechless, Engineer."
        self.responses[2] = "Very well, Engineer Manx. Do your best."
        self.responses[3] = "THROW THAT SPACE CADET OUT THE AIRLOCK!"
        self.fourthText = "Captain, the engine is fully operational once more."
    elseif disaster == "sensors" then
        self.charPicDraw[1] = Cat1Pic
        self.charPicDraw[2] = Cat2Pic
        self.charPicDraw[3] = Cat3Pic
        self.charQuadDraw = CatQuad
        self.firstText = "ENGINEER MANX:"
        self.secondText = "Captain: the long-range sensors are damaged."
        self.thirdText = "Until they're mended, we can only sense nearby asteroids."
        self.responses[1] = "Engineer, get off the comm and FIX THOSE SENSORS!!"
        self.responses[2] = "Manx, I've just about had it with you!"
        self.responses[3] = "YOU OVERGROWN HOUSECAT!! I'll have your fur for a coat!!"
        self.fourthText = "Captain, the long-range sensors are back online."
    elseif disaster == "controlswap" then
        self.charPicDraw[1] = Lady1Pic
        self.charPicDraw[2] = Lady2Pic
        self.charPicDraw[3] = Lady3Pic
        self.charQuadDraw = LadyQuad
        self.firstText = "GUNNER ADINOYA"
        self.secondText = "Life support is on the fritz, sir. Expect lower response times."
        self.thirdText = "You may find it hard to breathe and reason until air flow is restored."
        self.responses[1] = ""
        self.responses[2] = ""
        self.responses[3] = ""
        self.fourthText = "Captain, life support is restored: oxygen is returning to normal levels."
    elseif disaster == "gunproblem" then
        self.charPicDraw[1] = Lady1Pic
        self.charPicDraw[2] = Lady2Pic
        self.charPicDraw[3] = Lady3Pic
        self.charQuadDraw = LadyQuad
        self.firstText = "GUNNER ADINOYA"
        self.secondText = "Sir, the cannons are jamming. We need to clear the barrels."
        self.thirdText = "In the meantime, the cannons may misfire."
        self.responses[1] = ""
        self.responses[2] = ""
        self.responses[3] = ""
        self.fourthText = "Captain, the cannons are back online. Good hunting."
    else
        print("Invalid cutscene type: " + sceneType)
    end
end

function Cutscene:draw()
    if self.active then
        love.graphics.setColor(0, 0, 0, 200)
        love.graphics.rectangle("fill", 20, midpointY - 190, 700, 300)
        love.graphics.reset()
        love.graphics.draw(self.charPicDraw[math.ceil(self.active)], self.charQuadDraw,
                           130, midpointY - 60,
                           0, 1, 1, 87, 116)
        love.graphics.setFont(CutsceneFont)
        love.graphics.setColor(122, 226, 245, 255)
        love.graphics.rectangle("line", 20, midpointY - 190, 700, 300)
        love.graphics.print(self.firstText, 150, midpointY - 160)
        love.graphics.print(self.secondText, 150, midpointY - 145)
        love.graphics.print(self.thirdText, 150, midpointY - 130)
        -- TODO
        love.graphics.reset()
    end
end

function Cutscene:update()
    if self.active and self.active < 2.8 then
        self.active = self.active + 0.2
    elseif self.active and self.active >= 2.8 then
        self.active = 0.1
    end
    -- TODO check for response selection (numbers)
    -- TODO check for spacebar hit to end cutscene?
    if self.active and love.keyboard.isDown(" ") then
        self.active = false
        self.owner.cutscene = nil
    end
end

return Cutscene
