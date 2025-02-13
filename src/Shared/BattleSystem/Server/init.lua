local BattleSystem = script.Parent
local Events = BattleSystem.Events
local Maps: Folder & { Model }

local Types = require(BattleSystem.Types)

local battleSystemEvent = Events.Event

local function startVote()
    
end

local function battleSystemEventConnect(battleData: Types.BattleDataType)
    if battleData.Mode == "Single" or battleData.Mode == "Party" then
        startVote()
    elseif battleData.Mode == "Versus" then
    end
end

local function initialize()
    battleSystemEvent.Event:Connect(battleSystemEventConnect)
end

return {
    initialize = initialize,
}