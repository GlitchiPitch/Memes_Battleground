local RunService = game:GetService("RunService")
if RunService:IsServer() then
    return require(script.Server)
elseif RunService:IsClient() then

end