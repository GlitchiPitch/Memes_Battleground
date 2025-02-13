local Players = game:GetService("Players")
local function checkValidPlayers(playerList: { Player })
    for i, player in playerList do
        if (player.Parent ~= Players) or (not player.Character) then
            table.remove(playerList, i)
        end
    end
end

return checkValidPlayers