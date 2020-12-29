-- scrollSelector.lua
-- created by Justtuchthat
-- first created on 25-10-2020
-- last edited on 29-12-2020
-- this is used for creating and drawing a scrollable list

buttonHeight = 18

function newScrollButton(buttonInfo, buttonNo, loc, mode)
  scrollButton = newButton("text", newLocationObject(loc.x, loc.y+buttonHeight*buttonNo), buttonInfo.name, {0.8, 0.8, 0.8}, {1, 1, 1})
  scrollButton.pressAction:addFunction(buttonInfo.pressAction)
  return scrollButton
end

function newScrollableButtonSelector(selectorList, length, loc, mode)
  local scrollObject = {}
  scrollObject.loc = loc or newLocationObject(0,0);
  for i, selectorItem in ipairs(selectorList) do
    scrollObject[i] = newScrollButton(selectorItem, i-1, loc, mode)
  end
  scrollObject.isInView = function(self, item)
    item = item - 1
    if item < self.scrollOffset then return false end
    return item < self.scrollOffset + self.length
  end
  scrollObject.draw = function(self)
    if not self.disabled then
      for i, scrollItem in ipairs(self) do
        scrollItem:draw()
      end
    end
  end
  scrollObject.updateList = function(self, newList)
    for i, oldSelectoritem in ipairs(self) do
      scrollObject[i] = nil
    end
    for i, newSelectorItem in ipairs(newList) do
      scrollObject[i] = newScrollButton(newSelectorItem, i-1, self.loc, self.mode)
    end
  end
  scrollObject.checkAllowedToClick = function(self)
    for i, btn in ipairs(self) do
      if self:isInView(i) then
        btn:enable()
      else
        btn:disable()
      end
    end
  end
  scrollObject.mode = mode
  scrollObject.length = length
  scrollObject.scrollOffset = 0
  scrollObject.disabled = true
  scrollObject.disable = function(self)
    for i, btn in ipairs(self) do
      btn:disable()
    end
    self.disabled = true
  end
  scrollObject.enable = function(self)
    for i, btn in ipairs(self) do
      btn:enable()
    end
    self.disabled = false
  end
  scrollObject.getMaxScrollOffset = function(self)
    return (#self - 1) - self.length
  end
  scrollObject.scrollDown = function(self, amount)
    for i, scrlbtn in ipairs(self) do
      scrlbtn.loc.y = scrlbtn.loc.y - buttonHeight*amount
    end
  end
  scrollObject.scrollUp = function(self, amount)
    for i, scrlbtn in ipairs(self) do
      scrlbtn.loc.y = scrlbtn.loc.y + buttonHeight*amount
    end
  end
  mouse.scrollAction:addFunction(function(_, mouse)
    if scrollObject.mode == currentMode then
      if mouse.wheel.y < 0 then
        scrollAllowed = ((scrollObject.scrollOffset <= scrollObject:getMaxScrollOffset() and 1) or 0)
        scrollObject.scrollOffset = scrollObject.scrollOffset + scrollAllowed
        scrollObject:scrollDown(scrollAllowed)
      else
        scrollAllowed = ((scrollObject.scrollOffset > 0 and 1) or 0)
        scrollObject.scrollOffset = scrollObject.scrollOffset - scrollAllowed
        scrollObject:scrollUp(scrollAllowed)
      end
      scrollObject:checkAllowedToClick()
    end
  end)
  scrollObject.getHeight = function(self)
    return self.length*buttonHeight
  end
  modes[scrollObject.mode].menuItems:addMenuItem(scrollObject)
  scrollObject:checkAllowedToClick()
  return scrollObject
end
