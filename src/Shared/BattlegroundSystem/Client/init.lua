local BattlegroundSystem = script.Parent
local Events = BattlegroundSystem.Events

local Types = require(BattlegroundSystem.Types)

local battleSystemRemote = Events.Remote

local function setupArea(area: Part)
    
end

local function battleSystemRemoteConnect(battleData: Types.BattleDataType)
    if battleData.Mode == "Single" or battleData.Mode == "Party" then
        setupArea(battleData.Map.SpawnAreas.Blue)
    elseif battleData.Mode == "Versus" then
        setupArea(battleData.Map.SpawnAreas.Blue)
        setupArea(battleData.Map.SpawnAreas.Red)
    end
end

local function initialize()
    battleSystemRemote.OnClientEvent:Connect(battleSystemRemoteConnect)
end

return {
    initialize = initialize,
}