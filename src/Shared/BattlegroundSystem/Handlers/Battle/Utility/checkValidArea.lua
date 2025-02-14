local function checkValidArea(unitPosition: CFrame, area: { max: Vector3, min: Vector3 })
    return (
        unitPosition.Position.X > area.min.X 
        and unitPosition.Position.X < area.max.X 
        and unitPosition.Position.Z > area.min.Z
        and unitPosition.Position.Z < area.max.Z  
	)
end

return checkValidArea