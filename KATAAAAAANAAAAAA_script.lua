local ReplicatedStorage = game:GetService("ReplicatedStorage")

local katanaEvent = ReplicatedStorage:WaitForChild("KatanaEvent")

katanaEvent.OnServerEvent:Connect(function(player)
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            -- Aumenta a força e a velocidade em +3
            humanoid.WalkSpeed = humanoid.WalkSpeed + 3
            -- Aqui você pode adicionar lógica para aumentar a força do jogador
            -- Por exemplo, incrementando um valor em leaderstats
            local leaderstats = player:FindFirstChild("leaderstats")
            if leaderstats then
                local strength = leaderstats:FindFirstChild("Strength")
                if strength then
                    strength.Value = strength.Value + 3
                end
            end
        end
    end
end)
