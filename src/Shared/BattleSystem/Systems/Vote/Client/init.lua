local Client = script
local VoteSystem = Client.Parent
local Systems = VoteSystem.Parent
local BattleSystem = Systems.Parent

local Events = BattleSystem.Events
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
