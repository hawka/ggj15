function love.load()
    -- love calls this once, on game startup.
    -- this is the place to load resources, initialize variables, etc.

    -- 1. load required files.
    require 'src.disasteroids'

    -- 2. initialize global variables.
    gameIsPaused = false
    midpointX = love.graphics.getWidth()/2
    midpointY = love.graphics.getHeight()/2
    disasteroidsActive = true -- TODO switch to false
    diasteroidsInit(midpointX, midpointY) -- TODO move to minigame startup

    -- TODO
end

function love.update(dt)
    -- love calls this continuously.
    -- this is where most of the math and logic updates should happen.
    -- dt is delta time, the number of seconds since this function was last called.
    if gameIsPaused then
        return
    end
    -- TODO
end

function love.draw()
    -- love calls this continuously.
    -- this is where all the drawing happens.
    -- all love.graphics functions need to be called from within this function.
    if gameIsPaused then
        love.graphics.print("Game Paused", midpointX - 45, midpointY - 50)
        return -- TODO maybe don't return? instead, print this last?
    end
    -- TODO
end

function love.mousepressed(x, y, button)
    -- this is called whenever the mouse is pressed.
end

function love.mousereleased(x, y, button)
    -- this is called whenever the mouse is released.
end

function love.keypressed(key)
    -- this is called whenever a key is pressed.
    if key == 'p' then
        gameIsPaused = not gameIsPaused
    elseif key == 'a' and disasteroidsActive then
        spaceshipTurn('left')
    elseif key == 'd' and disasteroidsActive then
        spaceshipTurn('right')
    elseif key == 'w' and disasteroidsActive then
        -- TODO
    elseif key == 's' and diasteroidsActive then
        -- TODO
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
