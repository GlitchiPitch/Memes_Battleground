local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Utility = ReplicatedStorage.Utility
local clearConnections = require(Utility.clearConnections)

local BattleHandler = script.Parent
local Handlers = BattleHandler.Parent
local BattlegroundSystem = Handlers.Parent

local Events = BattlegroundSystem.Events
local Types = require(ReplicatedStorage.Types)

local event = Events.Event
local eventActions = require(event.Actions)

local remote = Events.Remote
local remoteActions = require(remote.Actions)

local _connections: { RBXScriptConnection } = {}
local _battleData: Types.BattleDataType

local function giveRewards()
    
end

local function finishBattle()
    giveRewards()

    clearConnections(_connections)
    _battleData = {}
end

local function checkFinishBattle()
    -- checkValidPlayers
    return not ( 0 ) -- #redUnits or #blueUnits
end

local function actUnits()
    for _, team: Types.TeamType in _battleData.Teams do
        for _, unit in team.Units do
            unit:Act()
        end
    end
end

local function startBattle()
    coroutine.wrap(function()
        while task.wait(1) do
            if checkFinishBattle() then
                break
            end
            actUnits()
        end
        finishBattle()
    end)()
end

local function eventConnect(action: string, ...: any)
    local actions = {
        [eventActions.startBattle] = startBattle,
    }
    if actions[action] then
        actions[action](...)
    end
end

local function initialize(battleData: Types.BattleDataType)
    _battleData = battleData
    table.insert(
        _connections,
        event.Event:Connect(eventConnect)
    )
end

return {
    initialize = initialize,
}