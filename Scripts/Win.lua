Win = Actor:extend()

function Win:new(x, y, resx, resy, name, icon, posyt)
  Win.super.new(self, x, y, resx, resy)
  self.name = name or "(Untitled)"
  self.icon = love.graphics.newImage(icon or "Textures/win_icon.png")
  self.realsize = Vector.new(self.size.x - 6, self.size.y - 25)
  self.winI = Vector.new((self.position.x - (self.realsize.x * self.origin.x)) + 1, (self.position.y - ((self.realsize.y - 22) * self.origin.y)) + 2)
  self.winF = Vector.new((self.position.x + (self.realsize.x * self.origin.x)) - 1, (self.position.y + (self.realsize.y * self.origin.y + 3)) - 1)
  self.clsbtn = CloseBtn((self.position.x + (self.realsize.x * self.origin.x)) - 18, self.position.y - (self.size.y * self.origin.y) + 6)
  self.focused = false
  self.task = DMenuBar(posyt or 139, name, icon)
  self.savePos = Vector.new(0, 0)
  self.tempPos = Vector.new(0, 0)
  self.task.isSelected = self.focused
end

function Win:OnClose()
  self.task = nil
end

function Win:update(dt)
  if not d.mousemoving or self.tempPos ~= d.mousestart then
    self.savePos = self.position
  else
    local x, y = love.mouse.getPosition()
    self.position = Vector.new(x, y) + (self.savePos - self.tempPos)
  end
  self.clsbtn:setPos( self.position.x + (self.realsize.x * self.origin.x) - 18, self.position.y - (self.size.y * self.origin.y) + 6)

  self.winI.x = self.position.x - (self.realsize.x * self.origin.x) + 1
  self.winI.y = self.position.y - ((self.realsize.y - 22) * self.origin.y) + 2
  self.winF.x = self.position.x + (self.realsize.x * self.origin.x) - 1
  self.winF.y = self.position.y + (self.realsize.y * self.origin.y + 3) - 1
end

function Win:draw()
  self.task:draw()
  love.graphics.setColor(0, 0, 0) -- Black
  love.graphics.rectangle("fill", self.position.x - (self.size.x * self.origin.x), self.position.y - (self.size.y * self.origin.y), self.size.x, self.size.y) -- Bg
  love.graphics.setColor(1, 1, 1) -- White
  -- Here whatever you want
  -- VVV This after super.draw VVV
  self:DrawWin() -- Window
end

function Win:DrawWin()
  love.graphics.setColor(0.77, 0.76, 0.78)
  love.graphics.rectangle("line", self.position.x - (self.size.x * self.origin.x), self.position.y - (self.size.y * self.origin.y), self.size.x, self.size.y)
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("line", self.position.x - ((self.size.x * self.origin.x) - 1), self.position.y - ((self.size.y * self.origin.y) - 1), self.size.x - 2, self.size.y - 2)
  love.graphics.setColor(0.77, 0.76, 0.78)
  love.graphics.rectangle("line", self.position.x - ((self.size.x * self.origin.x) - 2), self.position.y - ((self.size.y * self.origin.y) - 2), self.size.x - 4, self.size.y - 4)
  love.graphics.setColor(0.52, 0.51, 0.52)
  love.graphics.line(self.position.x - ((self.size.x * self.origin.x) - 1), self.position.y + ((self.size.y * self.origin.y) - 1), self.position.x + ((self.size.x * self.origin.x) - 1), self.position.y + ((self.size.y * self.origin.y) - 1))
  love.graphics.setColor(0, 0, 0)
  love.graphics.line(self.position.x - (self.size.x * self.origin.x), self.position.y + (self.size.y * self.origin.y), self.position.x + (self.size.x * self.origin.x), self.position.y + (self.size.y * self.origin.y))
  love.graphics.setColor(0, 0.05, 0.49)
  love.graphics.rectangle("fill", self.position.x - ((self.size.x * self.origin.x) - 3), self.position.y - ((self.size.y * self.origin.y) - 3), self.size.x - 6, 18)
  love.graphics.setColor(0.77, 0.76, 0.78)
  love.graphics.line(self.position.x - ((self.size.x * self.origin.x) - 3), self.position.y - ((self.size.y * self.origin.y) - 22), self.position.x + ((self.size.x * self.origin.x) - 3), self.position.y - ((self.size.y * self.origin.y) - 22))
  love.graphics.draw(self.icon, self.position.x - (self.size.x * self.origin.x) + 6, self.position.y - (self.size.y * self.origin.y) + 3)
  love.graphics.printf(self.name, self.position.x - (self.size.x * self.origin.x) + 24, self.position.y - (self.size.y * self.origin.y) + 4, 160)
  self.clsbtn:draw()
end

function Win:keyPressed(key)
end

function Win:CheckPos(mpos)
  if self.clsbtn:CheckPos(mpos) then
    for i, k in ipairs(d.processes) do
      if k == self then
        table.remove(d.processes, i)
        self = nil
      end
    end
  else
    if mpos.x >= self.position.x - (self.size.x * self.origin.x) and mpos.x <= self.position.x + (self.size.x * self.origin.x) - 32 and mpos.y >= self.position.y - (self.size.y * self.origin.y) and mpos.y <= self.position.y - (self.size.y * self.origin.y) + 22 then
      return true
    end
    return false
  end
end
