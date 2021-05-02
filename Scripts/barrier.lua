Barrier = Actor:extend()

function Barrier:new(world, x, y, sizex, sizey, winx, winy)
  Barrier.super.new(self, x, y, sizex, sizey)
  self.win = Vector.new(winx, winy)

  self.body = love.physics.newBody(world, self.win.x + self.position.x, self.win.y + self.position.y)
  self.shape = love.physics.newRectangleShape(self.size.x, self.size.y)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.fixture:setUserData("barrier")
  self.key = false
end

function Barrier:destroy()
  self.body:destroy()
  self.image = nil
  self = nil
end

function Barrier:ChangeColor()
  if self.key then
    love.graphics.setColor(0, 1, 0)
  else
    love.graphics.setColor(0.5, 0, 0.5)
  end
end

function Barrier:update(dt)
end

function Barrier:draw()
  self:ChangeColor()
  love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end
