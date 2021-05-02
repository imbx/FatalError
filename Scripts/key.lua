Key = ImgActor:extend()

function Key:new(world, x, y, winx, winy)
  Key.super.new(self, "Textures/key.png", x, y)
  self.win = Vector.new(winx, winy)

  self.body = love.physics.newBody(world, self.win.x + self.position.x, self.win.y + self.position.y)
  self.shape = love.physics.newRectangleShape(self.size.x, self.size.y)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.fixture:setUserData("key")
end

function Key:destroy()
  self.body:destroy()
  self.image = nil
  self = nil
end


function Key:update(dt)
end

function Key:draw()
  if self.image ~= nil then
    love.graphics.setColor(1, 1, 1)
    xx = self.win.x + self.position.x
    ox = self.origin.x
    yy = self.win.y + self.position.y
    oy = self.origin.y
    sx = self.scale.x
    sy = self.scale.y
    rr = self.rot
    love.graphics.draw(self.image, self.win.x + self.position.x - (self.size.x * self.origin.x), self.win.y + self.position.y - (self.size.y * self.origin.y))
  end
end
