local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local character = player.Character or player.CharacterAdded:Wait()

mouse.Button1Down:Connect(function()
    local target = mouse.Target
    if target and target.Parent then
        local targetCharacter = target.Parent
        local targetPlayer = game.Players:GetPlayerFromCharacter(targetCharacter)
        if targetPlayer and targetPlayer ~= player then
            -- Muda seu DisplayName (nome mostrado)
            player.DisplayName = targetPlayer.DisplayName

            -- Ajusta sua vida para a mesma
            local targetHumanoid = targetCharacter:FindFirstChildWhichIsA("Humanoid")
            local myHumanoid = character:FindFirstChildWhichIsA("Humanoid")
            if targetHumanoid and myHumanoid then
                myHumanoid.MaxHealth = targetHumanoid.MaxHealth
                myHumanoid.Health = targetHumanoid.Health
            end

            -- (Opcional) Copiar aparência
            local humanoidDescription = targetPlayer.Character:FindFirstChildOfClass("Humanoid"):GetAppliedDescription()
            character:FindFirstChildOfClass("Humanoid"):ApplyDescription(humanoidDescription)
        end
    end
end)
