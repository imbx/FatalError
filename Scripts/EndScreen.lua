EndScreen = Actor:extend ()

function EndScreen:new()
   self.background = love.graphics.newImage("Textures/shutdown.jpg")
end

function EndScreen:update(dt)

end

function EndScreen:draw()


love.graphics.draw(self.background, 0,0,0,1,1,0,0)

end
