--! Class representing player 1 
Player = Object:extend()

function Player:new()
    -- getting the image with the constant center
    self.image = love.graphics.newImage("gfx/triangle.png")
    -- setting initial dimensions
    self.speed = starting_speed
    -- image dimensions
    self.width = self.image:getWidth() 
    self.height = self.image:getHeight()
    -- image rotation angle
    self.angle = 0
    -- coordinates for drawing the image
    self.x = starting_width
    self.y = love.graphics.getHeight()-starting_height-self.height/2+starting_offset/2
    self.y_inc = love.graphics.getHeight()-starting_height-starting_size
    -- image center offset
    self.offset = 15
    self.offset_increment = 1
    self.timer = 1

    --triangle initial parameters
    self.size = starting_size
    self.c1x = 0
    self.c1y = self.size
    self.c2x = 0
    self.c2y = 0
    self.c_angle = 0
    self.d = 2 * math.pi * self.size/6
    self.degrees = 0
    self.radians = 0
    self.n = 0
    self.c3x=(self.c2x-self.c1x)*math.cos(math.rad(60))-(self.c2y-self.c1y)*math.sin(math.rad(60))+self.c1x
    self.c3y=(self.c2x-self.c1x)*math.sin(math.rad(60))+(self.c2y-self.c1y)*math.cos(math.rad(60))+self.c1y
end

function Player:triangle_update(inc)
    -- determining the location of the three vertices of the triangle by the rotation degree
    self.c_angle = self.c_angle + inc
    self.degrees = math.mod(self.c_angle, 120)
    self.n = math.floor(self.c_angle/120)
    self.radians = math.rad(self.degrees)
    if (self.degrees >=0) and (self.degrees <=60) then
        self.c1x =self.n * self.d + self.size*self.radians 
        self.c1y = self.size
        self.c2x = self.n * self.d + self.size * (self.radians - math.sin(self.radians))
        self.c2y = self.size * (1 - math.cos(self.radians))
    else
        self.c1x =self.n * self.d + self.d + self.size * math.sin(math.rad(self.degrees - 60))
        self.c1y = self.size * math.cos(math.rad(self.degrees - 60))
        self.c2x = self.n * self.d + self.d + self.size * math.cos(math.rad(210 - self.degrees))
        self.c2y = self.size * math.sin(math.rad(210 - self.degrees))
    end
    self.c3x=(self.c2x-self.c1x)*math.cos(math.rad(60))-(self.c2y-self.c1y)*math.sin(math.rad(60))+self.c1x
    self.c3y=(self.c2x-self.c1x)*math.sin(math.rad(60))+(self.c2y-self.c1y)*math.cos(math.rad(60))+self.c1y
end 

function Player:update(dt)
    --self:rotation_poc_timer()

    if love.keyboard.isDown("left") then
        self:triangle_update(-1* self.speed * dt)
    elseif love.keyboard.isDown("right") then
        self:triangle_update( self.speed * dt)
    end

    
end

function Player:draw()
    -- love.graphics.draw(self.image, self.x, self.y, math.rad(self.angle), 1,1, self.width/2, self.height/2+self.offset)
    love.graphics.polygon("line", self.c1x, self.y_inc +self.c1y, 
        self.c2x, self.y_inc +self.c2y,
        self.c3x, self.y_inc +self.c3y)
end

-- POC function to test the rotation of the image with center offset
function Player:rotation_poc_timer()
    self.timer = self.timer + 1
    -- We rotate every ten ticks of the timer
    if math.mod(self.timer,10)==0 then
        -- every time we rotate by 60 degrees
        self.angle = self.angle + 60 
        if self.angle == 0 then
            self.offset = 15
        elseif self.angle == 60 then   
            self.offset = -15
        elseif self.angle == 120 then
            self.offset = -75
        elseif self.angle == 180 then
            self.offset = -15
        elseif self.angle == 240 then   
            self.offset = -75
        elseif self.angle == 300 then
            self.offset = -15
        elseif self.angle == 360 then
            self.offset = 15
            -- after 360, rotation starts again
            self.angle = 0
        end
    end
end