local PlacementHandler = script.Parent
local Variables = PlacementHandler.Variables

local Handlers = PlacementHandler.Parent
local BattlegroundSystem = Handlers.Parent
local Events = BattlegroundSystem.Events

local Types = require(BattlegroundSystem.Types)

local remote = Events.Remote
local remoteActions = require(remote.Actions)

local event = Events.Event
local eventActions = require(event.Actions)

local _connections: { RBXScriptConnection } = {}
local _battleData: Types.BattleDataType



local function startPlacement()
    for _, team: { Player } in _battleData.Teams do
        if #team > 0 then
            for _, player in team do
                remote:FireClient(player, remoteActions.startPlacement)
            end
        end
    end
end

local function finishPlacement()
    
end

local function playerReady()
    
end

local function spawnUnit(player: Player, selectedUnit: {})
    -- check player has unit
    -- can spawn
    -- checkValidArea
    -- 
end

local function remoteConnect(player: Player, action: string)
    local actions = {
        [remoteActions.spawnUnit] = spawnUnit,
    }

    if actions[action] then
        actions[action](player)
    end
end

local function eventConnect(action: string, ...: any)
    local actions = {
        [eventActions.startPlacement] = startPlacement,
    }

    if actions[action] then
        actions[action](...)
    end
end

local function initialize(battleData: Types.BattleDataType)
    _battleData = battleData
    table.insert(
        _connections,
        remote.OnServerEvent:Connect(remoteConnect)
    )

    table.insert(
        _connections,
        event.Event:Connect(eventConnect)
    )
end

return {
    initialize = initialize,
}