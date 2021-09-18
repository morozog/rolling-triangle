--! Class representing player 1 
Player = Object:extend()

function Player:new()
    -- getting the image with the constant center
    self.image = love.graphics.newImage("gfx/triangle_centered.png")
    -- setting initial dimensions
    self.speed = starting_speed
    self.width = self.image:getWidth() 
    self.height = self.image:getHeight()
    self.angle = 0
    self.x = starting_width
    self.y = love.graphics.getHeight()-starting_height-self.height/2+starting_offset
    self.offset = 1
    self.offset_increment = 1
end

function Player:update(dt)
    if love.keyboard.isDown("left") then
        -- move the triangle left
        self.x = self.x - self.speed * dt
        -- rotat the triangle left
        self.angle = self.angle - 0.03
        -- move the triangle up/down match the terrain
        if self.offset >= starting_offset then
            self.offset_increment = -1
        elseif self.offset <= 0 then
            self.offset_increment = 1
        end 
        self.offset = self.offset + self.offset_increment
    elseif love.keyboard.isDown("right") then
        -- move the triangle right
        self.x = self.x + self.speed * dt
        -- rotate the triangle right
        self.angle = self.angle + 0.03
        -- move the triangle up/down to match the terrain
        if self.offset >= starting_offset then
            self.offset_increment = 1
        elseif self.offset <= 0 then
            self.offset_increment = -1
        end 
        self.offset = self.offset - self.offset_increment
    end
end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y-self.offset, self.angle, 1,1, self.width/2, self.height/2)
end