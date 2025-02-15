local PlacementHandler = script.Parent
local Handlers = PlacementHandler.Parent
local BattlegroundSystem = Handlers.Parent
local Events = BattlegroundSystem.Events

local remote = Events.Remote
local remoteActions = require(remote.Actions)

local event = Events.Event
local eventActions = require(event.Actions)

local _connections: { RBXScriptConnection } = {}

local function spawnUnit(player: Player, selectedUnit: {})
    -- check player has unit
    -- can spawn
    -- checkValidArea
    -- 
end

local function finishPlacement()
    
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
        [eventActions.finishPlacement] = finishPlacement,
    }

    if actions[action] then
        actions[action](...)
    end
end

local function initialize()
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