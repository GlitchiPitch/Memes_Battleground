local BattlegroundSystem = script.Parent

local Events = BattlegroundSystem.Events
local Handlers = BattlegroundSystem.Handlers

local Maps: Folder & { Model }

local VoteHandler = require(Handlers.Vote)
local BattleHanlder = require(Handlers.Battle)
local Types = require(BattlegroundSystem.Types)

local event = Events.Event
local _connections: { RBXScriptConnection } = {}

local function eventConnect(battleData: Types.BattleDataType)
    if battleData.Mode == "Single" or battleData.Mode == "Party" then
        VoteHandler.initialize(battleData)
    elseif battleData.Mode == "Versus" then
        BattleHanlder.initialize(battleData)
    end
end

local function initialize()
    table.insert(
        _connections,
        event.Event:Connect(eventConnect)
    )
end

return {
    initialize = initialize,
}