local BattleHandler = script.Parent
local Handlers = BattleHandler.Parent
local BattlegroundSystem = Handlers.Parent

local Events = BattlegroundSystem.Events
local battleSystemRemote = Events.Remote
local battleSystemRemoteActions = require(battleSystemRemote.Actions)

local Types = require(BattlegroundSystem.Types)

local _connections: { RBXScriptConnection } = {}

local function finishBattle()
    
end

local function prepare()
    
end

local function battleSystemRemoteConnect(action: string, ...: any)
    local actions = {
        [battleSystemRemoteActions.prepare] = prepare,
    }

    if actions[action] then
        actions[action](...)
    end
end

local function startBattle()
    table.insert(
        _connections,
        battleSystemRemote.OnClientEvent:Connect(battleSystemRemoteConnect)
    )
end


return {
    startBattle = startBattle,
}