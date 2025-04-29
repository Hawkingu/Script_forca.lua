_G.farmVida = true

while _G.farmVida do
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if humanoid and humanoid.Health < humanoid.MaxHealth then
        humanoid.Health = math.min(humanoid.Health + 3, humanoid.MaxHealth)
    end

    wait(0.5) -- ajustável: mais rápido ou mais lento
end
