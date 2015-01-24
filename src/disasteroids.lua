-- this is where the logic for the disasteroids minigame will go.

function diasteroidsInit(midpointX, midpointY)
    -- start the spaceship in the center of the screen
    spaceshipInit(midpointX, midpointY)
end

--
-- SPACESHIP LOGIC
--

function spaceshipInit(x, y)
    spaceshipAngle = 0
    spaceshipSpeed = 0
    spaceshipXPos = x
    spaceshipYPos = y
end

function spaceshipTurn(direction)
    -- calculate new spaceshipAngle and update spaceshipXPos, spaceshipYPos.
    if direction == 'left' then
        spaceshipAngle = (spaceshipAngle - 2) % 360
    elseif direction == 'right' then
        spaceshipAngle = (spaceshipAngle + 2) % 360
    else
        print('error: ship cannot turn in direction ' + direction)
    end
end

function spaceshipAccelerate()
    -- when the user presses 'w' the spaceship gains speed up to maxSpeed.
    local maxSpeed = 5 -- remember that speed degrades each spaceshipMove.
    local speedUp = 1
    speed = math.min(speed + speedUp, maxSpeed)
end

function spaceshupDecelerate()
    -- when the user presses 's' the spaceship loses speed up down to 0.
    local slowDown = 1 -- remember that speed degrades each spaceshipMove.
    speed = math.max(speed - slowDown, 0)
end

function spaceshipMove()
    -- calculate new position based on spaceshipSpeed, spaceshipAngle, spaceshipXPos, spaceshipYPos.
    -- update spaceshipSpeed, spaceshipXPos, spaceshipYPos as appropriate.

    -- TODO ship should move: update x and y coordinates.

    speed = math.max(speed - 1, 0) -- speed degrades each spaceshipMove until zero.
end

function spaceshipLocation()
    -- return spaceshipXPos, spaceshipYPos, spaceshipAngle for rendering purposes.
    return spaceshipXPos, spaceshipYPos, spaceshipAngle
end

--
-- ASTEROID LOGIC - TODO maybe in a diff file?
--
