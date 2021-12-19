function love.load()
    target = {}
    target.radius = 50
    target.x = love.math.random(target.radius, love.graphics.getWidth() - target.radius)
    target.y = love.math.random(target.radius, love.graphics.getHeight() - target.radius)
    target.r = love.math.random()
    target.g = love.math.random()
    target.b = love.math.random()
    countdown = 0
    timer = 10
    score = 0
    gameFont = love.graphics.newFont(30)
    STOPPED = 0
    RUNNING = 1
    gameState = STOPPED
    
    sprites = {}
    sprites.sky = love.graphics.newImage('sprites/sky.png')
    sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')
    sprites.target = love.graphics.newImage('sprites/target.png')
    
    love.mouse.setVisible(false)
end

function love.update(dt)
    if timer > 0 then
        timer = timer - dt
    end
    
    if timer < 0 then
        timer = 0
    end

    countdown = countdown + dt
    if countdown >= 2 and gameState == RUNNING then
        resetTargetPos()
    end
end

function resetTargetPos()
    target.x = love.math.random(target.radius, love.graphics.getWidth() - target.radius)
    target.y = love.math.random(target.radius, love.graphics.getHeight() - target.radius)
    target.r = love.math.random()
    target.g = love.math.random()
    target.b = love.math.random()
    countdown = 0
end

function love.mousepressed(x, y, button)
    -- primary mouse button clicked
    if button == 1 and gameState == RUNNING then
        dist = distanceBetween(target.x, target.y, x, y)
        if dist <= target.radius then
            score = score + 1

            -- reset target x, y
            resetTargetPos()
        end
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    -- love.graphics.setColor(target.r, target.g, target.b)
    -- love.graphics.circle('fill', target.x, target.y, target.radius)
    -- draw background
    love.graphics.draw(sprites.sky, 0, 0)
    
    love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)

    -- draw score text
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gameFont)
    love.graphics.print('Score: ' .. score)
    
    -- draw timer text
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gameFont)
    love.graphics.print(string.format('Timer: %.0f', timer), 0, gameFont:getHeight() + 10)
    
    love.graphics.draw(sprites.crosshairs, love.mouse.getX() - sprites.crosshairs:getWidth() / 2, love.mouse.getY() - sprites.crosshairs:getHeight() / 2)
end

function distanceBetween(x1, y1, x2, y2)
    dist = math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
    return dist
end