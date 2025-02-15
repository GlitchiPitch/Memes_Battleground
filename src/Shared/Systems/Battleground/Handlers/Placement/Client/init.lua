local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Variables = script.Variables

local PlacementHandler = script.Parent
local Handlers = PlacementHandler.Parent
local BattlegroundSystem = Handlers.Parent
local Events = BattlegroundSystem.Events
local remote = Events.Remote

local PlacementConstants = require(PlacementHandler.Constants)
local remoteActions = require(remote.Actions)

local _connections: { RBXScriptConnection } = {}

local function mouseRaycast(camera: Camera, blacklist: { any })
	local mousePos = UserInputService:GetMouseLocation()
	local mouseRay = camera:ViewportPointToRay(mousePos.X, mousePos.Y)
	local raycastParams = RaycastParams.new()

	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = blacklist

	local raycastResult = workspace:Raycast(mouseRay.Origin, mouseRay.Direction * 1000, raycastParams)

	return raycastResult
end

local function colorPlaceholderUnit()
    local unitToSpawn = Variables.SelectedUnit.Value :: Model
	for _, object in unitToSpawn:GetDescendants() do
		if object:IsA("BasePart") then
			object.Color3 = PlacementConstants.SELECTED_UNIT_COLOR
		end
	end
end

local function updatePlaceOfUnit()
	if placement.canPossibleToPlace == false then
		return
	end

	local unit = nil
	for k, v in pairs(placement.units) do
		if v.Id == id then
			unit = v
			break;
		end
	end

	if not unit then 
		return
	end

	placement.unitReplacing = true
	placement.AddUnitPlacehodler(id) 
end

local function startPlaceUnit()
    table.insert(
        _connections,
        RunService.RenderStepped:Connect(updatePlaceOfUnit)
    )
end

local function onSelectedUnitChanged(value: Model?)
    if value then
        colorPlaceholderUnit()
        updatePlaceOfUnit()
    end
end

local function onSelectedUnitIdChanged(value: string)
    if value ~= "" then
        
    end
end

local function initialize()
    Variables.SelectedUnitId.Changed:Connect(onSelectedUnitIdChanged)
    Variables.SelectedUnit.Changed:Connect(onSelectedUnitChanged)
end

return {
    initialize = initialize,
}