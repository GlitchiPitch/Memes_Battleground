local BattlegroundSystem = script.Parent

local Events = BattlegroundSystem.Events
local Handlers = BattlegroundSystem.Handlers

local Maps: Folder & { Model }

local VoteHandler = require(Handlers.Vote)
local BattleHandler = require(Handlers.Battle)
local PlacementHandler = require(Handlers.Placement)

local Types = require(BattlegroundSystem.Types)

local event = Events.Event
local eventActions = require(event.Actions)

local _connections: { RBXScriptConnection } = {}

local function initializeBattle(battleData: Types.BattleDataType)
    BattleHandler.initialize(battleData)
    PlacementHandler.initialize(battleData)
    
    if battleData.Mode == "Single" or battleData.Mode == "Party" then
        VoteHandler.initialize(battleData)
    elseif battleData.Mode == "Versus" then
        event:Fire(eventActions.startPlacement)
    end
end

local function eventConnect(action: string, battleData: Types.BattleDataType)
    local actions = {
        [eventActions.initializeBattle] = initializeBattle,
    }
    
    if actions[action] then
        actions[action](battleData)
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