CloseBtn = Actor:extend()

function CloseBtn:new(x, y)
  CloseBtn.super.new(self, x, y, 16, 14)
end

function CloseBtn:update(dt)
end

function CloseBtn:draw()
  love.graphics.setColor(0.77, 0.76, 0.78)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x - 1, self.size.y - 1)
  love.graphics.setColor(1, 1, 1)
  love.graphics.line(self.position.x, self.position.y + self.size.y - 2, self.position.x, self.position.y, self.position.x + self.size.x - 2, self.position.y)
  love.graphics.setColor(0.52, 0.51, 0.52)
  love.graphics.line(self.position.x + 1, self.position.y + self.size.y - 2, self.position.x + self.size.x - 2, self.position.y + self.size.y - 2, self.position.x + self.size.x - 2, self.position.y + 1)
  love.graphics.setColor(0, 0, 0)
  love.graphics.line(self.position.x, self.position.y + self.size.y - 1, self.position.x + self.size.x - 1, self.position.y + self.size.y - 1, self.position.x + self.size.x - 1, self.position.y)
  love.graphics.line(self.position.x + 5, self.position.y + 4, self.position.x + self.size.x - 6, self.position.y + self.size.y - 6)
  love.graphics.line(self.position.x + 5, self.position.y + self.size.y - 6, self.position.x + self.size.x - 6, self.position.y + 4)
  love.graphics.line(self.position.x , self.position.y,
  self.position.x + self.size.x , self.position.y,
  self.position.x + self.size.x, self.position.y + self.size.y,
  self.position.x, self.position.y + self.size.y,
  self.position.x , self.position.y)
end

function CloseBtn:CheckPos(mpos)
  if mpos.x >= self.position.x and mpos.x <= self.position.x + self.size.x and mpos.y >= self.position.y and mpos.y <= self.position.y + self.size.y then
    return true
  end
  return false
end
