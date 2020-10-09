-- currencyHandler.lua
-- created by Justtuchthat
-- first created on 09-10-2020
-- last edited on 09-10-2020
-- this is used for managing money

buildCost = {}
buildCost.grass = 0
buildCost.pool = 10

money = 0

function addMoney(additionalMoney)
  money = money + additionalMoney
end

function removeMoney(cost)
  if cheatingMode then return true end
  if (money - cost) < 0 then
    return false
  else
    money = money - cost
    return true
  end
end

function calculateBuildingCost(beginPointX, beginPointY, endPointX, endPointY, buildTile)
  buildCost = 0
  for x = beginPointX, endPointX do
    for y = beginPointY, endPointY do
      buildCost = buildCost - tilePrice(y, x)
      buildCost = buildCost + knownTiles[buildTile].buildCost
    end
  end
  return buildCost
end
