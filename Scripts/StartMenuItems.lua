StartMenuItems = Actor:extend()

function StartMenuItems:new(x, y, title, image)
  StartMenuItems.super.new(self, x, y, 155, 40)
  self.name = title or "(Untitled)"
  self.image = love.graphics.newImage(image or "Textures/level_icon.png")
  self.isHover = false
end

function StartMenuItems:draw()
  love.graphics.setColor(0, 0, 0)
  if self.isHover then
    love.graphics.setColor(0, 0.07, 0.63)
    love.graphics.rectangle("fill", self.position.x - 4, self.position.y - 4, self.size.x, self.size.y - 2)
    love.graphics.setColor(1, 1, 1)
  end

  love.graphics.print(self.name, self.position.x + 45, self.position.y + (self.size.y * self.origin.y) - 14)
  love.graphics.setColor(1, 1, 1)
  xx = self.position.x
  ox = self.origin.x
  yy = self.position.y
  oy = self.origin.y
  sx = self.scale.x
  sy = self.scale.y
  rr = self.rot
  love.graphics.draw(self.image, xx, yy)
end

function StartMenuItems:CheckPos(mpos)
  if mpos.x > self.position.x - (self.size.x * self.origin.x) and mpos.x < self.position.x + (self.size.x * self.origin.x) and mpos.y > self.position.y - (self.size.y * self.origin.y) and mpos.y < self.position.y + (self.size.y * self.origin.y) then
    return true
  end
  return false
end
