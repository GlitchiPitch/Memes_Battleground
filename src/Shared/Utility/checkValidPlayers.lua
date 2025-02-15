local Players = game:GetService("Players")
local function checkValidPlayers(playerList: { Player }) : boolean
    for i, player in playerList do
        if (player.Parent ~= Players) or (not player.Character) then
            table.remove(playerList, i)
        end
    end
    return #playerList > 0
end

return checkValidPlayers