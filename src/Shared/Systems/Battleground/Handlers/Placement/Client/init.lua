local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")


local Variables = script.Variables

local PlacementHandler = script.Parent
local Handlers = PlacementHandler.Parent
local BattlegroundSystem = Handlers.Parent
local Events = BattlegroundSystem.Events

local Constants = require(BattlegroundSystem.Constants)

local remote = Events.Remote
local remoteActions = require(remote.Actions)

local camera = workspace.CurrentCamera
local player = Players.LocalPlayer

local _connections: { [string]: RBXScriptConnection } = {}
local _connectionKeys = {
	onInputBegan = "onInputBegan",
	remoteConnect = "remoteConnect",
	updatePlaceOfUnit = "updatePlaceOfUnit",
	onSelectedUnitChanged = "onSelectedUnitChanged",
	onSelectedUnitIdChanged = "onSelectedUnitIdChanged",
}

-- add different contorls for devices
local _inputKeys: { [string]: { [string]: Enum.KeyCode} } = {
	PlaceUnit = {
		
	},

}

local _raycastBlackList: { any } = {}

local function calculateUnitCFrame(raycastResultPosition: Vector3, additionY: number)
	local placePosition = Vector3.new(
		raycastResultPosition.X,
		raycastResultPosition.Y + additionY,
		raycastResultPosition.Z
	)
	local cframe = CFrame.new(placePosition) * CFrame.Angles(0, math.rad(-90), 0)

	return cframe
end

local function mouseRaycast() : RaycastResult
	local mousePos = UserInputService:GetMouseLocation()
	local mouseRay = camera:ViewportPointToRay(mousePos.X, mousePos.Y)
	local raycastParams = RaycastParams.new()

	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = _raycastBlackList

	local raycastResult = workspace:Raycast(mouseRay.Origin, mouseRay.Direction * 1000, raycastParams)

	return raycastResult
end

local function checkValidRaycastResult(raycastResult: RaycastResult)
	local instance = raycastResult and raycastResult.Instance
	local playerTeam = player:GetAttribute(Constants.PLAYER_TEAM_ATTRIBUTE)
	local isArenaFloor = instance and instance.Name == `ArenaFloor{playerTeam}`
	return isArenaFloor
end

local function colorPlaceholderUnit(canSpawn: boolean)
    local unitToSpawn = Variables.SelectedUnit.Value :: Model
	local color = canSpawn and Constants.CAN_SPAWN_UNIT_COLOR or Constants.COULD_NOT_SPAWN_UNIT_COLOR
	for _, object in unitToSpawn:GetDescendants() do
		if object:IsA("BasePart") then
			object.Color3 = color
		end
	end
end

local function placeUnit()
	local raycastResult = mouseRaycast()
	local unitToSpawn = Variables.SelectedUnit.Value :: Model
	if not checkValidRaycastResult(raycastResult) or not unitToSpawn then
		return
	end

	local cframe = calculateUnitCFrame(raycastResult.Position, unitToSpawn.Humanoid.HipHeight + unitToSpawn.PrimaryPart.Size.Y / 2)
	remote:FireServer(remoteActions.placeUnit, cframe)
	unitToSpawn:Destroy()
	Variables.SelectedUnit.Value = nil
end

local function updatePlaceOfUnit()
	local unitToSpawn = Variables.SelectedUnit.Value :: Model?
	if not unitToSpawn then
		return
	end
	
	local raycastResult = mouseRaycast()
	if not checkValidRaycastResult(raycastResult) then
		colorPlaceholderUnit(false)
		return
	end

	colorPlaceholderUnit(true)

	local cframe = calculateUnitCFrame(raycastResult.Position, unitToSpawn.Humanoid.HipHeight + unitToSpawn.PrimaryPart.Size.Y / 2)
	unitToSpawn:PivotTo(cframe)

	-- placement.AddUnitPlacehodler(id)
end

local function onInputBegan(input: InputObject, inProccess: boolean)
	if inProccess then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		if Variables.SelectedUnit.Value then
			placeUnit()
		end
	end
end

local function onSelectedUnitChanged(value: Model?)
    if value then
        colorPlaceholderUnit()
		_connections[_connectionKeys.updatePlaceOfUnit] = RunService.RenderStepped:Connect(updatePlaceOfUnit)
		_connections[_connectionKeys.onInputBegan] = UserInputService.InputBegan:Connect(onInputBegan)
	else
		_connections[_connectionKeys.updatePlaceOfUnit]:Disconnect()
		_connections[_connectionKeys.updatePlaceOfUnit] = nil
    end
end

local function onSelectedUnitIdChanged(value: string)
    if value ~= "" then
        -- check valid unit id form player inventory
		local selectedUnit: Model
		if selectedUnit then
			local function selectedUnitDestroying()
				table.remove(_raycastBlackList, table.find(_raycastBlackList, selectedUnit))
			end

			Variables.SelectedUnit.Value = selectedUnit
			table.insert(_raycastBlackList, selectedUnit)
			selectedUnit.Destroying:Connect(selectedUnitDestroying)
		end
    end
end

local function on()
	
end

local function finishPlacement()
	for connectName, _ in _connections do
		if connectName ~= _connectionKeys.remoteConnect then
			_connections[connectName]:Disconnect()
			_connections[connectName] = nil
		end	
	end
end

local function startPlacement()
	_connections[_connectionKeys.onSelectedUnitIdChanged] = Variables.SelectedUnitId.Changed:Connect(onSelectedUnitIdChanged)
	_connections[_connectionKeys.onSelectedUnitChanged] = Variables.SelectedUnit.Changed:Connect(onSelectedUnitChanged)
	
end

local function remoteConnect(action: string, ...: any)
	local actions = {
		[remoteActions.startPlacement] = startPlacement,
		[remoteActions.finishPlacement] = finishPlacement,
	}

	if actions[action] then
		actions[action](...)
	end
end

local function initialize()
	_connections[_connectionKeys.remoteConnect] = remote.OnClientEvent:Connect(remoteConnect)
end

return {
    initialize = initialize,
}