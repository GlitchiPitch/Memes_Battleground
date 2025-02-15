local Client = script.Parent
local VoteHandler = Client.Parent
local Systems = VoteHandler.Parent
local BattlegroundSystem = Systems.Parent

local Events = BattlegroundSystem.Events
local battleSystemRemote = Events.Remote

type VoteDataType = { timer: number, votes: { [string]: number } }

local function updateVote(voteData: VoteDataType)
    
end

local function battleSystemRemoteConnect(voteData: VoteDataType)
    updateVote(voteData)
end

local function startVote()
    battleSystemRemote.OnClientEvent:Connect(battleSystemRemoteConnect)
end

return startVote
