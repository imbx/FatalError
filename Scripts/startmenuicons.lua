startmenuicons = ImgActor:extend()

function startmenuicons:new(x, y, image)
    startmenuicons.super.new(self, image, x, y)
end

function startmenuicons:draw()
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

function startmenuicons:CheckPos(mpos)
  if mpos.x > self.position.x - self.size.x and mpos.x < self.position.x + self.size.x and mpos.y > self.position.y - (self.size.y * self.origin.y) and mpos.y < self.position.y + (self.size.y * self.origin.y) + 4 + (self.size.y * self.origin.y) then
    return true
  end
  return false
end
