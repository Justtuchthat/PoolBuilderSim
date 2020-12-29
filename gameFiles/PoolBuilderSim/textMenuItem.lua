-- textMenuItem.lua
-- created by Justtuchthat
-- created on 29-12-2020
-- last edited on 29-12-2020
-- this is used to create text menu items for simply displaying text

function newTextMenuItem(updateFunction, loc, color, mode)
  textMenuItem = {}
  textMenuItem.disabled = true
  textMenuItem.disable = function(self)
    self.disabled = true
  end
  textMenuItem.enable = function(self)
    self.disabled = false
  end
  textMenuItem.color = color or {0,0,0}
  textMenuItem.text = ""
  textMenuItem.drawableText = nil
  textMenuItem.draw = function(self)
    if self.disabled then return end
    love.graphics.setColor(self.color)
    love.graphics.draw(self.drawableText, self.loc.x, self.loc.y)
  end
  textMenuItem.updateFunction = updateFunction
  textMenuItem.update = function(self)
    self:updateFunction()
    self.drawableText = love.graphics.newText(love.graphics.getFont(), self.text)
  end
  textMenuItem.loc = loc
  textMenuItem:update()
  modes[mode].menuItems:addMenuItem(textMenuItem)
  return textMenuItem
end
