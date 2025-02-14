local BattlegroundSystem = script.Parent
local Events = BattlegroundSystem.Events
local Maps: Folder & { Model }

local Types = require(BattlegroundSystem.Types)

local VoteSystem = require(BattlegroundSystem.Systems.Vote)
local BattleSystem = require(BattlegroundSystem.Systems.Battle)

local battleSystemEvent = Events.Event

local function battleSystemEventConnect(battleData: Types.BattleDataType)
    if battleData.Mode == "Single" or battleData.Mode == "Party" then
        VoteSystem.startVote()
    elseif battleData.Mode == "Versus" then
    end
end

local function initialize()
    battleSystemEvent.Event:Connect(battleSystemEventConnect)
end

return {
    initialize = initialize,
}