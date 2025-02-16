local function calculateUnitCFrame(raycastResultPosition: Vector3, additionY: number)
	local placePosition = Vector3.new(
		raycastResultPosition.X,
		raycastResultPosition.Y + additionY,
		raycastResultPosition.Z
	)
	local cframe = CFrame.new(placePosition) * CFrame.Angles(0, math.rad(-90), 0)

	return cframe
end

return calculateUnitCFrame