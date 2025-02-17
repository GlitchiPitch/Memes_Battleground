local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GlobalConstants = require(ReplicatedStorage.Constants)

local MainStore = DataStoreService:GetDataStore("Main" .. GlobalConstants.DATA_STORE_VERSION)

export type DataType = {
    Units: {},
}

local defaultData: DataType = {
    Units = {},
}
local dataKeys = {}
-- @param {[userId]: Data}
local sessionData: {[number]: DataType} = {}

function get(player: Player)
    local playerData = MainStore:GetAsync(player.UserId) or table.clone(defaultData)
    sessionData[player.UserId] = playerData
end
function post(player: Player)
    local playerData = sessionData[player.UserId]
    MainStore:SetAsync(player.UserId, playerData)
    sessionData[player.UserId] = nil
end
function getSession(player: Player) : DataType
    local playerData = sessionData[player.UserId]
    return playerData
end
function postSession(player: Player, key: string?, value: any)
    local playerData = sessionData[player.UserId]
    playerData[key] = value
    sessionData[player.UserId] = playerData
end
return {
    postSession = postSession,
    getSession = getSession,
    dataKeys = dataKeys,
    post = post,
    get = get,
}