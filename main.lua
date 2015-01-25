Class = require 'src.third_party.hump.class' -- `Class' is now a shortcut to new()
Disasteroids = require 'src.disasteroids'
local DisasterManager = require 'src.disasters'

-- for better random numbers
math.randomseed( os.time() )

function love.load()
    -- love calls this once, on game startup.
    -- this is the place to load resources, initialize variables, etc.

    -- 1. load required files.
    -- IMAGES
    ShipBasePic = love.graphics.newImage('res/ship/base.gif')
    ShipMove1Pic = love.graphics.newImage('res/ship/move1.gif')
    ShipMove2Pic = love.graphics.newImage('res/ship/move2.gif')
    ShipMove3Pic = love.graphics.newImage('res/ship/move3.gif')
    ShipShootPic = love.graphics.newImage('res/ship/shoot.gif')
    ShipMoveShoot1Pic = love.graphics.newImage('res/ship/moveshoot1.gif')
    ShipMoveShoot2Pic = love.graphics.newImage('res/ship/moveshoot2.gif')
    ShipMoveShoot3Pic = love.graphics.newImage('res/ship/moveshoot3.gif')

    ShipQuad = love.graphics.newQuad(0, 0, 66, 60, ShipBasePic:getDimensions())

    ShipExplode1Pic = love.graphics.newImage('res/ship/explode1.gif')
    ShipExplode2Pic = love.graphics.newImage('res/ship/explode2.gif')
    ShipExplode3Pic = love.graphics.newImage('res/ship/explode3.gif')
    ShipExplode4Pic = love.graphics.newImage('res/ship/explode4.gif')

    ShipExplodeQuad = love.graphics.newQuad(0, 0, 80, 60, ShipExplode1Pic:getDimensions())

    AsteroidLargePic = love.graphics.newImage('res/asteroids/asteroidlarge.gif')
    AsteroidLargeQuad = love.graphics.newQuad(0, 0, 77, 77, AsteroidLargePic:getDimensions())
    AsteroidMedPic = love.graphics.newImage('res/asteroids/asteroidmed.gif')
    AsteroidMedQuad = love.graphics.newQuad(0, 0, 56, 56, AsteroidMedPic:getDimensions())
    AsteroidSmallPic = love.graphics.newImage('res/asteroids/asteroidsmall.gif')
    AsteroidSmallQuad = love.graphics.newQuad(0, 0, 42, 42, AsteroidSmallPic:getDimensions())

    Admiral1Pic = love.graphics.newImage('res/characters/admiral1.gif')
    Admiral2Pic = love.graphics.newImage('res/characters/admiral2.gif')
    Admiral3Pic = love.graphics.newImage('res/characters/admiral3.gif')
    AdmiralQuad = love.graphics.newQuad(0, 0, 87, 116, Admiral1Pic:getDimensions())
    Shark1Pic = love.graphics.newImage('res/characters/shark1.gif')
    Shark2Pic = love.graphics.newImage('res/characters/shark2.gif')
    Shark3Pic = love.graphics.newImage('res/characters/shark3.gif')
    SharkQuad = love.graphics.newQuad(0, 0, 87, 116, Shark1Pic:getDimensions())
    Cat1Pic = love.graphics.newImage('res/characters/cat1.gif')
    Cat2Pic = love.graphics.newImage('res/characters/cat2.gif')
    Cat3Pic = love.graphics.newImage('res/characters/cat3.gif')
    CatQuad = love.graphics.newQuad(0, 0, 87, 116, Cat1Pic:getDimensions())
    Lady1Pic = love.graphics.newImage('res/characters/lady1.gif')
    Lady2Pic = love.graphics.newImage('res/characters/lady2.gif')
    Lady3Pic = love.graphics.newImage('res/characters/lady3.gif')
    LadyQuad = love.graphics.newQuad(0, 0, 87, 116, Lady1Pic:getDimensions())

    -- FONTS
    love.graphics.setDefaultFilter("nearest", "nearest")
    CutsceneFont = love.graphics.newFont('res/fonts/Jura-DemiBold.ttf', 14)
    SmallFont = love.graphics.newFont('res/fonts/Jura-DemiBold.ttf', 20)

    -- SOUNDS
    ExpSound1 = "res/sfx/explosion1.ogg"
    ExpSound2 = "res/sfx/explosion2.ogg"
    ExpSound3 = "res/sfx/explosion3.ogg"
    ExpSounds = {ExpSound1, ExpSound2, ExpSound3}
    LaserSound = "res/sfx/shoot.ogg"
    DeathSound = "res/sfx/death.ogg"
    MenuSound = "res/sfx/menu.ogg"

    -- 2. initialize global variables.
    gameIsPaused = false
    midpointX = love.graphics.getWidth()/2
    midpointY = love.graphics.getHeight()/2
    disasterManager = DisasterManager()
    round = 0
    minigame = Disasteroids(midpointX, midpointY, true, round+5) -- TODO move to minigame startup
    -- number of asteroids destroyed
    score = 0
end

function love.update(dt)
    -- love calls this continuously.
    -- this is where most of the math and logic updates should happen.
    -- dt is delta time, the number of seconds since this function was last called.
    if gameIsPaused then
        return
    end

    if minigame.isActive and not minigame.cutscene then
        disasterManager:update(dt)
        minigame:update(dt)

        if disasterManager.readyToChange then
            disasterManager:newDisaster()
            TEsound.play(MenuSound)
            minigame:launchCutscene(disasterManager.disaster)
            minigame:resetRound()
        end
    elseif minigame.isActive and minigame.cutscene then
        minigame.cutscene:update()
    end
end

function love.draw()
    -- love calls this continuously.
    -- this is where all the drawing happens.
    -- all love.graphics functions need to be called from within this function.
    if minigame.isActive then
        minigame:draw()
    end
    if gameIsPaused then
        love.graphics.setFont(SmallFont)
        love.graphics.print("( Game Paused )", midpointX - 90, midpointY - 50)
    end
end

function love.mousepressed(x, y, button)
    -- this is called whenever the mouse is pressed.
end

function love.mousereleased(x, y, button)
    -- this is called whenever the mouse is released.
end

function love.keypressed(key, isrepeat)
    -- this is called whenever a key is pressed.
    if key == 'p' then
        gameIsPaused = not gameIsPaused
    end
    if key == '0' and not minigame.cutscene then
        disasterManager:newDisaster()
        TEsound.play(MenuSound)
        minigame:launchCutscene(disasterManager.disaster)
        minigame:resetRound()
    end

end

function love.keyreleased(key)
    -- this is called whenever a key is released.
end

function love.focus(f)
    -- this is called whenever the user clicks off and on the window.
    gameIsPaused = not f
end

function love.quit()
    -- this is called on quit.
    -- if we want to save state, that goes here.
end
