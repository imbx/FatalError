DMenuBar = Actor:extend()

function DMenuBar:new(x, name, icon)
  DMenuBar.super.new(self, x, love.graphics.getHeight() - 23, 160, 22)
  self.name = name or "(untitled)"
  self.icon = love.graphics.newImage(icon or "Textures/win_icon.png")
  self.bg = love.graphics.newImage("Textures/bg_bar.png")
  self.bg:setWrap("repeat", "repeat")
  self.sicon = Vector.new(16, 16)
  self.bg_quad = love.graphics.newQuad(0, 0, self.size.x - 1, self.size.y - 1, self.bg:getWidth(), self.bg:getHeight())
  self.selected = true
end

function DMenuBar:update(dt)

end

function DMenuBar:draw()
  love.graphics.setColor(1, 1, 1)
  if self.selected then
    love.graphics.draw(self.bg, self.bg_quad, self.position.x, self.position.y)
    love.graphics.setColor(0, 0, 0)
    love.graphics.line(self.position.x, self.position.y + 20, self.position.x, self.position.y, self.position.x + (self.size.x - 2), self.position.y)
    love.graphics.setColor(0.52, 0.51, 0.52)
    love.graphics.line(self.position.x + 1, self.position.y + 19, self.position.x + 1, self.position.y + 1, (self.position.x + (self.size.x - 2)) - 1, self.position.y + 1)
    love.graphics.setColor(0.77, 0.76, 0.78)
    love.graphics.line(self.position.x + 1, (self.position.y + (self.size.y - 1)) - 1, (self.position.x + (self.size.x - 1)) - 1, (self.position.y + (self.size.y - 1)) - 1, (self.position.x + (self.size.x - 1)) - 1, self.position.y + 1)
    love.graphics.setColor(1, 1, 1)
    love.graphics.line(self.position.x + 3, self.position.y + 2, self.position.x + (self.size.x - 1) - 3, self.position.y + 2)
    love.graphics.line(self.position.x, self.position.y + (self.size.y - 1), self.position.x + (self.size.x - 1), self.position.y + (self.size.y - 1), self.position.x + (self.size.x - 1), self.position.y)
  else
    love.graphics.setColor(1, 1, 1)
    love.graphics.line(self.position.x, self.position.y + 20, self.position.x, self.position.y, self.position.x + (self.size.x - 2), self.position.y)
    love.graphics.setColor(0, 0, 0)
    love.graphics.line(self.position.x, self.position.y + (self.size.y - 1), self.position.x + (self.size.x - 1), self.position.y + (self.size.y - 1), self.position.x + (self.size.x - 1), self.position.y)
    love.graphics.setColor(0.52, 0.51, 0.52)
    love.graphics.line(self.position.x + 1, (self.position.y + (self.size.y - 1)) - 1, (self.position.x + (self.size.x - 1)) - 1, (self.position.y + (self.size.y - 1)) - 1, (self.position.x + (self.size.x - 1)) - 1, self.position.y + 1)
  end

  love.graphics.setColor(0, 0, 0)
  love.graphics.print(self.name, self.position.x + 22, self.position.y + 3)
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.icon, self.position.x + 4, self.position.y + 3)
end

function DMenuBar:CheckPos(mpos)
  if mpos.x > self.position.x and mpos.x < self.position.x + self.size.x - 1 and mpos.y > self.position.y and mpos.y < self.position.y + self.size.y - 1 then
    self.selected = true
  else self.selected = false end
end
