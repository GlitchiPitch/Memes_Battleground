local function getMagnitude(unit1: Model, unit2: Model)
    return (unit1:GetPivot().Position - unit2:GetPivot().Position).Magnitude
end

return getMagnitude