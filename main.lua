function love.load()
    x = 100
end

function love.draw()
    love.graphics.polygon("fill", x,100, x+100,100, x+50,200)
end

function love.update(dt)
	if love.keyboard.isDown("left") then
        x = x - 5 * dt
    elseif love.keyboard.isDown("right") then
        x = x + 5 * dt
    end
end
