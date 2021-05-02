UI = Actor:extend()

function UI:new(x, y, sizex, cd)
  UI.super.new(self, x, y, sizex, 5)
  self.currentWidth = 0
  self.cooldown = cd
end

function UI:update(dt)
  self.currentWidth = (self.size.x * self.cooldown:GetPercentage() ) / 100
end

function UI:draw()
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.currentWidth, self.size.y)
end
