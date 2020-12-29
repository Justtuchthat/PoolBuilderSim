-- currencyHandler.lua
-- created by Justtuchthat
-- first created on 09-10-2020
-- last edited on 29-12-2020
-- this is used for managing money

buildCost = {}
buildCost.grass = 0
buildCost.pool = 10

function resetMoney()
  money = 1000
end

function addMoney(additionalMoney)
  money = money + additionalMoney
  moneyText:update()
  return true
end

function removeMoney(cost)
  if cheatingMode then return true end
  if (money - cost) < 0 then
    return false
  else
    money = money - cost
    moneyText:update()
    return true
  end
end

function calculateBuildingCost(beginPointX, beginPointY, endPointX, endPointY, buildTile)
  buildCost = 0
  for x = beginPointX, endPointX do
    for y = beginPointY, endPointY do
      if not isInBounds(newLocationObject(x,y)) then return end
      buildCost = buildCost - tilePrice(y, x)
      buildCost = buildCost + knownTiles[buildTile].buildCost
    end
  end
  return buildCost
end
