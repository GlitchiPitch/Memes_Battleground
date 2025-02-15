local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BattleHandler = script.Parent
local Handlers = BattleHandler.Parent
local BattlegroundSystem = Handlers.Parent

local Events = BattlegroundSystem.Events
local remote = Events.Remote
local battleSystemRemoteActions = require(remote.Actions)

local Types = require(ReplicatedStorage.Types)

local _connections: { RBXScriptConnection } = {}

local function finishBattle()
    
end

local function prepare()
    
end

local function remoteConnect(action: string, ...: any)
    local actions = {
        [battleSystemRemoteActions.prepare] = prepare,
    }

    if actions[action] then
        actions[action](...)
    end
end

local function initialize()
    table.insert(
        _connections,
        remote.OnClientEvent:Connect(remoteConnect)
    )
end


return {
    initialize = initialize,
}