--! Interface representing log 
Logger = Object:extend()

--! Class for logging on screen
ScreenLogger = Logger:extend()

function ScreenLogger:new()
    self.x = screen_logger_x
    self.y = screen_logger_y
    self.inc = screen_logger_inc
end

function ScreenLogger:log(...)
    love.graphics.setColor(0, 1, 0, 1)
    local offset = 0
    local arg = {...}
    for i,v in ipairs(arg) do
        love.graphics.print(v, self.x, self.y + offset) 
        offset = offset + self.inc
    end
 end