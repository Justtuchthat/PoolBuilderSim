-- textInputItem.lua
-- created by Justtuchthat
-- first created on 19-11-2020
-- last edited on 29-12-2020
-- this is used as a menu item to get text input

textInputItems = {}

function enterTextFunction(keyboard, mouse)
  for i, textInputItem in ipairs(textInputItems) do
    if not textInputItem.disabled then
      textInputItem.enterFunction(textInputItem.currentText)
    end
  end
end

function startTextInputItems()
  Keyboard:addKeyListener('enter')
  Keyboard.enter.firstPressActions:addFunction(enterTextFunction)
end

function newTextInputMenuItem(itemLoc, enterFunction, maxLength)
  textMenuItem = {}
  textMenuItem.maxLength = maxLength or 20
  textMenuItem.loc = itemLoc or {x=0,y=0}
  textMenuItem.currentText = ""
  textMenuItem.disabled = true
  textMenuItem.disable = function(self)
    self.disabled = true
  end
  textMenuItem.enable = function(self)
    self.currentText = ""
    self.disabled = false
  end
  textMenuItem.addLetter = function(self, char)
    if string.len(self.currentText) < self.maxLength then
      self.currentText = self.currentText .. char
    end
  end
  textMenuItem.deleteLetter = function(self)
    self.currentText = self.currentText:sub(1,-2)
  end
  textMenuItem.draw = function(self)
    local font = love.graphics.getFont()
    local text = love.graphics.newText(font, self.currentText)
    love.graphics.setColor(1, 1, 1, 1)
    textWidth, textHeight = text:getDimensions()
    if textHeight == 0 then
      textHeight = 14
    end
    love.graphics.rectangle("fill", self.loc.x, self.loc.y, textWidth + 10, textHeight)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.draw(text, self.loc.x + 5, self.loc.y)
  end
  textMenuItem.enterFunction = enterFunction
  table.insert(textInputItems, textMenuItem)
  textMenuItem:disable()
  return textMenuItem
end
