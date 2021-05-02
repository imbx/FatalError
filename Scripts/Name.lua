Name = Actor:extend ()

function Name:new()
  self.background = love.graphics.newImage("Textures/opening.jpg")
end

function Name:update(dt)

end

function Name:draw()


  love.graphics.draw(self.background, 0, 0, 0, 1, 1, 0, 0)

end
